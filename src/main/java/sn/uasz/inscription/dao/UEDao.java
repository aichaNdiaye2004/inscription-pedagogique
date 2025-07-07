package sn.uasz.inscription.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import sn.uasz.inscription.entities.UE;
import sn.uasz.inscription.util.JpaUtil;

import java.util.List;

public class UEDao {
	
	public List<UE> findByFormationAndType(Long formationId, boolean obligatoire) {
		EntityManager em = JpaUtil.getEntityManager();

	    
	    try {
	        TypedQuery<UE> query = ((EntityManager) em).createQuery(
	            "SELECT ue FROM UE ue WHERE ue.formation.id = :fid AND ue.obligatoire = :obligatoire", UE.class);
	        query.setParameter("fid", formationId);
	        query.setParameter("obligatoire", obligatoire);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}
	public UE findById(Long code) {
	    EntityManager em = JpaUtil.getEntityManager();
	    try {
	        return em.find(UE.class, code);
	    } finally {
	        em.close();
	    }
	}

	public void create(UE ue) {
	    EntityManager em = JpaUtil.getEntityManager();
	    try {
	        em.getTransaction().begin();
	        em.persist(ue);
	        em.getTransaction().commit();
	    } catch (RuntimeException e) {
	        if (em.getTransaction().isActive()) {
	            em.getTransaction().rollback();
	        }
	        throw e;
	    } finally {
	        em.close();
	    }
	}


    public void update(UE ue) {
    	EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();
            em.merge(ue);
            em.getTransaction().commit(); 
        } finally {
            em.close();
        }
    }
    public void delete(Long code) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            UE ue = em.find(UE.class, code);
            if (ue != null) {
                em.remove(ue);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

  
    
    public List<UE> findOptionnellesByFormation(Long formationId) {
    	EntityManager em = JpaUtil.getEntityManager();

        try {
            String jpql = "SELECT ue FROM UE ue WHERE ue.formation.id = :fid AND ue.obligatoire = false";
            TypedQuery<UE> query = em.createQuery(jpql, UE.class);
            query.setParameter("fid", formationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<UE> findAll() {
    	EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<UE> query = em.createQuery("SELECT u FROM UE u", UE.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<UE> findByFormation(Long formationId) {
    	EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<UE> query = em.createQuery(
                "SELECT u FROM UE u WHERE u.formation.id = :id", UE.class);
            query.setParameter("id", formationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<UE> findObligatoiresByFormation(Long formationId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT ue FROM UE ue WHERE ue.formation.id = :fid AND ue.obligatoire = true";
            TypedQuery<UE> query = em.createQuery(jpql, UE.class);
            query.setParameter("fid", formationId);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<UE> findAllOptionnelles() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            String jpql = "SELECT ue FROM UE ue WHERE ue.obligatoire = false";
            TypedQuery<UE> query = em.createQuery(jpql, UE.class);
            return query.getResultList();
        } finally {
            em.close();
        }
    }


}