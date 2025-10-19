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
  <link href="../assets/img/favicon.png" rel="icon">
  <link href="../assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&family=Ubuntu:ital,wght@0,300;0,400;0,500;0,700;1,300;1,400;1,500;1,700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="../assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="../assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="../assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="../assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="../assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="../assets/css/main.css" rel="stylesheet">

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
            <li><a href="index.html">Home</a></li>
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
                 <a class="nav-link" href="services.html">Profile</a>
 <a class="nav-link" href="services.html">
    <i class="fas fa-user-circle"></i> Profile
  </a>
  <a class="nav-link " href="#">
    <i class="fas fa-envelope-open-text"></i> Demandes
  </a>
  <a class="nav-link" href="#">
    <i class="fas fa-exclamation-triangle"></i> Réclamations
  </a>
  <a class="nav-link active" href="#">
    <i class="fas fa-concierge-bell"></i> Services
  </a>
  <a class="nav-link" href="#">
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
              <div class="edit-section" data-aos="fade-up">
                <button class="edit-btn" id="openModalBtn">
                  <i class="fas fa-edit"></i>
                  Ajouter un Service
                </button>
              </div>

              <div class="services-grid">
                <div class="row g-4">

                  <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="200">
                    <div class="service-card primary-care">
                      <div class="service-header">
                        <div class="service-icon">
                          <i class="fas fa-heartbeat"></i>
                        </div>
                        <span class="service-category">Primary Care</span>
                      </div>
                      <div class="service-body">
                        <h4>General Consultation</h4>
                        <p>Comprehensive health assessments and preventive care planning for all family members.</p>
                        <div class="service-features">
                          <span class="feature-badge">Health Monitoring</span>
                          <span class="feature-badge">Wellness Programs</span>
                          <span class="feature-badge">Preventive Care</span>
                        </div>
                      </div>
                      <div class="service-footer">
                        <a href="service-details.html" class="service-btn">
                          Schedule Visit
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </div>
                    </div>
                  </div>

                  <!-- Les autres cartes de services -->
                  <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="service-card specialty-care featured">
                      <div class="service-header">
                        <div class="service-icon">
                          <i class="fas fa-heart"></i>
                        </div>
                        <span class="service-category">Specialty</span>
                        <div class="featured-badge">Most Popular</div>
                      </div>
                      <div class="service-body">
                        <h4>Cardiology Services</h4>
                        <p>Advanced heart care including diagnostics, treatment, and post-operative rehabilitation programs.</p>
                        <div class="service-features">
                          <span class="feature-badge">Heart Surgery</span>
                          <span class="feature-badge">ECG Testing</span>
                          <span class="feature-badge">Cardiac Rehab</span>
                        </div>
                      </div>
                      <div class="service-footer">
                        <a href="service-details.html" class="service-btn">
                          Book Appointment
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </div>
                    </div>
                  </div>

                  <!-- Les autres cartes de services -->
                  <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="service-card specialty-care featured">
                      <div class="service-header">
                        <div class="service-icon">
                          <i class="fas fa-heart"></i>
                        </div>
                        <span class="service-category">Specialty</span>
                        <div class="featured-badge">Most Popular</div>
                      </div>
                      <div class="service-body">
                        <h4>Cardiology Services</h4>
                        <p>Advanced heart care including diagnostics, treatment, and post-operative rehabilitation programs.</p>
                        <div class="service-features">
                          <span class="feature-badge">Heart Surgery</span>
                          <span class="feature-badge">ECG Testing</span>
                          <span class="feature-badge">Cardiac Rehab</span>
                        </div>
                      </div>
                      <div class="service-footer">
                        <a href="service-details.html" class="service-btn">
                          Book Appointment
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </div>
                    </div>
                  </div>

                  <!-- Les autres cartes de services -->
                  <div class="col-lg-4 col-md-6" data-aos="zoom-in" data-aos-delay="300">
                    <div class="service-card specialty-care featured">
                      <div class="service-header">
                        <div class="service-icon">
                          <i class="fas fa-heart"></i>
                        </div>
                        <span class="service-category">Specialty</span>
                        <div class="featured-badge">Most Popular</div>
                      </div>
                      <div class="service-body">
                        <h4>Cardiology Services</h4>
                        <p>Advanced heart care including diagnostics, treatment, and post-operative rehabilitation programs.</p>
                        <div class="service-features">
                          <span class="feature-badge">Heart Surgery</span>
                          <span class="feature-badge">ECG Testing</span>
                          <span class="feature-badge">Cardiac Rehab</span>
                        </div>
                      </div>
                      <div class="service-footer">
                        <a href="service-details.html" class="service-btn">
                          Book Appointment
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </div>
                    </div>
                  </div>

                </div>
              </div>

              <div class="services-stats" data-aos="fade-up" data-aos-delay="800">
                <div class="row">
                  <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                      <div class="stat-number" data-purecounter-start="0" data-purecounter-end="25000" data-purecounter-duration="2"></div>
                      <div class="stat-label">Patients Served</div>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                      <div class="stat-number" data-purecounter-start="0" data-purecounter-end="150" data-purecounter-duration="2"></div>
                      <div class="stat-label">Medical Experts</div>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                      <div class="stat-number" data-purecounter-start="0" data-purecounter-end="18" data-purecounter-duration="2"></div>
                      <div class="stat-label">Specializations</div>
                    </div>
                  </div>
                  <div class="col-lg-3 col-md-6">
                    <div class="stat-item">
                      <div class="stat-number" data-purecounter-start="0" data-purecounter-end="24" data-purecounter-duration="2"></div>
                      <div class="stat-label">Hours Service</div>
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
        <form id="serviceForm">
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
                  <option value="primary-care">Primary Care</option>
                  <option value="specialty">Specialty</option>
                  <option value="diagnostics">Diagnostics</option>
                  <option value="emergency">Emergency</option>
                  <option value="maternal">Maternal Health</option>
                  <option value="vaccination">Vaccination</option>
                  <option value="radiology">Radiology</option>
                  <option value="neurology">Neurology</option>
                  <option value="orthopedics">Orthopedics</option>
                  <option value="ophthalmology">Ophthalmology</option>
                  <option value="dentistry">Dentistry</option>
                  <option value="allergy">Allergy & Immunology</option>
                  <option value="genetics">Genetics</option>
                </select>
              </div>
            </div>
          </div>
          
          <div class="form-group">
            <label for="serviceIcon" class="form-label">Icône (classe FontAwesome)</label>
            <input type="text" id="serviceIcon" class="form-control" placeholder="Ex: fas fa-heart" required>
            <small class="text-muted">Utilisez les classes FontAwesome (ex: fas fa-heart, fas fa-brain, etc.)</small>
          </div>
          
          <div class="form-group">
            <label for="serviceDescription" class="form-label">Description du service</label>
            <textarea id="serviceDescription" class="form-control" placeholder="Décrivez le service en détail..." required></textarea>
          </div>
          
          <div class="form-group">
            <label class="form-label">Fonctionnalités du service</label>
            <div id="featuresContainer">
              <div class="feature-input-group">
                <input type="text" class="form-control feature-input" placeholder="Ex: Consultation spécialisée">
                <button type="button" class="remove-feature-btn" style="display: none;">
                  <i class="fas fa-times"></i>
                </button>
              </div>
            </div>
            <button type="button" class="add-feature-btn" id="addFeatureBtn">
              <i class="fas fa-plus"></i> Ajouter une fonctionnalité
            </button>
          </div>
          
          <div class="form-group">
            <div class="form-check">
              <input type="checkbox" id="featuredService" class="form-check-input">
              <label for="featuredService" class="form-check-label">Service en vedette (avec badge "Most Popular")</label>
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

  <footer id="footer" class="footer position-relative">
    <div class="container copyright text-center">
      <p>© <span>Copyright</span> <strong>MediNest</strong>&nbsp;<span>All Rights Reserved</span></p>
      <div class="credits">
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>
  </footer>

  <!-- Scroll Top -->
  <a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <!-- Preloader -->
  <div id="preloader"></div>

  <!-- Vendor JS Files -->
  <script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="../assets/vendor/php-email-form/validate.js"></script>
  <script src="../assets/vendor/aos/aos.js"></script>
  <script src="../assets/vendor/glightbox/js/glightbox.min.js"></script>
  <script src="../assets/vendor/purecounter/purecounter_vanilla.js"></script>
  <script src="../assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
  <script src="../assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
  <script src="../assets/vendor/swiper/swiper-bundle.min.js"></script>

  <!-- Main JS File -->
  <script src="../assets/js/main.js"></script>

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
      
      // Ajouter une fonctionnalité
      addFeatureBtn.addEventListener('click', function() {
        const featureGroup = document.createElement('div');
        featureGroup.className = 'feature-input-group';
        
        const input = document.createElement('input');
        input.type = 'text';
        input.className = 'form-control feature-input';
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
      
      // Soumettre le formulaire
      submitBtn.addEventListener('click', function() {
        const serviceName = document.getElementById('serviceName').value;
        const serviceCategory = document.getElementById('serviceCategory').value;
        const serviceIcon = document.getElementById('serviceIcon').value;
        const serviceDescription = document.getElementById('serviceDescription').value;
        const featuredService = document.getElementById('featuredService').checked;
        
        // Validation basique
        if (!serviceName || !serviceCategory || !serviceIcon || !serviceDescription) {
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
        
        // Ici, vous pouvez envoyer les données au serveur
        console.log('Nouveau service:', {
          name: serviceName,
          category: serviceCategory,
          icon: serviceIcon,
          description: serviceDescription,
          features: features,
          featured: featuredService
        });
        
        // Afficher un message de confirmation
        alert('Service ajouté avec succès!');
        
        // Réinitialiser le formulaire
        document.getElementById('serviceForm').reset();
        
        // Fermer le modal
        closeModal();
      });
    });
  </script>

</body>

</html>