package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.dao.UserRepository;

/**
 * Servlet implementation class VerificationServlet
 */
@WebServlet("/VerificationServlet")
public class VerificationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserRepository repo = new UserRepository();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Utilisateur pendingUser = (Utilisateur) session.getAttribute("pendingUser");
        Integer storedCode = (Integer) session.getAttribute("verificationCode");

        if (pendingUser == null || storedCode == null) {
            request.setAttribute("message", "Session expirée. Veuillez recommencer l'inscription.");
            request.getRequestDispatcher("/JSP/echec.jsp").forward(request, response); 
            return;
        }

        String enteredCodeStr = request.getParameter("verificationCode");
        if (enteredCodeStr == null || enteredCodeStr.isEmpty()) {
            request.setAttribute("message", "Veuillez entrer le code de vérification.");
            request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
            return;
        }

        try {
            int enteredCode = Integer.parseInt(enteredCodeStr);
            if (enteredCode == storedCode) {
                // Vérifier si l'utilisateur existe déjà
                boolean isExiste = repo.isExiste(pendingUser);
                if (isExiste) {
                    // Utilisateur existe déjà : invalider la session et rediriger avec un message clair
                    session.invalidate();
                    request.setAttribute("message", "Cet email est déjà enregistré. Veuillez utiliser un autre email ou vous connecter.");
                    request.getRequestDispatcher("/JSP/echec.jsp").forward(request, response); // Ou vers une page de connexion
                    return;
                } else {
                    // Code correct et utilisateur n'existe pas : enregistrer
                    repo.save(pendingUser);
                    session.removeAttribute("pendingUser");
                    session.removeAttribute("verificationCode");
                    request.setAttribute("message", "Inscription réussie !");
                    request.getRequestDispatcher("/JSP/success.jsp").forward(request, response); // Page de succès
                }
            } else {
                request.setAttribute("message", "Code incorrect. Veuillez réessayer.");
                request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Code invalide.");
            request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	 try {
             // Forward to the services JSP page
             request.getRequestDispatcher("/JSP/Verification.jsp").forward(request, response);
         } catch (Exception e) {
             e.printStackTrace();
             response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur lors du chargement de la page services: " + e.getMessage());
         }
    }
}