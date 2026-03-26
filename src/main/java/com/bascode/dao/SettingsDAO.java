package com.bascode.dao;

import com.bascode.model.entity.Setting;
import jakarta.persistence.*;

public class SettingsDAO {
    // Make sure "VotingPU" matches your persistence.xml
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("VotingPU");

    public Setting getSettings() {
        EntityManager em = emf.createEntityManager();
        try {
            // We usually only have one row of settings (ID 1)
            Setting s = em.find(Setting.class, 1);
            return s;
        } finally {
            em.close();
        }
    }

    public void updateSettings(Setting setting) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction et = em.getTransaction();
        try {
            et.begin();
            setting.setId(1); // Force it to always update the first row
            em.merge(setting);
            et.commit();
        } catch (Exception e) {
            if (et.isActive()) et.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}