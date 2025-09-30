package com.projet.jee.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Manager")
@PrimaryKeyJoinColumn(name = "id")
public class Manager extends Utilisateur {

    private String telephone;

    @Enumerated(EnumType.STRING)
    private Abonnement abonnement;

    @OneToMany(mappedBy = "manager")
    private java.util.List<Service> services;

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public Abonnement getAbonnement() {
		return abonnement;
	}

	public void setAbonnement(Abonnement abonnement) {
		this.abonnement = abonnement;
	}

	public java.util.List<Service> getServices() {
		return services;
	}

	public void setServices(java.util.List<Service> services) {
		this.services = services;
	}
}
