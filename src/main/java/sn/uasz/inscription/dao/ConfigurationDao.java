package sn.uasz.inscription.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import sn.uasz.inscription.entities.Configuration;
import sn.uasz.inscription.util.JpaUtil;

public class ConfigurationDao {

    public Configuration find() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Configuration> query = em.createQuery("SELECT c FROM Configuration c", Configuration.class);
            return query.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }

    public void save(Configuration config) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            if (config.getId() == null) {
                em.persist(config);
            } else {
                em.merge(config);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}
