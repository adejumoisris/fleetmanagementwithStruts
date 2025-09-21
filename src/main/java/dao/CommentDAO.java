package dao;

import model.MaintenanceComment;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class CommentDAO {

    public void saveComment(MaintenanceComment comment) {
        Transaction tx = null;
        Session session = null;
        try {
            session = HibernateUtil.getSessionFactory().openSession();
            tx = session.beginTransaction();
            session.save(comment);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.getStatus().canRollback()) {
                tx.rollback();
            }
            throw e; // rethrow so Struts can handle
        } finally {
            if (session != null && session.isOpen()) {
                session.close();
            }
        }
    }

    public List<MaintenanceComment> getCommentsByRequest(Long requestId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM MaintenanceComment c WHERE c.requestId = :reqId ORDER BY c.createdAt DESC",
                            MaintenanceComment.class)
                    .setParameter("reqId", requestId)
                    .list();
        }
    }







}
