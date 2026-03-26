//package com.bascode.util;
//
//import jakarta.persistence.EntityManagerFactory;
//import jakarta.persistence.Persistence;
//import jakarta.servlet.ServletContextEvent;
//import jakarta.servlet.ServletContextListener;
//import jakarta.servlet.annotation.WebListener;
//
//
//@WebListener
//public class JPAInitializer implements ServletContextListener {
//    private static EntityManagerFactory emf;
//
//    @Override
//    public void contextInitialized(ServletContextEvent sce) {
//        emf = Persistence.createEntityManagerFactory("VotingPU");
//        sce.getServletContext().setAttribute("emf", emf);
//    }
//
//    @Override
//    public void contextDestroyed(ServletContextEvent sce) {
//        if (emf != null && emf.isOpen()) {
//            emf.close(); 
//        }
//    }
//}



package com.bascode.util;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JPAInitializer implements ServletContextListener {

    private EntityManagerFactory emf;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            System.out.println("Initializing JPA...");
            emf = Persistence.createEntityManagerFactory("VotingPU");

            ServletContext context = sce.getServletContext();
            context.setAttribute("emf", emf);

            // Register EMF for static access
            JPAUtil.setEntityManagerFactory(emf);
            // Seed super admin
            seedSuperAdmin();
            System.out.println("JPA Initialized Successfully!");
        } catch (Exception e) {
            System.err.println("JPA Initialization Failed!");
            e.printStackTrace();
            throw new RuntimeException("Failed to initialize JPA", e);
        }
    }

    private void seedSuperAdmin() {
        try (var em = emf.createEntityManager()) {
            em.getTransaction().begin();

            // Check if super admin exists
            var query = em.createQuery("SELECT COUNT(u) FROM User u WHERE u.role = :role", Long.class);
            query.setParameter("role", com.bascode.model.enums.Role.ADMIN);
            Long count = query.getSingleResult();

            if (count == 0) {
                // Create super admin
                var superAdmin = new com.bascode.model.entity.User();
                superAdmin.setFirstName("Super");
                superAdmin.setLastName("Admin");
                superAdmin.setEmail("admin@votify.com");
                superAdmin.setPasswordHash(com.bascode.util.PasswordUtil.hashPassword("admin123"));
                superAdmin.setBirthDate(java.time.LocalDate.of(1990, 1, 1));
                superAdmin.setState("System");
                superAdmin.setCountry("System");
                superAdmin.setRole(com.bascode.model.enums.Role.ADMIN);
                superAdmin.setEmailVerified(true);

                em.persist(superAdmin);
                em.getTransaction().commit();
                System.out.println("Super admin seeded: admin@votify.com / admin123");
            } else {
                em.getTransaction().rollback();
            }
        } catch (Exception e) {
            System.err.println("Failed to seed super admin: " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (emf != null && emf.isOpen()) {
            System.out.println("Closing JPA EntityManagerFactory...");
            emf.close();
            System.out.println("JPA Closed Successfully!");
        }
    }
}