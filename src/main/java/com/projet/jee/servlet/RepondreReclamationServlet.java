package com.projet.jee.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.projet.jee.dao.ReclamationRepository;
import java.util.logging.Logger;

@WebServlet("/admin/repondre-reclamation")
public class RepondreReclamationServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(RepondreReclamationServlet.class.getName());
    private ReclamationRepository reclamationRepo;
    
    @Override
    public void init() throws ServletException {
        reclamationRepo = new ReclamationRepository();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String idParam = request.getParameter("id");
        String reponse = request.getParameter("reponse");
        
        if (idParam == null || reponse == null || reponse.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/reclamation-detail?id=" + idParam + "&error=1");
            return;
        }
        
        try {
            int id = Integer.parseInt(idParam);
            boolean success = reclamationRepo.updateReponse(id, reponse.trim());
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/admin/reclamation-detail?id=" + id + "&success=1");
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/reclamation-detail?id=" + id + "&error=1");
            }
            
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/reclamation-detail?id=" + idParam + "&error=1");
        }
    }
    
    @Override
    public void destroy() {
        if (reclamationRepo != null) {
            reclamationRepo.close();
        }
    }
}