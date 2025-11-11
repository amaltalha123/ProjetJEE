package com.projet.jee.model;

import jakarta.persistence.*;
import java.util.List;
import java.util.Set;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

@Entity
@Table(name = "service")
public class DetailService {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String titre;
    private String description;
    private String status;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "categorie_id")
    private Categorie categorie;

    // ✅ On garde List ici
    @OneToMany(mappedBy = "service", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private List<Fonctionnalite> fonctionnalites;

    // ✅ On change List → Set ici
    @OneToMany(mappedBy = "service", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    @Fetch(FetchMode.SUBSELECT)
    private Set<ServicePhoto> photos;

    // === Getters et Setters ===
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getTitre() { return titre; }
    public void setTitre(String titre) { this.titre = titre; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Categorie getCategorie() { return categorie; }
    public void setCategorie(Categorie categorie) { this.categorie = categorie; }

    public List<Fonctionnalite> getFonctionnalites() { return fonctionnalites; }
    public void setFonctionnalites(List<Fonctionnalite> fonctionnalites) { this.fonctionnalites = fonctionnalites; }

    public Set<ServicePhoto> getPhotos() { return photos; }
    public void setPhotos(Set<ServicePhoto> photos) { this.photos = photos; }
}
