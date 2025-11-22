package com.projet.jee.model;

import jakarta.persistence.*;

@Entity
@Table(name = "evaluation")
public class Evaluation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "TEXT", nullable = true)
    private String contenu;

    private int nbr_etoile; // contrainte à gérer côté code/service

    @ManyToOne
    @JoinColumn(name = "utilisateur_id")
    private Utilisateur utilisateur;

    @ManyToOne
    @JoinColumn(name = "service_id")
    private DetailService service;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getContenu() {
		return contenu;
	}

	public void setContenu(String contenu) {
		this.contenu = contenu;
	}

	public int getNbr_etoile() {
		return nbr_etoile;
	}

	public void setNbr_etoile(int nbr_etoile) {
		this.nbr_etoile = nbr_etoile;
	}

	public Utilisateur getUtilisateur() {
		return utilisateur;
	}

public void setUtilisateur(Utilisateur utilisateur) {
			this.utilisateur = utilisateur;
		}

		public DetailService getService() {
			return service;
		}

		public void setService(DetailService service) {
			this.service = service;
		}
}
