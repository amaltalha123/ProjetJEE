package com.projet.jee.servlet;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;

import org.mindrot.jbcrypt.BCrypt;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.dto.SessionUser;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/UpdateProfileServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class UpdateProfileServlet extends HttpServlet {
    
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("==== [UpdateProfileServlet] Début de la mise à jour ====");
        
        // Debug de la session
        HttpSession session = request.getSession(false);
        if (session == null) {
            System.out.println("❌ Aucune session active !");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        System.out.println("🔍 Session ID: " + session.getId());
        System.out.println("🔍 Attributs de session:");
        Enumeration<String> attributeNames = session.getAttributeNames();
        while (attributeNames.hasMoreElements()) {
            String attrName = attributeNames.nextElement();
            System.out.println("  - " + attrName + " = " + session.getAttribute(attrName));
        }
        
        // Vérifier la session utilisateur
        SessionUser sessionUser = (SessionUser) session.getAttribute("sessionUser");
        if (sessionUser == null) {
            System.out.println("⚠️ Aucun utilisateur en session !");
            System.out.println("🔍 Recherche d'autres clés possibles...");
            
            // Essayer d'autres noms de clés possibles
            Object user = session.getAttribute("user");
            Object currentUser = session.getAttribute("currentUser");
            Object loggedUser = session.getAttribute("loggedUser");
            
            System.out.println("  - user: " + user);
            System.out.println("  - currentUser: " + currentUser);
            System.out.println("  - loggedUser: " + loggedUser);
            
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        } else {
            System.out.println("Utilisateur trouvé : " + sessionUser.getEmail() + " (id=" + sessionUser.getId() + ")");
        }
        
        // Récupérer les paramètres du formulaire
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("motDePasse");
        
        System.out.println("📝 Données reçues : nom=" + nom + ", email=" + email);
        
        EntityManager em = emf.createEntityManager();
        
        try {
            em.getTransaction().begin();
            
            // Charger l'utilisateur depuis la base
            Utilisateur user = em.find(Utilisateur.class, sessionUser.getId());
            
            if (user == null) {
                System.out.println("❌ Utilisateur introuvable dans la base !");
                request.setAttribute("error", "Utilisateur introuvable.");
                request.getRequestDispatcher("/JSP/secured/profile.jsp").forward(request, response);
                return;
            }
            
            // Mettre à jour les informations de base
            user.setNom(nom);
            user.setEmail(email);
            
            // Mettre à jour le mot de passe seulement s'il est fourni
            if (motDePasse != null && !motDePasse.trim().isEmpty()) {
                // TODO: Hasher le mot de passe avant de le stocker
                // Exemple avec BCrypt : String hashedPassword = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
            	String hashedPassword = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
                user.setMotDePasse(hashedPassword);
                System.out.println("🔒 Mot de passe mis à jour");
            }
            
            // Gérer l'upload de la photo
            Part photoPart = request.getPart("photoProfile");
            if (photoPart != null && photoPart.getSize() > 0) {
                System.out.println("📷 Photo reçue : " + photoPart.getSize() + " octets");
                
                // Vérifier le type de fichier
                String contentType = photoPart.getContentType();
                if (contentType != null && contentType.startsWith("image/")) {
                    try (InputStream inputStream = photoPart.getInputStream()) {
                        byte[] photoBytes = inputStream.readAllBytes();
                        user.setPhotoProfile(photoBytes);
                        System.out.println("Photo de profil mise à jour");
                    }
                } else {
                    System.out.println(" Type de fichier invalide : " + contentType);
                    request.setAttribute("error", "Le fichier doit être une image.");
                    em.getTransaction().rollback();
                    request.getRequestDispatcher("/JSP/secured/profile.jsp").forward(request, response);
                    return;
                }
            }
            
            // Persister les modifications
            em.merge(user);
            em.getTransaction().commit();
            
            // Mettre à jour la session si l'email a changé
            if (!sessionUser.getEmail().equals(email)) {
                sessionUser.setEmail(email);
                session.setAttribute("sessionUser", sessionUser);
            }
            
            System.out.println("Profil mis à jour avec succès pour l'utilisateur : " + user.getEmail());
            
            // Message de succès
            session.setAttribute("message", "Profil mis à jour avec succès !");
            
            // Rediriger vers ProfileServlet pour recharger les données
            response.sendRedirect(request.getContextPath() + "/ProfileServlet");
            
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la mise à jour du profil : " + e.getMessage());
            e.printStackTrace();
            
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            
            request.setAttribute("error", "Erreur lors de la mise à jour : " + e.getMessage());
            request.getRequestDispatcher("/JSP/secured/profile.jsp").forward(request, response);
            
        } finally {
            em.close();
        }
    }
    
    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}