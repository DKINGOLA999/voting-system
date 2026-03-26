package com.bascode.dao;

import com.bascode.model.entity.Setting;
import jakarta.persistence.*;

public class SettingsDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("VotingPU");

    public Setting getSettings() {
        EntityManager em = emf.createEntityManager();
        try { return em.find(Setting.class, 1); } 
        finally { em.close(); }
    }

    public void updateSettings(Setting s) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(s);
            em.getTransaction().commit();
        } finally { em.close(); }
    }
}