package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.projet.jee.model.Utilisateur;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.model.Abonnement;
import com.projet.jee.model.Manager;
import com.projet.jee.model.Role;
/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserRepository repo = new UserRepository();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String email = request.getParameter("email");
    String motDePasse = request.getParameter("password");
    String roleParam = request.getParameter("role");
    Role role = Role.valueOf(roleParam.toUpperCase());

    Utilisateur utilisateur;

    if (role == Role.valueOf("MANAGER")) {
        String telephone = request.getParameter("telephone");
        String abonnementParam = request.getParameter("abonnement");
        Abonnement abonnement = Abonnement.valueOf(abonnementParam);

        Manager manager = new Manager();
        manager.setEmail(email);
        manager.setMotDePasse(motDePasse);
        manager.setRole(role);
        manager.setTelephone(telephone);
        manager.setAbonnement(abonnement);
        utilisateur = manager;

    } else {
        utilisateur = new Utilisateur();
        utilisateur.setEmail(email);
        utilisateur.setMotDePasse(motDePasse);
        utilisateur.setRole(role);
    }

    repo.save(utilisateur);

    request.setAttribute("message", "Utilisateur ajouté avec succès !");
    request.getRequestDispatcher("/index.jsp").forward(request, response);
}

}

