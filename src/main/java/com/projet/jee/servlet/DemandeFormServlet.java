package com.projet.jee.servlet;

import com.projet.jee.dao.ServiceRepository;
import com.projet.jee.model.Service;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DemandeFormServlet", urlPatterns = {"/manager/addDemande"})
public class DemandeFormServlet extends HttpServlet {

    private ServiceRepository serviceRepo = new ServiceRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // 🔽 SUPPRIMER: Récupérer la liste de tous les clients
        // List<Utilisateur> clients = userRepo.findAllClients();

        // Récupérer la liste de tous les services actifs
        List<Service> services = serviceRepo.findAllActif();

        // 🔽 SUPPRIMER l'envoi des clients à la JSP
        // req.setAttribute("clients", clients);
        req.setAttribute("services", services);

        // Rediriger vers la page du formulaire
        // Si un ID est présent, on redirige vers DemandeActionServlet pour charger la demande
        String demandeId = req.getParameter("id");
        if (demandeId != null && !demandeId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/manager/demandeAction?id=" + demandeId);
            return;
        }

        // Sinon, on affiche le formulaire d'ajout
        req.getRequestDispatcher("/JSP/secured/manager/addDemande.jsp").forward(req, resp);
    }
}