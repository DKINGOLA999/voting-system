package com.bascode.dao;

import jakarta.persistence.*;

import com.bascode.model.entity.Vote;
import com.bascode.model.entity.User;
import com.bascode.model.entity.Contester;
import jakarta.persistence.EntityManager;

import com.bascode.util.JPAInitializer;
import com.bascode.util.JPAUtil;
import com.bascode.model.enums.Position;

public class VoteDAO {

EntityManagerFactory emf =
JPAInitializer.getEntityManagerFactory();


public void castVote(Long voterId, Long contesterId){

EntityManager em = emf.createEntityManager();

em.getTransaction().begin();

User voter = em.find(User.class, voterId);

Contester contester = em.find(Contester.class, contesterId);

Vote vote = new Vote();

vote.setVoter(voter);

vote.setContester(contester);

em.persist(vote);

em.getTransaction().commit();

em.close();

}


public java.util.List<Vote> getAllVotes(){

EntityManager em = emf.createEntityManager();

java.util.List<Vote> votes =
em.createQuery("SELECT v FROM Vote v", Vote.class)
.getResultList();

em.close();

return votes;

}

public Long countByPosition(Position position){

    EntityManager em = JPAUtil.getEntityManager();

    try{
        return em.createQuery(
            "SELECT COUNT(v) FROM Vote v WHERE v.contester.position = :pos",
            Long.class)
            .setParameter("pos", position)
            .getSingleResult();

    } finally {
        em.close();
    }
}

}