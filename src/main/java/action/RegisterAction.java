package action;

import com.opensymphony.xwork2.ActionSupport;
import dao.UserDAO;
import model.User;

public class RegisterAction extends ActionSupport {
    private String username;
    private String password;

    public String execute() {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        new UserDAO().save(user);
        return SUCCESS;
    }

    // Getters & Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
