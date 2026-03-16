package com.bascode.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import com.bascode.model.entity.User;
import com.bascode.util.JPAInitializer;

public class UserDAO {

    EntityManagerFactory emf = JPAInitializer.getEntityManagerFactory();

    public List<User> getAllUsers() {

        EntityManager em = emf.createEntityManager();

        List<User> users =
        em.createQuery("SELECT u FROM User u", User.class)
        .getResultList();

        em.close();

        return users;
    }


    public Long countUsers(){

        EntityManager em = emf.createEntityManager();

        Long count =
        em.createQuery("SELECT COUNT(u) FROM User u", Long.class)
        .getSingleResult();

        em.close();

        return count;
    }

}