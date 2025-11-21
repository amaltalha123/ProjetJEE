package com.projet.jee.servlet;

import com.projet.jee.dao.DemandeRepository;
import com.projet.jee.dao.UserRepository;
import com.projet.jee.dao.ServiceRepository;
import com.projet.jee.model.Demande;
import com.projet.jee.model.Service;
import com.projet.jee.model.Utilisateur;
import com.projet.jee.model.StatutDemande;
import com.projet.jee.dto.SessionUser;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet(name = "DemandeActionServlet", urlPatterns = {"/manager/demandeAction"})
public class DemandeActionServlet extends HttpServlet {

    private DemandeRepository demandeRepo = new DemandeRepository();
    private ServiceRepository serviceRepo = new ServiceRepository();
    private UserRepository userRepo = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String description = request.getParameter("description");
        String statutParam = request.getParameter("statut");
        String dateStr = request.getParameter("dateIntervention");
        String serviceId = request.getParameter("serviceId");
        


        SessionUser su = (SessionUser) request.getSession().getAttribute("sessionUser");

        if (su == null) {
            // Le manager n'est pas connecté, redirection vers la page de login
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (description == null || dateStr == null || serviceId == null) {
            request.setAttribute("error", "Tous les champs sont obligatoires !");
            request.getRequestDispatcher("/JSP/secured/manager/addDemande.jsp").forward(request, response);
            return;
        }

        try {
            // ✅ Conversion de la date (String → java.util.Date)
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dateStr);

            String demandeId = request.getParameter("demandeId");
            Demande d;

            if (demandeId != null && !demandeId.isEmpty()) {
                // Modification d'une demande existante
                d = demandeRepo.findById(Integer.parseInt(demandeId));
                if (d == null) {
                    throw new RuntimeException("Demande introuvable pour la mise à jour avec l'ID: " + demandeId);
                }
            } else {
                // Création d'une nouvelle demande
                d = new Demande();
            }

            d.setDescription(description);

            // Logique de statut :
            if (demandeId == null || demandeId.isEmpty()) {
                // Pour une nouvelle demande, le statut est toujours EN_ATTENTE
                d.setStatut(StatutDemande.EN_ATTENTE);
            } else if (statutParam != null && !statutParam.isEmpty()) {
                // Pour une modification, on met à jour le statut s'il est fourni
                d.setStatut(StatutDemande.valueOf(statutParam));
            }
            // Si c'est une modification et que statutParam est null, le statut existant est conservé.
            
            d.setDateIntervention(date);
            
            // ✅ MODIFICATION : Utiliser le constructeur avec ID au lieu de findById
            Service service = serviceRepo.findById(Integer.parseInt(serviceId));
            if (service == null) {
                throw new RuntimeException("Service introuvable avec l'ID: " + serviceId);
            }
            d.setService(service);
            
            // ✅ Utiliser le manager connecté
            // ✅ Utiliser le manager connecté
            Utilisateur manager = new Utilisateur(su.getId()); // Juste l'ID du manager
            d.setUtilisateur(manager);

            if (demandeId != null && !demandeId.isEmpty()) {
                demandeRepo.update(d);
            } else {
                demandeRepo.save(d);
            }

            // ✅ Redirection vers la page principale
            response.sendRedirect(request.getContextPath() + "/manager/mes-demandes");

        } catch (RuntimeException e) {
            // L'exception est levée par DemandeRepository si la transaction échoue
            e.printStackTrace();
            request.setAttribute("error", "Erreur lors de l'enregistrement : " + e.getMessage());
            request.getRequestDispatcher("/JSP/secured/manager/addDemande.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Erreur inattendue : " + e.getMessage());
            request.getRequestDispatcher("/JSP/secured/manager/addDemande.jsp").forward(request, response);
        }
    }

    @Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        String demandeIdStr = request.getParameter("id");

        if (demandeIdStr != null && !demandeIdStr.isEmpty()) {
            try {
                int demandeId = Integer.parseInt(demandeIdStr);
                DemandeRepository repo = new DemandeRepository();
                Demande demande = repo.findById(demandeId);

                if (demande != null) {
                    if ("confirm".equals(action)) {
                        demande.setStatut(StatutDemande.EN_COURS);
                        repo.update(demande);
                        response.sendRedirect(request.getContextPath() + "/manager/mes-demandes");
                        return;
                    } else if ("cancel".equals(action)) {
                        demande.setStatut(StatutDemande.ANNULE);
                        repo.update(demande);
                        response.sendRedirect(request.getContextPath() + "/manager/mes-demandes");
                        return;
                    } else if ("delete".equals(action)) {
                        repo.delete(demandeId);
                        response.sendRedirect(request.getContextPath() + "/manager/mes-demandes");
                        return;
                    } else {
                        // Pour l'affichage du formulaire de modification
                        request.setAttribute("demande", demande);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        request.setAttribute("services", new ServiceRepository().findAllActif());
        request.getRequestDispatcher("/JSP/secured/manager/addDemande.jsp").forward(request, response);
    }
}