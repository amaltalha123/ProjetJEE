package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.model.Utilisateur;
import com.projet.jee.dto.SessionUser;


@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserRepository repo = new UserRepository();

   
        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            Utilisateur user = repo.findByEmail(email);

            if (user != null && BCrypt.checkpw(password, user.getMotDePasse())){
                // prévention fixation de session
                HttpSession old = request.getSession(true);
                if (old != null) old.invalidate();

                HttpSession session = request.getSession(true);
                session.setMaxInactiveInterval(30 * 60); // 30 minutes

                // Stocker un DTO léger
                SessionUser su = new SessionUser(user.getId(), user.getEmail(), user.getRole(),user.getPhotoProfile());
                session.setAttribute("sessionUser", su);

                // Optionnel: sécuriser cookie JSESSIONID (si HTTPS)
                Cookie cookie = new Cookie("JSESSIONID", session.getId());
                cookie.setHttpOnly(true);
                cookie.setPath(request.getContextPath());
                // cookie.setSecure(true); // activer si HTTPS
                response.addCookie(cookie);

                // redirection selon rôle
                if (su.getRole() == com.projet.jee.model.Role.MANAGER) {
                    response.sendRedirect(request.getContextPath() + "/JSP/secured/manager/dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/JSP/secured/user/dashboard.jsp");
                }
            } else {
                request.setAttribute("error", "Email ou mot de passe incorrect");
                request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
            }
        }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/JSP/login.jsp").forward(request, response);
    }

}
