package dao;

import model.VehicleMaintenanceRequest;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class VehicleMaintenanceDAO {
    public void save(VehicleMaintenanceRequest req){
        Transaction tx =null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.save(req);
            tx.commit();
        }catch (Exception e) {
            if (tx != null) tx.rollback();
            throw new RuntimeException(e);
        } finally {
            if (session != null) session.close();
        }
    }

    public List<VehicleMaintenanceRequest> findAll(){
        try (Session session = HibernateUtil.getSessionFactory().openSession()){
            return session.createQuery("from VehicleMaintenanceRequest", VehicleMaintenanceRequest.class).list();
        }
    }
}
