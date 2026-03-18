package com.bascode.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;

import com.bascode.model.entity.Voter;
import com.bascode.model.enums.Position;
import com.bascode.util.JPAInitializer;
import com.bascode.util.JPAUtil;

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
    
    public Long countByPosition(Position position) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            // Using a JOIN to ensure JPQL finds the position correctly
            String jpql = "SELECT COUNT(v) FROM Vote v JOIN v.contester c WHERE c.position = :pos";
            return em.createQuery(jpql, Long.class)
                     .setParameter("pos", position)
                     .getSingleResult();
        } catch (Exception e) {
            e.printStackTrace();
            return 0L;
        } finally {
            em.close();
        }
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


