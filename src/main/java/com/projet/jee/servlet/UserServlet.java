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
    // 🔹 Dossier uploads dans webapp 
    String uploadDir = getServletContext().getRealPath("/uploads");
    Path uploadPath = Paths.get(uploadDir);
    if (!Files.exists(uploadPath)) Files.createDirectories(uploadPath);

    Part filePart = request.getPart("photo");
    String photoPath = null; // chemin relatif à stocker dans la base

    if (filePart != null && filePart.getSize() > 0) {
        String contentType = filePart.getContentType();
        if (contentType == null || !contentType.startsWith("image/")) {
            request.setAttribute("error", "Le fichier doit être une image.");
            request.getRequestDispatcher("/JSP/createManager.jsp").forward(request, response);
            return;
        }

        String submitted = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String ext = "";
        int i = submitted.lastIndexOf('.');
        if (i > 0) ext = submitted.substring(i);

        String uniqueName = UUID.randomUUID().toString() + ext;
        Path filePath = uploadPath.resolve(uniqueName);
        try (InputStream in = filePart.getInputStream()) {
            Files.copy(in, filePath, StandardCopyOption.REPLACE_EXISTING);
        }

        // 🔹 Chemin relatif à stocker
        photoPath = "/uploads/" + uniqueName;
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
        if (photoPath != null) manager.setPhotoProfile(photoPath);
        utilisateur = manager;

    } else {
        utilisateur = new Utilisateur();
        utilisateur.setEmail(email);
        utilisateur.setNom(nom);
        utilisateur.setMotDePasse(hashedPassword);
        utilisateur.setRole(role);
        if (photoPath != null) utilisateur.setPhotoProfile(photoPath);

    }

    repo.save(utilisateur);

    request.setAttribute("message", "Utilisateur ajouté avec succès !");
    request.getRequestDispatcher("/index.jsp").forward(request, response);
}

}

