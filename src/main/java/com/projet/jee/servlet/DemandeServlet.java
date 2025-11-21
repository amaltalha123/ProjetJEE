package com.projet.jee.servlet;

import com.projet.jee.dao.DemandeRepository;
import com.projet.jee.dto.SessionUser;
import com.projet.jee.model.Demande; // ✅ AJOUTER CET IMPORT
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List; // ✅ AJOUTER CET IMPORT

@WebServlet("/manager/mes-demandes")
public class DemandeServlet extends HttpServlet {
    private DemandeRepository demandeRepo = new DemandeRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        SessionUser su = (SessionUser) request.getSession().getAttribute("sessionUser");

        if (su == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Récupérer les demandes
        List<Demande> demandes = demandeRepo.findByManagerId(su.getId());
        
        System.out.println("🔍 Nombre de demandes trouvées : " + demandes.size());
        
        // Log détaillé de chaque demande
     // Remplacer ce log :
        for (Demande d : demandes) {
            System.out.println("📋 Demande ID: " + d.getId() + 
                ", Service: " + (d.getService() != null ? d.getService().getTitre() : "NULL") +
                ", Description: " + d.getDescription()); // ✅ Afficher la description au lieu du "client"
        }

        request.setAttribute("demandes", demandes);
        request.getRequestDispatcher("/JSP/secured/manager/mes-demandes.jsp").forward(request, response);
    }
}