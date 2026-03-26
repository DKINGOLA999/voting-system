package com.bascode.util;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

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
        return emf.createEntityManager();
    }
}