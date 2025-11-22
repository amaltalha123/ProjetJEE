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
    :root {
      --primary-gradient: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
      --primary-color: #0290d2;
      --secondary-color: #2c3e50;
      --accent-color: #ffc107;
    }
    
    body {
      padding-top: 80px;
      background: linear-gradient(135deg, #f5f7fa 0%, #e4efe9 100%);
      min-height: 100vh;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    
    .service-content {
      background: white;
      border-radius: 20px;
      box-shadow: 0 15px 50px rgba(0,0,0,0.1);
      overflow: hidden;
      margin-bottom: 40px;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border: none;
    }
    
    .service-content:hover {
      transform: translateY(-5px);
      box-shadow: 0 20px 60px rgba(0,0,0,0.15);
    }
    
    .service-image-main {
      width: 100%;
      height: 450px;
      object-fit: cover;
      transition: transform 0.5s ease;
      cursor: pointer;
    }
    
    .service-image-main:hover {
      transform: scale(1.02);
    }
    
    .service-info {
      padding: 40px;
      position: relative;
    }
    
    .service-title {
      font-size: 2.5rem;
      font-weight: 800;
      margin-bottom: 20px;
      color: var(--secondary-color);
      background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    
    .service-category {
      background: var(--primary-gradient);
      color: white;
      padding: 10px 20px;
      border-radius: 25px;
      font-weight: 600;
      display: inline-block;
      margin-bottom: 25px;
      box-shadow: 0 4px 15px rgba(2, 144, 210, 0.3);
      transition: transform 0.3s ease;
    }
    
    .service-category:hover {
      transform: translateY(-2px);
    }
    
    .service-description {
      font-size: 1.15rem;
      line-height: 1.8;
      color: #555;
      margin-bottom: 30px;
    }
    
    .features-section {
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      padding: 40px;
      border-radius: 15px;
      margin: 30px 0;
      border-left: 5px solid var(--primary-color);
    }
    
    .feature-item {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
      padding: 15px;
      background: white;
      border-radius: 12px;
      border-left: 4px solid var(--primary-color);
      box-shadow: 0 3px 10px rgba(0,0,0,0.08);
      transition: all 0.3s ease;
      cursor: pointer;
    }
    
    .feature-item:hover {
      transform: translateX(10px);
      box-shadow: 0 5px 20px rgba(0,0,0,0.15);
    }
    
    .feature-item i {
      color: var(--primary-color);
      margin-right: 15px;
      font-size: 1.3rem;
      transition: transform 0.3s ease;
    }
    
    .feature-item:hover i {
      transform: scale(1.2);
    }
    
    .gallery-section {
      margin: 40px 0;
      padding: 0 40px;
    }
    
    .gallery-title {
      font-size: 1.8rem;
      font-weight: 700;
      margin-bottom: 25px;
      color: var(--secondary-color);
      display: flex;
      align-items: center;
      gap: 10px;
    }
    
    .gallery-image {
      width: 100%;
      height: 200px;
      object-fit: cover;
      border-radius: 12px;
      cursor: pointer;
      transition: all 0.4s ease;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .gallery-image:hover {
      transform: scale(1.05) rotate(1deg);
      box-shadow: 0 10px 30px rgba(0,0,0,0.2);
    }
    
    .comments-section {
      margin: 50px 0;
      padding: 0 40px 40px;
    }
    
    .comment-card {
      background: white;
      border-radius: 15px;
      padding: 25px;
      margin-bottom: 25px;
      box-shadow: 0 5px 20px rgba(0,0,0,0.08);
      border-left: 4px solid var(--primary-color);
      transition: all 0.3s ease;
    }
    
    .comment-card:hover {
      transform: translateY(-3px);
      box-shadow: 0 8px 25px rgba(0,0,0,0.12);
    }
    
    .comment-header {
      display: flex;
      align-items: center;
      margin-bottom: 15px;
    }
    
    .comment-avatar {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      object-fit: cover;
      margin-right: 15px;
      border: 3px solid var(--primary-color);
      transition: transform 0.3s ease;
    }
    
    .comment-card:hover .comment-avatar {
      transform: scale(1.1);
    }
    
    .comment-author {
      font-weight: 700;
      color: var(--secondary-color);
      margin: 0;
    }
    
    .comment-date {
      color: #6c757d;
      font-size: 0.9rem;
      margin: 0;
    }
    
    .comment-content {
      color: #555;
      line-height: 1.7;
      margin: 0;
    }
    
    .back-button {
      background: var(--secondary-color);
      color: white;
      border: none;
      padding: 12px 30px;
      border-radius: 10px;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 10px;
      transition: all 0.3s ease;
      margin-bottom: 30px;
      box-shadow: 0 4px 15px rgba(44, 62, 80, 0.3);
    }
    
    .back-button:hover {
      background: var(--primary-color);
      color: white;
      text-decoration: none;
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(2, 144, 210, 0.4);
    }
    
    .action-buttons {
      display: flex;
      gap: 20px;
      margin-top: 30px;
      flex-wrap: wrap;
    }
    
    .btn-primary-custom {
      background: var(--primary-gradient);
      border: none;
      padding: 15px 30px;
      border-radius: 12px;
      color: white;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 10px;
      transition: all 0.4s ease;
      font-weight: 600;
      cursor: pointer;
      box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
    }
    
    .btn-primary-custom:hover {
      transform: translateY(-3px) scale(1.05);
      box-shadow: 0 10px 30px rgba(102, 126, 234, 0.6);
      color: white;
      text-decoration: none;
    }
    
    .no-data {
      text-align: center;
      color: #6c757d;
      font-style: italic;
      padding: 60px 0;
    }

    /* Style pour le système d'étoiles amélioré */
    .rating-stars {
      display: flex;
      flex-direction: row-reverse;
      justify-content: flex-start;
      gap: 8px;
    }

    .rating-stars input[type="radio"] {
      display: none;
    }

    .star-label {
      font-size: 2.2rem;
      color: #e0e0e0;
      cursor: pointer;
      transition: all 0.3s ease;
      text-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .star-label:hover,
    .star-label:hover ~ .star-label,
    .rating-stars input[type="radio"]:checked ~ .star-label {
      color: var(--accent-color);
      transform: scale(1.1);
      text-shadow: 0 3px 10px rgba(255, 193, 7, 0.3);
    }

    /* Style pour la modale manager améliorée */
    .manager-avatar img {
      border: 4px solid var(--primary-color);
      box-shadow: 0 5px 20px rgba(2, 144, 210, 0.3);
      transition: all 0.3s ease;
    }

    .manager-avatar img:hover {
      transform: scale(1.05);
      box-shadow: 0 8px 25px rgba(2, 144, 210, 0.4);
    }

    .detail-item {
      padding: 12px 0;
      border-bottom: 1px solid #f8f9fa;
      transition: all 0.3s ease;
    }

    .detail-item:hover {
      background: #f8f9fa;
      border-radius: 8px;
      padding-left: 15px;
    }

    .manager-name {
      color: var(--secondary-color);
      font-weight: 700;
      background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }

    /* Style pour le formulaire de commentaire */
    .comment-form-card {
      background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
      border-radius: 15px;
      padding: 30px;
      margin-bottom: 30px;
      border-left: 5px solid var(--primary-color);
      box-shadow: 0 5px 20px rgba(0,0,0,0.08);
    }

    /* Évaluation manager améliorée */
    .manager-rating {
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 15px;
      margin: 20px 0;
      padding: 15px;
      background: white;
      border-radius: 12px;
      box-shadow: 0 3px 15px rgba(0,0,0,0.1);
    }

    .rating-stars-small {
      display: flex;
      gap: 3px;
    }

    .rating-star {
      color: #e0e0e0;
      font-size: 1.4rem;
      transition: all 0.3s ease;
    }

    .rating-star.filled {
      color: var(--accent-color);
      text-shadow: 0 2px 8px rgba(255, 193, 7, 0.4);
    }

    .rating-value {
      font-weight: 700;
      color: var(--secondary-color);
      background: var(--primary-gradient);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
      padding: 8px 16px;
      border-radius: 25px;
      border: 2px solid var(--primary-color);
    }

    .evaluation-count {
      font-size: 1rem;
      color: var(--secondary-color);
      font-weight: 500;
    }

    /* Galerie Modal améliorée */
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
      backdrop-filter: blur(10px);
    }

    .gallery-modal.active {
      display: flex;
      animation: fadeIn 0.3s ease;
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    .gallery-modal-content {
      width: 95%;
      max-width: 1400px;
      height: 95vh;
      display: flex;
      flex-direction: column;
      position: relative;
    }

    .gallery-close-btn {
      position: absolute;
      top: -60px;
      right: 0;
      background: rgba(255, 255, 255, 0.2);
      border: none;
      color: white;
      width: 50px;
      height: 50px;
      border-radius: 50%;
      cursor: pointer;
      font-size: 1.5rem;
      transition: all 0.4s ease;
      display: flex;
      align-items: center;
      justify-content: center;
      z-index: 10001;
      backdrop-filter: blur(10px);
    }

    .gallery-close-btn:hover {
      background: rgba(255, 255, 255, 0.3);
      transform: rotate(90deg) scale(1.1);
    }

    .gallery-image-container {
      flex: 1;
      position: relative;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-bottom: 25px;
    }

    .modal-gallery-img {
      max-width: 100%;
      max-height: 100%;
      object-fit: contain;
      border-radius: 15px;
      box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
      transition: all 0.5s ease;
      animation: zoomIn 0.4s ease;
    }

    @keyframes zoomIn {
      from { transform: scale(0.8); opacity: 0; }
      to { transform: scale(1); opacity: 1; }
    }

    .gallery-arrow {
      position: absolute;
      background: rgba(255, 255, 255, 0.95);
      border: none;
      width: 70px;
      height: 70px;
      border-radius: 50%;
      cursor: pointer;
      font-size: 2.2rem;
      color: var(--secondary-color);
      display: flex;
      align-items: center;
      justify-content: center;
      transition: all 0.4s ease;
      z-index: 10;
      box-shadow: 0 5px 20px rgba(0,0,0,0.3);
    }

    .gallery-arrow:hover {
      background: white;
      transform: scale(1.15);
      box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
    }

    .left-arrow {
      left: 30px;
    }

    .right-arrow {
      right: 30px;
    }

    .gallery-counter {
      position: absolute;
      bottom: 25px;
      left: 50%;
      transform: translateX(-50%);
      background: rgba(0, 0, 0, 0.8);
      color: white;
      padding: 12px 25px;
      border-radius: 30px;
      font-size: 1.1rem;
      font-weight: 600;
      backdrop-filter: blur(10px);
    }

    .gallery-thumbnails {
      display: flex;
      gap: 12px;
      overflow-x: auto;
      padding: 15px 0;
      justify-content: center;
      scrollbar-width: thin;
      scrollbar-color: var(--primary-color) transparent;
    }

    .gallery-thumbnails::-webkit-scrollbar {
      height: 8px;
    }

    .gallery-thumbnails::-webkit-scrollbar-thumb {
      background: var(--primary-color);
      border-radius: 10px;
    }

    .gallery-thumbnail {
      width: 120px;
      height: 90px;
      object-fit: cover;
      border-radius: 10px;
      cursor: pointer;
      border: 3px solid transparent;
      transition: all 0.4s ease;
      opacity: 0.7;
    }

    .gallery-thumbnail:hover {
      opacity: 0.9;
      transform: translateY(-5px) scale(1.05);
    }

    .gallery-thumbnail.active {
      border-color: var(--primary-color);
      opacity: 1;
      box-shadow: 0 5px 20px rgba(2, 144, 210, 0.6);
      transform: translateY(-5px);
    }

    /* Animation pour les sections */
    .fade-in-section {
      opacity: 0;
      transform: translateY(30px);
      transition: all 0.6s ease;
    }

    .fade-in-section.visible {
      opacity: 1;
      transform: translateY(0);
    }

    /* Responsive improvements */
    @media (max-width: 768px) {
      .service-title {
        font-size: 2rem;
      }
      
      .service-info {
        padding: 25px;
      }
      
      .gallery-section,
      .comments-section {
        padding: 0 25px;
      }
      
      .action-buttons {
        flex-direction: column;
      }
      
      .gallery-arrow {
        width: 50px;
        height: 50px;
        font-size: 1.5rem;
      }
      
      .left-arrow {
        left: 10px;
      }
      
      .right-arrow {
        right: 10px;
      }
    }
  </style>
</head>
<body>

<!-- Navbar (conservé d'origine) -->
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
    
    <!-- Bouton retour avec animation -->
    <div class="my-4 fade-in-section">
      <a href="${pageContext.request.contextPath}/services" class="back-button">
        <i class="bi bi-arrow-left"></i> Retour aux services
      </a>
    </div>

    <div class="service-content fade-in-section">
      
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
                <i class="bi bi-image text-muted" style="font-size: 4rem;"></i>
              </div>
            </c:otherwise>
          </c:choose>
        </div>
        
        <div class="col-lg-6">
          <div class="service-info">
            <h1 class="service-title">${service.titre}</h1>
            <span class="service-category">
              <i class="bi bi-tag me-2"></i>${service.categorie.nom}
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

      <!-- Fonctionnalités avec animation -->
      <div class="features-section fade-in-section">
        <h3 class="gallery-title"><i class="bi bi-list-check"></i> Fonctionnalités du service</h3>
        <c:choose>
          <c:when test="${not empty service.fonctionnalites}">
            <div class="row">
              <c:forEach var="f" items="${service.fonctionnalites}" varStatus="status">
                <div class="col-md-6 mb-3">
                  <div class="feature-item" style="animation-delay: ${status.index * 0.1}s;">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>${f.description}</span>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <p class="text-muted text-center py-4">
              <i class="bi bi-info-circle me-2"></i>Aucune fonctionnalité spécifiée pour ce service.
            </p>
          </c:otherwise>
        </c:choose>
      </div>

      <!-- Galerie d'images avec animation -->
      <c:if test="${fn:length(photosBase64) > 1}">
        <div class="gallery-section fade-in-section">
          <h3 class="gallery-title"><i class="bi bi-images"></i> Galerie du service</h3>
          <div class="row g-4">
            <c:forEach var="photo" items="${photosBase64}" begin="1" varStatus="status">
              <div class="col-lg-3 col-md-4 col-sm-6">
                <img src="data:image/jpeg;base64,${photo}" 
                     alt="Image ${status.index + 1}" 
                     class="gallery-image"
                     onclick="openGalleryModal(${status.index})"
                     style="animation-delay: ${status.index * 0.1}s;">
              </div>
            </c:forEach>
          </div>
        </div>
      </c:if>

      <!-- Section Évaluation et Commentaires avec animation -->
      <div class="comments-section fade-in-section">
        <h3 class="gallery-title"><i class="bi bi-chat-left-text"></i> Évaluations et Commentaires</h3>
        
        <!-- Formulaire d'ajout de commentaire -->
        <div class="comment-form-card mb-5">
          <div class="card border-0 shadow-sm">
            <div class="card-body p-4">
              <h5 class="card-title fw-bold mb-4">
                <i class="bi bi-pencil-square me-2"></i>Ajouter un commentaire
              </h5>
              <form id="commentForm" action="${pageContext.request.contextPath}/AddCommentServlet" method="POST">
                <input type="hidden" name="serviceId" value="${service.id}">
                
                <!-- Système d'étoiles amélioré -->
                <div class="mb-4">
                  <label class="form-label fw-semibold">Votre note :</label>
                  <div class="rating-stars">
                    <input type="radio" id="star5" name="rating" value="5" ${sessionScope.sessionUser == null ? 'disabled' : ''}>
                    <label for="star5" class="star-label" style="${sessionScope.sessionUser == null ? 'cursor: not-allowed;' : 'cursor: pointer;'}">★</label>
                    <input type="radio" id="star4" name="rating" value="4" ${sessionScope.sessionUser == null ? 'disabled' : ''}>
                    <label for="star4" class="star-label" style="${sessionScope.sessionUser == null ? 'cursor: not-allowed;' : 'cursor: pointer;'}">★</label>
                    <input type="radio" id="star3" name="rating" value="3" ${sessionScope.sessionUser == null ? 'disabled' : ''}>
                    <label for="star3" class="star-label" style="${sessionScope.sessionUser == null ? 'cursor: not-allowed;' : 'cursor: pointer;'}">★</label>
                    <input type="radio" id="star2" name="rating" value="2" ${sessionScope.sessionUser == null ? 'disabled' : ''}>
                    <label for="star2" class="star-label" style="${sessionScope.sessionUser == null ? 'cursor: not-allowed;' : 'cursor: pointer;'}">★</label>
                    <input type="radio" id="star1" name="rating" value="1" ${sessionScope.sessionUser == null ? 'disabled' : ''}>
                    <label for="star1" class="star-label" style="${sessionScope.sessionUser == null ? 'cursor: not-allowed;' : 'cursor: pointer;'}">★</label>
                  </div>
                </div>
                
                <!-- Champ commentaire -->
                <div class="mb-4">
                  <label for="commentText" class="form-label fw-semibold">Votre commentaire :</label>
                  <textarea class="form-control border-2" id="commentText" name="comment" 
                            rows="4" placeholder="Partagez votre expérience avec ce service..." 
                            ${sessionScope.sessionUser == null ? 'disabled' : ''}
                            style="border-radius: 12px; padding: 15px;"></textarea>
                </div>
                
                <!-- Bouton de soumission -->
                <button type="submit" class="btn btn-primary px-4 py-2" ${sessionScope.sessionUser == null ? 'disabled' : ''}
                        style="border-radius: 12px; font-weight: 600;">
                  <i class="bi bi-send-fill me-2"></i> Publier le commentaire
                </button>
                
                <!-- Message d'information -->
                <c:if test="${sessionScope.sessionUser == null}">
                  <div class="alert alert-info mt-4 border-0 shadow-sm" style="border-radius: 12px;">
                    <i class="bi bi-info-circle me-2"></i> 
                    Vous devez être connecté pour ajouter un commentaire.
                    <a href="${pageContext.request.contextPath}/login" class="alert-link ms-1">Se connecter</a>
                  </div>
                </c:if>
              </form>
            </div>
          </div>
        </div>

        <!-- Liste des commentaires existants -->
        <c:choose>
          <c:when test="${not empty commentaires}">
            <div class="row">
              <c:forEach var="comment" items="${commentaires}" varStatus="status">
                <div class="col-12 mb-4">
                  <div class="comment-card" style="animation-delay: ${status.index * 0.1}s;">
                    <div class="comment-header">
                      <c:choose>
                        <c:when test="${not empty comment.photoAuteur}">
                          <img src="${comment.photoAuteur}" 
                               alt="Photo de ${comment.nomAuteur}" 
                               class="comment-avatar">
                        </c:when>
                        <c:otherwise>
                          <div class="comment-avatar bg-primary d-flex align-items-center justify-content-center text-white">
                            <i class="bi bi-person-fill"></i>
                          </div>
                        </c:otherwise>
                      </c:choose>
                      <div>
                        <h6 class="comment-author">${comment.nomAuteur}</h6>
                        <small class="comment-date">
                          <i class="bi bi-clock me-1"></i>${comment.dateCreation}
                        </small>
                      </div>
                    </div>
                    <p class="comment-content mt-3">${comment.contenu}</p>
                  </div>
                </div>
              </c:forEach>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-center py-5 fade-in-section">
              <i class="bi bi-chat-square-text display-1 text-muted mb-3"></i>
              <h5 class="text-muted mb-3">Aucun avis pour le moment.</h5>
              <c:if test="${sessionScope.sessionUser == null}">
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary px-4 py-2">
                  <i class="bi bi-pencil-square me-2"></i> Soyez le premier à donner votre avis
                </a>
              </c:if>
            </div>
          </c:otherwise>
        </c:choose>
      </div>

    </div>
  </c:if>

  <c:if test="${empty service}">
    <div class="alert alert-danger text-center border-0 shadow-sm fade-in-section" style="border-radius: 15px;">
      <i class="bi bi-exclamation-triangle display-4 mb-3"></i>
      <h4>Service non trouvé</h4>
      <p class="mb-3">Le service que vous recherchez n'existe pas ou n'est plus disponible.</p>
      <a href="${pageContext.request.contextPath}/services" class="btn btn-primary px-4 py-2">
        <i class="bi bi-arrow-left me-2"></i> Retour à la liste des services
      </a>
    </div>
  </c:if>
</div>

<!-- Footer (conservé d'origine) -->
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
    <div class="modal-content border-0 shadow-lg" style="border-radius: 20px;">
      <div class="modal-header bg-primary text-white" style="border-radius: 20px 20px 0 0;">
        <h5 class="modal-title fw-bold" id="managerModalLabel">
          <i class="bi bi-person-badge me-2"></i> Informations du Prestataire
        </h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body p-4">
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

// Animation au défilement
document.addEventListener('DOMContentLoaded', function() {
  const fadeSections = document.querySelectorAll('.fade-in-section');
  
  const fadeInOnScroll = function() {
    fadeSections.forEach(section => {
      const sectionTop = section.getBoundingClientRect().top;
      const windowHeight = window.innerHeight;
      
      if (sectionTop < windowHeight - 100) {
        section.classList.add('visible');
      }
    });
  };
  
  // Initial check
  fadeInOnScroll();
  
  // Check on scroll
  window.addEventListener('scroll', fadeInOnScroll);
});

// Système d'étoiles basique (pour l'affichage uniquement)
<c:if test="${sessionScope.sessionUser == null}">
document.addEventListener('DOMContentLoaded', function() {
  const stars = document.querySelectorAll('.star-label');
  stars.forEach(star => {
    star.addEventListener('click', function() {
      alert('Veuillez vous connecter pour évaluer ce service.');
    });
  });
});
</c:if>

</script>

</body>
</html>