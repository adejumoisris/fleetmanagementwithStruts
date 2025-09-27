package action;

import com.opensymphony.xwork2.ActionSupport;
import model.FileEntity;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.io.File;
import java.nio.file.Files;

public class UploadFileAction extends ActionSupport {
    private File[] fileUpload;
    private String[] fileUploadFileName;
    private String[] fileUploadContentType;

    // Getters and Setters
    public File[] getFileUpload() { return fileUpload; }
    public void setFileUpload(File[] fileUpload) { this.fileUpload = fileUpload; }

    public String[] getFileUploadFileName() { return fileUploadFileName; }
    public void setFileUploadFileName(String[] fileUploadFileName) { this.fileUploadFileName = fileUploadFileName; }

    public String[] getFileUploadContentType() { return fileUploadContentType; }
    public void setFileUploadContentType(String[] fileUploadContentType) { this.fileUploadContentType = fileUploadContentType; }

    @Override
    public String execute() {
        Session session = null;
        Transaction tx = null;

        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            for (int i = 0; i < fileUpload.length; i++) {
                FileEntity fileEntity = new FileEntity();
                fileEntity.setFileName(fileUploadFileName[i]);
                fileEntity.setFileType(fileUploadContentType[i]);
                fileEntity.setFileData(Files.readAllBytes(fileUpload[i].toPath()));

                session.save(fileEntity);
            }

            tx.commit();
            addActionMessage("Files uploaded successfully!");
            return SUCCESS;

        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
            addActionError("File upload failed: " + e.getMessage());
            return ERROR;
        } finally {
            if (session != null) session.close();
        }
    }
}
