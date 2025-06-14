package sn.uasz.inscription.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import sn.uasz.inscription.entities.UE;

import java.util.List;

public class UEDao {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("InscriptionPU");

    public void create(UE ue) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(ue);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public UE find(String code) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(UE.class, code);
        } finally {
            em.close();
        }
    }

    public List<UE> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT u FROM UE u", UE.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void update(UE ue) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(ue);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(String code) {
        EntityManager em = emf.createEntityManager();
        try {
            UE ue = em.find(UE.class, code);
            if (ue != null) {
                em.getTransaction().begin();
                em.remove(ue);
                em.getTransaction().commit();
            }
        } finally {
            em.close();
        }
    }
}
