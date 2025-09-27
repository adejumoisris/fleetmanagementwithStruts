import org.hibernate.Session;
import util.HibernateUtil;

public class TestSchema {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        session.close();
        System.out.println("✅ Hibernate started, check your DB!");
    }
}
