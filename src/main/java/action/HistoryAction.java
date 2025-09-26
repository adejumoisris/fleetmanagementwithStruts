package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.HistoryDao;
import model.History;

import java.util.List;

public class HistoryAction extends ActionSupport {
    private List<History> histories;

    public String execute(){
        histories = new HistoryDao().findAll();
        return SUCCESS;
    }

    public List<History> getHistories() {
        return histories;
    }
}
