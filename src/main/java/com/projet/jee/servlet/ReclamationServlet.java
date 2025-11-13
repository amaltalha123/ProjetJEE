package com.projet.jee.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.projet.jee.dao.ReclamationRepository;
import com.projet.jee.model.Reclamation;
import com.projet.jee.model.Role; // IMPORTANT: Ajoutez cet import
import java.util.Map;
import java.util.logging.Logger;

@WebServlet("/admin/reclamations")
public class ReclamationServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ReclamationServlet.class.getName());
    private ReclamationRepository reclamationRepo;
    private static final int PAGE_SIZE = 10;
    
    @Override
    public void init() throws ServletException {
        reclamationRepo = new ReclamationRepository();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Récupérer les paramètres
            int page = 1;
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.isEmpty()) {
                try {
                    page = Integer.parseInt(pageParam);
                    if (page < 1) page = 1;
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }
            
            // Récupérer le filtre par rôle
            String roleFilter = request.getParameter("role");
            Role role = null;
            if (roleFilter != null && !roleFilter.isEmpty()) {
                try {
                    role = Role.valueOf(roleFilter.toUpperCase());
                } catch (IllegalArgumentException e) {
                    // Rôle invalide, on garde null pour tout afficher
                    logger.warning("Rôle invalide: " + roleFilter);
                }
            }
            
            // Récupérer les données selon le filtre
            Map<Reclamation, Boolean> reclamationsWithStatus;
            int totalCount;
            int unreadCount;
            int readCount;
            
            if (role != null) {
                // Filtrage par rôle
                reclamationsWithStatus = reclamationRepo.findAllWithReadStatusByRole(page, PAGE_SIZE, role);
                totalCount = reclamationRepo.getCountByRole(role);
                unreadCount = reclamationRepo.getUnreadCountByRole(role);
                readCount = totalCount - unreadCount;
            } else {
                // Toutes les réclamations
                reclamationsWithStatus = reclamationRepo.findAllWithReadStatus(page, PAGE_SIZE);
                totalCount = reclamationRepo.getTotalCount();
                unreadCount = reclamationRepo.getUnreadCount();
                readCount = totalCount - unreadCount;
            }
            
            // Calculer les informations de pagination
            int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
            if (totalPages == 0) totalPages = 1;
            if (page > totalPages) page = totalPages;
            
            int startItem = (page - 1) * PAGE_SIZE + 1;
            int endItem = Math.min(page * PAGE_SIZE, totalCount);
            
            // Définir les attributs
            request.setAttribute("reclamationsWithStatus", reclamationsWithStatus);
            request.setAttribute("unreadCount", unreadCount);
            request.setAttribute("readCount", readCount);
            request.setAttribute("totalCount", totalCount);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("pageSize", PAGE_SIZE);
            request.setAttribute("startItem", startItem);
            request.setAttribute("endItem", endItem);
            request.setAttribute("selectedRole", roleFilter);
            request.setAttribute("servlet_executed", "YES");
            
            request.getRequestDispatcher("/JSP/secured/admin/reclamations.jsp").forward(request, response);
            
        } catch (Exception e) {
            logger.severe("Erreur dans ReclamationServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Erreur: " + e.getMessage());
        }
    }
    
    @Override
    public void destroy() {
        if (reclamationRepo != null) {
            reclamationRepo.close();
        }
    }
}