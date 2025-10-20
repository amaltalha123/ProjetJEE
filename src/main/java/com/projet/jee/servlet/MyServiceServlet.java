package com.projet.jee.servlet;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.Query;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import com.projet.jee.dao.UserRepository;
import com.projet.jee.dto.SessionUser;
import com.projet.jee.model.Categorie;
import com.projet.jee.model.Fonctionnalite;
import com.projet.jee.model.Service;
import com.projet.jee.model.StatutService;
import com.projet.jee.model.Manager;
import com.projet.jee.model.ServicePhoto;
import com.projet.jee.model.Utilisateur;
import com.projet.jee.service.ServiceService;

@WebServlet("/MyServiceServlet")
@MultipartConfig(maxFileSize = 16177215) // 15 Mo
public class MyServiceServlet extends HttpServlet {

    private final ServiceService serviceService = new ServiceService();
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("DemoPU");
    private UserRepository userRepo = new UserRepository();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
          
        request.setCharacterEncoding("UTF-8");
        EntityManager em = emf.createEntityManager();
        String name = request.getParameter("name");
        String categoryId = request.getParameter("category");
        String description = request.getParameter("description");
        
        HttpSession session = request.getSession(false);
        SessionUser sessionUser = (session != null) ? (SessionUser) session.getAttribute("sessionUser") : null;
        
        if (sessionUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        Manager manager = userRepo.find((long) sessionUser.getId());

        // 🧱 Construire le service
        Service service = new Service();
        service.setTitre(name);
        service.setDescription(description);
        service.setManager(manager);
        service.setStatus(StatutService.ACTIF);
        Categorie cat = new Categorie();
        cat.setId(Integer.parseInt(categoryId));
        service.setCategorie(cat);

     // Remplacer la section features
        String[] featuresValues = request.getParameterValues("features");
        List<Fonctionnalite> features = new ArrayList<>();
        if (featuresValues != null) {
            for (String val : featuresValues) {
                if (val != null && !val.isEmpty()) {
                    Fonctionnalite f = new Fonctionnalite();
                    f.setDescription(val);
                    f.setService(service);
                    features.add(f);
                }
            }
        }

        // Pour les photos, la boucle reste la même, mais assurez-vous qu'elle traite tous les parts nommés "photos"
        List<ServicePhoto> photos = new ArrayList<>();
        for (Part part : request.getParts()) {
            if ("photos".equals(part.getName()) && part.getSize() > 0) {
                try (InputStream inputStream = part.getInputStream()) {
                    byte[] imageBytes = inputStream.readAllBytes();
                    ServicePhoto photo = new ServicePhoto();
                    photo.setPhoto(imageBytes);
                    photo.setService(service);
                    photos.add(photo);
                }
            }
        }
        
        service.setFonctionnalites(features);
        service.setPhotos(photos);
        // Debug logging
        System.out.println("Collected features: " + features.size());
        System.out.println("Collected photos: " + photos.size());
        System.out.println("Parameter map keys: " + request.getParameterMap().keySet());
        for (String paramName : request.getParameterMap().keySet()) {
            if (paramName.startsWith("features")) {
                System.out.println("Feature param: " + paramName + " = " + request.getParameter(paramName));
            }
        }
        for (Part part : request.getParts()) {
            if (part.getName().startsWith("photos")) {
                System.out.println("Photo part: " + part.getName() + " size: " + part.getSize());
            }
        }
        // 💾 Enregistrement
        try {
            serviceService.addService(service, features, photos);
            // Redirection vers la page des services après succès
            response.sendRedirect(request.getContextPath() + "/JSP/secured/manager/services.jsp");  // Adaptez l'URL selon votre page des services
        } catch (Exception e) {
            // En cas d'erreur, rediriger vers une page d'erreur ou afficher un message
            response.sendRedirect(request.getContextPath() + "/error.html?message=Erreur lors de l'ajout du service");
        }
    }
}
