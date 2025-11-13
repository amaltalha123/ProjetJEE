package com.projet.jee.dao;

import com.projet.jee.model.Reclamation;
import com.projet.jee.model.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
        Map<Reclamation, Boolean> reclamationsWithStatus = new LinkedHashMap<>(); // Changé à LinkedHashMap
        
        if (emf == null) {
            return reclamationsWithStatus;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            
            // Calculer l'offset
            int offset = (page - 1) * pageSize;
            
            // Récupérer les réclamations avec pagination et tri STRICT
            List<Reclamation> reclamations = em.createQuery(
                "SELECT r FROM Reclamation r ORDER BY r.dateCreation DESC, r.id DESC", 
                Reclamation.class
            )
            .setFirstResult(offset)
            .setMaxResults(pageSize)
            .getResultList();
            
            // DEBUG : Affichez l'ordre dans les logs
            logger.info("=== ORDRE DES RÉCLAMATIONS ===");
            for (Reclamation r : reclamations) {
                logger.info("ID: " + r.getId() + " | Date: " + r.getDateCreation() + " | État: " + r.isEtat());
            }
            logger.info("=== TOTAL: " + reclamations.size() + " réclamations ===");
            
            // Associer chaque réclamation avec son statut "nouveau"
            for (Reclamation reclamation : reclamations) {
                boolean isNew = !reclamation.isEtat();
                reclamationsWithStatus.put(reclamation, isNew);
            }
            
            return reclamationsWithStatus;
            
        } catch (Exception e) {
            logger.severe("💥 ERREUR findAllWithReadStatus: " + e.getMessage());
            return reclamationsWithStatus;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public Map<Reclamation, Boolean> findAllWithReadStatusByRole(int page, int pageSize, Role role) {
        Map<Reclamation, Boolean> reclamationsWithStatus = new LinkedHashMap<>(); // Changé à LinkedHashMap
        
        if (emf == null) {
            return reclamationsWithStatus;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            
            int offset = (page - 1) * pageSize;
            
            // Tri STRICT par date et ID
            String queryStr = "SELECT r FROM Reclamation r WHERE r.utilisateur.role = :role ORDER BY r.dateCreation DESC, r.id DESC";
            List<Reclamation> reclamations = em.createQuery(queryStr, Reclamation.class)
                .setParameter("role", role)
                .setFirstResult(offset)
                .setMaxResults(pageSize)
                .getResultList();
            
            // DEBUG
            logger.info("=== ORDRE DES RÉCLAMATIONS PAR ROLE: " + role + " ===");
            for (Reclamation r : reclamations) {
                logger.info("ID: " + r.getId() + " | Date: " + r.getDateCreation() + " | User: " + 
                           (r.getUtilisateur() != null ? r.getUtilisateur().getEmail() : "null"));
            }
            
            for (Reclamation reclamation : reclamations) {
                boolean isNew = !reclamation.isEtat();
                reclamationsWithStatus.put(reclamation, isNew);
            }
            
            return reclamationsWithStatus;
            
        } catch (Exception e) {
            logger.severe("💥 ERREUR findAllWithReadStatusByRole: " + e.getMessage());
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
    
    public int getUnreadCountByRole(Role role) {
        if (emf == null) {
            return 0;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Reclamation r WHERE r.etat = false AND r.utilisateur.role = :role", 
                Long.class
            ).setParameter("role", role).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getUnreadCountByRole: " + e.getMessage());
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
    
    public int getCountByRole(Role role) {
        if (emf == null) {
            return 0;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            Long count = em.createQuery(
                "SELECT COUNT(r) FROM Reclamation r WHERE r.utilisateur.role = :role", 
                Long.class
            ).setParameter("role", role).getSingleResult();
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            logger.severe("💥 ERREUR getCountByRole: " + e.getMessage());
            return 0;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public Reclamation findById(int id) {
        if (emf == null) {
            return null;
        }
        
        EntityManager em = emf.createEntityManager();
        try {
            Reclamation reclamation = em.find(Reclamation.class, id);
            if (reclamation != null) {
                logger.info("✅ Réclamation trouvée - ID: " + id + " | Date: " + reclamation.getDateCreation());
            }
            return reclamation;
        } catch (Exception e) {
            logger.severe("💥 ERREUR findById: " + e.getMessage());
            return null;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public boolean markAsRead(int id) {
        if (emf == null) {
            return false;
        }
        
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            int updated = em.createQuery(
                "UPDATE Reclamation r SET r.etat = true WHERE r.id = :id"
            )
            .setParameter("id", id)
            .executeUpdate();
            em.getTransaction().commit();
            
            logger.info("✅ Réclamation #" + id + " marquée comme lue - " + (updated > 0 ? "SUCCÈS" : "ÉCHEC"));
            return updated > 0;
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("❌ Erreur markAsRead: " + e.getMessage());
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    public boolean updateReponse(int id, String reponse) {
        if (emf == null) {
            return false;
        }
        
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            int updated = em.createQuery(
                "UPDATE Reclamation r SET r.reponseAdmin = :reponse WHERE r.id = :id"
            )
            .setParameter("reponse", reponse)
            .setParameter("id", id)
            .executeUpdate();
            em.getTransaction().commit();
            
            logger.info("✅ Réponse mise à jour pour réclamation #" + id + " - " + (updated > 0 ? "SUCCÈS" : "ÉCHEC"));
            return updated > 0;
            
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.severe("❌ Erreur updateReponse: " + e.getMessage());
            return false;
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    
    // Méthode de test pour vérifier l'ordre sans pagination
    public void debugOrder() {
        if (emf == null) {
            return;
        }
        
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            
            List<Reclamation> reclamations = em.createQuery(
                "SELECT r FROM Reclamation r ORDER BY r.dateCreation DESC, r.id DESC", 
                Reclamation.class
            ).getResultList();
            
            logger.info("=== DEBUG COMPLET - ORDRE DES RÉCLAMATIONS ===");
            for (Reclamation r : reclamations) {
                logger.info("ID: " + r.getId() + 
                          " | Date: " + r.getDateCreation() + 
                          " | État: " + r.isEtat() + 
                          " | User: " + (r.getUtilisateur() != null ? r.getUtilisateur().getEmail() : "null"));
            }
            logger.info("=== TOTAL GÉNÉRAL: " + reclamations.size() + " réclamations ===");
            
        } catch (Exception e) {
            logger.severe("💥 ERREUR debugOrder: " + e.getMessage());
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

    public List<Reclamation> findAll() {
        // TODO: Implémenter si nécessaire
        return null;
    }
}