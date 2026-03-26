package com.bascode.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import com.bascode.model.entity.Contester;
import com.bascode.model.enums.Position;
import com.bascode.util.JPAInitializer;
import com.bascode.util.JPAUtil;

public class ContestantDAO {
	
	
	public void approve(Long id){

		EntityManager em = emf.createEntityManager();

		em.getTransaction().begin();

		Contester c = em.find(Contester.class,id);

		c.setStatus(com.bascode.model.enums.ContesterStatus.APPROVED);

		em.getTransaction().commit();

		em.close();

		}

	// ADD THESE METHODS TO ContestantDAO.java

	// 1. Get the Leaderboard (All contestants sorted by highest votes)
	public List<Contester> getAllContestantsOrderedByVotes() {
	    EntityManager em = JPAUtil.getEntityManager(); 
	    try {
	        // This query joins Contester with their votes and sorts by the count
	        return em.createQuery(
	            "SELECT c FROM Contester c ORDER BY size(c.votes) DESC", Contester.class)
	            .getResultList();
	    } finally {
	        em.close();
	    }
	}

	// 2. Get the winner's name for a specific position
	public String getWinnerByPosition(Position position) {
	    EntityManager em = JPAUtil.getEntityManager();
	    try {
	        List<Contester> results = em.createQuery(
	            "SELECT c FROM Contester c WHERE c.position = :pos ORDER BY size(c.votes) DESC", Contester.class)
	            .setParameter("pos", position)
	            .setMaxResults(1) // Only get the top person
	            .getResultList();
	            
	        return results.isEmpty() ? "No Candidate" : results.get(0).getFirstName();
	    } finally {
	        em.close();
	    }
	}

		public void deny(Long id){

		EntityManager em = emf.createEntityManager();

		em.getTransaction().begin();

		Contester c = em.find(Contester.class,id);

		c.setStatus(com.bascode.model.enums.ContesterStatus.DENIED);

		em.getTransaction().commit();

		em.close();

		}

    EntityManagerFactory emf = JPAInitializer.getEntityManagerFactory();

    public List<Contester> getAllContestants() {

        EntityManager em = emf.createEntityManager();

        List<Contester> contesters =
        em.createQuery("SELECT c FROM Contester c", Contester.class)
        .getResultList();

        em.close();
        
        

        return contesters;
    }
}