package com.projet.jee.servlet;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

import com.projet.jee.model.Service;
import com.projet.jee.model.Categorie;
import com.projet.jee.model.Fonctionnalite;
import com.projet.jee.model.ServicePhoto;

@WebServlet("/updateService")
@MultipartConfig // ⬅️ important pour gérer les fichiers
public class UpdateServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("DemoPU");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            tx.begin();

            int id = Integer.parseInt(request.getParameter("id"));
            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String categorieIdStr = request.getParameter("categorieId");

            Service service = em.find(Service.class, id);
            if (service == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"Service introuvable.\"}");
                return;
            }

            // --- Mettre à jour les infos de base ---
            service.setTitre(titre);
            service.setDescription(description);

            if (categorieIdStr != null && !categorieIdStr.isEmpty()) {
                int categorieId = Integer.parseInt(categorieIdStr);
                Categorie categorie = em.find(Categorie.class, categorieId);
                if (categorie != null) service.setCategorie(categorie);
            }

            // --- Supprimer les anciennes fonctionnalités ---
            
            
            List<Fonctionnalite> oldFoncs = service.getFonctionnalites();
            for (Fonctionnalite f : oldFoncs) {
                em.remove(f);
            }
            service.getFonctionnalites().clear();

            // --- Ajouter les nouvelles fonctionnalités ---
            String[] fonctionnalites = request.getParameterValues("fonctionnalites");
            if (fonctionnalites != null) {
                for (String desc : fonctionnalites) {
                    if (desc != null && !desc.trim().isEmpty()) {
                        // Vérifie si cette description existe déjà
                        boolean exists = service.getFonctionnalites().stream()
                                                .anyMatch(f -> f.getDescription().equals(desc));
                        if (!exists) {
                            Fonctionnalite f = new Fonctionnalite();
                            f.setDescription(desc);
                            f.setService(service);
                            em.persist(f);
                            service.getFonctionnalites().add(f);
                        }
                    }
                }
            }


            // --- Supprimer les photos supprimées ---
            String[] deletedPhotos = request.getParameterValues("deletedPhotos");
            if (deletedPhotos != null) {
                for (String pid : deletedPhotos) {
                    try {
                        int photoId = Integer.parseInt(pid);
                        ServicePhoto photo = em.find(ServicePhoto.class, photoId);
                        if (photo != null) em.remove(photo);
                    } catch (Exception ignored) {}
                }
            }

            // --- Ajouter les nouvelles images ---
            for (Part part : request.getParts()) {
                if ("images".equals(part.getName()) && part.getSize() > 0) {
                    byte[] imageData = part.getInputStream().readAllBytes();
                    ServicePhoto photo = new ServicePhoto();
                    photo.setPhoto(imageData);
                    photo.setService(service);
                    em.persist(photo);
                }
            }

            em.merge(service);
            tx.commit();

            response.getWriter().write("{\"success\": true, \"message\": \"Service mis à jour avec succès.\"}");

        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        } finally {
            em.close();
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) emf.close();
    }
}
