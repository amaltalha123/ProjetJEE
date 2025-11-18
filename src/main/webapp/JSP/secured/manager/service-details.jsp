<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        out.println("ID du service manquant !");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Détails du Service - MediNest</title>

  <!-- Vendor CSS -->
  <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

  <!-- Main CSS -->
  <link href="${pageContext.request.contextPath}/assets/css/main.css" rel="stylesheet">

  <style>
    /* Styles Service Details et Modal */
    .main-content { padding: 25px; background-color: #fff; min-height: 100vh; }
    .edit-section { margin-bottom: 30px; padding: 20px; background-color: #ffff; border-radius: 8px; }
    .edit-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
    .edit-title { font-size: 1.5rem; font-weight: 600; color: #2c3e50; }
    .action-buttons .btn { margin-left: 10px; }
    .edit-description { color: #6c757d; font-size: 1rem; }

    .service-details-content h2 { margin-bottom: 10px; }
    .service-details-content p { margin-bottom: 8px; }
    .service-features { background-color: #ffff; padding: 15px; border-radius: 8px; margin-top: 20px; }
    .service-features h4 {   color: #000000; margin-bottom: 10px; }
    .service-features ul { list-style-type: disc; padding-left: 20px; }
    .service-features li { margin-bottom: 8px; font-size: 1rem; color: #333; }
    .service-images { margin-top: 20px; }
    .service-images img { width:150px; height:100px; margin-right:10px; margin-bottom:10px; border-radius:8px; object-fit:cover; }
    .service-status { font-weight: 500; margin-left: 15px; padding: 2px 8px; border-radius: 6px; background-color:#28a745; color:#fff; font-size:0.9rem; }
    .service-status.inactive { background-color: #dc3545; }

    /* Modal */
    .modal-overlay { position: fixed; top:0; left:0; width:100%; height:100%; background-color: rgba(0,0,0,0.5); display:none; justify-content:center; align-items:center; z-index:1050; }
    .modal-content { background-color:#fff; border-radius:12px; max-width:700px; width:100%; max-height:90vh; overflow-y:auto; padding:20px; }
    .modal-header { display:flex; justify-content:space-between; align-items:center; border-bottom:1px solid #e9ecef; margin-bottom:15px; }
    .modal-title { font-size:1.5rem; font-weight:600; }
    .close-btn { background:none; border:none; font-size:1.5rem; cursor:pointer; }
    .form-group { margin-bottom:20px; }
    .form-label { font-weight:500; margin-bottom:8px; display:block; }
    .form-control { width:100%; padding:10px 12px; border:1px solid #ced4da; border-radius:6px; }
    .modal-footer { display:flex; justify-content:flex-end; gap:10px; margin-top:15px; }
    .btn-cancel { background-color:#f8f9fa; border:1px solid #ced4da; }
    .btn-submit { background: linear-gradient(135deg,#667eea 0%,#0290d2 100%); color:white; }
    
  </style>
  <style>
  .main {
            margin: 0;
            padding: 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
  .page-title {
            margin: 0;
            padding: 0;
            flex-shrink: 0;
        }
        
  .breadcrumbs {
            margin: 0;
            padding: 15px 0;
            background-color: #f8f9fa;
            border-bottom: 1px solid #dee2e6;
        }
        
        .breadcrumbs ol {
            list-style: none;
            display: flex;
            gap: 10px;
            margin: 0;
            padding: 0;
        }
        
        .breadcrumbs li {
            display: flex;
            align-items: center;
        }
        
        .breadcrumbs li:not(:last-child)::after {
            content: '/';
            margin-left: 10px;
            color: #6c757d;
        }
        
        .breadcrumbs a {
            color: #0d6efd;
            text-decoration: none;
        }
        
        .breadcrumbs a:hover {
            text-decoration: underline;
        }
        
        .breadcrumbs .current {
            color: #6c757d;
        }
   
    .main-content { padding: 25px; background-color: #fff; min-height: 100vh; }
    /* ... autres styles ... */
    .no-gutters-row {
            margin: 0;
            flex: 1;
            display: flex;
        }
    /* ✅ AJOUTEZ CES STYLES POUR LE SIDEBAR */
    .sidebar-column {
        padding: 0;
        display: flex;
        flex-direction: column;
    }
    
    
    .sidebar {
        background-color: #f8f9fa;
        border-right: 1px solid #dee2e6;
        flex: 1;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        min-height: 100%;
    }
    
    .sidebar nav {
        flex: 1;
        display: flex;
        flex-direction: column;
    }
    
    .sidebar .nav-link {
        color: #495057;
        padding: 15px 25px;
        border-radius: 0;
        transition: all 0.3s;
        margin: 0;
        border: none;
        flex-shrink: 0;
        font-size: 1.05rem;
        text-decoration: none;
        display: flex;
        align-items: center;
    }
    
    .sidebar .nav-link:hover, 
    .sidebar .nav-link.active {
        background-color: #e9ecef;
        color: #0290d2;
        border-right: 4px solid #0290d2;
    }
    
    .sidebar .nav-link i {
        margin-right: 12px;
        width: 22px;
        text-align: center;
        font-size: 1.1rem;
    }
    
    .logout-container {
        margin-top: auto;
        padding: 20px 25px;
    }

    .btn-logout {
        width: 100%;
        padding: 12px;
        background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
        color: white;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
    }

    .btn-logout:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        color: white;
    }
.services-section  {
            margin: 0;
            padding: 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
    /* Responsive */
    @media (max-width: 991.98px) {
        .sidebar {
            height: auto;
            border-right: none;
            border-bottom: 1px solid #dee2e6;
            min-height: auto;
        }
        
        .sidebar-column {
            flex: none;
        }
        
        .sidebar .nav-link {
            padding: 12px 20px;
            font-size: 1rem;
        }
    }

    @media (min-width: 992px) {
        .sidebar-column {
            flex: 0 0 300px;
        }
    }
    
    @media (min-width: 1200px) {
        .sidebar-column {
            flex: 0 0 350px;
        }
    }
    
    /* Galerie d'images */
.image-gallery-container {
  width: 100%;
}

.main-image-wrapper {
  position: relative;
  width: 100%;
  height: 400px;
  margin-bottom: 15px;
  border-radius: 12px;
  overflow: hidden;
  background-color: #000;
}

.main-gallery-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

/* Boutons de navigation */
.gallery-nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  background: rgba(255, 255, 255, 0.9);
  border: none;
  width: 45px;
  height: 45px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  z-index: 10;
  box-shadow: 0 2px 10px rgba(0,0,0,0.2);
}

.gallery-nav-btn:hover {
  background: white;
  transform: translateY(-50%) scale(1.1);
}

.prev-btn {
  left: 15px;
}

.next-btn {
  right: 15px;
}

.gallery-nav-btn i {
  font-size: 1.5rem;
  color: #2c3e50;
}

/* Compteur d'images */
.image-counter {
  position: absolute;
  bottom: 15px;
  right: 15px;
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 8px 15px;
  border-radius: 20px;
  font-size: 0.9rem;
  font-weight: 600;
}

/* Miniatures */
.thumbnails-container {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 10px;
}

.thumbnail-wrapper {
  position: relative;
  height: 80px;
  border-radius: 8px;
  overflow: hidden;
  cursor: pointer;
  border: 3px solid transparent;
  transition: all 0.3s ease;
}

.thumbnail-wrapper:hover {
  transform: translateY(-3px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.15);
}

.thumbnail-wrapper.active {
  border-color: #0290d2;
  box-shadow: 0 0 0 2px rgba(2, 144, 210, 0.3);
}

.thumbnail-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transition: transform 0.3s ease;
}

.thumbnail-wrapper:hover .thumbnail-image {
  transform: scale(1.1);
}

/* Badge "Voir plus" */
.more-images-badge {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-size: 1.2rem;
  font-weight: bold;
}

/* Responsive */
@media (max-width: 768px) {
  .main-image-wrapper {
    height: 300px;
  }
  
  .thumbnails-container {
    grid-template-columns: repeat(3, 1fr);
  }
  
  .gallery-nav-btn {
    width: 35px;
    height: 35px;
  }
  
  .gallery-nav-btn i {
    font-size: 1.2rem;
  }
}

@media (max-width: 576px) {
  .main-image-wrapper {
    height: 250px;
  }
  
  .thumbnails-container {
    grid-template-columns: repeat(3, 1fr);
    gap: 8px;
  }
  
  .thumbnail-wrapper {
    height: 60px;
  }
}
/* Bouton Voir plus */
.btn-voir-plus {
  width: 100%;
  padding: 15px;
  background: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 1rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
}

.btn-voir-plus:hover {
  transform: translateY(-2px);
  box-shadow: 0 6px 20px rgba(2, 144, 210, 0.4);
}

.btn-voir-plus i {
  font-size: 1.2rem;
}

/* Modal Galerie */
.gallery-modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.95);
  z-index: 9999;
  justify-content: center;
  align-items: center;
  animation: fadeIn 0.3s ease;
}

.gallery-modal.active {
  display: flex;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.gallery-modal-content {
  width: 90%;
  max-width: 1200px;
  height: 90vh;
  display: flex;
  flex-direction: column;
  position: relative;
}

.gallery-close-btn {
  position: absolute;
  top: -50px;
  right: 0;
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  width: 45px;
  height: 45px;
  border-radius: 50%;
  cursor: pointer;
  font-size: 1.5rem;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 10001;
}

.gallery-close-btn:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: rotate(90deg);
}

.gallery-image-container {
  flex: 1;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 20px;
}

.modal-gallery-img {
  max-width: 100%;
  max-height: 100%;
  object-fit: contain;
  border-radius: 8px;
  box-shadow: 0 10px 40px rgba(0, 0, 0, 0.5);
  transition: opacity 0.3s ease;
}

/* Flèches de navigation */
.gallery-arrow {
  position: absolute;
  background: rgba(255, 255, 255, 0.9);
  border: none;
  width: 60px;
  height: 60px;
  border-radius: 50%;
  cursor: pointer;
  font-size: 2rem;
  color: #2c3e50;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
  z-index: 10;
}

.gallery-arrow:hover {
  background: white;
  transform: scale(1.1);
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.3);
}

.left-arrow {
  left: 20px;
}

.right-arrow {
  right: 20px;
}

/* Compteur */
.gallery-counter {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0, 0, 0, 0.7);
  color: white;
  padding: 10px 20px;
  border-radius: 25px;
  font-size: 1rem;
  font-weight: 600;
}

/* Miniatures en bas */
.gallery-thumbnails {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  padding: 10px 0;
  justify-content: center;
}

.gallery-thumbnails::-webkit-scrollbar {
  height: 6px;
}

.gallery-thumbnails::-webkit-scrollbar-track {
  background: rgba(255, 255, 255, 0.1);
  border-radius: 10px;
}

.gallery-thumbnails::-webkit-scrollbar-thumb {
  background: rgba(255, 255, 255, 0.3);
  border-radius: 10px;
}

.gallery-thumbnail {
  width: 100px;
  height: 80px;
  object-fit: cover;
  border-radius: 8px;
  cursor: pointer;
  border: 3px solid transparent;
  transition: all 0.3s ease;
  opacity: 0.6;
}

.gallery-thumbnail:hover {
  opacity: 0.9;
  transform: translateY(-3px);
}

.gallery-thumbnail.active {
  border-color: #0290d2;
  opacity: 1;
  box-shadow: 0 0 15px rgba(2, 144, 210, 0.5);
}

/* Responsive */
@media (max-width: 768px) {
  .gallery-arrow {
    width: 45px;
    height: 45px;
    font-size: 1.5rem;
  }
  
  .left-arrow {
    left: 10px;
  }
  
  .right-arrow {
    right: 10px;
  }
  
  .gallery-thumbnail {
    width: 70px;
    height: 60px;
  }
  
  .gallery-close-btn {
    top: -40px;
    width: 40px;
    height: 40px;
  }
}
    
</style>
</head>
<body>

<main class="main">
<div class="page-title">
            <nav class="breadcrumbs">
                <div class="container">
                    <ol>
                        <li><a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Home</a></li>
                        <li class="current">Detail service</li>
                    </ol>
                </div>
            </nav>
        </div>
  <section class="services-section">
    <div class="container-fluid">
      <div class="row">
        <!-- Sidebar inchangé -->
        <div class="col-lg-4 col-xl-3 sidebar-column">
          <div class="sidebar">
            <nav class="nav flex-column">
              <a class="nav-link" href="${pageContext.request.contextPath}/ProfileServlet"><i class="fas fa-user-circle"></i> Profil</a>
              <a class="nav-link" href="#"><i class="fas fa-envelope-open-text"></i> Demandes</a>
              <a class="nav-link" href="${pageContext.request.contextPath}/secured/reclamations"><i class="fas fa-exclamation-triangle"></i> Réclamations</a>
              <a class="nav-link active" href="${pageContext.request.contextPath}/secured/GetServicesPage"><i class="fas fa-concierge-bell"></i> Services</a>
              <a class="nav-link" href="${pageContext.request.contextPath}/JSP/secured/manager/statistiques.jsp"><i class="fas fa-chart-line"></i> Statistiques</a>
              <div class="logout-container mt-auto">
                <a href="logout" class=""><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
              </div>
            </nav>
          </div>
        </div>

        <!-- Contenu principal -->
        <div class="col-lg-8 col-xl-9 content-column">
          <div class="main-content">

            <!-- Actions Service -->
            <div class="edit-section">
              <div class="edit-header">
                <h3 class="edit-title">Gestion du Service</h3>
                <div class="action-buttons d-flex">
                  <button id="editServiceBtn" class="btn btn-info btn-sm"><i class="bi bi-pencil-square"></i> Modifier</button>
                  <!-- Boutons avec data-id et data-status -->
              <button class="btn btn-success btn-sm btn-status" data-service-id="${service.id}" data-status="ACTIF">
    <i class="bi bi-toggle-on"></i> Activer
           </button>
<button class="btn btn-danger btn-sm btn-status" data-service-id="${service.id}" data-status="ARCHIVE">
    <i class="bi bi-archive"></i> Archiver
</button>

                    </div>
              </div>
            </div>





            <!-- Service Details -->
<c:if test="${not empty service}">
  <div class="service-details-content">
    <!-- En-tête avec image principale à gauche -->
    <div class="row g-4 mb-5">
      <!-- Colonne gauche : première image -->
     <div class="col-lg-5">
  <c:choose>
    <c:when test="${not empty photosBase64}">
      <!-- Affichage des 3 premières images -->
      <c:forEach var="photo" items="${photosBase64}" varStatus="status">
        <c:if test="${status.index < 3}">
          <img src="data:image/jpeg;base64,${photo}"
               alt="Image du service ${status.index + 1}"
               class="img-fluid rounded shadow-sm mb-3"
               style="object-fit: cover; width: 100%; height: 200px; cursor: pointer;"
               onclick="openGalleryModal(${status.index})">
        </c:if>
      </c:forEach>
      
      <!-- Bouton "Voir plus" si plus de 3 images -->
      <!-- Bouton "Voir plus" si plus de 3 images -->
<c:if test="${fn:length(photosBase64) > 3}">
  <button class="btn-voir-plus" onclick="openGalleryModal(0)">
    <i class="bi bi-images"></i>
    Voir toutes les photos (${fn:length(photosBase64)})
  </button>
</c:if>
    </c:when>
    <c:otherwise>
      <div class="bg-light d-flex align-items-center justify-content-center rounded"
           style="min-height: 300px; color: #888;">
        <i class="bi bi-image" style="font-size: 2.5rem;"></i>
      </div>
    </c:otherwise>
  </c:choose>
</div>
      <!-- Colonne droite : titre, description, cat, fonctionnalités, commentaires -->
      <div class="col-lg-7">
        <h2 id="serviceTitle" class="mb-3">
          ${service.titre}
          <p></p>
          <span class="service-status ${service.status eq 'ARCHIVE' ? 'archive' : 'active'}" 
                id="serviceStatus">
            ${service.status}
          </span>
        </h2>
 <p><strong>Catégorie :</strong> <span id="serviceCategory">${service.categorie.nom}</span></p>
        <p><strong></strong> <span id="serviceDescription">${service.description}</span></p>
       

        <!-- Fonctionnalités -->
        <div class="service-features mt-4" id="serviceFeatures">
          <h4 class="edit-title">Fonctionnalités :</h4>
          <c:choose>
            <c:when test="${not empty service.fonctionnalites}">
              <ul class="list-unstyled">
              
                <c:forEach var="f" items="${service.fonctionnalites}">
                  <li class="d-flex align-items-start mb-2">
                    <i class="bi bi-check-circle-fill text-success me-2 mt-1"></i>
                    <span>${f.description}</span>
                  </li>
                </c:forEach>
              </ul>
            </c:when>
            <c:otherwise>
              <p class="text-muted">Aucune fonctionnalité disponible.</p>
            </c:otherwise>
          </c:choose>
        </div>
       
<div class="service-features mt-4" id="serviceFeatures">
          <h4 class="edit-title"> Feedback des utilisateurs  :</h4>
<c:forEach var="c" items="${commentaires}">
    <div style="display:flex; align-items:flex-start; margin-bottom:10px;">
        <c:choose>
            <c:when test="${not empty c.photoAuteur}">
                <img src="${c.photoAuteur}" alt="Photo auteur" style="width:40px; height:40px; border-radius:50%; margin-right:10px;">
            </c:when>
            <c:otherwise>
                <img src="default-profile.png" alt="Photo par défaut" style="width:40px; height:40px; border-radius:50%; margin-right:10px;">
            </c:otherwise>
        </c:choose>
        <div>
            <strong>${c.nomAuteur}</strong> <br/>
            <p>${c.contenu}</p>
        </div>
    </div>
</c:forEach>
</div>
<!-- 
<div class="service-images" id="serviceImages" >
  <h4>Images :</h4>
  <c:choose>
    <c:when test="${not empty photosBase64}">
      <div class="row g-4"> 
        <c:forEach var="photo" items="${photosBase64}" varStatus="loop">
          <div class="col-lg-4 col-md-6 col-12" 
               data-aos="fade-up" 
               data-aos-delay="${100 + (loop.index * 100)}">
            <div class="service-card h-100">
              <img src="data:image/jpeg;base64,${photo}" 
                   alt="Image du service ${loop.index + 1}" 
                   class="service-image w-100"
                   style="height: 180px; object-fit: cover; border-radius: 8px;">
            </div>
          </div>
        </c:forEach>
      </div>
    </c:when>
    <c:otherwise>
      <p class="no-data">Aucune image disponible.</p>
    </c:otherwise>
  </c:choose>
</div>
 -->
              </div>
            </c:if>

          </div>
        </div>
      </div>
    </div>
  </section>
</main>

<!-- Modal Modifier Service -->
<div class="modal-overlay" id="serviceModal">
  <div class="modal-content">
    <div class="modal-header">
      <h3 class="modal-title">Modifier le service</h3>
      <button class="close-btn" id="closeModalBtn">&times;</button>
    </div>
    <form id="serviceForm">
      <input type="hidden" id="serviceId" value="${service.id}">
      <div class="form-group">
        <label class="form-label" for="serviceName">Nom du service</label>
        <input type="text" id="serviceName" class="form-control" value="${service.titre}" required>
      </div>
      <div class="form-group">
        <label class="form-label" for="serviceDescriptionInput">Description</label>
        <textarea id="serviceDescriptionInput" class="form-control" required>${service.description}</textarea>
      </div>
      <div class="form-group">
        <label class="form-label" for="serviceCategoryInput">Catégorie</label>
      <select id="serviceCategoryInput" class="form-control" required>
  <option value="">Sélectionner une catégorie</option>
  <c:forEach var="cat" items="${categories}">
  <option value="${cat.id}" ${service.categorie.id == cat.id ? 'selected' : ''}>
    ${cat.nom}
  </option>
</c:forEach>
  
</select>
     <div class="form-group">
  <label for="serviceFeatures">Fonctionnalités</label>
  <div id="featuresContainer">
    <c:forEach var="f" items="${service.fonctionnalites}">
      <input type="text" name="fonctionnalites" class="form-control mb-2" value="${f.description}">
    </c:forEach>
  </div>
  <button type="button" id="addFeatureBtn" class="btn btn-sm btn-secondary mt-1">+ Ajouter</button>
</div>


<div class="form-group">
  <label for="serviceImages">Images</label>
  <input type="file" id="newImages" name="images" multiple class="form-control">

  <div id="previewImages" class="mt-2">
  <c:forEach var="photo" items="${photosForForm}">
    <div class="image-wrapper" data-photo-id="${photo.id}" style="display:inline-block; position:relative; margin:5px;">
        <img src="data:image/jpeg;base64,${photo.base64}" width="100" height="80" style="border-radius:6px;">
        <button type="button" class="delete-photo" 
                style="position:absolute; top:-8px; right:-8px; background:red; color:white; border:none; border-radius:50%; width:22px; height:22px;">
            ×
        </button>
    </div>
  </c:forEach>
</div>
  
</div>

      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-cancel" id="cancelBtn">Annuler</button>
        <button type="button" class="btn btn-submit" id="submitBtn">Modifier</button>
      </div>
    </form>
  </div>
</div>
</div>
        </div>
      </div>
    </div>
  </section>
<!-- NE PAS FERMER </main> ICI -->

<!-- Modal Modifier Service -->
<div class="modal-overlay" id="serviceModal">
  <div class="modal-content">
    <div class="modal-header">
      <h3 class="modal-title">Modifier le service</h3>
      <button class="close-btn" id="closeModalBtn">&times;</button>
    </div>
    <form id="serviceForm">
      <input type="hidden" id="serviceId" value="${service.id}">
      <div class="form-group">
        <label class="form-label" for="serviceName">Nom du service</label>
        <input type="text" id="serviceName" class="form-control" value="${service.titre}" required>
      </div>
      <div class="form-group">
        <label class="form-label" for="serviceDescriptionInput">Description</label>
        <textarea id="serviceDescriptionInput" class="form-control" required>${service.description}</textarea>
      </div>
      <div class="form-group">
        <label class="form-label" for="serviceCategoryInput">Catégorie</label>
        <select id="serviceCategoryInput" class="form-control" required>
          <option value="">Sélectionner une catégorie</option>
          <c:forEach var="cat" items="${categories}">
            <option value="${cat.id}" ${service.categorie.id == cat.id ? 'selected' : ''}>
              ${cat.nom}
            </option>
          </c:forEach>
        </select>
      </div>
      <div class="form-group">
        <label for="serviceFeatures">Fonctionnalités</label>
        <div id="featuresContainer">
    <c:forEach var="f" items="${service.fonctionnalites}" varStatus="st">
        <div class="feature-item d-flex align-items-center mb-2">
            <input type="text" name="fonctionnalites" class="form-control" value="${f.description}">
            <button type="button" class="btn btn-danger btn-sm ms-2 remove-feature">
                ×
            </button>
        </div>
    </c:forEach>
</div>

        <button type="button" id="addFeatureBtn" class="btn btn-sm btn-secondary mt-1">+ Ajouter</button>
      </div>
      <div class="form-group">
        <label for="serviceImages">Images</label>
        <input type="file" id="newImages" name="images" multiple class="form-control">
        <div id="previewImages" class="mt-2">
          <c:forEach var="photo" items="${photosForForm}">
            <div class="image-wrapper" data-photo-id="${photo.id}" style="display:inline-block; position:relative; margin:5px;">
              <img src="data:image/jpeg;base64,${photo.base64}" width="100" height="80" style="border-radius:6px;">
              <button type="button" class="delete-photo" 
                      style="position:absolute; top:-8px; right:-8px; background:red; color:white; border:none; border-radius:50%; width:22px; height:22px;">
                ×
              </button>
            </div>
          </c:forEach>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-cancel" id="cancelBtn">Annuler</button>
        <button type="button" class="btn btn-submit" id="submitBtn">Modifier</button>
      </div>
    </form>
  </div>
</div>

<!-- Modal Galerie d'images -->
<div class="gallery-modal" id="galleryModal">
  <div class="gallery-modal-content">
    <button class="gallery-close-btn" onclick="closeGalleryModal()">
      <i class="bi bi-x-lg"></i>
    </button>
    
    <div class="gallery-image-container">
      <button class="gallery-arrow left-arrow" onclick="previousImage()">
        <i class="bi bi-chevron-left"></i>
      </button>
      
      <img id="modalGalleryImage" src="" alt="Image du service" class="modal-gallery-img">
      
      <button class="gallery-arrow right-arrow" onclick="nextImage()">
        <i class="bi bi-chevron-right"></i>
      </button>
      
      <div class="gallery-counter">
        <span id="modalCurrentIndex">1</span> / <span id="modalTotalImages">${fn:length(photosBase64)}</span>
      </div>
    </div>
    
    <div class="gallery-thumbnails">
      <c:forEach var="photo" items="${photosBase64}" varStatus="status">
        <img src="data:image/jpeg;base64,${photo}"
             alt="Miniature ${status.index + 1}"
             class="gallery-thumbnail ${status.index == 0 ? 'active' : ''}"
             onclick="changeGalleryImage(${status.index})"
             data-index="${status.index}">
      </c:forEach>
    </div>
  </div>
</div>

</main>
<!-- FERMER </main> ICI -->

<!-- Script Modal de modification -->
<script>
const modal = document.getElementById('serviceModal');
const openBtn = document.getElementById('editServiceBtn');
const closeBtn = document.getElementById('closeModalBtn');
const cancelBtn = document.getElementById('cancelBtn');
const submitBtn = document.getElementById('submitBtn');

openBtn.addEventListener('click', () => modal.style.display = 'flex');
closeBtn.addEventListener('click', () => modal.style.display = 'none');
cancelBtn.addEventListener('click', () => modal.style.display = 'none');

document.getElementById('addFeatureBtn').addEventListener('click', () => {
	  const container = document.getElementById('featuresContainer');

	  const wrapper = document.createElement('div');
	  wrapper.className = "feature-item d-flex align-items-center mb-2";

	  wrapper.innerHTML = `
	    <input type="text" name="fonctionnalites" class="form-control" placeholder="Nouvelle fonctionnalité">
	    <button type="button" class="btn btn-danger btn-sm ms-2 remove-feature">×</button>
	  `;

	  container.appendChild(wrapper);
	});


document.querySelectorAll('.delete-photo').forEach(btn => {
  btn.addEventListener('click', () => {
    const wrapper = btn.closest('.image-wrapper');
    const photoId = wrapper.getAttribute('data-photo-id');
    wrapper.remove();
    const deletedInput = document.createElement('input');
    deletedInput.type = 'hidden';
    deletedInput.name = 'deletedPhotos';
    deletedInput.value = photoId;
    document.getElementById('serviceForm').appendChild(deletedInput);
  });
});
//Supprimer une fonctionnalité
document.addEventListener('click', function(e) {
  if (e.target.classList.contains('remove-feature')) {
    const item = e.target.closest('.feature-item');
    item.remove();
  }
});

submitBtn.addEventListener('click', () => {
    const formData = new FormData();
    formData.append("id", document.getElementById('serviceId').value);
    formData.append("titre", document.getElementById('serviceName').value);
    formData.append("description", document.getElementById('serviceDescriptionInput').value);
    formData.append("categorieId", document.getElementById('serviceCategoryInput').value);

    document.querySelectorAll('input[name="fonctionnalites"]').forEach(f => {
        formData.append("fonctionnalites", f.value);
    });

    Array.from(document.getElementById('newImages').files).forEach(file => {
        formData.append("images", file);
    });

    document.querySelectorAll('input[name="deletedPhotos"]').forEach(p => {
        formData.append("deletedPhotos", p.value);
    });

    fetch('${pageContext.request.contextPath}/updateService', {
        method: 'POST',
        body: formData
    })
    .then(r => r.json())
    .then(data => {
        if (data.success) {
            alert("Service mis à jour !");
            modal.style.display = 'none';
            location.reload();
        } else {
            alert("Erreur : " + data.message);
        }
    })
    .catch(err => console.error("Erreur Fetch :", err));
});
</script>

<!-- Script Changement de statut -->
<script>
document.querySelectorAll('.btn-status').forEach(btn => {
    btn.addEventListener('click', () => {
        const serviceId = btn.getAttribute('data-service-id');
        const status = btn.getAttribute('data-status');

        fetch('${pageContext.request.contextPath}/changeServiceStatus', {
            method: 'POST',
            body: new URLSearchParams({
                id: serviceId,
                status: status
            })
        })
        .then(r => r.json())
        .then(data => {
            if (data.success) {
                alert("Statut mis à jour !");
                const badge = document.getElementById('serviceStatus');
                badge.textContent = status;
                badge.classList.toggle('inactive', status === 'ARCHIVE');
            } else {
                alert("Erreur : " + data.message);
            }
        })
        .catch(err => console.error("Erreur Fetch :", err));
    });
});
</script>

<!-- Script Galerie d'images -->
<script>
console.log('✅ Script galerie chargé');

// Tableau des images
const galleryPhotos = [
  <c:forEach var="photo" items="${photosBase64}" varStatus="status">
    "data:image/jpeg;base64,${photo}"${!status.last ? ',' : ''}
  </c:forEach>
];

console.log('📸 Nombre d\'images:', galleryPhotos.length);

let currentGalleryIndex = 0;

// Ouvrir le modal
function openGalleryModal(startIndex) {
  console.log('🟢 Ouverture du modal, index:', startIndex);
  currentGalleryIndex = startIndex;
  document.getElementById('galleryModal').classList.add('active');
  document.body.style.overflow = 'hidden';
  updateGalleryImage();
}

// Fermer le modal
function closeGalleryModal() {
  document.getElementById('galleryModal').classList.remove('active');
  document.body.style.overflow = 'auto';
}

// Mettre à jour l'image affichée
function updateGalleryImage() {
  const img = document.getElementById('modalGalleryImage');
  const counter = document.getElementById('modalCurrentIndex');
  
  img.style.opacity = '0';
  
  setTimeout(() => {
    img.src = galleryPhotos[currentGalleryIndex];
    counter.textContent = currentGalleryIndex + 1;
    img.style.opacity = '1';
  }, 150);
  
  document.querySelectorAll('.gallery-thumbnail').forEach((thumb, index) => {
    thumb.classList.toggle('active', index === currentGalleryIndex);
  });
}

// Image précédente
function previousImage() {
  currentGalleryIndex = (currentGalleryIndex > 0) 
    ? currentGalleryIndex - 1 
    : galleryPhotos.length - 1;
  updateGalleryImage();
}

// Image suivante
function nextImage() {
  currentGalleryIndex = (currentGalleryIndex < galleryPhotos.length - 1) 
    ? currentGalleryIndex + 1 
    : 0;
  updateGalleryImage();
}

// Changer l'image via miniature
function changeGalleryImage(index) {
  currentGalleryIndex = index;
  updateGalleryImage();
}

// Navigation au clavier
document.addEventListener('keydown', (e) => {
  const modal = document.getElementById('galleryModal');
  if (modal.classList.contains('active')) {
    if (e.key === 'ArrowLeft') previousImage();
    if (e.key === 'ArrowRight') nextImage();
    if (e.key === 'Escape') closeGalleryModal();
  }
});

// Fermer en cliquant à l'extérieur
document.getElementById('galleryModal').addEventListener('click', (e) => {
  if (e.target.id === 'galleryModal') {
    closeGalleryModal();
  }
});

console.log('Toutes les fonctions de la galerie sont prêtes');
</script>

</body>
</html>