<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Détails du Service - MediNest</title>

  <!-- Vendor CSS -->
  <link href="${pageContext.request.contextPath}/JSP/secured/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/JSP/secured/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/JSP/secured/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">

  <style>
    body {
      padding-top: 80px;
      background-color: #f8f9fa;
    }
    
    .service-content {
      background: white;
      border-radius: 15px;
      box-shadow: 0 5px 25px rgba(0,0,0,0.1);
      overflow: hidden;
      margin-bottom: 30px;
    }
    
    .service-image-main {
      width: 100%;
      height: 400px;
      object-fit: cover;
    }
    
    .service-info {
      padding: 30px;
    }
    
    .service-title {
      font-size: 2.2rem;
      font-weight: 700;
      margin-bottom: 15px;
      color: #2c3e50;
    }
    
    .service-category {
      background: #e3f2fd;
      color: #1976d2;
      padding: 8px 16px;
      border-radius: 20px;
      font-weight: 600;
      display: inline-block;
      margin-bottom: 20px;
    }
    
    .service-description {
      font-size: 1.1rem;
      line-height: 1.7;
      color: #555;
      margin-bottom: 25px;
    }
    
    .features-section {
      background: #f8f9fa;
      padding: 25px;
      border-radius: 10px;
      margin: 25px 0;
    }
    
    .feature-item {
      display: flex;
      align-items: center;
      margin-bottom: 12px;
      padding: 12px;
      background: white;
      border-radius: 8px;
      border-left: 4px solid #0290d2;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    
    .feature-item i {
      color: #0290d2;
      margin-right: 12px;
      font-size: 1.1rem;
    }
    
    .gallery-section {
      margin: 30px 0;
      padding: 0 25px;
    }
    
    .gallery-title {
      font-size: 1.5rem;
      font-weight: 600;
      margin-bottom: 20px;
      color: #2c3e50;
    }
    
    .gallery-image {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 10px;
      cursor: pointer;
      transition: transform 0.3s ease;
    }
    
    .gallery-image:hover {
      transform: scale(1.05);
    }
    
    .comments-section {
      margin: 40px 0;
      padding: 0 25px 25px;
    }
    
    .comment-card {
      background: white;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 20px;
      box-shadow: 0 3px 15px rgba(0,0,0,0.08);
      border-left: 4px solid #0290d2;
    }
    
    .comment-header {
      display: flex;
      align-items: center;
      margin-bottom: 12px;
    }
    
    .comment-avatar {
      width: 45px;
      height: 45px;
      border-radius: 50%;
      object-fit: cover;
      margin-right: 15px;
    }
    
    .comment-author {
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }
    
    .comment-date {
      color: #6c757d;
      font-size: 0.9rem;
      margin: 0;
    }
    
    .comment-content {
      color: #555;
      line-height: 1.6;
      margin: 0;
    }
    
    .back-button {
      background: #6c757d;
      color: white;
      border: none;
      padding: 12px 25px;
      border-radius: 8px;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: all 0.3s ease;
      margin-bottom: 20px;
    }
    
    .back-button:hover {
      background: #5a6268;
      color: white;
      text-decoration: none;
    }
    
    .action-buttons {
      display: flex;
      gap: 15px;
      margin-top: 20px;
      flex-wrap: wrap;
    }
    
    .btn-primary-custom {
      background: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
      border: none;
      padding: 12px 25px;
      border-radius: 8px;
      color: white;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 8px;
      transition: all 0.3s ease;
      font-weight: 500;
      cursor: pointer;
    }
    
    .btn-primary-custom:hover {
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
      color: white;
      text-decoration: none;
    }
    
    .no-data {
      text-align: center;
      color: #6c757d;
      font-style: italic;
      padding: 40px 0;
    }

    /* Style pour le système d'étoiles */
    .rating-stars {
      display: flex;
      flex-direction: row-reverse;
      justify-content: flex-end;
      gap: 5px;
    }

    .rating-stars input[type="radio"] {
      display: none;
    }

    .star-label {
      font-size: 2rem;
      color: #ddd;
      cursor: not-allowed;
      transition: color 0.2s;
    }

    .rating-stars input[type="radio"]:checked ~ .star-label,
    .star-label:hover,
    .star-label:hover ~ .star-label {
      color: #ffc107;
    }

    /* Style pour la modale manager */
    .manager-avatar img {
      border: 4px solid #e9ecef;
    }

    .detail-item {
      padding: 8px 0;
      border-bottom: 1px solid #f8f9fa;
    }

    .manager-name {
      color: #2c3e50;
      font-weight: 600;
    }

    /* Style pour le formulaire de commentaire désactivé */
    .comment-form-card .form-control:disabled,
    .comment-form-card .btn:disabled {
      cursor: not-allowed;
      opacity: 0.6;
    }

    .comment-form-card {
      background: #f8f9fa;
      border-radius: 12px;
      padding: 20px;
      margin-bottom: 25px;
      border-left: 4px solid #0290d2;
    }

    /* Évaluation manager */
    .manager-rating {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 10px;
      margin: 10px 0;
    }

    .rating-stars-small {
      display: flex;
      gap: 2px;
    }

    .rating-star {
      color: #ddd;
      font-size: 1.2rem;
    }

    .rating-star.filled {
      color: #ffc107;
    }

    .rating-value {
      font-weight: 600;
      color: #2c3e50;
      background: #f8f9fa;
      padding: 4px 12px;
      border-radius: 20px;
      border: 1px solid #dee2e6;
    }

    .evaluation-count {
      font-size: 0.9rem;
      color: #6c757d;
    }

    /* Galerie Modal */
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
    }

    .gallery-modal.active {
      display: flex;
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

    .gallery-thumbnails {
      display: flex;
      gap: 10px;
      overflow-x: auto;
      padding: 10px 0;
      justify-content: center;
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
    .manager-rating {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  margin: 10px 0;
}

.rating-stars-small {
  display: flex;
  gap: 2px;
}

.rating-star {
  color: #ddd;
  font-size: 1.2rem;
}

.rating-star.filled {
  color: #ffc107;
}

.rating-value {
  font-weight: 600;
  color: #2c3e50;
  background: #f8f9fa;
  padding: 4px 12px;
  border-radius: 20px;
  border: 1px solid #dee2e6;
}

.evaluation-count {
  font-size: 0.9rem;
  color: #6c757d;
}
  </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}">Services Interventions</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}">Accueil</a></li>
        <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/services">Services</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/login">Connexion</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <c:if test="${not empty service}">
    
    <!-- Bouton retour -->
    <div class="my-4">
      <a href="${pageContext.request.contextPath}/services" class="back-button">
        <i class="bi bi-arrow-left"></i> Retour aux services
      </a>
    </div>

    <div class="service-content">
      
      <!-- En-tête avec image principale -->
      <div class="row g-0">
        <div class="col-lg-6">
          <c:choose>
            <c:when test="${not empty photosBase64}">
              <img src="data:image/jpeg;base64,${photosBase64[0]}" 
                   alt="${service.titre}" 
                   class="service-image-main"
                   onclick="openGalleryModal(0)">
            </c:when>
            <c:otherwise>
              <div class="service-image-main bg-light d-flex align-items-center justify-content-center">
                <i class="bi bi-image text-muted" style="font-size: 3rem;"></i>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
        
        <div class="col-lg-6">
          <div class="service-info">
            <h1 class="service-title">${service.titre}</h1>
            <span class="service-category">
              ${service.categorie.nom}
            </span>
            
            <p class="service-description">${service.description}</p>
            
            <div class="action-buttons">
              <button type="button" class="btn-primary-custom" data-bs-toggle="modal" data-bs-target="#managerModal">
                <i class="bi bi-telephone-fill"></i> Contacter le prestataire
              </button>
             
            </div>
          </div>
        </div>
      </div>

      <!-- Fonctionnalités -->
      <div class="features-section">
        <h3 class="gallery-title"><i class="bi bi-list-check"></i> Fonctionnalités du service</h3>
        <c:choose>
          <c:when test="${not empty service.fonctionnalites}">
            <div class="row">
              <c:forEach var="f" items="${service.fonctionnalites}">
                <div class="col-md-6">
                  <div class="feature-item">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>${f.description}</span>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <p class="text-muted">Aucune fonctionnalité spécifiée pour ce service.</p>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Galerie d'images -->
      <c:if test="${fn:length(photosBase64) > 1}">
        <div class="gallery-section">
          <h3 class="gallery-title"><i class="bi bi-images"></i> Galerie du service</h3>
          <div class="row g-3">
            <c:forEach var="photo" items="${photosBase64}" begin="1" varStatus="status">
              <div class="col-lg-3 col-md-4 col-sm-6">
                <img src="data:image/jpeg;base64,${photo}" 
                     alt="Image ${status.index + 1}" 
                     class="gallery-image"
                     onclick="openGalleryModal(${status.index})">
              </div>
            </c:forEach>
          </div>
        </div>
      </c:if>

      <!-- Section Évaluation et Commentaires -->
      <div class="comments-section">
        <h3 class="gallery-title"><i class="bi bi-chat-left-text"></i> Évaluations et Commentaires</h3>
        
        <!-- Formulaire d'ajout de commentaire (statique - demande connexion) -->
        <div class="comment-form-card mb-4">
          <div class="card">
            <div class="card-body">
              <h5 class="card-title">Ajouter un commentaire</h5>
              <form id="commentForm" action="${pageContext.request.contextPath}/login" method="GET">
                <!-- Système d'étoiles -->
                <div class="mb-3">
                  <label class="form-label">Note :</label>
                  <div class="rating-stars">
                    <input type="radio" id="star5" name="rating" value="5" disabled>
                    <label for="star5" class="star-label">★</label>
                    <input type="radio" id="star4" name="rating" value="4" disabled>
                    <label for="star4" class="star-label">★</label>
                    <input type="radio" id="star3" name="rating" value="3" disabled>
                    <label for="star3" class="star-label">★</label>
                    <input type="radio" id="star2" name="rating" value="2" disabled>
                    <label for="star2" class="star-label">★</label>
                    <input type="radio" id="star1" name="rating" value="1" disabled>
                    <label for="star1" class="star-label">★</label>
                  </div>
                </div>
                
                <!-- Champ commentaire -->
                <div class="mb-3">
                  <label for="commentText" class="form-label">Votre commentaire :</label>
                  <textarea class="form-control" id="commentText" name="comment" 
                            rows="4" placeholder="Partagez votre expérience avec ce service..." 
                            disabled></textarea>
                </div>
                
                <!-- Bouton de soumission -->
                <button type="submit" class="btn btn-primary" disabled>
                  <i class="bi bi-send-fill"></i> Publier le commentaire
                </button>
                
                <!-- Message d'information -->
                <div class="alert alert-info mt-3">
                  <i class="bi bi-info-circle"></i> 
                  Vous devez être connecté pour ajouter un commentaire.
                </div>
              </form>
            </div>
          </div>
        </div>

        <!-- Liste des commentaires existants -->
        <c:choose>
          <c:when test="${not empty commentaires}">
            <div class="row">
              <c:forEach var="comment" items="${commentaires}">
                <div class="col-12 mb-3">
                  <div class="comment-card">
                    <div class="comment-header">
                      <c:choose>
                        <c:when test="${not empty comment.photoAuteur}">
                          <img src="${comment.photoAuteur}" 
                               alt="Photo de ${comment.nomAuteur}" 
                               class="comment-avatar">
                        </c:when>
                        <c:otherwise>
                          <div class="comment-avatar bg-secondary d-flex align-items-center justify-content-center text-white">
                            <i class="bi bi-person-fill"></i>
                          </div>
                        </c:otherwise>
                      </c:choose>
                      <div>
                        <h6 class="comment-author">${comment.nomAuteur}</h6>
                        <small class="comment-date">${comment.dateCreation}</small>
                      </div>
                    </div>
                    <p class="comment-content">${comment.contenu}</p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-4">
              <i class="bi bi-chat-square-text display-4 text-muted"></i>
              <p class="text-muted mt-3">Aucun avis pour le moment.</p>
              <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                <i class="bi bi-pencil-square"></i> Soyez le premier à donner votre avis
              </a>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </div>
  </c:if>

  <c:if test="${empty service}">
    <div class="alert alert-danger text-center">
      <h4>Service non trouvé</h4>
      <p>Le service que vous recherchez n'existe pas ou n'est plus disponible.</p>
      <a href="${pageContext.request.contextPath}/services" class="btn btn-primary">
        Retour à la liste des services
      </a>
    </div>
  </c:if>
</div>

<!-- Footer -->
<footer class="bg-dark text-light mt-5 py-4">
  <div class="container text-center">
    <p>&copy; 2024 MediNest. Tous droits réservés.</p>
  </div>
</footer>

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

<!-- Modal Informations du Manager -->
<div class="modal fade" id="managerModal" tabindex="-1" aria-labelledby="managerModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header bg-primary text-white">
        <h5 class="modal-title" id="managerModalLabel">
          <i class="bi bi-person-badge"></i> Informations du Prestataire
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="manager-info text-center">
          <!-- Photo du manager -->
          <div class="manager-avatar mb-3">
            <c:choose>
              <c:when test="${not empty managerInfo.photoProfile}">
                <img src="${managerInfo.photoProfile}" 
                     alt="Photo de ${managerInfo.nom}" 
                     class="rounded-circle" 
                     style="width: 100px; height: 100px; object-fit: cover;">
              </c:when>
              <c:otherwise>
                <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center mx-auto"
                     style="width: 100px; height: 100px;">
                  <i class="bi bi-person-fill text-white" style="font-size: 2rem;"></i>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
          
          <!-- Informations du manager -->
          <h4 class="manager-name">${managerInfo.nom}</h4>
          <p class="text-muted mb-3">Prestataire de service</p>
          
          <!-- Évaluation du manager -->
          <div class="manager-rating mb-3">
            <div class="rating-stars-small">
              <c:forEach begin="1" end="5" var="i">
                <span class="rating-star <c:if test="${i <= managerInfo.moyenneEvaluation}">filled</c:if>">
                  ★
                </span>
              </c:forEach>
            </div>
            <span class="rating-value">${managerInfo.moyenneEvaluation}/5</span>
          </div>
          
          <c:if test="${not empty managerInfo.nombreEvaluations}">
            <div class="evaluation-count mb-3">
              <i class="bi bi-star-fill text-warning"></i>
              ${managerInfo.nombreEvaluations} évaluation(s)
            </div>
          </c:if>
          
          <div class="manager-details">
            <div class="detail-item mb-2">
              <i class="bi bi-envelope-fill text-primary me-2"></i>
              <strong>Email :</strong> ${managerInfo.email}
            </div>
            <div class="detail-item mb-3">
              <i class="bi bi-telephone-fill text-primary me-2"></i>
              <strong>Téléphone :</strong> ${managerInfo.telephone}
            </div>
          </div>
          
          <!-- Boutons d'action -->
          <div class="action-buttons mt-4">
            <a href="mailto:${managerInfo.email}" class="btn btn-outline-primary me-2">
              <i class="bi bi-envelope"></i> Envoyer un email
            </a>
            <c:if test="${managerInfo.telephone != 'N/A' && managerInfo.telephone != 'Non renseigné'}">
              <a href="tel:${managerInfo.telephone}" class="btn btn-outline-success">
                <i class="bi bi-telephone"></i> Appeler
              </a>
            </c:if>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Scripts -->
<script src="${pageContext.request.contextPath}/JSP/secured/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

<script>
// Galerie d'images
const galleryPhotos = [
  <c:forEach var="photo" items="${photosBase64}" varStatus="status">
    "data:image/jpeg;base64,${photo}"${!status.last ? ',' : ''}
  </c:forEach>
];

let currentGalleryIndex = 0;

function openGalleryModal(startIndex) {
  if (galleryPhotos.length === 0) return;
  
  currentGalleryIndex = startIndex;
  document.getElementById('galleryModal').classList.add('active');
  document.body.style.overflow = 'hidden';
  updateGalleryImage();
}

function closeGalleryModal() {
  document.getElementById('galleryModal').classList.remove('active');
  document.body.style.overflow = 'auto';
}

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

function previousImage() {
  currentGalleryIndex = (currentGalleryIndex > 0) 
    ? currentGalleryIndex - 1 
    : galleryPhotos.length - 1;
  updateGalleryImage();
}

function nextImage() {
  currentGalleryIndex = (currentGalleryIndex < galleryPhotos.length - 1) 
    ? currentGalleryIndex + 1 
    : 0;
  updateGalleryImage();
}

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

// Système d'étoiles basique (pour l'affichage uniquement)
document.addEventListener('DOMContentLoaded', function() {
  const stars = document.querySelectorAll('.star-label');
  stars.forEach(star => {
    star.addEventListener('click', function() {
      // Désactivé - nécessite une connexion
      alert('Veuillez vous connecter pour évaluer ce service.');
    });
  });
});
</script>

</body>
</html>