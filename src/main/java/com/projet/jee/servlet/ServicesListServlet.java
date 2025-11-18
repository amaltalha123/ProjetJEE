package com.projet.jee.servlet;

import com.projet.jee.model.Categorie;
import com.projet.jee.model.Service;

import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/services")
public class ServicesListServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final EntityManagerFactory emf =
            Persistence.createEntityManagerFactory("DemoPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔓 AUCUNE vérification de session ici → page publique

        EntityManager em = emf.createEntityManager();
        try {
            // 1) Toutes les catégories pour le filtre
            TypedQuery<Categorie> catQuery = em.createQuery(
                    "SELECT c FROM Categorie c ORDER BY c.nom",
                    Categorie.class
            );
            List<Categorie> categories = catQuery.getResultList();

            // 2) Tous les services avec leur catégorie chargée
            TypedQuery<Service> srvQuery = em.createQuery(
                    "SELECT DISTINCT s FROM Service s " +
                    "LEFT JOIN FETCH s.categorie " +
                    "ORDER BY s.id DESC",
                    Service.class
            );
            List<Service> services = srvQuery.getResultList();

            System.out.println(">>> [SERVICES] nb services = " + services.size());

            request.setAttribute("categories", categories);
            request.setAttribute("services", services);

            // 👉 JSP publique (évite "secured" si tu veux vraiment que ce soit ouvert)
            request.getRequestDispatcher("/JSP/secured/user/categorie-services.jsp")
                   .forward(request, response);

        } finally {
            if (em.isOpen()) em.close();
        }
    }
}
