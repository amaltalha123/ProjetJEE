package com.projet.jee.dao;


import com.projet.jee.model.Manager;
import com.projet.jee.model.Utilisateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

public class UserRepository {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    public void save(Utilisateur user) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(user);
        em.getTransaction().commit();
        em.close();
    }


    public Manager find(Long id) {
        EntityManager em = emf.createEntityManager();
        Manager user = em.find(Manager.class, id);
        em.close();
        return user;
    }
     
    public Utilisateur findByEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Utilisateur> q = em.createQuery(
                "SELECT u FROM Utilisateur u WHERE u.email = :email", Utilisateur.class);
            q.setParameter("email", email);
            return q.getResultStream().findFirst().orElse(null);
        } finally {
            em.close();
        }
    }
    public Utilisateur findById(Long id) {
        EntityManager em = emf.createEntityManager();
        Utilisateur user = em.find(Utilisateur.class, id);
        em.close();
        return user;
    }
    
    public boolean isExiste(Utilisateur utilisateur) {
        EntityManager em = emf.createEntityManager(); // Assurez-vous d'avoir une méthode pour obtenir l'EntityManager
        try {
            Query query = em.createQuery("SELECT COUNT(u) FROM Utilisateur u WHERE u.email = :email");
            query.setParameter("email", utilisateur.getEmail());
            Long count = (Long) query.getSingleResult();
            return count > 0; 
        } catch (Exception e) {
            e.printStackTrace();
            return false; // En cas d'erreur, assumer qu'il n'existe pas (ou gérer différemment)
        } finally {
            em.close();
        }
    }
    
 // Ajoutez cette méthode à la fin de votre UserRepository existant
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
