package com.projet.jee.dao;


import com.projet.jee.model.Manager;
import com.projet.jee.model.Utilisateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
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
}
