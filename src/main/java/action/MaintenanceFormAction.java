package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.MaintenanceDAO;

import java.util.List;

public class MaintenanceFormAction extends ActionSupport {
    private List<String> offices;
    private List<String> clients;
    private List<String> vehicles;
    private List<String> drivers;
    private List<String> faultTypes;
    private List<String> statuses;
    private List<String> assignList;

    @Override
    public String execute() {
        MaintenanceDAO dao = new MaintenanceDAO();
        offices = dao.getDistinctValues("office");
        clients = dao.getDistinctValues("client");
        vehicles = dao.getDistinctValues("vehicle");
        drivers = dao.getDistinctValues("driver");
        faultTypes = dao.getDistinctValues("faultType");
        statuses = dao.getDistinctValues("status");
        assignList = dao.getDistinctValues("assignName");
        return SUCCESS;
    }

    public List<String> getOffices() { return offices; }
    public List<String> getClients() { return clients; }
    public List<String> getVehicles() { return vehicles; }
    public List<String> getDrivers() { return drivers; }
    public List<String> getFaultTypes() { return faultTypes; }
    public List<String> getStatuses() { return statuses; }
    public List<String> getAssignList() {return assignList;}

    public void setAssignList(List<String> assignList) {
        this.assignList = assignList;
    }

    public void setClients(List<String> clients) {
        this.clients = clients;
    }

    public void setDrivers(List<String> drivers) {
        this.drivers = drivers;
    }

    public void setFaultTypes(List<String> faultTypes) {
        this.faultTypes = faultTypes;
    }

    public void setOffices(List<String> offices) {
        this.offices = offices;
    }

    public void setStatuses(List<String> statuses) {
        this.statuses = statuses;
    }

    public void setVehicles(List<String> vehicles) {
        this.vehicles = vehicles;
    }
}
