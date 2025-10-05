package com.projet.jee.dao;

import com.projet.jee.model.Reclamation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class ReclamationRepository {
    
    private static final Logger logger = Logger.getLogger(ReclamationRepository.class.getName());
    private EntityManagerFactory emf;
    
    public ReclamationRepository() {
        try {
            emf = Persistence.createEntityManagerFactory("DemoPU");
        } catch (Exception e) {
            logger.severe("❌ Erreur EntityManagerFactory: " + e.getMessage());
        }
    }
    
    public Map<Reclamation, Boolean> findAllWithReadStatus(int page, int pageSize) {
        Map<Reclamation, Boolean> reclamationsWithStatus = new HashMap<>();
        
        if (emf == null) {
            return reclamationsWithStatus;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            
            // Calculer l'offset
            int offset = (page - 1) * pageSize;
            
            // Récupérer les réclamations avec pagination
            List<Reclamation> reclamations = em.createQuery(
                "SELECT r FROM Reclamation r ORDER BY r.etat ASC, r.id DESC", 
                Reclamation.class
            )
            .setFirstResult(offset)
            .setMaxResults(pageSize)
            .getResultList();
            
            // Associer chaque réclamation avec son statut "nouveau" (etat = 0)
            for (Reclamation reclamation : reclamations) {
                boolean isNew = (reclamation.isEtat() == false);
                reclamationsWithStatus.put(reclamation, isNew);
            }
            
            return reclamationsWithStatus;
            
        } catch (Exception e) {
            logger.severe("💥 ERREUR: " + e.getMessage());
            return reclamationsWithStatus;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public int getUnreadCount() {
        if (emf == null) {
            return 0;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Reclamation r WHERE r.etat = false", 
                Long.class
            ).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getUnreadCount: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public int getTotalCount() {
        if (emf == null) {
            return 0;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Reclamation r", 
                Long.class
            ).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getTotalCount: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public Reclamation findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Reclamation.class, id);
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
    
    public boolean markAsRead(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            int updated = em.createNativeQuery(
                "UPDATE reclamation SET etat = 1 WHERE id = :id"
            ).setParameter("id", id).executeUpdate();
            em.getTransaction().commit();
            return updated > 0;
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("❌ Erreur markAsRead: " + e.getMessage());
            return false;
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
    
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}