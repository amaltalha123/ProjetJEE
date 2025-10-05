package com.projet.jee.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.projet.jee.dao.StatisticsRepository;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(DashboardServlet.class.getName());
    private StatisticsRepository statsRepo;
    
    @Override
    public void init() throws ServletException {
        statsRepo = new StatisticsRepository();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Récupérer les statistiques
            int totalUsers = statsRepo.getTotalUsers();
            int totalCategories = statsRepo.getTotalCategories();
            int totalReclamations = statsRepo.getTotalReclamations();
            int activeReclamations = statsRepo.getActiveReclamations();
            int adminUsers = statsRepo.getUsersByRole("ADMIN");
            int managerUsers = statsRepo.getUsersByRole("MANAGER");
            int clientUsers = statsRepo.getUsersByRole("CLIENT");
            
            // Récupérer les données récentes
            List<Object[]> recentUsers = statsRepo.getRecentUsers(5);
            List<Object[]> recentReclamations = statsRepo.getRecentReclamations(5);
            
            // Définir les attributs
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("totalCategories", totalCategories);
            request.setAttribute("totalReclamations", totalReclamations);
            request.setAttribute("activeReclamations", activeReclamations);
            request.setAttribute("adminUsers", adminUsers);
            request.setAttribute("managerUsers", managerUsers);
            request.setAttribute("clientUsers", clientUsers);
            request.setAttribute("recentUsers", recentUsers);
            request.setAttribute("recentReclamations", recentReclamations);
            
            request.getRequestDispatcher("/JSP/secured/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            logger.severe("💥 ERREUR DashboardServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Erreur: " + e.getMessage());
        }
    }
    
    @Override
    public void destroy() {
        if (statsRepo != null) {
            statsRepo.close();
        }
    }
}