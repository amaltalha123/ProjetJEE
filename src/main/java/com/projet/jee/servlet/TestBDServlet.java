package com.projet.jee.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;
import com.projet.jee.dao.ReclamationRepository;
import com.projet.jee.model.Reclamation;
import java.util.List;

@WebServlet("/test-bd")
public class TestBDServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        out.println("<!DOCTYPE html>");
        out.println("<html><head><title>Test BD</title></head><body>");
        out.println("<h1>🧪 TEST URGENT BASE DE DONNÉES</h1>");
        
        out.println("<h2>Étape 1: Création Repository</h2>");
        ReclamationRepository repo = new ReclamationRepository();
        
        out.println("<h2>Étape 2: Appel findAll()</h2>");
        try {
            List<Reclamation> reclamations = repo.findAll();
            
            out.println("<h3>Résultats:</h3>");
            out.println("<p><strong>Nombre de réclamations: " + reclamations.size() + "</strong></p>");
            
            if (reclamations.isEmpty()) {
                out.println("<div style='background: red; color: white; padding: 20px;'>");
                out.println("<h3>❌ CRITIQUE: AUCUNE DONNÉE TROUVÉE</h3>");
                out.println("<p>La base de données ne retourne aucune réclamation.</p>");
                out.println("</div>");
                
                out.println("<h3>Diagnostic:</h3>");
                out.println("<ul>");
                out.println("<li>Vérifiez que MySQL est démarré</li>");
                out.println("<li>Vérifiez la base 'projetjee' existe</li>");
                out.println("<li>Vérifiez la table 'reclamation' existe</li>");
                out.println("<li>Vérifiez les identifiants BD dans persistence.xml</li>");
                out.println("</ul>");
            } else {
                out.println("<table border='1' style='border-collapse: collapse; width: 100%;'>");
                out.println("<tr style='background: #f0f0f0;'><th>ID</th><th>Contenu</th><th>État</th><th>User ID</th></tr>");
                
                for (Reclamation r : reclamations) {
                    out.println("<tr>");
                    out.println("<td>" + r.getId() + "</td>");
                    out.println("<td>" + (r.getContenu() != null ? r.getContenu() : "NULL") + "</td>");
                    out.println("<td>" + r.isEtat() + "</td>");
                    out.println("<td>" + (r.getUtilisateur() != null ? r.getUtilisateur().getId() : "NULL") + "</td>");
                    out.println("</tr>");
                }
                
                out.println("</table>");
                out.println("<p style='color: green; margin-top: 20px;'>✅ SUCCÈS: Données trouvées dans la BD</p>");
            }
            
        } catch (Exception e) {
            out.println("<div style='background: darkred; color: white; padding: 20px;'>");
            out.println("<h3>💥 ERREUR CRITIQUE</h3>");
            out.println("<p><strong>" + e.getMessage() + "</strong></p>");
            out.println("</div>");
            e.printStackTrace(out);
        } finally {
            repo.close();
        }
        
        out.println("</body></html>");
    }
}