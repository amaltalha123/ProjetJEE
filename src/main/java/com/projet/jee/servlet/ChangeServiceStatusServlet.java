package com.projet.jee.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.persistence.*;

import com.projet.jee.model.Service;
import com.projet.jee.model.StatutService;

@WebServlet("/changeServiceStatus")
public class ChangeServiceStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("DemoPU");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();

            int serviceId = Integer.parseInt(request.getParameter("id"));
            String newStatusStr = request.getParameter("status");

            Service service = em.find(Service.class, serviceId);
            if (service == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Service introuvable.\"}");
                return;
            }

            // Convert String -> Enum
            StatutService newStatus = StatutService.valueOf(newStatusStr.toUpperCase());
            service.setStatus(newStatus);

            em.merge(service);
            tx.commit();

            response.getWriter().write("{\"success\": true, \"message\": \"Statut mis à jour.\"}");

        } catch (IllegalArgumentException e) {
            if (tx.isActive()) tx.rollback();
            response.getWriter().write("{\"success\": false, \"message\": \"Statut invalide.\"}");
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Erreur serveur.\"}");
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) emf.close();
    }
}
