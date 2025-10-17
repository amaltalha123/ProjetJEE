package com.projet.jee.dao;

import com.projet.jee.model.Reclamation;
import com.projet.jee.model.Utilisateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class ReclamationRepositorymanger {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    public void save(Reclamation reclamation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(reclamation);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Reclamation> findByUtilisateur(Utilisateur utilisateur) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Reclamation> query = em.createQuery(
                "SELECT r FROM Reclamation r WHERE r.utilisateur = :utilisateur ORDER BY r.id DESC", 
                Reclamation.class
            );
            query.setParameter("utilisateur", utilisateur);
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public List<Reclamation> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Reclamation> query = em.createQuery(
                "SELECT r FROM Reclamation r ORDER BY r.id DESC", 
                Reclamation.class
            );
            return query.getResultList();
        } finally {
            em.close();
        }
    }

    public Reclamation findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Reclamation.class, id);
        } finally {
            em.close();
        }
    }

    public void update(Reclamation reclamation) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(reclamation);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}