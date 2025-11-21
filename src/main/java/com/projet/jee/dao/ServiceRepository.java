package com.projet.jee.dao;

import com.projet.jee.model.Service;
import jakarta.persistence.*;
import java.util.List;

public class ServiceRepository {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    public List<Service> findAllActif() {
        EntityManager em = emf.createEntityManager();
        List<Service> list = em.createQuery(
            "SELECT s FROM Service s WHERE s.status = com.projet.jee.model.StatutService.ACTIF", Service.class)
            .getResultList();
        em.close();
        return list;
    }
    
    // ✅ AJOUTER cette méthode
    public Service findById(int id) {
        EntityManager em = emf.createEntityManager();
        try {
            Service service = em.find(Service.class, id);
            return service;
        } finally {
            em.close();
        }
    }
}