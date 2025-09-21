package service;

import dao.UserDAO;
import model.User;

public class UserService {
    private UserDAO userDAO = new UserDAO();

    public User validateUser(String username, String password) {
        return userDAO.findByUsernameAndPassword(username, password);
    }

    public void saveUser(User user) {
        userDAO.save(user);
    }
}
