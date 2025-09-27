package dao;

import model.History;
import org.hibernate.Session;
import org.hibernate.Transaction;
import util.HibernateUtil;

import java.util.List;

public class HistoryDao {
    public void save(History history) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = session.beginTransaction();
        session.save(history);
        tx.commit();
        session.close();
    }

    public List<History> findAll() {
        Session session = HibernateUtil.getSessionFactory().openSession();
        List<History> list = session.createQuery("FROM History ORDER BY timestamp DESC", History.class).list();
        session.close();
        return list;
    }

    public List<History> getByRequestId(Long requestId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                            "FROM model.History h WHERE h.record.id = :reqId ORDER BY h.timestamp DESC\n",
                            History.class
                    )
                    .setParameter("reqId", requestId)
                    .list();
        }
    }



}
