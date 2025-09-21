package action;

import com.opensymphony.xwork2.ActionSupport;
import model.User;
import service.UserService;

public class LoginAction extends ActionSupport {
    private String username;
    private String password;

    private UserService userService = new UserService();

    public String execute(){
        User user = userService.validateUser(username, password);
        if (user != null) {
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
