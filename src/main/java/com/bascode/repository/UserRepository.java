package com.bascode.repository;

import com.bascode.model.entity.User;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

/*
 Repository Layer

 Responsible ONLY for database access.

 This ensures:
 - controllers never talk to the database
 - services stay clean
 - easier testing and maintenance
*/

public class UserRepository {

    private EntityManager em;

    public UserRepository(EntityManager em){
        this.em = em;
    }

    // Find user by email
    public User findByEmail(String email){

        try{

            TypedQuery<User> query =
                    em.createQuery(
                            "SELECT u FROM User u WHERE u.email=:email",
                            User.class
                    );

            query.setParameter("email",email);

            return query.getSingleResult();

        }catch(Exception e){

            return null;
        }
    }

    // Save user
    public void save(User user){

        em.persist(user);

    }

}