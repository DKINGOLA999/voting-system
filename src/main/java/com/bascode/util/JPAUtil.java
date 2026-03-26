package com.bascode.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
<<<<<<< HEAD

public class JPAUtil {

    private static EntityManagerFactory emf;

    // Register EMF from JPAInitializer
    public static void setEntityManagerFactory(EntityManagerFactory factory) {
        emf = factory;
    }

    // Get a new EntityManager
    public static EntityManager getEntityManager() {
        if (emf == null) {
            throw new IllegalStateException("EntityManagerFactory not initialized");
        }
=======
import jakarta.persistence.Persistence;

public class JPAUtil {

    private static final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("VotingPU");

    public static EntityManager getEntityManager() {
>>>>>>> recovery-branch
        return emf.createEntityManager();
    }
}