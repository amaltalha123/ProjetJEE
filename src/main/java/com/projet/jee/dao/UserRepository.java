package com.projet.jee.dao;


import com.projet.jee.model.Manager;
import com.projet.jee.model.Utilisateur;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

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
}
