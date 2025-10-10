package com.projet.jee.dao;

import com.projet.jee.model.Categorie;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class CategorieRepository {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    public void save(Categorie c) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(c);
        em.getTransaction().commit();
        em.close();
    }

    public List<Categorie> findAll() {
        EntityManager em = emf.createEntityManager();
        List<Categorie> list = em.createQuery("SELECT c FROM Categorie c", Categorie.class).getResultList();
        em.close();
        return list;
    }

    public Categorie findById(int id) {
        EntityManager em = emf.createEntityManager();
        Categorie c = em.find(Categorie.class, id);
        em.close();
        return c;
    }

    public void update(Categorie c) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.merge(c);
        em.getTransaction().commit();
        em.close();
    }

    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Categorie c = em.find(Categorie.class, id);
        if (c != null) em.remove(c);
        em.getTransaction().commit();
        em.close();
    }
}
