package com.bascode.model.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name="settings")
public class Setting {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String electionName;

    private LocalDate startDate;

    private LocalDate endDate;

    public Setting(){}

    public Long getId(){
        return id;
    }

    public String getElectionName(){
        return electionName;
    }

    public void setElectionName(String electionName){
        this.electionName = electionName;
    }

    public LocalDate getStartDate(){
        return startDate;
    }

    public void setStartDate(LocalDate startDate){
        this.startDate = startDate;
    }

    public LocalDate getEndDate(){
        return endDate;
    }

    public void setEndDate(LocalDate endDate){
        this.endDate = endDate;
    }
}