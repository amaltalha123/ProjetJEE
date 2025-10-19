package com.projet.jee.model;

import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;

@Entity
@Table(name = "Service")
public class Service {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titre;

    @Column(columnDefinition = "TEXT")
    private String description;

    @Enumerated(EnumType.STRING)
    private StatutService status;

    @ManyToOne
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;

    @ManyToOne
    @JoinColumn(name = "manager_id")
    private Manager manager;

    @OneToMany(mappedBy = "service")
    private java.util.List<Demande> demandes;

    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "service", orphanRemoval = true)
    private List<Fonctionnalite> fonctionnalites = new ArrayList<>();
    
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "service", orphanRemoval = true)
    private List<ServicePhoto> photos = new ArrayList<>();
    
    // Add getters/setters
    public List<Fonctionnalite> getFonctionnalites() { return fonctionnalites; }
    public void setFonctionnalites(List<Fonctionnalite> fonctionnalites) { this.fonctionnalites = fonctionnalites; }
    
    public List<ServicePhoto> getPhotos() { return photos; }
    public void setPhotos(List<ServicePhoto> photos) { this.photos = photos; }
    

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitre() {
		return titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public StatutService getStatus() {
		return status;
	}

	public void setStatus(StatutService status) {
		this.status = status;
	}

	public Categorie getCategorie() {
		return categorie;
	}

	public void setCategorie(Categorie categorie) {
		this.categorie = categorie;
	}

	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}

	public java.util.List<Demande> getDemandes() {
		return demandes;
	}

	public void setDemandes(java.util.List<Demande> demandes) {
		this.demandes = demandes;
	}
}
