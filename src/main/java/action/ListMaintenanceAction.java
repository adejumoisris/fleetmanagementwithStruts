package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;
import model.MaintenanceRecord;

import java.util.List;

public class ListMaintenanceAction extends ActionSupport {

    private List<MaintenanceRecord> requests; // will hold DB records

    public List<MaintenanceRecord> getRequests() {
        return requests;
    }

    public void setRequests(List<MaintenanceRecord> requests) {
        this.requests = requests;
    }

    @Override
    public String execute() {
        MaintenanceDAO dao = new MaintenanceDAO();
        requests = dao.findAll();  // fetch from DB
        System.out.println("DEBUG: Found " + (requests != null ? requests.size() : 0) + " records");
        return SUCCESS;
    }
}
