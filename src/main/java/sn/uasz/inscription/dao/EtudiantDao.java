package sn.uasz.inscription.dao;

import jakarta.persistence.*;
import sn.uasz.inscription.entities.Etudiant;

import java.util.List;

public class EtudiantDao {
    private final EntityManagerFactory emf;

    public EtudiantDao() {
        this.emf = Persistence.createEntityManagerFactory("InscriptionPU");
    }

    public void create(Etudiant etudiant) {
        if (etudiant.getIne() == null || etudiant.getIne().trim().isEmpty()) {
            throw new IllegalArgumentException("L'INE de l'étudiant doit être défini et non vide");
        }

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(etudiant);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            throw new RuntimeException("Erreur lors de la création de l'étudiant : " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Etudiant> query = em.createQuery("SELECT e FROM Etudiant e", Etudiant.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public void save(Etudiant etudiant) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Etudiant existing = em.find(Etudiant.class, etudiant.getIne());
            if (existing != null) {
                em.merge(etudiant); // Mise à jour
            } else {
                em.persist(etudiant); // Nouveau
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw new RuntimeException("Erreur dans save : " + e.getMessage(), e);
        } finally {
            em.close();
        }
    }

    public Etudiant findById(String ine) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Etudiant.class, ine);
        } finally {
            em.close();
        }
    }

    public void delete(String ine) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Etudiant e = em.find(Etudiant.class, ine);
            if (e != null) {
                em.remove(e);
            }
            tx.commit();
        } catch (Exception ex) {
            if (tx.isActive()) tx.rollback();
            throw new RuntimeException("Erreur lors de la suppression : " + ex.getMessage(), ex);
        } finally {
            em.close();
        }
    }


}
