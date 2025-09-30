package com.projet.jee.model;

import jakarta.persistence.*;

@Entity
@Table(name = "Utilisateur")
@Inheritance(strategy = InheritanceType.JOINED) // car Manager hérite
public class Utilisateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String nom;

    @Column(unique = true)
    private String email;

    private String motDePasse;

    @Enumerated(EnumType.STRING)
    private Role role;

    // Relations
    @OneToMany(mappedBy = "utilisateur")
    private java.util.List<Demande> demandes;

    @OneToMany(mappedBy = "utilisateur")
    private java.util.List<Reclamation> reclamations;

    @OneToMany(mappedBy = "utilisateur")
    private java.util.List<Evaluation> evaluations;

	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMotDePasse() {
		return motDePasse;
	}

	public void setMotDePasse(String motDePasse) {
		this.motDePasse = motDePasse;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public java.util.List<Demande> getDemandes() {
		return demandes;
	}

	public void setDemandes(java.util.List<Demande> demandes) {
		this.demandes = demandes;
	}

	public java.util.List<Reclamation> getReclamations() {
		return reclamations;
	}

	public void setReclamations(java.util.List<Reclamation> reclamations) {
		this.reclamations = reclamations;
	}

	public java.util.List<Evaluation> getEvaluations() {
		return evaluations;
	}

	public void setEvaluations(java.util.List<Evaluation> evaluations) {
		this.evaluations = evaluations;
	}

    // Getters & setters
}

