package dao;

import model.User;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

public class UserDAO {

    public User findByUsernameAndPassword(String username, String password) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        User user = null;
        try {
            user = session.createQuery(
                            "FROM model.User  WHERE username = :uname AND password = :pass",
                            User.class)
                    .setParameter("uname", username)
                    .setParameter("pass", password)
                    .uniqueResult();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return user;
    }





    public void save(User user) {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();

            session.save(user);

            tx.commit();
        } catch (Exception e) {
            if (tx != null) {
                tx.rollback();  // rollback works because session is still open
            }
            e.printStackTrace();
        } finally {
            if (session != null) {
                session.close(); // close session here
            }
        }
    }
}
