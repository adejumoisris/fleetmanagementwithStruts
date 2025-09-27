package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.HistoryDao;
import dao.MaintenanceDAO;
import model.History;
import model.MaintenanceRecord;
import org.apache.struts2.ServletActionContext;

import java.util.Date;
import java.util.List;

public class SaveMaintenanceAction extends ActionSupport {
    private String office;
    private String client;
    private String vehicle;
    private String mileageDate;
    private String mileageTime;
    private String driver;
    private String location;
    private String faultType;
    private String complaint;
    private String status;

//    List of drop down

    private List<String> offices;
    private List<String> clients;

    public List<String> getClients() {
        return clients;
    }

    public void setClients(List<String> clients) {
        this.clients = clients;
    }

    public List<String> getOffices() {
        return offices;
    }

    public void setOffices(List<String> offices) {
        this.offices = offices;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getComplaint() {
        return complaint;
    }

    public void setComplaint(String complaint) {
        this.complaint = complaint;
    }

    public String getDriver() {
        return driver;
    }

    public void setDriver(String driver) {
        this.driver = driver;
    }

    public String getFaultType() {
        return faultType;
    }

    public void setFaultType(String faultType) {
        this.faultType = faultType;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getMileageDate() {
        return mileageDate;
    }

    public void setMileageDate(String mileageDate) {
        this.mileageDate = mileageDate;
    }

    public String getMileageTime() {
        return mileageTime;
    }

    public void setMileageTime(String mileageTime) {
        this.mileageTime = mileageTime;
    }

    public String getOffice() {
        return office;
    }

    public void setOffice(String office) {
        this.office = office;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getVehicle() {
        return vehicle;
    }

    public void setVehicle(String vehicle) {
        this.vehicle = vehicle;
    }


    public String execute() {
        try {
            // Create entity
            MaintenanceRecord record = new MaintenanceRecord();
            record.setOffice(office);
            record.setClient(client);
            record.setVehicle(vehicle);
            record.setMileageDate(mileageDate);
            record.setMileageTime(mileageTime);
            record.setDriver(driver);
            record.setLocation(location);
            record.setFaultType(faultType);
            record.setComplaint(complaint);
            record.setStatus(status);

            // Save using DAO
            MaintenanceDAO dao = new MaintenanceDAO();
            dao.save(record);

            // Log History

            History history = new History();
            history.setUsername(getLoggedInUser());
            history.setAction("new maintenance request");
            history.setDetails("created a new maintenance request");
            history.setTimestamp(new Date());
            new HistoryDao().save(history);

            return SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            addActionError("Failed to create maintenance Request");
            return ERROR;
        }
    }

    // Get logged-in user from session
    private String getLoggedInUser() {
        return (String) ServletActionContext.getRequest().getSession().getAttribute("username");
    }

}
