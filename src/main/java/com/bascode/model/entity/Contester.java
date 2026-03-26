package com.bascode.model.entity;

import java.util.List;

import com.bascode.model.enums.ContesterStatus;
import com.bascode.model.enums.Position;

import jakarta.persistence.*;

@Entity
@Table(name = "contesters")
public class Contester {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    private User user;

    @Enumerated(EnumType.STRING)
    private Position position;

    @Enumerated(EnumType.STRING)
    private ContesterStatus status;
    
    @OneToMany(mappedBy = "contester", fetch = FetchType.LAZY)
    private List<Vote> votes;

    // Add Getter
    public List<Vote> getVotes() { return votes; }

<<<<<<< HEAD
    @Column(length = 2500) // 500 words max (approx 5 chars per word)
    private String manifesto;

=======
    private String reason;

	private String lastName;

    public String getReason(){
    return reason;
    }

    public void setReason(String reason){
    this.reason = reason;
    }
>>>>>>> recovery-branch
    
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Position getPosition() {
		return position;
	}

	public void setPosition(Position position) {
		this.position = position;
	}

	public ContesterStatus getStatus() {
		return status;
	}

	public void setStatus(ContesterStatus status) {
		this.status = status;
	}
<<<<<<< HEAD

	public String getManifesto() {
		return manifesto;
	}

	public void setManifesto(String manifesto) {
		this.manifesto = manifesto;
	}
    
    
=======
	public String getFirstName() {
		return getFirstName();
	}
	public void setFirstName(String FirstName) {
	}
	public String getLastName() {
		return getLastName();
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public boolean isApproved() {
		// TODO Auto-generated method stub
		return false;
	}
>>>>>>> recovery-branch
}
