package com.projet.jee.model;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import com.projet.jee.model.Utilisateur;
import com.projet.jee.model.Reclamation;

public class V2__Create_Reclamation_Table {

    public static void main(String[] args) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            // ✅ On récupère un utilisateur existant (par exemple celui avec id = 1)
            Utilisateur utilisateur = em.find(Utilisateur.class, 1);
            if (utilisateur == null) {
                System.err.println("❌ Aucun utilisateur avec ID = 1 trouvé dans la base !");
                return;
            }

            // ✅ Insertion de quelques réclamations de test
            Reclamation r1 = new Reclamation();
            r1.setContenu("Problème de connexion au compte.");
            r1.setEtat(false);
            r1.setUtilisateur(utilisateur);

            Reclamation r2 = new Reclamation();
            r2.setContenu("Erreur dans le montant de la facture.");
            r2.setEtat(true);
            r2.setUtilisateur(utilisateur);

            Reclamation r3 = new Reclamation();
            r3.setContenu("Demande de modification des informations personnelles.");
            r3.setEtat(false);
            r3.setUtilisateur(utilisateur);

            // ✅ Persistance dans la base
            em.persist(r1);
            em.persist(r2);
            em.persist(r3);

            em.getTransaction().commit();
            System.out.println("✅ Insertion réussie : Réclamations ajoutées à la table !");
        } catch (Exception e) {
            em.getTransaction().rollback();
            System.err.println("❌ Erreur lors de l’insertion : " + e.getMessage());
        } finally {
            em.close();
            emf.close();
        }
    }
}
