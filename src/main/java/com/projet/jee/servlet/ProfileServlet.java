package com.projet.jee.servlet;

import java.io.IOException;
import java.util.Base64;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.dto.SessionUser;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ProfileServlet")
public class ProfileServlet extends HttpServlet {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("==== [ProfileServlet] Vérification de session ====");
        SessionUser sessionUser = (SessionUser) request.getSession().getAttribute("sessionUser");
        if (sessionUser == null) {
            System.out.println(" Aucun utilisateur en session !");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        } else {
            System.out.println(" Utilisateur trouvé : " + sessionUser.getEmail() + " (id=" + sessionUser.getId() + ")");
        }


        EntityManager em = emf.createEntityManager();
        try {
            // ✅ Charger l'utilisateur complet depuis la base grâce à son id
            Utilisateur user = em.find(Utilisateur.class, sessionUser.getId());

            if (user != null && user.getPhotoProfile() != null) {
                String photoBase64 = Base64.getEncoder().encodeToString(user.getPhotoProfile());
                request.setAttribute("userPhotoBase64", photoBase64);
            }

            // ✅ Passer les infos à la page JSP
            request.setAttribute("user", user);
            request.getRequestDispatcher("/JSP/secured/profile.jsp").forward(request, response);

        } finally {
            em.close();
        }
    }
}
