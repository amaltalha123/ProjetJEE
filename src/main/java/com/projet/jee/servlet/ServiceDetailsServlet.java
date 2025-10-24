package com.projet.jee.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import jakarta.persistence.NoResultException;

import com.projet.jee.model.ServicePhoto;
import com.projet.jee.model.DetailService;
import com.projet.jee.model.Fonctionnalite;
import com.projet.jee.model.Categorie;
import com.projet.jee.model.Commentaire;

@WebServlet("/ServiceDetailsServlet")
public class ServiceDetailsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        System.out.println(" ID reçu par le servlet: " + idParam);

        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("error", "ID du service manquant");
            request.getRequestDispatcher("/JSP/secured/manager/service-details.jsp").forward(request, response);
            return;
        }

        EntityManager em = emf.createEntityManager();

        try {
            Long id = Long.parseLong(idParam);

            //  Utiliser DISTINCT pour éviter les doublons
            TypedQuery<DetailService> query = em.createQuery(
                "SELECT DISTINCT s FROM DetailService s " +
                "LEFT JOIN FETCH s.categorie " +
                "LEFT JOIN FETCH s.fonctionnalites " +
                "WHERE s.id = :id", 
                DetailService.class
            );
            query.setParameter("id", id);
            DetailService service = query.getSingleResult();

            //  Charger les photos séparément (évite le produit cartésien)
            TypedQuery<DetailService> photoQuery = em.createQuery(
                "SELECT DISTINCT s FROM DetailService s " +
                "LEFT JOIN FETCH s.photos " +
                "WHERE s.id = :id", 
                DetailService.class
            );
            photoQuery.setParameter("id", id);
            service = photoQuery.getSingleResult();

            //  Nettoyer les doublons avec LinkedHashSet (garde l'ordre)
            if (service.getFonctionnalites() != null) {
                List<Fonctionnalite> uniqueFonctionnalites = new ArrayList<>(
                    new LinkedHashSet<>(service.getFonctionnalites())
                );
                service.setFonctionnalites(uniqueFonctionnalites);
            }

            // Récupérer toutes les catégories pour le menu déroulant
            List<Categorie> categories = em.createQuery("SELECT c FROM Categorie c", Categorie.class)
                                           .getResultList();

            //  Récupérer les commentaires liés au service
            TypedQuery<Commentaire> commentaireQuery = em.createQuery(
                "SELECT c FROM Commentaire c " +
                "JOIN FETCH c.auteur a " +
                "WHERE c.service.id = :serviceId " +
                "ORDER BY c.dateCreation DESC",
                Commentaire.class
            );
            commentaireQuery.setParameter("serviceId", id);
            List<Commentaire> commentaires = commentaireQuery.getResultList();

            //  Créer une liste de Map pour stocker chaque commentaire + photo Base64
            List<Map<String, String>> commentairesAvecPhoto = new ArrayList<>();
            for (Commentaire c : commentaires) {
                Map<String, String> map = new HashMap<>();
                map.put("contenu", c.getContenu());
                map.put("nomAuteur", c.getAuteur().getNom());
                map.put("dateCreation", c.getDateCreation().toString());

                // photo profil en Base64
                byte[] photoBytes = c.getAuteur().getPhotoProfile();
                if (photoBytes != null && photoBytes.length > 0) {
                    String photoBase64 = Base64.getEncoder().encodeToString(photoBytes);
                    map.put("photoAuteur", "data:image/jpeg;base64," + photoBase64);
                } else {
                    map.put("photoAuteur", null);
                }

                commentairesAvecPhoto.add(map);
            }

            request.setAttribute("commentaires", commentairesAvecPhoto);

            //  Convertir les photos en Base64
            List<String> photosBase64 = (service.getPhotos() != null)
                ? service.getPhotos().stream()
                    .map(p -> Base64.getEncoder().encodeToString(p.getPhoto()))
                    .collect(Collectors.toList())
                : Collections.emptyList();
            request.setAttribute("photosBase64", photosBase64);

            // Pour le formulaire de modification (avec id)
            List<ServicePhoto> photosForForm = (service.getPhotos() != null)
                ? new ArrayList<>(service.getPhotos())
                : Collections.emptyList();
            request.setAttribute("photosForForm", photosForForm);

            // 🔹 Envoyer les données à la JSP
            request.setAttribute("service", service);
            request.setAttribute("categories", categories);

            //  Rediriger vers la page JSP
            request.getRequestDispatcher("/JSP/secured/manager/service-details.jsp").forward(request, response);

        } catch (NoResultException e) {
            request.setAttribute("error", "Service non trouvé");
            request.getRequestDispatcher("/JSP/secured/manager/service-details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID invalide");
            request.getRequestDispatcher("/JSP/secured/manager/service-details.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }
}