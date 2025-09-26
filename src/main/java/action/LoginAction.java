package action;

import com.opensymphony.xwork2.ActionSupport;
import model.User;
import org.apache.struts2.ServletActionContext;
import service.UserService;

import javax.servlet.http.HttpSession;

public class LoginAction extends ActionSupport {
    private String username;
    private String password;

    private UserService userService = new UserService();

    public String execute(){
        User user = userService.validateUser(username, password);
        if (user != null) {
            // Store username in session
            HttpSession session = ServletActionContext.getRequest().getSession();
            session.setAttribute("username", user.getUsername());
            return SUCCESS;
        } else {
            addActionError("Invalid username or password");
            return INPUT;
        }

    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
