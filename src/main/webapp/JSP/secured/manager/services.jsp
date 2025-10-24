<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Services - MediNest Bootstrap Template</title>
  <meta name="description" content="">
  <meta name="keywords" content="">

  <!-- Favicons -->
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/img/favicon.png" rel="icon">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/img/apple-touch-icon.png" rel="apple-touch-icon">


  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">
  
  <!-- Vendor CSS Files -->
 <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/css/main.css" rel="stylesheet">

  <style>
    /* Reset complet des marges et padding */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }
    
    body {
      margin: 0;
      padding: 0;
      height: 100vh;
      display: flex;
      flex-direction: column;
    }
    
    /* Header collé au top */
    .header {
      margin: 0;
      padding: 15px 0;
      position: relative;
      top: 0;
      width: 100%;
      border-bottom: 1px solid #dee2e6;
      flex-shrink: 0;
    }
    
    /* Main prend toute la hauteur restante */
    .main {
      margin: 0;
      padding: 0;
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    
    /* Page Title sans marges */
    .page-title {
      margin: 0;
      padding: 0;
      flex-shrink: 0;
    }
    
    .breadcrumbs {
      margin: 0;
      padding: 10px 0;
      border-bottom: 1px solid #dee2e6;
    }
    
    /* Services section prend toute la hauteur */
    .services.section {
      margin: 0;
      padding: 0;
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    
    /* Container principal prend toute la hauteur */
    .services-section-container {
      padding: 0;
      margin: 0;
      max-width: 100%;
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    
    /* Row prend toute la hauteur */
    .no-gutters-row {
      margin: 0;
      flex: 1;
      display: flex;
    }
    
    /* Sidebar élargie et adaptative */
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
    }
    
    .sidebar .nav-link:hover, 
    .sidebar .nav-link.active {
      background-color: #e9ecef;
      color: #0d6efd;
      border-right: 4px solid #0d6efd;
    }
    
    .sidebar .nav-link i {
      margin-right: 12px;
      width: 22px;
      text-align: center;
      font-size: 1.1rem;
    }
    
    /* Colonne de contenu principal prend toute la hauteur */
    .content-column {
      padding: 0;
      display: flex;
      flex-direction: column;
      flex: 1;
    }
    
    /* Contenu principal scrollable */
    .main-content {
      padding: 25px;
      flex: 1;
      overflow-y: auto;
      background-color: #fff;
    }
    
    /* Footer collé en bas */
    .footer {
      margin: 0;
      padding: 20px 0;
      border-top: 1px solid #dee2e6;
      flex-shrink: 0;
    }
    
    .footer .copyright {
      margin: 0;
      padding: 0;
    }
    
    /* Services grid sans marges supplémentaires */
    .services-grid {
      margin: 0;
    }
    
    /* Ajustement des cartes de services pour mieux remplir l'espace */
    .service-card {
      height: 100%;
      display: flex;
      flex-direction: column;
    }
    
    .service-body {
      flex: 1;
    }
    
    /* Styles pour le bouton Modifier */
    .edit-section {
      margin-bottom: 30px;
      padding: 20px;
      background-color: #ffff;
      border-radius: 8px;
      border: 1px solid #ffff;
    }
    
    .edit-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }
    
    .edit-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }
    
    .edit-btn {
      background: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 6px;
      font-weight: 600;
      font-size: 1rem;
      transition: all 0.3s ease;
      display: flex;
      align-items: center;
      gap: 8px;
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
      cursor: pointer;
    }
    
    .edit-btn:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
      color: white;
    }
    
    .edit-btn i {
      font-size: 1.1rem;
    }
    
    .edit-description {
      color: #6c757d;
      font-size: 1rem;
      line-height: 1.6;
      margin: 0;
    }
    
    /* Modal Styles */
    .modal-overlay {
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background-color: rgba(0, 0, 0, 0.5);
      display: flex;
      justify-content: center;
      align-items: center;
      z-index: 1050;
      padding: 20px;
      opacity: 0;
      visibility: hidden;
      transition: all 0.3s ease;
    }
    
    .modal-overlay.active {
      opacity: 1;
      visibility: visible;
    }
    
    .modal-content {
      background-color: white;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 700px;
      max-height: 90vh;
      overflow-y: auto;
      transform: translateY(-20px);
      transition: transform 0.3s ease;
    }
    
    .modal-overlay.active .modal-content {
      transform: translateY(0);
    }
    
    .modal-header {
      padding: 20px 25px;
      border-bottom: 1px solid #e9ecef;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    
    .modal-title {
      font-size: 1.5rem;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }
    
    .close-btn {
      background: none;
      border: none;
      font-size: 1.5rem;
      color: #6c757d;
      cursor: pointer;
      transition: color 0.3s;
      width: 30px;
      height: 30px;
      display: flex;
      align-items: center;
      justify-content: center;
      border-radius: 50%;
    }
    
    .close-btn:hover {
      color: #495057;
      background-color: #f8f9fa;
    }
    
    .modal-body {
      padding: 25px;
    }
    
    .form-group {
      margin-bottom: 20px;
    }
    
    .form-label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #495057;
    }
    
    .form-control {
      width: 100%;
      padding: 12px 15px;
      border: 1px solid #ced4da;
      border-radius: 6px;
      font-size: 1rem;
      transition: border-color 0.3s, box-shadow 0.3s;
    }
    
    .form-control:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      outline: none;
    }
    
    textarea.form-control {
      min-height: 120px;
      resize: vertical;
    }
    
    .form-row {
      display: flex;
      flex-wrap: wrap;
      margin-right: -10px;
      margin-left: -10px;
    }
    
    .form-col {
      flex: 1;
      padding-right: 10px;
      padding-left: 10px;
      min-width: 200px;
    }
    
    .feature-input-group {
      display: flex;
      gap: 10px;
      margin-bottom: 10px;
    }
    
    .feature-input-group .form-control {
      flex: 1;
    }
    
    .add-feature-btn {
      background-color: #f8f9fa;
      border: 1px dashed #ced4da;
      color: #6c757d;
      padding: 10px 15px;
      border-radius: 6px;
      cursor: pointer;
      transition: all 0.3s;
      display: flex;
      align-items: center;
      gap: 5px;
    }
    
    .add-feature-btn:hover {
      background-color: #e9ecef;
      color: #495057;
    }
    
    .remove-feature-btn {
      background: none;
      border: none;
      color: #dc3545;
      cursor: pointer;
      padding: 5px;
      border-radius: 4px;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    
    .remove-feature-btn:hover {
      background-color: rgba(220, 53, 69, 0.1);
    }
    
    .modal-footer {
      padding: 20px 25px;
      border-top: 1px solid #e9ecef;
      display: flex;
      justify-content: flex-end;
      gap: 10px;
    }
    
    .btn {
      padding: 10px 20px;
      border-radius: 6px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s;
      border: none;
    }
    
    .btn-cancel {
      background-color: #f8f9fa;
      color: #495057;
      border: 1px solid #ced4da;
    }
    
    .btn-cancel:hover {
      background-color: #e9ecef;
    }
    
    .btn-submit {
      background: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
      color: white;
      box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
    }
    
    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
    }
    
    /* Responsive */
    @media (max-width: 991.98px) {
      .no-gutters-row {
        flex-direction: column;
      }
      
      .sidebar {
        height: auto;
        border-right: none;
        border-bottom: 1px solid #dee2e6;
        min-height: auto;
      }
      
      .sidebar-column {
        flex: none;
      }
      
      .main-content {
        padding: 20px;
        overflow-y: visible;
      }
      
      .sidebar .nav-link {
        padding: 12px 20px;
        font-size: 1rem;
      }
      
      .edit-header {
        flex-direction: column;
        gap: 15px;
        align-items: flex-start;
      }
      
      .edit-btn {
        width: 100%;
        justify-content: center;
      }
      
      .modal-content {
        max-width: 95%;
      }
      
      .form-row {
        flex-direction: column;
      }
      
      .form-col {
        width: 100%;
        margin-bottom: 15px;
      }
    }
    .photos-container {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

.photo-input-wrapper {
  position: relative;
  width: 100px;
  height: 100px;
  border: 2px dashed #ccc;
  border-radius: 10px;
  display: flex;
  justify-content: center;
  align-items: center;
  cursor: pointer;
  overflow: hidden;
  background-color: #f9f9f9;
  transition: all 0.3s;
}

.photo-input-wrapper:hover {
  border-color: #007bff;
}

.photo-placeholder {
  text-align: center;
  color: #aaa;
}

.photo-placeholder i {
  font-size: 28px;
  display: block;
}

.photo-thumbnail {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.remove-photo-btn {
  position: absolute;
  top: 4px;
  right: 4px;
  background: rgba(0,0,0,0.5);
  border: none;
  color: white;
  border-radius: 50%;
  cursor: pointer;
  width: 22px;
  height: 22px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.remove-photo-btn:hover {
  background: rgba(255, 0, 0, 0.7);
}

.photo-info {
  font-size: 14px;
  color: #666;
  margin-top: 5px;
}
    
  /* Styles pour la barre de recherche */
.edit-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 15px;
  gap: 20px;
}

.search-container {
  flex: 1;
  max-width: 500px;
}

.search-box {
  position: relative;
  display: flex;
  align-items: center;
  background-color: #fff;
  border: 1px solid #ced4da;
  border-radius: 6px;
  padding: 0 15px;
  transition: all 0.3s ease;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.search-box:focus-within {
  border-color: #667eea;
  box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.search-icon {
  color: #6c757d;
  margin-right: 10px;
  font-size: 1rem;
}

.search-input {
  border: none;
  outline: none;
  padding: 12px 0;
  width: 100%;
  font-size: 1rem;
  background: transparent;
}

.clear-search {
  background: none;
  border: none;
  color: #6c757d;
  cursor: pointer;
  padding: 5px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.clear-search:hover {
  background-color: #f8f9fa;
  color: #495057;
}

/* Responsive pour la barre de recherche */
@media (max-width: 768px) {
  .edit-header {
    flex-direction: column;
    gap: 15px;
    align-items: stretch;
  }
  
  .search-container {
    max-width: 100%;
  }
  
  .edit-btn {
    width: 100%;
    justify-content: center;
  }
}  
    @media (min-width: 992px) {
      .sidebar-column {
        flex: 0 0 300px; /* Largeur fixe plus grande pour la sidebar */
      }
      
      .content-column {
        flex: 1;
      }
    }
    
    @media (min-width: 1200px) {
      .sidebar-column {
        flex: 0 0 350px; /* Encore plus large sur les grands écrans */
      }
    }
  </style>
</head>

<body class="services-page">

  <main class="main">

    <!-- Page Title -->
    <div class="page-title">
      <nav class="breadcrumbs">
        <div class="container">
          <ol>
            <li><a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Home</a></li>
            <li class="current">Services</li>
          </ol>
        </div>
      </nav>
    </div><!-- End Page Title -->

    <!-- Services Section avec Sidebar -->
    <section id="services" class="services section">
      <!-- Container modifié pour prendre toute la hauteur -->
      <div class="container-fluid services-section-container" data-aos="fade-up" data-aos-delay="100">
        <div class="row no-gutters-row">
          <!-- Sidebar - colonne élargie -->
           <div class="col-lg-4 col-xl-3 sidebar-column">
            <div class="sidebar">
              <nav class="nav flex-column">
                <a class="nav-link" href="${pageContext.request.contextPath}/ProfileServlet">
                  <i class="fas fa-user-circle"></i> Profile
                </a>
                <a class="nav-link" href="#">
                  <i class="fas fa-envelope-open-text"></i> Demandes
                </a>
                <a class="nav-link" href="#">
                  <i class="fas fa-exclamation-triangle"></i> Réclamations
                </a>
                <a class="nav-link" href="#">
                  <i class="fas fa-concierge-bell"></i> Services
                </a>
                <a class="nav-link active" href="#">
                  <i class="fas fa-chart-line"></i> Statistiques
                </a>
                <div class="logout-container mt-auto">
                  <a href="logout" class="btn btn-logout">
                    <i class="fas fa-sign-out-alt"></i> Déconnexion
                  </a>
                </div>
              </nav>
            </div>
          </div>
          
          <!-- Contenu principal - colonne adaptative -->
          <div class="col-lg-8 col-xl-9 content-column">
            <div class="main-content">
              
              <!-- Section Modifier avec bouton -->
             <!-- Section Modifier avec bouton et barre de recherche -->
			<div class="edit-section" data-aos="fade-up">
			  <div class="edit-header">
			    <div class="search-container">
			      <div class="search-box">
			        <i class="fas fa-search search-icon"></i>
			        <input type="text" id="serviceSearch" class="search-input" placeholder="Rechercher un service par titre...">
			        <button type="button" class="clear-search" id="clearSearchBtn" style="display: none;">
			          <i class="fas fa-times"></i>
			        </button>
			      </div>
			    </div>
			    <button class="edit-btn" id="openModalBtn">
			      <i class="fas fa-edit"></i>
			      Ajouter un Service
			    </button>
			  </div>
			</div>
              <div class="services-grid">
                <div class="row g-4">

                  <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="service-card primary-care">
                      <div class="service-header">
                        <div class="service-icon">
                          <i class="fas fa-heartbeat"></i>
                        </div>
                        <span class="service-category">Nom de catégorie</span>
                      </div>
                      <div class="service-body">
                        <h4>Titre du service</h4>
                        <p>description du service ...</p>
                        <div class="service-features">
                          <!-- les premiers 3 fonctionnalité du service -->
                          <span class="feature-badge">Fonctionnalté 1 du service</span>
                          <span class="feature-badge">Fonctionnalté 2 du service</span>
                          <span class="feature-badge">Fonctionnalté 3 du service</span>
                        </div>
                      </div>
                      <div class="service-footer">
                        <a href="http://localhost:8082/ProjetJEE/ServiceDetailsServlet?id=${service.id}" class="service-btn">
                          Voir details du service
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </div>
                    </div>
                  </div>

               
                </div>
              </div>

              

              
          </div>
        </div>
      </div>
    </section><!-- /Services Section -->

  </main>

  <!-- Modal pour ajouter un service -->
  <div class="modal-overlay" id="serviceModal">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title">Ajouter un nouveau service</h3>
        <button class="close-btn" id="closeModalBtn">&times;</button>
      </div>
      <div class="modal-body">
        <form id="serviceForm"   enctype="multipart/form-data">
          <div class="form-row">
            <div class="form-col">
              <div class="form-group">
                <label for="serviceName" class="form-label">Nom du service</label>
                <input type="text" id="serviceName" class="form-control" placeholder="Ex: Cardiologie" required>
              </div>
            </div>
            <div class="form-col">
              <div class="form-group">
                <label for="serviceCategory" class="form-label">Catégorie</label>
                <select id="serviceCategory" class="form-control" required>
                  <option value="">Sélectionner une catégorie</option>
                 
                </select>
              </div>
            </div>
          </div>
          
         
          <div class="form-group">
            <label for="serviceDescription" class="form-label">Description du service</label>
            <textarea id="serviceDescription" class="form-control" placeholder="Décrivez le service en détail..." required></textarea>
          </div>
          <div class="form-group"> 
          <label class="form-label">Fonctionnalités du service</label> 
          <div id="featuresContainer"> <div class="feature-input-group"> 
          <input type="text" class="form-control feature-input" name="features[]" placeholder="Ex: Consultation spécialisée"> 
          <button type="button" class="remove-feature-btn" style="display: none;"> 
          <i class="fas fa-times"></i> 
          </button> 
          </div> 
          </div> 
          <button type="button" class="add-feature-btn" id="addFeatureBtn"> 
          <i class="fas fa-plus"></i> Ajouter une fonctionnalité </button> 
          </div> 
          
          <div class="form-group"> 
	          <label class="form-label">Photos du service (max. 6)</label> 
	          <div id="photosContainer" class="photos-container"> 
		          <div class="photo-input-wrapper"> 
		             <input type="file" class="photo-input" name="photos" accept="image/*" required hidden multiple> 
			          <div class="photo-placeholder" id="addFirstPhoto"> 
			          <i class="fas fa-camera"></i> 
			          <span>Ajouter une photo</span> 
			          </div>
			         </div> 
			       </div> 
		          <div class="photo-info"> 
		            <span id="photoCount">0</span>/6 photos ajoutées 
	             </div> 
          </div>
		         
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-cancel" id="cancelBtn">Annuler</button>
        <button type="button" class="btn btn-submit" id="submitBtn">Ajouter le service</button>
      </div>
    </div>
  </div>

 

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/php-email-form/validate.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/aos/aos.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/swiper/swiper-bundle.min.js"></script>


  <!-- Main JS File -->
 <script src="<%= request.getContextPath() %>/JSP/secured/assets/js/main.js"></script>
  <script>
document.addEventListener("DOMContentLoaded", function () {
    // Fonction pour charger et afficher les services
    function loadServices() {
        fetch('<%= request.getContextPath() %>/GetServicesServlet') 
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erreur réseau : ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                const servicesGrid = document.querySelector('.services-grid .row');
                servicesGrid.innerHTML = '';  // Vider le contenu existant (supprime l'exemple statique)

                if (data.length === 0) {
                    servicesGrid.innerHTML = '<p>Aucun service disponible.</p>';
                    return;
                }

                data.forEach((service, index) => {
                    // Créer la carte de service
                    const colDiv = document.createElement('div');
                    colDiv.className = 'col-lg-4 col-md-6';
                    colDiv.setAttribute('data-aos', 'zoom-in');
                    colDiv.setAttribute('data-aos-delay', (200 + index * 100).toString());  // Délai progressif

                    const cardDiv = document.createElement('div');
                    cardDiv.className = 'service-card primary-care';  // Adaptez la classe selon la catégorie si nécessaire

                    // Header de la carte
                    const headerDiv = document.createElement('div');
                    headerDiv.className = 'service-header';
                    const iconDiv = document.createElement('div');
                    iconDiv.className = 'service-icon';
                    iconDiv.innerHTML = '<i class="fas fa-heartbeat"></i>';  // Icône par défaut, adaptez si vous avez des icônes dynamiques
                    const categorySpan = document.createElement('span');
                    categorySpan.className = 'service-category';
                    categorySpan.textContent = service.categorie ? service.categorie.nom : 'Aucune catégorie';
                    headerDiv.appendChild(iconDiv);
                    headerDiv.appendChild(categorySpan);

                    // Body de la carte
                    const bodyDiv = document.createElement('div');
                    bodyDiv.className = 'service-body';
                    const titleH4 = document.createElement('h4');
                    titleH4.textContent = service.titre;
                    const descP = document.createElement('p');
                    descP.textContent = service.description;
                    const featuresDiv = document.createElement('div');
                    featuresDiv.className = 'service-features';
                    // Ajouter les 3 premières fonctionnalités (ou moins si pas disponibles)
                    (service.fonctionnalites || []).forEach(feature => {
                        const badgeSpan = document.createElement('span');
                        badgeSpan.className = 'feature-badge';
                        badgeSpan.textContent = feature;
                        featuresDiv.appendChild(badgeSpan);
                    });
                    bodyDiv.appendChild(titleH4);
                    bodyDiv.appendChild(descP);
                    bodyDiv.appendChild(featuresDiv);

                    // Footer de la carte
                    const footerDiv = document.createElement('div');
                    footerDiv.className = 'service-footer';
                    const linkA = document.createElement('a');
                    linkA.className = 'service-btn';
                    linkA.href = 'http://localhost:8082/ProjetJEE/ServiceDetailsServlet?id=' + service.id;  // Lien vers les détails, adaptez
                    linkA.innerHTML = 'Voir details du service <i class="fas fa-arrow-right"></i>';
                    footerDiv.appendChild(linkA);

                    // Assembler la carte
                    cardDiv.appendChild(headerDiv);
                    cardDiv.appendChild(bodyDiv);
                    cardDiv.appendChild(footerDiv);
                    colDiv.appendChild(cardDiv);
                    servicesGrid.appendChild(colDiv);
                });

                // Réinitialiser AOS après ajout dynamique (si vous utilisez AOS)
                if (typeof AOS !== 'undefined') {
                    AOS.refresh();
                }
            })
            .catch(error => {
                console.error('Erreur lors du chargement des services :', error);
                const servicesGrid = document.querySelector('.services-grid .row');
                servicesGrid.innerHTML = '<p>Erreur lors du chargement des services. Veuillez réessayer.</p>';
            });
    }

    // Charger les services au démarrage
    loadServices();
});
</script>

<script>
//Fonction de recherche
document.addEventListener("DOMContentLoaded", function() {
  const searchInput = document.getElementById('serviceSearch');
  const clearSearchBtn = document.getElementById('clearSearchBtn');
  
  // Afficher/masquer le bouton de suppression
  searchInput.addEventListener('input', function() {
    if (this.value.trim() !== '') {
      clearSearchBtn.style.display = 'flex';
    } else {
      clearSearchBtn.style.display = 'none';
    }
    filterServices(this.value.trim());
  });
  
  // Effacer la recherche
  clearSearchBtn.addEventListener('click', function() {
    searchInput.value = '';
    this.style.display = 'none';
    filterServices('');
  });
  
  // Fonction pour filtrer les services
  function filterServices(searchTerm) {
    const serviceCards = document.querySelectorAll('.services-grid .col-lg-4.col-md-6');
    
    serviceCards.forEach(card => {
      const title = card.querySelector('h4').textContent.toLowerCase();
      
      if (title.includes(searchTerm.toLowerCase()) || searchTerm === '') {
        card.style.display = 'block';
      } else {
        card.style.display = 'none';
      }
    });
  }
});
</script>
  <script>
  
  const maxPhotos = 6;
  const photosContainer = document.getElementById('photosContainer');
  const photoCountText = document.getElementById('photoCount');

  let photoCount = 0;
  let selectedFiles = []; // Tableau pour stocker tous les fichiers sélectionnés

  // Écouter le clic sur le bouton "ajouter une photo"
  photosContainer.addEventListener('click', (e) => {
    const placeholder = e.target.closest('.photo-placeholder');
    if (placeholder) {
      const fileInput = placeholder.parentElement.querySelector('.photo-input');
      fileInput.click();
    }
  });

  // Quand un fichier est sélectionné
  photosContainer.addEventListener('change', (e) => {
    const input = e.target;
    if (input.classList.contains('photo-input') && input.files.length > 0) {
      const files = Array.from(input.files);
      files.forEach(file => {
        if (photoCount >= maxPhotos) {
          alert(`Vous pouvez ajouter au maximum ${maxPhotos} photos.`);
          return;
        }

        // Ajouter au tableau
        selectedFiles.push(file);

        const reader = new FileReader();
        reader.onload = function (event) {
          const imageURL = event.target.result;

          // Créer un bloc miniature
          const photoWrapper = document.createElement('div');
          photoWrapper.className = 'photo-input-wrapper';
          photoWrapper.dataset.index = selectedFiles.length - 1; // Stocker l'index pour la suppression

          const img = document.createElement('img');
          img.src = imageURL;
          img.className = 'photo-thumbnail';

          const removeBtn = document.createElement('button');
          removeBtn.type = 'button';
          removeBtn.className = 'remove-photo-btn';
          removeBtn.innerHTML = '<i class="fas fa-times"></i>';
          removeBtn.addEventListener('click', () => {
            const index = parseInt(photoWrapper.dataset.index);
            selectedFiles.splice(index, 1); // Retirer du tableau
            photoWrapper.remove();
            photoCount--;

            // Mettre à jour les indices des wrappers restants
            const wrappers = photosContainer.querySelectorAll('.photo-input-wrapper:not(:last-child)'); // Exclure le placeholder
            wrappers.forEach((wrapper, i) => {
              wrapper.dataset.index = i;
            });

            updatePhotoCount();
            checkAddButton();
          });

          photoWrapper.appendChild(img);
          photoWrapper.appendChild(removeBtn);

          // Ajouter au container avant le placeholder
          const placeholderBlock = photosContainer.querySelector('.photo-input-wrapper:last-child');
          photosContainer.insertBefore(photoWrapper, placeholderBlock);

          photoCount++;
          updatePhotoCount();
          checkAddButton();
        };
        reader.readAsDataURL(file);
      });

      // Vider l'input pour permettre de nouveaux ajouts
      input.value = '';
    }
  });

  // Mettre à jour le compteur
  function updatePhotoCount() {
    photoCountText.textContent = photoCount;
  }

  // Masquer ou afficher le bouton d'ajout
  function checkAddButton() {
    const placeholder = photosContainer.querySelector('.photo-placeholder');
    if (photoCount >= maxPhotos) {
      placeholder.style.display = 'none';
    } else {
      placeholder.style.display = 'flex';
    }
  }

	document.addEventListener("DOMContentLoaded", function () {
	    const categorySelect = document.getElementById("serviceCategory");
	
	    // Vider le select (sauf l'option par défaut)
	    categorySelect.innerHTML = '<option value="">Sélectionner une catégorie</option>';
	
	    // Appel AJAX vers ta servlet
	    fetch('<%= request.getContextPath() %>/api/categories')
	        .then(response => response.json())
	        .then(data => {
	            data.forEach(categorie => {
	                const option = document.createElement("option");
	                option.value = categorie.id;  // ou autre champ si nécessaire
	                option.textContent = categorie.nom;
	                categorySelect.appendChild(option);
	            });
	        })
	        .catch(error => console.error("Erreur lors du chargement des catégories :", error));
	});
	</script>
  
  <script>
    // Gestion du modal
    document.addEventListener('DOMContentLoaded', function() {
      const modal = document.getElementById('serviceModal');
      const openBtn = document.getElementById('openModalBtn');
      const closeBtn = document.getElementById('closeModalBtn');
      const cancelBtn = document.getElementById('cancelBtn');
      const submitBtn = document.getElementById('submitBtn');
      const addFeatureBtn = document.getElementById('addFeatureBtn');
      const featuresContainer = document.getElementById('featuresContainer');
      
      // Ouvrir le modal
      openBtn.addEventListener('click', function() {
        modal.classList.add('active');
        document.body.style.overflow = 'hidden'; // Empêcher le défilement de la page
      });
      
      // Fermer le modal
      function closeModal() {
        modal.classList.remove('active');
        document.body.style.overflow = ''; // Rétablir le défilement
      }
      
      closeBtn.addEventListener('click', closeModal);
      cancelBtn.addEventListener('click', closeModal);
      
      // Fermer le modal en cliquant à l'extérieur
      modal.addEventListener('click', function(e) {
        if (e.target === modal) {
          closeModal();
        }
      });
      
      let featureIndex = 1;
      // Ajouter une fonctionnalité
      addFeatureBtn.addEventListener('click', function() {
        const featureGroup = document.createElement('div');
        featureGroup.className = 'feature-input-group';
        
        
        
        const input = document.createElement('input');
        input.type = 'text';
        input.className = 'form-control feature-input';
        input.name = 'features[]';
        featureIndex++;
        input.placeholder = 'Ex: Consultation spécialisée';
        
        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'remove-feature-btn';
        removeBtn.innerHTML = '<i class="fas fa-times"></i>';
        
        removeBtn.addEventListener('click', function() {
          featureGroup.remove();
        });
        
        featureGroup.appendChild(input);
        featureGroup.appendChild(removeBtn);
        featuresContainer.appendChild(featureGroup);
      });
      
  
      submitBtn.addEventListener('click', function() {
    	    const serviceName = document.getElementById('serviceName').value;
    	    const serviceCategory = document.getElementById('serviceCategory').value;
    	    const serviceDescription = document.getElementById('serviceDescription').value;

    	    // Validation basique
    	    if (!serviceName || !serviceCategory || !serviceDescription) {
    	        alert('Veuillez remplir tous les champs obligatoires.');
    	        return;
    	    }

    	    // Récupérer les fonctionnalités
    	    const featureInputs = document.querySelectorAll('.feature-input');
    	    const features = [];
    	    featureInputs.forEach(input => {
    	        if (input.value.trim()) {
    	            features.push(input.value.trim());
    	        }
    	    });

    	    if (selectedFiles.length === 0) {
    	        alert('Veuillez ajouter au moins une photo.');
    	        return;
    	    }

    	    // Créer FormData et ajouter les fichiers
    	    const formData = new FormData();
    	    formData.append('name', serviceName);
    	    formData.append('category', serviceCategory);
    	    formData.append('description', serviceDescription);
    	    features.forEach((feature) => formData.append('features', feature));
    	    selectedFiles.forEach((file) => formData.append('photos', file)); // Ajouter tous les fichiers

    	    fetch('http://localhost:8084/ProjetJEE/MyServiceServlet', {
    	        method: 'POST',
    	        body: formData
    	    })
    	    .then(response => {
    	        if (response.ok) {
    	            alert('Service ajouté avec succès !');
    	            // Fermer le modal
    	            closeModal();
    	            // Recharger la page pour rafraîchir la liste des services
    	            window.location.reload();
    	        } else {
    	            alert('Erreur lors de l’enregistrement.');
    	        }
    	    })
    	    .catch(error => {
    	        console.error('Erreur:', error);
    	        alert('Erreur lors de l’envoi au serveur.');
    	    });
    	});

      
     
    });
  </script>

</body>

</html>