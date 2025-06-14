package sn.uasz.inscription.test;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class TestConnexionJpa {
    public static void main(String[] args) {
        try {
            EntityManagerFactory emf = Persistence.createEntityManagerFactory("InscriptionPU");
            EntityManager em = emf.createEntityManager();

            System.out.println("✅ Connexion à la base de données établie avec succès.");

            em.close();
            emf.close();
        } catch (Exception e) {
            System.err.println("❌ Erreur de connexion à la base de données : " + e.getMessage());
            e.printStackTrace();
        }
    }
}
