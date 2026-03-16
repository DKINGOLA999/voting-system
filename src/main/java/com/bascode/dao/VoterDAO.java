package com.bascode.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import com.bascode.model.entity.Voter;
import com.bascode.util.JPAInitializer;

public class VoterDAO {

    EntityManagerFactory emf = JPAInitializer.getEntityManagerFactory();

    public List<Voter> getAllVoters() {

        EntityManager em = emf.createEntityManager();

        List<Voter> voters =
        em.createQuery("SELECT v FROM Voter v", Voter.class)
        .getResultList();

        em.close();

        return voters;
    }
    public List<Voter> searchByEmail(String email){

    	EntityManager em = emf.createEntityManager();

    	List<Voter> voters = em.createQuery(
    	"SELECT v FROM Voter v WHERE v.email LIKE :email",
    	Voter.class)
    	.setParameter("email","%"+email+"%")
    	.getResultList();

    	em.close();

    	return voters;
    	}
   
}


