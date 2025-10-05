package com.projet.jee.dao;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;
import java.util.logging.Logger;

public class StatisticsRepository {
    
    private static final Logger logger = Logger.getLogger(StatisticsRepository.class.getName());
    private EntityManagerFactory emf;
    
    public StatisticsRepository() {
        try {
            emf = Persistence.createEntityManagerFactory("DemoPU");
        } catch (Exception e) {
            logger.severe("❌ Erreur EntityManagerFactory: " + e.getMessage());
        }
    }
    
    public int getTotalUsers() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(u) FROM Utilisateur u", 
                Long.class
            ).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getTotalUsers: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public int getUsersByRole(String role) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(u) FROM Utilisateur u WHERE u.role = :role", 
                Long.class
            )
            .setParameter("role", com.projet.jee.model.Role.valueOf(role))
            .getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getUsersByRole: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public List<Object[]> getRecentUsers(int limit) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery(
                "SELECT u.id, u.email, u.role, u.nom FROM Utilisateur u ORDER BY u.id DESC", 
                Object[].class
            )
            .setMaxResults(limit)
            .getResultList();
        } catch (Exception e) {
            logger.severe("💥 ERREUR getRecentUsers: " + e.getMessage());
            return java.util.Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public int getTotalCategories() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(c) FROM Categorie c", 
                Long.class
            ).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getTotalCategories: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public int getTotalReclamations() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Reclamation r", 
                Long.class
            ).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getTotalReclamations: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public int getActiveReclamations() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Reclamation r WHERE r.etat = false", 
                Long.class
            ).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getActiveReclamations: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public List<Object[]> getRecentReclamations(int limit) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            return em.createQuery(
                "SELECT r.id, u.email, r.contenu, r.etat FROM Reclamation r JOIN r.utilisateur u ORDER BY r.id DESC", 
                Object[].class
            )
            .setMaxResults(limit)
            .getResultList();
        } catch (Exception e) {
            logger.severe("💥 ERREUR getRecentReclamations: " + e.getMessage());
            return java.util.Collections.emptyList();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}