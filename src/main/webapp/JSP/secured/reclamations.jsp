<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Réclamations - MediNest</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    
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
        
        /* Réclamations section prend toute la hauteur */
        .reclamations.section {
            margin: 0;
            padding: 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        /* Container principal prend toute la hauteur */
        .reclamations-section-container {
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
        
        /* Sidebar élargie et adaptative - MÊME STYLE QUE SERVICES */
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
        
        /* Colonne de contenu principal prend toute la hauteur - MÊME STYLE QUE SERVICES */
        .content-column {
            padding: 0;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        
        /* Contenu principal scrollable - MÊME STYLE QUE SERVICES */
        .main-content {
            padding: 25px;
            flex: 1;
            overflow-y: auto;
            background-color: #fff;
        }
        
        /* Styles spécifiques aux réclamations */
        .reclamation-header-section {
            margin-bottom: 30px;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            border: 1px solid #fff;
        }
        
        .reclamation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }
        
        .reclamation-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 15px;
            color: #6c757d;
        }
        
        .message {
            padding: 15px 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-weight: 500;
            border: 1px solid transparent;
        }
        
        .success {
            background-color: #d1fae5;
            color: #28a745;
            border-color: #b8f2d6;
        }
        
        .error {
            background-color: #fee2e2;
            color: #dc3545;
            border-color: #fecaca;
        }
        
        .reclamation-form-card {
            background: #fff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            margin-bottom: 40px;
            border: 1px solid #e9ecef;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .reclamation-form-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .reclamation-form-card h3 {
            margin-bottom: 20px;
            color: #2c3e50;
            font-size: 1.4rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .reclamation-form-card textarea {
            width: 100%;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
            font-size: 1rem;
            resize: vertical;
            min-height: 120px;
            transition: border-color 0.3s, box-shadow 0.3s;
            font-family: 'Inter', sans-serif;
        }
        
        .reclamation-form-card textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            outline: none;
        }
        
        .submit-btn {
            background: linear-gradient(135deg, #667eea 0%, #0290d2 100%);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }
        
        .reclamation-list h3 {
            margin-bottom: 25px;
            color: #2c3e50;
            font-size: 1.5rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .reclamation-item {
            background: #fff;
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            border: 1px solid #e9ecef;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        
        .reclamation-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .reclamation-item-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }
        
        .reclamation-id {
            font-weight: 700;
            color: #2c3e50;
            font-size: 1.1rem;
        }
        
        .reclamation-status {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }
        
        .status-pending {
            background: #fff3cd;
            color: #856404;
            border: 1px solid #ffeaa7;
        }
        
        .status-resolved {
            background: #d1ecf1;
            color: #0c5460;
            border: 1px solid #b8e2e8;
        }
        
        .reclamation-content {
            font-size: 1rem;
            line-height: 1.6;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .reclamation-user-info {
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #e9ecef;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 15px;
            color: #e9ecef;
        }
        
        .empty-state h4 {
            margin: 0 0 10px 0;
            color: #6c757d;
        }
        
        /* Responsive - MÊME STYLE QUE SERVICES */
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
            
            .reclamation-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            
            .reclamation-item-header {
                flex-direction: column;
                align-items: flex-start;
            }
        }
        
        @media (min-width: 992px) {
            .sidebar-column {
                flex: 0 0 300px;
            }
            
            .content-column {
                flex: 1;
            }
        }
        
        @media (min-width: 1200px) {
            .sidebar-column {
                flex: 0 0 350px;
            }
        }
    </style>
</head>

<body class="reclamations-page">

    <main class="main">

        <!-- Page Title -->
        <div class="page-title">
            <nav class="breadcrumbs">
                <div class="container">
                    <ol>
                        <li><a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Home</a></li>
                        <li class="current">Réclamations</li>
                    </ol>
                </div>
            </nav>
        </div><!-- End Page Title -->

        <!-- Réclamations Section avec Sidebar -->
        <section id="reclamations" class="reclamations section">
            <!-- Container modifié pour prendre toute la hauteur -->
            <div class="container-fluid reclamations-section-container" data-aos="fade-up" data-aos-delay="100">
                <div class="row no-gutters-row">
                    <!-- Sidebar - colonne élargie - MÊME STRUCTURE QUE SERVICES -->
                    <div class="col-lg-4 col-xl-3 sidebar-column">
                        <div class="sidebar">
                            <nav class="nav flex-column">
                                <a class="nav-link" href="#">
                                    <i class="fas fa-user-circle"></i> Profile
                                </a>
                                <a class="nav-link" href="#">
                                    <i class="fas fa-envelope-open-text"></i> Demandes
                                </a>
                                <a class="nav-link active" href="#">
                                    <i class="fas fa-exclamation-triangle"></i> Réclamations
                                </a>
                                <a class="nav-link" href="${pageContext.request.contextPath}/JSP/secured/manager/services.jsp">
                                    <i class="fas fa-concierge-bell"></i> Services
                                </a>
                                <a class="nav-link" href="${pageContext.request.contextPath}/JSP/secured/manager/statistiques.jsp">
                                    <i class="fas fa-chart-line"></i> Statistiques
                                </a>
                                <div class="logout-container mt-auto">
                                    <a href="${pageContext.request.contextPath}/logout" class="nav-link">
                                        <i class="fas fa-sign-out-alt"></i> Déconnexion
                                    </a>
                                </div>
                            </nav>
                        </div>
                    </div>
                    
                    <!-- Contenu principal - colonne adaptative - MÊME STRUCTURE QUE SERVICES -->
                    <div class="col-lg-8 col-xl-9 content-column">
                        <div class="main-content">
                            
                            <!-- En-tête des réclamations -->
                            <div class="reclamation-header-section" data-aos="fade-up">
                                <div class="reclamation-header">
                                    <h1 class="reclamation-title">
                                        <i class="fas fa-exclamation-triangle"></i> Gestion des Réclamations
                                    </h1>
                                    <div class="user-info">
                                        <span>Bienvenue <strong>${sessionScope.sessionUser.email}</strong></span>
                                    </div>
                                </div>
                            </div>

                            <!-- Messages -->
                            <c:if test="${not empty successMessage}">
                                <div class="message success" data-aos="fade-up">
                                    <i class="fas fa-check-circle"></i> ${successMessage}
                                </div>
                            </c:if>

                            <c:if test="${not empty errorMessage}">
                                <div class="message error" data-aos="fade-up">
                                    <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                                </div>
                            </c:if>

                            <c:if test="${param.success == 'created'}">
                                <div class="message success" data-aos="fade-up">
                                    <i class="fas fa-check-circle"></i> Réclamation créée avec succès !
                                </div>
                            </c:if>

                            <!-- Formulaire de création de réclamation -->
                            <div class="reclamation-form-card" data-aos="fade-up" data-aos-delay="100">
                                <h3><i class="fas fa-plus-circle"></i> Créer une nouvelle réclamation</h3>
                                <form action="${pageContext.request.contextPath}/secured/reclamations" method="post">
                                    <input type="hidden" name="action" value="create">
                                    <textarea name="contenu" placeholder="Décrivez votre réclamation en détail..." required></textarea>
                                    <br>
                                    <button type="submit" class="submit-btn">
                                        <i class="fas fa-paper-plane"></i> Soumettre la réclamation
                                    </button>
                                </form>
                            </div>

                            <!-- Liste des réclamations -->
                            <div class="reclamation-list" data-aos="fade-up" data-aos-delay="200">
                                <h3>
                                    <i class="fas fa-list"></i>
                                    <c:choose>
                                        <c:when test="${sessionScope.sessionUser.role == 'ADMIN'}">
                                            Toutes les Réclamations
                                        </c:when>
                                        <c:otherwise>
                                            Mes Réclamations
                                        </c:otherwise>
                                    </c:choose>
                                </h3>

                                <c:if test="${empty reclamations}">
                                    <div class="empty-state">
                                        <i class="fas fa-inbox"></i>
                                        <h4>Aucune réclamation trouvée</h4>
                                        <p>
                                            <c:choose>
                                                <c:when test="${sessionScope.sessionUser.role == 'ADMIN'}">
                                                    Aucune réclamation n'a été soumise pour le moment.
                                                </c:when>
                                                <c:otherwise>
                                                    Vous n'avez soumis aucune réclamation pour le moment.
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </c:if>

                                <c:forEach var="reclamation" items="${reclamations}" varStatus="status">
                                    <div class="reclamation-item" data-aos="fade-up" data-aos-delay="${300 + status.index * 100}">
                                        <div class="reclamation-item-header">
                                            <div class="reclamation-id">Réclamation #${reclamation.id}</div>
                                            <div class="reclamation-status ${reclamation.etat ? 'status-resolved' : 'status-pending'}">
                                                <i class="fas ${reclamation.etat ? 'fa-check-circle' : 'fa-clock'}"></i>
                                                ${reclamation.etat ? 'Résolue' : 'En attente'}
                                            </div>
                                        </div>
                                        <div class="reclamation-content">${reclamation.contenu}</div>
                                        
                                        <c:if test="${sessionScope.sessionUser.role == 'ADMIN'}">
                                            <div class="reclamation-user-info">
                                                <i class="fas fa-user"></i> Déposée par: ${reclamation.utilisateur.nom} (${reclamation.utilisateur.email})
                                            </div>
                                        </c:if>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section><!-- /Réclamations Section -->

    </main>

    <!-- Vendor JS Files -->
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/aos/aos.js"></script>
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/purecounter/purecounter_vanilla.js"></script>
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/swiper/swiper-bundle.min.js"></script>

    <!-- Main JS File -->
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/js/main.js"></script>

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
        });
    </script>

</body>
</html>