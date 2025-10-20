package com.projet.jee.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.fasterxml.jackson.databind.ObjectMapper;  // Import pour Jackson
import com.projet.jee.dao.UserRepository;
import com.projet.jee.dto.SessionUser;
import com.projet.jee.model.Fonctionnalite;  // Assurez-vous que cette classe existe
import com.projet.jee.model.Manager;
import com.projet.jee.model.Service;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;

import java.io.PrintWriter;
import java.util.HashMap;  // Ajout de l'import pour HashMap
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * Servlet implementation class GetServicesServlet
 */
@WebServlet("/GetServicesServlet")
public class GetServicesServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");
    private UserRepository userRepo = new UserRepository();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Récupérer l'utilisateur connecté depuis la session
    	 HttpSession session = request.getSession(false);
         SessionUser sessionUser = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;
         
         if (sessionUser == null) {
             response.sendRedirect(request.getContextPath() + "/login");
             return;
         }

         Manager manager = userRepo.find((long) sessionUser.getId());
        
        EntityManager em = emf.createEntityManager();
        
        try {
            // Log pour déboguer
            System.out.println("Manager ID récupéré de la session : " + sessionUser.getId());
            
            // Requête JPQL corrigée : utiliser s.manager.id au lieu de s.manager_id
            Query query = em.createQuery("SELECT DISTINCT s FROM Service s JOIN FETCH s.categorie LEFT JOIN FETCH s.fonctionnalites WHERE s.manager.id = :managerId");
            query.setParameter("managerId", manager.getId());
            List<Service> services = query.getResultList();
            
            // Log pour déboguer
            System.out.println("Nombre de services trouvés : " + services.size());
            
            // Préparer la réponse JSON
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            
            // Utiliser Jackson pour sérialiser
            ObjectMapper mapper = new ObjectMapper();
            
            // Créer une liste de maps pour personnaliser le JSON (inclure seulement les 3 premières fonctionnalités)
            List<Map<String, Object>> servicesJson = services.stream().map(service -> {
                Map<String, Object> serviceMap = new HashMap<>();
                serviceMap.put("id", service.getId());
                serviceMap.put("titre", service.getTitre());
                serviceMap.put("description", service.getDescription());
                serviceMap.put("status", service.getStatus() != null ? service.getStatus().toString() : null);
                
                // Pour la catégorie
                if (service.getCategorie() != null) {
                    Map<String, Object> categorieMap = new HashMap<>();
                    categorieMap.put("id", service.getCategorie().getId());
                    categorieMap.put("nom", service.getCategorie().getNom());
                    serviceMap.put("categorie", categorieMap);
                } else {
                    serviceMap.put("categorie", null);
                }
                
                // Pour les fonctionnalités (limitées à 3)
                if (service.getFonctionnalites() != null) {
                    List<String> fonctionnalites = service.getFonctionnalites().stream()
                        .limit(3)
                        .map(Fonctionnalite::getDescription)
                        .collect(Collectors.toList());
                    serviceMap.put("fonctionnalites", fonctionnalites);
                } else {
                    serviceMap.put("fonctionnalites", java.util.Collections.emptyList());
                }
                
                return serviceMap;
            }).collect(Collectors.toList());
            
            // Écrire le JSON
            mapper.writeValue(out, servicesJson);
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Erreur lors de la récupération des services\"}");
            e.printStackTrace();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
}
