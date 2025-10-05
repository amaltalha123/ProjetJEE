package com.projet.jee.model;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.model.Role;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import org.mindrot.jbcrypt.BCrypt;

import java.nio.file.Files;
import java.nio.file.Paths;

public class MainInsertionADMIN {

    public static void main(String[] args) {
    	EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");
// persistence-unit
        EntityManager em = emf.createEntityManager();

        try {
            // Création de l'utilisateur ADMIN
            Utilisateur admin = new Utilisateur();
            admin.setNom("Super Admin");
            admin.setEmail("admin@example.com");

            // Hachage du mot de passe
            String motDePasseBrut = "admin123";
            String motDePasseHash = BCrypt.hashpw(motDePasseBrut, BCrypt.gensalt(12));
            admin.setMotDePasse(motDePasseHash);

            admin.setRole(Role.ADMIN);

            // Option : charger une photo de profil
            try {
                byte[] photo = Files.readAllBytes(Paths.get("C:/images/admin.jpg"));
                admin.setPhotoProfile(photo);
            } catch (Exception e) {
                System.out.println("Photo non trouvée, insertion sans photo.");
            }

            // Commencer la transaction
            em.getTransaction().begin();

            // Persister l'utilisateur
            em.persist(admin);

            // Commit
            em.getTransaction().commit();

            System.out.println("Utilisateur ADMIN inséré avec succès !");
        } finally {
            em.close();
            emf.close();
        }
    }
}
