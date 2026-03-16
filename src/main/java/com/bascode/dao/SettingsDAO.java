package com.bascode.dao;

import com.bascode.model.entity.Setting;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.time.LocalDate;

public class SettingsDAO {

    private static EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("votingPU");


    public void saveSettings(String electionName, String start, String end){

        EntityManager em = emf.createEntityManager();

        em.getTransaction().begin();

        Setting setting;

        try{

            setting = em.createQuery(
                "SELECT s FROM Setting s",
                Setting.class
            ).setMaxResults(1).getSingleResult();

        }catch(Exception e){

            setting = new Setting();
        }

        setting.setElectionName(electionName);
        setting.setStartDate(LocalDate.parse(start));
        setting.setEndDate(LocalDate.parse(end));

        if(setting.getId()==null){
            em.persist(setting);
        }else{
            em.merge(setting);
        }

        em.getTransaction().commit();

        em.close();
    }


    public Setting getSettings(){

        EntityManager em = emf.createEntityManager();

        try{

            return em.createQuery(
                "SELECT s FROM Setting s",
                Setting.class
            ).setMaxResults(1).getSingleResult();

        }catch(Exception e){
            return null;
        }
    }

}