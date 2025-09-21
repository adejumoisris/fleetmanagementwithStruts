package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.VehicleMaintenanceDAO;
import model.VehicleMaintenanceRequest;

import java.util.List;

public class VehicleMaintenanceAction extends ActionSupport {
    private VehicleMaintenanceRequest request = new VehicleMaintenanceRequest();
    private List<VehicleMaintenanceRequest> requests;

    public String create(){
        new VehicleMaintenanceDAO().save(request);
        addActionMessage("Maintenance request created");
        return SUCCESS;
    }

    public String list(){
        requests = new VehicleMaintenanceDAO().findAll();
        return SUCCESS;
    }

    public VehicleMaintenanceRequest getRequest() {
        return request;
    }

    public void setRequest(VehicleMaintenanceRequest request) {
        this.request = request;
    }

    public List<VehicleMaintenanceRequest> getRequests() {
        return requests;
    }

    public void setRequests(List<VehicleMaintenanceRequest> requests) {
        this.requests = requests;
    }
}
