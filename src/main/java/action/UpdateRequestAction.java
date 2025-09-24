package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;
import model.MaintenanceRecord;

public class UpdateRequestAction extends ActionSupport {
    private MaintenanceRecord record;

    public String execute() {
        MaintenanceDAO dao = new MaintenanceDAO();
        dao.update(record);
        return SUCCESS; // redirect back to list
    }

    public MaintenanceRecord getRecord() { return record; }
    public void setRecord(MaintenanceRecord record) { this.record = record; }
}
