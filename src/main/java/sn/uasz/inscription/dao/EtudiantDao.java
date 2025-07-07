package sn.uasz.inscription.dao;

import jakarta.persistence.*;
import sn.uasz.inscription.entities.Etudiant;
import sn.uasz.inscription.util.JpaUtil;

import java.util.List;

public class EtudiantDao {
	
	public EtudiantDao() {
    }
	
	public void create(Etudiant e) {
	    EntityManager em = JpaUtil.getEntityManager();
	    EntityTransaction tx = em.getTransaction();
	    try {
	        System.out.println("➡️ Création de l’étudiant : " + e);
	        tx.begin();
	        em.persist(e);
	        System.out.println("✔️ Persist effectué");
	        tx.commit();
	        System.out.println("✅ Étudiant ajouté avec succès !");
	    } catch (Exception ex) {
	        if (tx.isActive()) tx.rollback();
	        ex.printStackTrace();
	    } finally {
	        em.close();
	    }
	}

	public List<Etudiant> findEtudiantsInscritsAUneUE(String codeUE) {
	    EntityManager em = JpaUtil.getEntityManager();
	    try {
	        String jpql = "SELECT DISTINCT e FROM Etudiant e " +  // Ajout espace après "e"
	                      "LEFT JOIN e.uesOptionnelles opt " +
	                      "JOIN e.formation f " +
	                      "JOIN f.ues u " +
	                      "WHERE opt.code = :codeUE OR (u.code = :codeUE AND u.obligatoire = true)";
	        TypedQuery<Etudiant> query = em.createQuery(jpql, Etudiant.class);
	        query.setParameter("codeUE", codeUE);
	        return query.getResultList();
	    } finally {
	        em.close();
	    }
	}

    public void update(Etudiant e) {
    	EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.merge(e);
            tx.commit();
        } catch (Exception ex) {
            if (tx.isActive()) tx.rollback();
            ex.printStackTrace();
        } finally {
            em.close();
        }
    }
    
    public Etudiant findByEmail(String email) {
        EntityManager em = JpaUtil.getEntityManager();
        Etudiant etudiant = null;
        try {
            etudiant = em.createQuery(
                "SELECT e FROM Etudiant e LEFT JOIN FETCH e.formation LEFT JOIN FETCH e.uesOptionnelles WHERE LOWER(e.email) = :email",
                Etudiant.class)
                .setParameter("email", email.toLowerCase())
                .getSingleResult();
        } catch (NoResultException ex) {
            // Aucun résultat trouvé
        } finally {
            em.close();
        }
        return etudiant;
    }

    public Etudiant findByIne(String ine) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Etudiant> query = em.createQuery(
                "SELECT e FROM Etudiant e LEFT JOIN FETCH e.uesOptionnelles WHERE e.ine = :ine", Etudiant.class);
            query.setParameter("ine", ine);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null; // Aucun étudiant trouvé
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findEtudiantsByUE(Long ueCode) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Etudiant e JOIN e.uesOptionnelles u WHERE u.code = :code", Etudiant.class)
                .setParameter("code", ueCode)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public Etudiant save(Etudiant etudiant) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Etudiant merged = em.merge(etudiant);
            tx.commit();
            return merged;
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findAll() {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Etudiant e", Etudiant.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void deleteByIne(String ine) {
        EntityManager em = JpaUtil.getEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            Etudiant etudiant = em.find(Etudiant.class, ine);
            if (etudiant != null) {
                em.remove(etudiant);
            }
            tx.commit();
        } catch (Exception e) {
            if (tx.isActive()) {
                tx.rollback();
            }
            throw e;
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByFormation(Long formationId) {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Etudiant e WHERE e.formation.id = :id", Etudiant.class)
                    .setParameter("id", formationId)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByUE(Long codeUE) {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT e FROM Etudiant e JOIN e.uesOptionnelles ue WHERE ue.code = :code", Etudiant.class)
                    .setParameter("code", codeUE)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByGroupeTD(int groupeTD) {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Etudiant e WHERE e.groupeTD = :gtd", Etudiant.class)
                    .setParameter("gtd", groupeTD)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByGroupeTP(int groupeTP) {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery("SELECT e FROM Etudiant e WHERE e.groupeTP = :gtp", Etudiant.class)
                    .setParameter("gtp", groupeTP)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByInscriptionValidee(boolean validee) {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Etudiant> query = em.createQuery(
                "SELECT e FROM Etudiant e WHERE e.inscriptionValidee = :validee", Etudiant.class);
            query.setParameter("validee", validee);
            return query.getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Etudiant> findAllWithFormation() {
    	EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Etudiant e LEFT JOIN FETCH e.formation", Etudiant.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByInscriptionValideeWithFormation(boolean validee) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Etudiant e LEFT JOIN FETCH e.formation WHERE e.inscriptionValidee = :validee", Etudiant.class)
                .setParameter("validee", validee)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findAllWithUesOptionnelles() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT DISTINCT e FROM Etudiant e LEFT JOIN FETCH e.uesOptionnelles LEFT JOIN FETCH e.formation", Etudiant.class)
                .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Etudiant> findByInscriptionNonValideeOuNull() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT e FROM Etudiant e WHERE e.inscriptionValidee = false OR e.inscriptionValidee IS NULL",
                Etudiant.class)
                .getResultList();
        } finally {
            em.close();
        }
    }
    
    public List<Etudiant> findByUECode(Long ueCode) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                "SELECT DISTINCT e FROM Etudiant e " +
                "LEFT JOIN e.uesOptionnelles uo " +
                "LEFT JOIN e.ues u " +
                "WHERE (uo.code = :code OR u.code = :code)", Etudiant.class)
                .setParameter("code", ueCode)
                .getResultList();
        } finally {
            em.close();
        }
    }

}
