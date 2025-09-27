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

//     Update the requests

    public MaintenanceRecord getById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(MaintenanceRecord.class, id);
        }
    }

    public void update(MaintenanceRecord record) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.update(record);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        }
    }


    public void delete(Long id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();

            MaintenanceRecord record = session.get(MaintenanceRecord.class, id);
            if (record != null) {
                session.delete(record);
            }

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public List<MaintenanceRecord> getByVehicle(String vehicle, Long excludeId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM MaintenanceRecord WHERE vehicle = :vehicle AND id != :id ORDER BY mileageDate DESC",
                            MaintenanceRecord.class
                    )
                    .setParameter("vehicle", vehicle)
                    .setParameter("id", excludeId)
                    .list();
        }
    }




}
