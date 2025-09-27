package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.HistoryDao;
import dao.MaintenanceDAO;
import model.History;
import model.MaintenanceRecord;

import java.util.List;

public class ViewRequestAction extends ActionSupport {
    private Long id;
    private MaintenanceRecord record;
    private List<MaintenanceRecord> pastRecords;
    private List<History> historyList;

    public String execute() {
        MaintenanceDAO dao = new MaintenanceDAO();
        record = dao.getById(id);
        if (record == null) {
            return ERROR;
        }

        // Past maintenance: same vehicle, exclude current record
        pastRecords = dao.getByVehicle(record.getVehicle(), record.getId());

        // History log: actions related to this request
        historyList = new HistoryDao().getByRequestId(record.getId());

        return SUCCESS;
    }

    // Getters & setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public MaintenanceRecord getRecord() { return record; }
    public void setRecord(MaintenanceRecord record) { this.record = record; }

    public List<MaintenanceRecord> getPastRecords() { return pastRecords; }
    public void setPastRecords(List<MaintenanceRecord> pastRecords) { this.pastRecords = pastRecords; }

    public List<History> getHistoryList() { return historyList; }
    public void setHistoryList(List<History> historyList) { this.historyList = historyList; }
}
