package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.model.Utilisateur;

import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/photo")
public class ImageServlet extends HttpServlet {
    private UserRepository repo = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID manquant");
            return;
        }

        try {
            Long id = Long.parseLong(idStr);
            Utilisateur user = repo.findById(id);  
            if (user != null && user.getPhotoProfile() != null) {
                byte[] photo = user.getPhotoProfile();

                // Définir le type MIME (ici on suppose jpg mais tu peux ajuster selon ton upload)
                response.setContentType("image/jpeg");
                response.setContentLength(photo.length);

                try (OutputStream os = response.getOutputStream()) {
                    os.write(photo);
                }
            } else {
                // Pas de photo => tu peux mettre une image par défaut
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Pas de photo");
            }
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID invalide");
        }
    }
}
