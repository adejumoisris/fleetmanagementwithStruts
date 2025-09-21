package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.CommentDAO;
import model.MaintenanceComment;

import java.util.List;

public class CommentAction extends ActionSupport {

    private Long requestId;
    private String comment;
    private String assign;  // Multiple emails (comma separated)
    private String notify;  // Multiple emails (comma separated)

    private List<MaintenanceComment> commentList;

    public String execute() {
        CommentDAO dao = new CommentDAO();

        // Save new comment
        if (comment != null && !comment.isEmpty()) {
            MaintenanceComment c = new MaintenanceComment();
            c.setRequestId(requestId);
            c.setUser("SysServe SysServe"); // Replace with session user
            c.setComment(comment);
            c.setAssignEmails(assign);
            c.setNotifyEmails(notify);

            dao.saveComment(c);
        }

        // Reload comments
        commentList = dao.getCommentsByRequest(requestId);

        return SUCCESS;
    }

    public List<MaintenanceComment> getMaintenanceComment(){
        return commentList;
    }

    public Long getRequestId() { return requestId; }
    public void setRequestId(Long requestId) { this.requestId = requestId; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getAssign() { return assign; }
    public void setAssign(String assign) { this.assign = assign; }

    public String getNotify() { return notify; }
    public void setNotify(String notify) { this.notify = notify; }

    public List<MaintenanceComment> getCommentList() { return commentList; }
    public void setCommentList(List<MaintenanceComment> commentList) { this.commentList = commentList; }


}
