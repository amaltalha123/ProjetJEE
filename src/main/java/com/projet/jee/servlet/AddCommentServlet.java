package com.projet.jee.servlet;

import java.io.IOException;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;

import com.projet.jee.dto.SessionUser;
import com.projet.jee.model.Commentaire;
import com.projet.jee.model.DetailService;
import com.projet.jee.model.Evaluation;
import com.projet.jee.model.Utilisateur;

@WebServlet("/AddCommentServlet")
public class AddCommentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        SessionUser sessionUser = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;

        // Vérification si l'utilisateur est connecté
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Récupération des paramètres envoyés par le formulaire
        String serviceIdParam = request.getParameter("serviceId");
        String contenu = request.getParameter("comment");
        String ratingParam = request.getParameter("rating");

        // Vérifier uniquement serviceId et contenu (rating peut être vide)
        if (serviceIdParam == null || serviceIdParam.isEmpty() || contenu == null || contenu.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/ServiceDetailsClientServlet?id=" + serviceIdParam + "&error=missing_fields");
            return;
        }

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();

            Long serviceId = Long.parseLong(serviceIdParam);

            // Récupérer auteur et service
            Utilisateur auteur = em.find(Utilisateur.class, (long) sessionUser.getId());
            DetailService service = em.find(DetailService.class, serviceId);

            if (auteur == null || service == null) {
                em.getTransaction().rollback();
                response.sendRedirect(request.getContextPath() + "/ServiceDetailsClientServlet?id=" + serviceIdParam + "&error=not_found");
                return;
            }

            // Enregistrer le commentaire
            Commentaire commentaire = new Commentaire();
            commentaire.setContenu(contenu);
            commentaire.setAuteur(auteur);
            commentaire.setService(service);
            commentaire.setDateCreation(new Date());
            em.persist(commentaire);

            // Si une note est fournie → enregistrer une évaluation
            if (ratingParam != null && !ratingParam.isEmpty()) {
                int rating = Integer.parseInt(ratingParam);

                Evaluation evaluation = new Evaluation();
                evaluation.setNbr_etoile(rating);
                evaluation.setUtilisateur(auteur);
                evaluation.setService(service);
                em.persist(evaluation);
            }

            em.getTransaction().commit();

            // Redirection après succès
            response.sendRedirect(request.getContextPath() + "/ServiceDetailsClientServlet?id=" + serviceIdParam + "&success=comment_added");

        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/ServiceDetailsClientServlet?id=" + serviceIdParam + "&error=db_error");
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
        super.destroy();
    }
}
