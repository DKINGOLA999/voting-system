package com.bascode.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import com.bascode.model.entity.Contester;
import com.bascode.util.JPAInitializer;

public class ContestantDAO {
	
	
	public void approve(Long id){

		EntityManager em = emf.createEntityManager();

		em.getTransaction().begin();

		Contester c = em.find(Contester.class,id);

		c.setStatus(com.bascode.model.enums.ContesterStatus.APPROVED);

		em.getTransaction().commit();

		em.close();

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