package com.projet.jee.dao;

import com.projet.jee.model.Service;
import com.projet.jee.model.Fonctionnalite;
import com.projet.jee.model.ServicePhoto;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.util.List;

public class MyServiceRepository {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    // ✅ Sauvegarder un service avec fonctionnalités et photos
    public void saveServiceWithDetails(Service service, List<Fonctionnalite> features, List<ServicePhoto> photos) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            // Sauvegarder le service
            em.persist(service);

            // Sauvegarder les fonctionnalités liées
            for (Fonctionnalite f : features) {
                f.setService(service);
                em.persist(f);
            }

            for (ServicePhoto p : photos) {
                p.setService(service);
                em.persist(p);
            }

            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    // ✅ Sauvegarde simple (si besoin)
    public void save(Service service) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(service);
        em.getTransaction().commit();
        em.close();
    }

    // ✅ Récupérer tous les services
    public List<Service> findAll() {
        EntityManager em = emf.createEntityManager();
        List<Service> services = em.createQuery("SELECT s FROM Service s", Service.class)
                .getResultList();
        em.close();
        return services;
    }

    // ✅ Récupérer un service par ID (int)
    public Service findById(int id) {
        EntityManager em = emf.createEntityManager();
        Service service = em.find(Service.class, id);
        em.close();
        return service;
    }

    // ✅ Supprimer un service
    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Service service = em.find(Service.class, id);
        if (service != null) {
            em.remove(service);
        }
        em.getTransaction().commit();
        em.close();
    }

    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}
