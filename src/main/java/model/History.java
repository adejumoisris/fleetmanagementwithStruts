package model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "history")
public class History {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String username;
    private String action; // e.g. "Created maintenance request", "Updated maintenance request"
    private String details;

    @Temporal(TemporalType.TIMESTAMP)
    private Date timestamp;

    // Many histories belong to one maintenance record
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "record_id")
    private MaintenanceRecord record;

    public History() {
    }

    public History(String username, String action, String details) {
        this.username = username;
        this.action = action;
        this.details = details;
        this.timestamp = new Date();
    }
    public History(String loggedInUser, String createdANewMaintenanceRequest) {
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(Date timestamp) {
        this.timestamp = timestamp;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getDetails() {return details;}

    public void setDetails(String details) {this.details = details;}

    public MaintenanceRecord getRecord() {
        return record;
    }

    public void setRecord(MaintenanceRecord record) {
        this.record = record;
    }
}
