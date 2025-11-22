package com.projet.jee.model;

import java.util.Date;

import jakarta.persistence.*;

@Entity
@Table(name = "commentaire")
public class Commentaire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(columnDefinition = "TEXT")
    private String contenu;  // Le texte du commentaire

    private Date dateCreation;  // Date et heure de création

    @ManyToOne
    @JoinColumn(name = "auteur_id", nullable = false)  // Clé étrangère vers Utilisateur
    private Utilisateur auteur;  // Auteur du commentaire (Utilisateur)

    @ManyToOne
    @JoinColumn(name = "service_id", nullable = false)
    private DetailService service;  // Relation vers le service

    // Constructeurs
    public Commentaire() {}

    public Commentaire(String contenu, Utilisateur auteur, DetailService service) {
        this.contenu = contenu;
        this.auteur = auteur;
        this.service = service;
        this.dateCreation = new Date();  // Définit automatiquement la date
    }

    // Getters et setters
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

    public Date getDateCreation() {
        return dateCreation;
    }

    public void setDateCreation(Date dateCreation) {
        this.dateCreation = dateCreation;
    }

    public Utilisateur getAuteur() {
        return auteur;
    }

    public void setAuteur(Utilisateur auteur) {
        this.auteur = auteur;
    }

    public DetailService getService() {
        return service;
    }

    public void setService(DetailService service) {
        this.service = service;
    }
}