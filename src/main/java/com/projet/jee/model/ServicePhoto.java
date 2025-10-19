package com.projet.jee.model;


import jakarta.persistence.*;

@Entity
@Table(name = "service_photo")
public class ServicePhoto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Lob
    @Column(columnDefinition = "LONGBLOB")
    private byte[] photo; 

    @ManyToOne
    @JoinColumn(name = "service_id")
    private Service service;

    // Getters et setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public byte[] getPhoto() {
        return photo;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public Service getService() {
        return service;
    }

    public void setService(Service service) {
        this.service = service;
    }
}