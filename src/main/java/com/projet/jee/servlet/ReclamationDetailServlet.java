package com.projet.jee.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.projet.jee.dao.ReclamationRepository;
import com.projet.jee.model.Reclamation;
import java.util.logging.Logger;

@WebServlet("/admin/reclamation-detail")
public class ReclamationDetailServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(ReclamationDetailServlet.class.getName());
    private ReclamationRepository reclamationRepo;
    
    @Override
    public void init() throws ServletException {
        reclamationRepo = new ReclamationRepository();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        if (idParam == null) {
            response.sendRedirect(request.getContextPath() + "/admin/reclamations");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            Reclamation reclamation = reclamationRepo.findById(id);
            
            if (reclamation == null) {
                response.sendRedirect(request.getContextPath() + "/admin/reclamations");
                return;
            }
            
            // Marquer comme lu dans la base de données
            if (!reclamation.isEtat()) { // Si pas encore lu
                reclamationRepo.markAsRead(id);
            }
            
            request.setAttribute("reclamation", reclamation);
            request.getRequestDispatcher("/JSP/secured/admin/reclamation-detail.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/reclamations");
        }
    }
    
    @Override
    public void destroy() {
        if (reclamationRepo != null) {
            reclamationRepo.close();
        }
    }
}