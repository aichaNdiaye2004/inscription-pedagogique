package sn.uasz.inscription.dao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import sn.uasz.inscription.entities.Formation;

import java.util.List;

public class FormationDao {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("InscriptionPU");

    public void create(Formation formation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(formation);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Formation find(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Formation.class, id);
        } finally {
            em.close();
        }
    }

    public List<Formation> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT f FROM Formation f", Formation.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Formation formation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(formation);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            Formation formation = em.find(Formation.class, id);
            if (formation != null) {
                em.getTransaction().begin();
                em.remove(formation);
                em.getTransaction().commit();
            }
        } finally {
            em.close();
        }
    }
}
