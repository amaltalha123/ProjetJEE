package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.projet.jee.dao.UserRepository;
import com.projet.jee.model.Utilisateur;

@WebServlet("/user-photo")
public class PhotoServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private UserRepository userRepo = new UserRepository();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                Long userId = Long.parseLong(idParam);
                Utilisateur user = userRepo.findById(userId);
                
                if (user != null && user.getPhotoProfile() != null && user.getPhotoProfile().length > 0) {
                    response.setContentType("image/jpeg");
                    response.setContentLength(user.getPhotoProfile().length);
                    response.getOutputStream().write(user.getPhotoProfile());
                } else {
                    // Image par défaut ou erreur 404
                    response.sendError(HttpServletResponse.SC_NOT_FOUND);
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    @Override
    public void destroy() {
        if (userRepo != null) {
            userRepo.close(); // Assurez-vous que UserRepository a une méthode close()
        }
        super.destroy();
    }
}