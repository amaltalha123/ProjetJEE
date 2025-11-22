package com.projet.jee.dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import com.projet.jee.model.Commentaire;

public class CommentaireRepository {

    private EntityManager em;

    public CommentaireRepository(EntityManager em) {
        this.em = em;
    }

    public List<Commentaire> findByServiceId(Long serviceId) {
        String jpql = "SELECT c FROM Commentaire c WHERE c.service.id = :serviceId ORDER BY c.dateCreation DESC";
        TypedQuery<Commentaire> query = em.createQuery(jpql, Commentaire.class);
        query.setParameter("serviceId", serviceId);
        return query.getResultList();
    }
}
