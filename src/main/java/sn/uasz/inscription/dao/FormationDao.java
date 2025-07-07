package sn.uasz.inscription.dao;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import sn.uasz.inscription.entities.Formation;
import sn.uasz.inscription.util.JpaUtil;

import java.util.List;

public class FormationDao { 
	
	
    public void create(Formation formation) {
    	EntityManager em = JpaUtil.getEntityManager();


        try {
            em.getTransaction().begin();
            em.persist(formation);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void update(Formation formation) {
    	EntityManager em = JpaUtil.getEntityManager();


        try {
            em.getTransaction().begin();
            em.merge(formation);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
    	EntityManager em = JpaUtil.getEntityManager();


        try {
            em.getTransaction().begin();
            Formation f = em.find(Formation.class, id);
            if (f != null) {
                em.remove(f);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Formation findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT f FROM Formation f LEFT JOIN FETCH f.ues WHERE f.id = :id", Formation.class)
                .setParameter("id", id)
                .getSingleResult();
        } finally {
            em.close();
        }
    }


    public List<Formation> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        System.out.println("Chargement des formations avec UEs...");

        try {
            return em.createQuery(
                "SELECT DISTINCT f FROM Formation f LEFT JOIN FETCH f.ues", Formation.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

  

}