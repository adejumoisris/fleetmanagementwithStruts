package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;

public class DeleteRequestAction extends ActionSupport {
    private Long id;

    public String execute() {
        if (id != null) {
            MaintenanceDAO dao = new MaintenanceDAO();
            dao.delete(id);
        }
        return SUCCESS; // after delete, return SUCCESS and redirect back to list
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
}
