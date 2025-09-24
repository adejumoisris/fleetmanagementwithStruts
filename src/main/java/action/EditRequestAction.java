package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;
import model.MaintenanceRecord;

public class EditRequestAction extends ActionSupport {
    private Long id;
    private MaintenanceRecord record;

    public String execute() {
        MaintenanceDAO dao = new MaintenanceDAO();
        record = dao.getById(id);
        if (record == null) {
            return ERROR;
        }
        return SUCCESS; // forward to edit JSP
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public MaintenanceRecord getRecord() {
        return record;
    }

    public void setRecord(MaintenanceRecord record) {
        this.record = record;
    }
}
