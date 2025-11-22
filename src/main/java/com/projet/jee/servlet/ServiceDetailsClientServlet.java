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
import com.projet.jee.model.Manager;
import com.projet.jee.dao.CommentaireRepository; // Import du repository

@WebServlet("/ServiceDetailsClientServlet")
public class ServiceDetailsClientServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");
        System.out.println(" ID reçu par le servlet: " + idParam);

        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("error", "ID du service manquant");
            request.getRequestDispatcher("/JSP/secured/user/service-details-client.jsp").forward(request, response);
            return;
        }

        EntityManager em = emf.createEntityManager();

        try {
            Long id = Long.parseLong(idParam);

            // Utiliser DISTINCT pour éviter les doublons
            TypedQuery<DetailService> query = em.createQuery(
                "SELECT DISTINCT s FROM DetailService s " +
                "LEFT JOIN FETCH s.categorie " +
                "LEFT JOIN FETCH s.fonctionnalites " +
                "WHERE s.id = :id", 
                DetailService.class
            );
            query.setParameter("id", id);
            DetailService service = query.getSingleResult();

            // Charger les photos séparément (évite le produit cartésien)
            TypedQuery<DetailService> photoQuery = em.createQuery(
                "SELECT DISTINCT s FROM DetailService s " +
                "LEFT JOIN FETCH s.photos " +
                "WHERE s.id = :id", 
                DetailService.class
            );
            photoQuery.setParameter("id", id);
            service = photoQuery.getSingleResult();

            // Nettoyer les doublons avec LinkedHashSet (garde l'ordre)
            if (service.getFonctionnalites() != null) {
                List<Fonctionnalite> uniqueFonctionnalites = new ArrayList<>(
                    new LinkedHashSet<>(service.getFonctionnalites())
                );
                service.setFonctionnalites(uniqueFonctionnalites);
            }

            // Récupérer toutes les catégories pour le menu déroulant
            List<Categorie> categories = em.createQuery("SELECT c FROM Categorie c", Categorie.class)
                                           .getResultList();

            // Récupérer les commentaires liés au service
            CommentaireRepository commentaireRepository = new CommentaireRepository(em);
            List<Commentaire> commentaires = commentaireRepository.findByServiceId(id);
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

            // Convertir les photos en Base64
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

            // Récupérer les informations du manager avec évaluations
            Map<String, Object> managerInfo = getManagerInfo(em, service);
            request.setAttribute("managerInfo", managerInfo);

            // Envoyer les données à la JSP
            request.setAttribute("service", service);
            request.setAttribute("categories", categories);

            // Rediriger vers la page JSP
            request.getRequestDispatcher("/JSP/secured/user/service-details-client.jsp").forward(request, response);

        } catch (NoResultException e) {
            request.setAttribute("error", "Service non trouvé");
            request.getRequestDispatcher("/JSP/secured/user/service-details-client.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID invalide");
            request.getRequestDispatcher("/JSP/secured/user/service-details-client.jsp").forward(request, response);
        } finally {
            if (em != null && em.isOpen()) em.close();
        }
    }

    private Map<String, Object> getManagerInfo(EntityManager em, DetailService service) {
        try {
            // Récupérer le manager associé à ce service
            TypedQuery<Manager> managerQuery = em.createQuery(
                "SELECT m FROM Manager m " +
                "JOIN m.services s " +
                "WHERE s.id = :serviceId", 
                Manager.class
            );
            managerQuery.setParameter("serviceId", service.getId());
            Manager manager = managerQuery.getSingleResult();
            
            Map<String, Object> managerInfo = new HashMap<>();
            managerInfo.put("nom", manager.getNom());
            managerInfo.put("email", manager.getEmail());
            managerInfo.put("telephone", manager.getTelephone() != null ? manager.getTelephone() : "Non renseigné");
            
            // Calcul de la moyenne des évaluations du manager
            TypedQuery<Double> avgQuery = em.createQuery(
                "SELECT AVG(e.nbr_etoile) FROM Evaluation e " +
                "WHERE e.utilisateur.id = :managerId", 
                Double.class
            );
            avgQuery.setParameter("managerId", manager.getId());
            Double moyenne = avgQuery.getSingleResult();
            
            // Nombre total d'évaluations du manager
            TypedQuery<Long> countQuery = em.createQuery(
                "SELECT COUNT(e) FROM Evaluation e " +
                "WHERE e.utilisateur.id = :managerId", 
                Long.class
            );
            countQuery.setParameter("managerId", manager.getId());
            Long nombreEvaluations = countQuery.getSingleResult();
            
            // Arrondir la moyenne à 1 décimale et gérer les valeurs null
            double moyenneArrondie = 0.0;
            if (moyenne != null) {
                moyenneArrondie = Math.round(moyenne * 10.0) / 10.0;
            }
            
            long nbEval = 0;
            if (nombreEvaluations != null) {
                nbEval = nombreEvaluations;
            }
            
            managerInfo.put("moyenneEvaluation", moyenneArrondie);
            managerInfo.put("nombreEvaluations", nbEval);
            
            // Convertir la photo de profil en Base64 si elle existe
            if (manager.getPhotoProfile() != null && manager.getPhotoProfile().length > 0) {
                String photoBase64 = Base64.getEncoder().encodeToString(manager.getPhotoProfile());
                managerInfo.put("photoProfile", "data:image/jpeg;base64," + photoBase64);
            } else {
                managerInfo.put("photoProfile", null);
            }
            
            return managerInfo;
            
        } catch (NoResultException e) {
            // Retourner des informations par défaut si aucun manager n'est trouvé
            Map<String, Object> defaultInfo = new HashMap<>();
            defaultInfo.put("nom", "Manager non assigné");
            defaultInfo.put("email", "N/A");
            defaultInfo.put("telephone", "N/A");
            defaultInfo.put("moyenneEvaluation", 0.0);
            defaultInfo.put("nombreEvaluations", 0);
            defaultInfo.put("photoProfile", null);
            return defaultInfo;
        } catch (Exception e) {
            // Gestion des autres exceptions
            System.err.println("Erreur lors de la récupération des informations du manager: " + e.getMessage());
            Map<String, Object> errorInfo = new HashMap<>();
            errorInfo.put("nom", "Erreur de chargement");
            errorInfo.put("email", "N/A");
            errorInfo.put("telephone", "N/A");
            errorInfo.put("moyenneEvaluation", 0.0);
            errorInfo.put("nombreEvaluations", 0);
            errorInfo.put("photoProfile", null);
            return errorInfo;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
        super.destroy();
    }
}