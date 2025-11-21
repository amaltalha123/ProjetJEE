package com.projet.jee.dao;

import com.projet.jee.model.Demande;
import jakarta.persistence.*;

import java.sql.Date;
import java.util.List;

public class DemandeRepository {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    public void save(Demande demande) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(demande);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace(); // Afficher l'erreur pour le diagnostic
            throw new RuntimeException("Erreur lors de l'enregistrement de la demande", e);
        } finally {
            em.close();
        }
    }

    public void update(Demande demande) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(demande);
            em.getTransaction().commit();
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace(); // Afficher l'erreur pour le diagnostic
            throw new RuntimeException("Erreur lors de la mise à jour de la demande", e);
        } finally {
            em.close();
        }
    }

    public void delete(int id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Demande d = em.find(Demande.class, id);
        if (d != null) em.remove(d);
        em.getTransaction().commit();
        em.close();
    }

    public List<Demande> findByManagerId(int managerId) {
        EntityManager em = emf.createEntityManager();
        try {
            List<Demande> list = em.createQuery(
                "SELECT d FROM Demande d " +
                "LEFT JOIN FETCH d.service s " +
                "LEFT JOIN FETCH d.utilisateur u " +
                "WHERE u.id = :managerId", Demande.class)
                .setParameter("managerId", managerId)
                .getResultList();
            
            System.out.println("🔍 Demandes trouvées pour manager " + managerId + ": " + list.size());
            return list;
        } finally {
            em.close();
        }
    }

    public Demande findById(int id) {
        EntityManager em = emf.createEntityManager();
        Demande d = em.find(Demande.class, id);
        em.close();
        return d;
    }
    public Demande findByDate(Date date) {
        EntityManager em = emf.createEntityManager();
        Demande demande = null;
        try {
            demande = em.createQuery(
                "SELECT d FROM Demande d WHERE d.dateIntervention = :date", Demande.class)
                .setParameter("date", date)
                .getSingleResult();
        } catch (NoResultException e) {
            demande = null;
        } finally {
            em.close();
        }
        return demande;
    }
    

}
