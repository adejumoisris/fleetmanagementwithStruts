package dao;

import model.MaintenanceRecord;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class MaintenanceDAO {
    public List<String> getDistinctValues(String column) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String hql = "SELECT DISTINCT v." + column + " FROM VehicleMaintenanceRequest v WHERE v." + column + " IS NOT NULL";
            return session.createQuery(hql, String.class).list();
        }
    }

    public void save(MaintenanceRecord record) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.save(record);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }


    public List<MaintenanceRecord> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("from MaintenanceRecord", MaintenanceRecord.class).list();

        }
    }































}
