package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.HistoryDao;
import model.FileEntity;
import model.History;
import model.MaintenanceRecord;
import org.apache.struts2.ServletActionContext;
import org.hibernate.Hibernate;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.io.File;
import java.nio.file.Files;
import java.util.Date;
import java.util.List;

public class UpdateRequestAction extends ActionSupport {
    private MaintenanceRecord record;
    private Long id;

    // Multiple file upload fields
    private List<File> fileUpload;
    private List<String> fileUploadFileName;
    private List<String> fileUploadContentType;

    public String execute() {
        Transaction tx = null;

        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();

            // Load existing record
            MaintenanceRecord existing = session.get(MaintenanceRecord.class, record.getId());
            if (existing == null) {
                addActionError("Record not found.");
                return ERROR;
            }

            // Build history details string by comparing old vs new values
            StringBuilder details = new StringBuilder();
            details.append("Updated record #").append(record.getId()).append(" | ");

            if (!safeEquals(existing.getOffice(), record.getOffice())) {
                details.append("Office was change from '").append(existing.getOffice())
                        .append("' to '").append(record.getOffice()).append("'. ");
            }
            if (!safeEquals(existing.getClient(), record.getClient())) {
                details.append("Client: is updated from  '").append(existing.getClient())
                        .append("' to'").append(record.getClient()).append("'. ");
            }
            if (!safeEquals(existing.getVehicle(), record.getVehicle())) {
                details.append("Vehicle: '").append(existing.getVehicle())
                        .append("' → '").append(record.getVehicle()).append("'. ");
            }
            if (!safeEquals(existing.getDriver(), record.getDriver())) {
                details.append("Driver: is  change from '").append(existing.getDriver())
                        .append("' to '").append(record.getDriver()).append("'. ");
            }
            if (!safeEquals(existing.getStatus(), record.getStatus())) {
                details.append("The status is updated from  '").append(existing.getStatus())
                        .append("' to '").append(record.getStatus()).append("'. ");
            }
            if (!safeEquals(existing.getLocation(), record.getLocation())) {
                details.append("The Location as change from  '").append(existing.getLocation())
                        .append("' to '").append(record.getLocation()).append("'. ");
            }
            if (!safeEquals(existing.getFaultType(), record.getFaultType())) {
                details.append("Fault Type: is updated from '").append(existing.getFaultType())
                        .append("' to '").append(record.getFaultType()).append("'. ");
            }
            if (!safeEquals(existing.getComplaint(), record.getComplaint())) {
                details.append("Complaint updated. ");
            }
            if (!safeEquals(existing.getMileageDate(), record.getMileageDate())) {
                details.append("Mileage Date as beaing updated from'").append(existing.getMileageDate())
                        .append("' to'").append(record.getMileageDate()).append("'. ");
            }
            if (!safeEquals(existing.getMileageTime(), record.getMileageTime())) {
                details.append("Mileage Time has change from  '").append(existing.getMileageTime())
                        .append("' to '").append(record.getMileageTime()).append("'. ");
            }

            // Fallback if no fields changed
            if (details.toString().equals("Updated record #" + record.getId() + " | ")) {
                details.append("No major fields changed.");
            }

            //  Update record fields
            existing.setOffice(record.getOffice());
            existing.setClient(record.getClient());
            existing.setVehicle(record.getVehicle());
            existing.setMileageDate(record.getMileageDate());
            existing.setMileageTime(record.getMileageTime());
            existing.setDriver(record.getDriver());
            existing.setLocation(record.getLocation());
            existing.setFaultType(record.getFaultType());
            existing.setComplaint(record.getComplaint());
            existing.setStatus(record.getStatus());

            //  Handle new file uploads and log them
            if (fileUpload != null) {
                for (int i = 0; i < fileUpload.size(); i++) {
                    byte[] fileData = Files.readAllBytes(fileUpload.get(i).toPath());

                    FileEntity fileEntity = new FileEntity();
                    fileEntity.setFileName(fileUploadFileName.get(i));
                    fileEntity.setFileType(fileUploadContentType.get(i));
                    fileEntity.setFileData(fileData);

                    existing.addFile(fileEntity);

                    details.append("Added file: ").append(fileUploadFileName.get(i)).append(". ");
                }
            }

            session.update(existing);
            tx.commit();

            // --- RELOAD RECORD TO ENSURE FILES ARE LOADED ---
            record = session.get(MaintenanceRecord.class, existing.getId());
            Hibernate.initialize(record.getFiles()); // ensure files are loaded for JSP

            //  Save history
            History history = new History();
            history.setUsername("user");
            history.setAction("Updated Maintenance Request");
            history.setDetails(details.toString());
            history.setTimestamp(new Date());
            history.setRecord(existing); // attach the record
            new HistoryDao().save(history);

            addActionMessage("Maintenance request updated successfully.");
            return SUCCESS;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            addActionError("Failed to update maintenance request");
            return ERROR;
        }
    }

    // Helper method for safe comparison (handles nulls)
    private boolean safeEquals(Object a, Object b) {
        return (a == null && b == null) || (a != null && a.equals(b));
    }

    public MaintenanceRecord getRecord() { return record; }
    public void setRecord(MaintenanceRecord record) { this.record = record; }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public List<File> getFileUpload() { return fileUpload; }
    public void setFileUpload(List<File> fileUpload) { this.fileUpload = fileUpload; }

    public List<String> getFileUploadFileName() { return fileUploadFileName; }
    public void setFileUploadFileName(List<String> fileUploadFileName) { this.fileUploadFileName = fileUploadFileName; }

    public List<String> getFileUploadContentType() { return fileUploadContentType; }
    public void setFileUploadContentType(List<String> fileUploadContentType) { this.fileUploadContentType = fileUploadContentType; }

    // Get logged-in user from session
    private String getLoggedInUser() {
        return (String) ServletActionContext.getRequest().getSession().getAttribute("username");
    }
}
