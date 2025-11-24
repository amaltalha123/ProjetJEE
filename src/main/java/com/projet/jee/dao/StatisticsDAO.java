package com.projet.jee.dao;

import com.projet.jee.model.StatutService;

import jakarta.persistence.*;

public class StatisticsDAO {
    @PersistenceContext
    private EntityManager entityManager;

    // Constructeur ou injection via CDI/Spring si nécessaire
    public StatisticsDAO(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    // Nombre de services actifs (utilise DetailService et StatutService.ACTIF)
    public Long getActiveServicesCount(int id) {
        if (entityManager == null) {
            throw new IllegalStateException("EntityManager n'est pas initialisé");
        }
        Query query = entityManager.createQuery("SELECT COUNT(ds) FROM DetailService ds WHERE ds.status = :status AND ds.manager.id = :managerId");
        query.setParameter("status", StatutService.ACTIF);
        query.setParameter("managerId", id);
        return (Long) query.getSingleResult();
    }

    // Nombre de services archivés (utilise DetailService et StatutService.ARCHIVE)
    public Long getArchivedServicesCount(int id) {
        if (entityManager == null) {
            throw new IllegalStateException("EntityManager n'est pas initialisé");
        }
        Query query = entityManager.createQuery("SELECT COUNT(ds) FROM Service ds WHERE ds.status = :status AND ds.manager.id = :managerId");
        query.setParameter("status",StatutService.ARCHIVE);  // Valeur de l'enum comme STRING
        query.setParameter("managerId", id);
        return (Long) query.getSingleResult();
    }

    // Nombre total de demandes (utilise l'entité Demande)
    public Long getTotalRequestsCount(int id) {
        if (entityManager == null) {
            throw new IllegalStateException("EntityManager n'est pas initialisé");
        }
        Query query = entityManager.createQuery("SELECT COUNT(d) FROM Demande d WHERE d.utilisateur.id = :utilisateurId");
        query.setParameter("utilisateurId", id);
        return (Long) query.getSingleResult();
    }

    // Nombre total de réclamations (utilise l'entité Reclamation)
    public Long getTotalComplaintsCount(int id) {
        if (entityManager == null) {
            throw new IllegalStateException("EntityManager n'est pas initialisé");
        }
        Query query = entityManager.createQuery("SELECT COUNT(r) FROM Reclamation r WHERE r.utilisateur.id = :utilisateurId");
        query.setParameter("utilisateurId", id);
        return (Long) query.getSingleResult();
    }
}