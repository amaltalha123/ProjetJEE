<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Statistiques - MediNest</title>
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
    
    /* Statistics section prend toute la hauteur */
    .statistics.section {
      margin: 0;
      padding: 0;
      flex: 1;
      display: flex;
      flex-direction: column;
    }
    
    /* Container principal prend toute la hauteur */
    .statistics-section-container {
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
    
    /* Styles pour les statistiques */
    .stats-header {
      margin-bottom: 30px;
    }
    
    .stats-title {
      font-size: 1.8rem;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 10px;
    }
    
    .stats-subtitle {
      color: #6c757d;
      font-size: 1rem;
    }
    
    /* Cartes de statistiques */
    .stat-card {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
      padding: 25px;
      margin-bottom: 25px;
      border: 1px solid #e9ecef;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    }
    
    .stat-card-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }
    
    .stat-card-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }
    
    .stat-card-icon {
      width: 50px;
      height: 50px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
    }
    
    .stat-card-value {
      font-size: 2.2rem;
      font-weight: 700;
      margin-bottom: 5px;
    }
    
    .stat-card-change {
      font-size: 0.9rem;
      display: flex;
      align-items: center;
    }
    
    .change-positive {
      color: #28a745;
    }
    
    .change-negative {
      color: #dc3545;
    }
    
    /* Graphiques */
    .chart-container {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
      padding: 25px;
      margin-bottom: 25px;
      border: 1px solid #e9ecef;
    }
    
    .chart-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    
    .chart-title {
      font-size: 1.3rem;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }
    
    .chart-actions {
      display: flex;
      gap: 10px;
    }
    
    .chart-action-btn {
      background: #f8f9fa;
      border: 1px solid #e9ecef;
      color: #6c757d;
      padding: 6px 12px;
      border-radius: 6px;
      font-size: 0.85rem;
      cursor: pointer;
      transition: all 0.3s;
    }
    
    .chart-action-btn:hover, .chart-action-btn.active {
      background: #0d6efd;
      color: #fff;
      border-color: #0d6efd;
    }
    
    .chart-placeholder {
      height: 300px;
      background: #f8f9fa;
      border-radius: 8px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #6c757d;
      font-size: 1rem;
    }
    
    /* Tableaux de données */
    .data-table-container {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
      padding: 25px;
      margin-bottom: 25px;
      border: 1px solid #e9ecef;
      overflow: hidden;
    }
    
    .data-table-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
    }
    
    .data-table-title {
      font-size: 1.3rem;
      font-weight: 600;
      color: #2c3e50;
      margin: 0;
    }
    
    .data-table {
      width: 100%;
      border-collapse: collapse;
    }
    
    .data-table th {
      background-color: #f8f9fa;
      padding: 12px 15px;
      text-align: left;
      font-weight: 600;
      color: #495057;
      border-bottom: 1px solid #e9ecef;
    }
    
    .data-table td {
      padding: 12px 15px;
      border-bottom: 1px solid #e9ecef;
      color: #6c757d;
    }
    
    .data-table tr:last-child td {
      border-bottom: none;
    }
    
    .data-table tr:hover td {
      background-color: #f8f9fa;
    }
    
    .status-badge {
      padding: 5px 10px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 500;
    }
    
    .status-pending {
      background-color: #fff3cd;
      color: #856404;
    }
    
    .status-completed {
      background-color: #d1ecf1;
      color: #0c5460;
    }
    
    .status-cancelled {
      background-color: #f8d7da;
      color: #721c24;
    }
    
    /* Filtres */
    .filters-container {
      background: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
      padding: 20px;
      margin-bottom: 25px;
      border: 1px solid #e9ecef;
    }
    
    .filters-title {
      font-size: 1.2rem;
      font-weight: 600;
      color: #2c3e50;
      margin-bottom: 15px;
    }
    
    .filters-row {
      display: flex;
      flex-wrap: wrap;
      gap: 15px;
    }
    
    .filter-group {
      flex: 1;
      min-width: 200px;
    }
    
    .filter-label {
      display: block;
      margin-bottom: 8px;
      font-weight: 500;
      color: #495057;
    }
    
    .filter-select, .filter-input {
      width: 100%;
      padding: 10px 15px;
      border: 1px solid #ced4da;
      border-radius: 6px;
      font-size: 1rem;
      transition: border-color 0.3s, box-shadow 0.3s;
    }
    
    .filter-select:focus, .filter-input:focus {
      border-color: #667eea;
      box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
      outline: none;
    }
    
    .apply-filters-btn {
      background: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
      color: white;
      border: none;
      padding: 10px 20px;
      border-radius: 6px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.3s ease;
      align-self: flex-end;
      margin-top: 25px;
    }
    
    .apply-filters-btn:hover {
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
      
      .filters-row {
        flex-direction: column;
      }
      
      .filter-group {
        width: 100%;
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

<body class="statistics-page">

  <main class="main">

    <!-- Page Title -->
    <div class="page-title">
      <nav class="breadcrumbs">
        <div class="container">
          <ol>
            <li><a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Home</a></li>
            <li class="current">Statistiques</li>
          </ol>
        </div>
      </nav>
    </div><!-- End Page Title -->

    <!-- Statistics Section avec Sidebar -->
    <section id="statistics" class="statistics section">
      <!-- Container modifié pour prendre toute la hauteur -->
      <div class="container-fluid statistics-section-container" data-aos="fade-up" data-aos-delay="100">
        <div class="row no-gutters-row">
          <!-- Sidebar - colonne élargie -->
          <div class="col-lg-4 col-xl-3 sidebar-column">
            <div class="sidebar">
              <nav class="nav flex-column">
                <a class="nav-link" href="#">
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
              
              <!-- En-tête des statistiques -->
              <div class="stats-header">
                <h1 class="stats-title">Tableau de Bord Statistiques</h1>
                <p class="stats-subtitle">Vue d'ensemble de votre performance  </p>
              </div>
              
              
              <!-- Cartes de statistiques principales -->
              <div class="row">
                <div class="col-md-3">
                  <div class="stat-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-card-header">
                      <h3 class="stat-card-title">Services Actifs</h3>
                      <div class="stat-card-icon" style="background-color: rgba(13, 110, 253, 0.1); color: #0d6efd;">
                        <i class="fas fa-concierge-bell"></i>
                      </div>
                    </div>
                    <div class="stat-card-value" id="activeServices">${activeServices}</div>
                   
                  </div>
                </div>
                <div class="col-md-3">
                  <div class="stat-card" data-aos="fade-up" data-aos-delay="100">
                    <div class="stat-card-header">
                      <h3 class="stat-card-title">Services Archvés</h3>
                      <div class="stat-card-icon" style="background-color: rgba(13, 110, 253, 0.1); color: #0d6efd;">
                        <i class="fas fa-concierge-bell"></i>
                      </div>
                    </div>
                    <div class="stat-card-value" id="archiveServices">${archivedServices}</div>
                   
                  </div>
                </div>
                
                <div class="col-md-3">
                  <div class="stat-card" data-aos="fade-up" data-aos-delay="200">
                    <div class="stat-card-header">
                      <h3 class="stat-card-title">Demandes</h3>
                      <div class="stat-card-icon" style="background-color: rgba(40, 167, 69, 0.1); color: #28a745;">
                        <i class="fas fa-envelope-open-text"></i>
                      </div>
                    </div>
                    <div class="stat-card-value" id="totalRequests">${totalRequests}</div>
                    
                  </div>
                </div>
                
                <div class="col-md-3">
                  <div class="stat-card" data-aos="fade-up" data-aos-delay="300">
                    <div class="stat-card-header">
                      <h3 class="stat-card-title">Réclamations</h3>
                      <div class="stat-card-icon" style="background-color: rgba(220, 53, 69, 0.1); color: #dc3545;">
                        <i class="fas fa-exclamation-triangle"></i>
                      </div>
                    </div>
                    <div class="stat-card-value" id="totalComplaints">${totalComplaints}</div>
                   
                  </div>
                </div>
                
               
              
             
               
            </div>
          </div>
        </div>
      </div>
    </section><!-- /Statistics Section -->

  </main>

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
    document.addEventListener("DOMContentLoaded", function() {
      // Initialisation des animations AOS
      if (typeof AOS !== 'undefined') {
        AOS.init({
          duration: 800,
          easing: 'ease-in-out',
          once: true
        });
      }
      
      // Gestion des boutons de période des graphiques
      const chartPeriodButtons = document.querySelectorAll('.chart-action-btn');
      chartPeriodButtons.forEach(button => {
        button.addEventListener('click', function() {
          chartPeriodButtons.forEach(btn => btn.classList.remove('active'));
          this.classList.add('active');
          // Ici vous pouvez ajouter la logique pour changer les données du graphique
        });
      });
      
      // Gestion du bouton d'application des filtres
      const applyFiltersBtn = document.getElementById('applyFiltersBtn');
      applyFiltersBtn.addEventListener('click', function() {
        const period = document.getElementById('periodFilter').value;
        const serviceType = document.getElementById('serviceTypeFilter').value;
        const status = document.getElementById('statusFilter').value;
        
        // Simulation de chargement de données filtrées
        simulateFilteredData(period, serviceType, status);
      });
      
      // Fonction de simulation de données filtrées
      function simulateFilteredData(period, serviceType, status) {
        // Simulation de mise à jour des données en fonction des filtres
        console.log(`Filtres appliqués: Période=${period}, Type=${serviceType}, Statut=${status}`);
        
        // Mise à jour des valeurs des cartes (simulation)
        const activeServicesElem = document.getElementById('activeServices');
        const totalRequestsElem = document.getElementById('totalRequests');
        const totalComplaintsElem = document.getElementById('totalComplaints');
        const satisfactionRateElem = document.getElementById('satisfactionRate');
        
        // Valeurs simulées basées sur les filtres
        let activeServicesValue, totalRequestsValue, totalComplaintsValue, satisfactionRateValue;
        
        switch(period) {
          case 'today':
            activeServicesValue = 8;
            totalRequestsValue = 12;
            totalComplaintsValue = 1;
            satisfactionRateValue = '96%';
            break;
          case 'week':
            activeServicesValue = 24;
            totalRequestsValue = 156;
            totalComplaintsValue = 12;
            satisfactionRateValue = '94%';
            break;
          case 'month':
            activeServicesValue = 24;
            totalRequestsValue = 642;
            totalComplaintsValue = 38;
            satisfactionRateValue = '92%';
            break;
          case 'quarter':
            activeServicesValue = 28;
            totalRequestsValue = 1850;
            totalComplaintsValue = 105;
            satisfactionRateValue = '91%';
            break;
          case 'year':
            activeServicesValue = 32;
            totalRequestsValue = 7450;
            totalComplaintsValue = 420;
            satisfactionRateValue = '93%';
            break;
          default:
            activeServicesValue = 24;
            totalRequestsValue = 156;
            totalComplaintsValue = 12;
            satisfactionRateValue = '94%';
        }
        
        // Animation de comptage pour les valeurs
        animateValue(activeServicesElem, 0, activeServicesValue, 1000);
        animateValue(totalRequestsElem, 0, totalRequestsValue, 1000);
        animateValue(totalComplaintsElem, 0, totalComplaintsValue, 1000);
        
        // Mise à jour directe pour le pourcentage
        satisfactionRateElem.textContent = satisfactionRateValue;
        
        // Afficher un message de confirmation
        showNotification('Filtres appliqués avec succès', 'success');
      }
      
      // Fonction d'animation de comptage
      function animateValue(element, start, end, duration) {
        let startTimestamp = null;
        const step = (timestamp) => {
          if (!startTimestamp) startTimestamp = timestamp;
          const progress = Math.min((timestamp - startTimestamp) / duration, 1);
          element.innerHTML = Math.floor(progress * (end - start) + start);
          if (progress < 1) {
            window.requestAnimationFrame(step);
          }
        };
        window.requestAnimationFrame(step);
      }
      
      // Fonction d'affichage de notification (CORRIGÉE)
      function showNotification(message, type) {
        // Créer l'élément de notification
        const notification = document.createElement('div');
        
        // CORRECTION : Utilisation de conditions JavaScript normales
        let alertClass = 'alert-danger';
        if (type === 'success') {
          alertClass = 'alert-success';
        }
        
        notification.className = `alert ${alertClass} alert-dismissible fade show`;
        notification.style.cssText = 'position: fixed; top: 20px; right: 20px; z-index: 1050; min-width: 300px;';
        notification.innerHTML = `
          ${message}
          <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        `;
        
        // Ajouter à la page
        document.body.appendChild(notification);
        
        // Supprimer automatiquement après 3 secondes
        setTimeout(() => {
          if (notification.parentNode) {
            notification.parentNode.removeChild(notification);
          }
        }, 3000);
      }
    });
  </script>

</body>

</html>