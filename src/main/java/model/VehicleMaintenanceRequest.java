package model;

import javax.persistence.*;

import java.util.Date;

@Entity
@Table(name = "vehicle_maintenance_request")
public class VehicleMaintenanceRequest {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false)
    private Long id;

    private String office;
    private String client;
    private String vehicle;
    private String driver;
    @Column(name = "fault_type")
    private String faultType;
    @Column(columnDefinition = "TEXT")
    private String complaint;
    private String status;
    @Column(columnDefinition = "TEXT")
    private String comments;
    private String location;
    private String workshop;
    private String assignName;
    private String assignEmail;

    @Temporal(TemporalType.TIMESTAMP)
    private Date mileageDate;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getClient() {
        return client;
    }

    public void setClient(String client) {
        this.client = client;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
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

    public Date getMileageDate() {
        return mileageDate;
    }

    public void setMileageDate(Date mileageDate) {
        this.mileageDate = mileageDate;
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

    public String getWorkshop() {
        return workshop;
    }

    public void setWorkshop(String workshop) {
        this.workshop = workshop;
    }

    public String getAssignName() {
        return assignName;
    }

    public void setAssignName(String assignName) {
        this.assignName = assignName;
    }

    public String getAssignEmail() {
        return assignEmail;
    }

    public void setAssignEmail(String assignEmail) {
        this.assignEmail = assignEmail;
    }
}
