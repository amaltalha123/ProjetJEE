package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import com.projet.jee.dao.ReclamationRepositorymanger;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.dto.SessionUser;
import com.projet.jee.model.Reclamation;
import com.projet.jee.model.Utilisateur;

/**
 * Servlet implementation class ClientReclamation
 */
@WebServlet("/secured/ClientReclamation")
public class ClientReclamation extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private ReclamationRepositorymanger reclamationRepo = new ReclamationRepositorymanger();
    private UserRepository userRepo = new UserRepository();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ClientReclamation() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        SessionUser sessionUser = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;
        
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Utilisateur utilisateur = userRepo.findById((long) sessionUser.getId());
        List<Reclamation> reclamations;

        if (sessionUser.getRole() == com.projet.jee.model.Role.MANAGER) {
            reclamations = reclamationRepo.findByUtilisateur(utilisateur);
        } else if (sessionUser.getRole() == com.projet.jee.model.Role.ADMIN) {
            reclamations = reclamationRepo.findAll();
        } else {
            reclamations = reclamationRepo.findByUtilisateur(utilisateur);
        }

        request.setAttribute("reclamations", reclamations);
        request.getRequestDispatcher("/JSP/secured/user/Reclamation.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        SessionUser sessionUser = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;
        
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String action = request.getParameter("action");
        
        if ("create".equals(action)) {
            String contenu = request.getParameter("contenu");
            
            if (contenu != null && !contenu.trim().isEmpty()) {
                Reclamation reclamation = new Reclamation();
                reclamation.setContenu(contenu);
                reclamation.setEtat(false);
                
                Utilisateur utilisateur = userRepo.findById((long) sessionUser.getId());
                reclamation.setUtilisateur(utilisateur);
                
                reclamationRepo.save(reclamation);
                response.sendRedirect(request.getContextPath() + "/secured/ClientReclamation?success=created");
                return;
            } else {
                request.setAttribute("errorMessage", "Le contenu de la réclamation ne peut pas être vide.");
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/secured/ClientReclamation");
    }


}
