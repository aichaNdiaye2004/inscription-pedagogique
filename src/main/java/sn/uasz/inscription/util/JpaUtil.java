package sn.uasz.inscription.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class JpaUtil {

    private static final EntityManagerFactory emf;

    static {
        try {
            emf = Persistence.createEntityManagerFactory("InscriptionPU"); // Vérifie le nom dans persistence.xml
        } catch (Throwable ex) {
            System.err.println("Initialisation de EntityManagerFactory échouée : " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    // Renvoie l'EntityManagerFactory
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }

    // Crée et renvoie un EntityManager
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    // Ferme l'EntityManagerFactory (à appeler à la fin de l'application)
    public static void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
