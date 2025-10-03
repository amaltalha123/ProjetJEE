package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.InputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

import org.mindrot.jbcrypt.BCrypt;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.model.Abonnement;
import com.projet.jee.model.Manager;
import com.projet.jee.model.Role;
/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
@MultipartConfig

public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserRepository repo = new UserRepository();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String nom= request.getParameter("nom");

    String motDePasse = request.getParameter("password");
    String roleParam = request.getParameter("role");
    Role role = Role.valueOf(roleParam.toUpperCase());
    String hashedPassword = BCrypt.hashpw(motDePasse, BCrypt.gensalt());
    
    Part filePart = request.getPart("photo");
    byte[] photoBytes = null;

    if (filePart != null && filePart.getSize() > 0) {
        try (InputStream inputStream = filePart.getInputStream()) {
            photoBytes = inputStream.readAllBytes();
        }
    }

   
    
    Utilisateur utilisateur;

    if (role == Role.valueOf("MANAGER")) {
        String telephone = request.getParameter("telephone");
        String abonnementParam = request.getParameter("abonnement");
        Abonnement abonnement = Abonnement.valueOf(abonnementParam);

        Manager manager = new Manager();
        manager.setEmail(email);
        manager.setNom(nom);
        manager.setMotDePasse(hashedPassword);
        manager.setRole(role);
        manager.setTelephone(telephone);
        manager.setAbonnement(abonnement);
        manager.setPhotoProfile(photoBytes);
        utilisateur = manager; 

    } else {
        utilisateur = new Utilisateur();
        utilisateur.setEmail(email);
        utilisateur.setNom(nom);
        utilisateur.setMotDePasse(hashedPassword);
        utilisateur.setRole(role);
        utilisateur.setPhotoProfile(photoBytes);

    }

    repo.save(utilisateur);

    request.setAttribute("message", "Utilisateur ajouté avec succès !");
    request.getRequestDispatcher("/index.jsp").forward(request, response);
}

}

