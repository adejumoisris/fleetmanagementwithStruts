package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.HistoryDao;
import dao.MaintenanceDAO;
import model.History;
import model.MaintenanceRecord;
import org.apache.struts2.ServletActionContext;

import java.util.Date;

public class UpdateRequestAction extends ActionSupport {
    private MaintenanceRecord record;
    private Long id;

    public String execute() {
        MaintenanceDAO dao = new MaintenanceDAO();
        dao.update(record);

        // Log history
        History history = new History();
        history.setUsername(getLoggedInUser()); // must not be null
        history.setAction("Updated a maintenance request (ID: " + record.getId() + ")");
        history.setTimestamp(new Date()); // ✅ ensure timestamp is set
        new HistoryDao().save(history);

        addActionMessage("Maintenance request updated successfully.");

        return SUCCESS; // redirect back to list
    }

    public MaintenanceRecord getRecord() { return record; }
    public void setRecord(MaintenanceRecord record) { this.record = record; }

    // Get logged-in user from session
    private String getLoggedInUser() {
        return (String) ServletActionContext.getRequest().getSession().getAttribute("username");
    }
}
