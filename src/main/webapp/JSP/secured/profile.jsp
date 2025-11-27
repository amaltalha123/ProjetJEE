<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mon Profil</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
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
            background: #ffffff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
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
        
        .profile-section {
            margin: 0;
            padding: 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .profile-container {
            padding: 0;
            margin: 0;
            max-width: 100%;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        
        .no-gutters-row {
            margin: 0;
            flex: 1;
            display: flex;
        }
        
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
            color: #0d6efd;
            border-right: 4px solid #0d6efd;
        }
        
        .sidebar .nav-link i {
            margin-right: 12px;
            width: 22px;
            text-align: center;
            font-size: 1.1rem;
        }
        
        .content-column {
            padding: 0;
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        
        .main-content {
            padding: 40px;
            flex: 1;
            overflow-y: auto;
            background-color: #fff;
        }

        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            animation: fadeIn 0.5s ease-in;
            max-width: 700px;
            margin: 0 auto;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .profile-header {
            background: #17a2b8;
            padding: 40px 30px 80px;
            text-align: center;
            position: relative;
        }

        .profile-header h2 {
            color: white;
            font-weight: 600;
            margin: 0;
            font-size: 28px;
        }

        .profile-photo-wrapper {
            position: relative;
            margin: -60px auto 0;
            width: 140px;
            height: 140px;
        }

        .profile-photo {
            width: 140px;
            height: 140px;
            border-radius: 50%;
            border: 6px solid white;
            object-fit: cover;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.15);
            background: #f8f9fa;
        }

        .photo-upload-overlay {
            position: absolute;
            bottom: 5px;
            right: 5px;
            width: 40px;
            height: 40px;
            background: #17a2b8;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
        }

        .photo-upload-overlay:hover {
            background: #138496;
            transform: scale(1.1);
        }

        .photo-upload-overlay i {
            color: white;
            font-size: 18px;
        }

        .profile-body {
            padding: 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .form-label i {
            color: #17a2b8;
            font-size: 18px;
        }

        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s ease;
            font-size: 15px;
        }

        .form-control:focus {
            border-color: #17a2b8;
            box-shadow: 0 0 0 0.2rem rgba(23, 162, 184, 0.15);
        }

        .file-input-wrapper {
            position: relative;
            overflow: hidden;
            display: none;
        }

        .file-input-wrapper input[type=file] {
            position: absolute;
            left: -9999px;
        }

        .btn-update {
            width: 100%;
            padding: 14px;
            font-size: 16px;
            font-weight: 600;
            border-radius: 10px;
            border: none;
            background: #17a2b8;
            color: white;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-update:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        }

        .btn-update i {
            margin-right: 8px;
        }

        .alert {
            border-radius: 10px;
            border: none;
            margin-bottom: 20px;
        }

        .password-hint {
            font-size: 13px;
            color: #6c757d;
            margin-top: 5px;
            font-style: italic;
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
            
            .content-column {
                flex: 1;
            }
        }
        
        @media (min-width: 1200px) {
            .sidebar-column {
                flex: 0 0 350px;
            }
        }

        @media (max-width: 576px) {
            .profile-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>

    <main class="main">
        <!-- Page Title -->
        <div class="page-title">
            <nav class="breadcrumbs">
                <div class="container">
                    <ol>
                        <li><a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Home</a></li>
                        <li class="current">Mon Profil</li>
                    </ol>
                </div>
            </nav>
        </div>

        <!-- Profile Section avec Sidebar -->
        <section class="profile-section">
            <div class="container-fluid profile-container">
                <div class="row no-gutters-row">
                    <!-- Sidebar -->
                    <div class="col-lg-4 col-xl-3 sidebar-column">
                        <div class="sidebar">
                             <nav class="nav flex-column">
				                <a class="nav-link active" href="${pageContext.request.contextPath}/ProfileServlet">
				                  <i class="fas fa-user-circle"></i> Profile
				                </a>
				                <a class="nav-link" href="${pageContext.request.contextPath}/manager/mes-demandes">
				                  <i class="fas fa-envelope-open-text"></i> Demandes
				                </a>
				                <a class="nav-link" href="${pageContext.request.contextPath}/secured/reclamations">
				                  <i class="fas fa-exclamation-triangle"></i> Réclamations
				                </a>
				                <a class="nav-link" href="${pageContext.request.contextPath}/secured/GetServicesPage">
				                  <i class="fas fa-concierge-bell"></i> Services
				                </a>
				                <a class="nav-link" href="${pageContext.request.contextPath}/secured/Statistics">
				                  <i class="fas fa-chart-line"></i> Statistiques
				                </a>
				                <div class="logout-container mt-auto">
				                  <a href="${pageContext.request.contextPath}/logout" class="btn btn-logout">
				                    <i class="fas fa-sign-out-alt"></i> Déconnexion
				                  </a>
				                </div>
				              </nav>
                        </div>
                    </div>
                    
                    <!-- Contenu principal -->
                    <div class="col-lg-8 col-xl-9 content-column">
                        <div class="main-content">
                            <div class="profile-card">
                                <div class="profile-header">
                                    <h2><i class="bi bi-person-circle"></i> Mon Profil</h2>
                                </div>

                                <c:if test="${not empty user}">
                                    <form action="UpdateProfileServlet" method="post" enctype="multipart/form-data">
                                        <!-- ID caché -->
                                        <input type="hidden" name="id" value="${user.id}" />

                                        <!-- Photo de profil -->
                                        <div class="profile-photo-wrapper">
                                            <img src="<c:choose>
                                                        <c:when test='${not empty userPhotoBase64}'>data:image/jpeg;base64,${userPhotoBase64}</c:when>
                                                        <c:otherwise>default-profile.png</c:otherwise>
                                                    </c:choose>"
                                                 alt="Photo profil" 
                                                 class="profile-photo"
                                                 id="profileImage">
                                            
                                            <label for="photoProfile" class="photo-upload-overlay">
                                                <i class="bi bi-camera-fill"></i>
                                            </label>
                                        </div>

                                        <div class="profile-body">
                                            <!-- Message de succès/erreur -->
                                            <c:if test="${not empty message}">
                                                <div class="alert alert-success">
                                                    <i class="bi bi-check-circle-fill"></i> ${message}
                                                </div>
                                            </c:if>

                                            <c:if test="${not empty error}">
                                                <div class="alert alert-danger">
                                                    <i class="bi bi-exclamation-triangle-fill"></i> ${error}
                                                </div>
                                            </c:if>

                                            <!-- Nom -->
                                            <div class="form-group">
                                                <label class="form-label">
                                                    <i class="bi bi-person-fill"></i>
                                                    Nom complet
                                                </label>
                                                <input type="text" 
                                                       class="form-control" 
                                                       name="nom" 
                                                       value="${user.nom}" 
                                                       placeholder="Entrez votre nom"
                                                       required />
                                            </div>

                                            <!-- Email -->
                                            <div class="form-group">
                                                <label class="form-label">
                                                    <i class="bi bi-envelope-fill"></i>
                                                    Adresse email
                                                </label>
                                                <input type="email" 
                                                       class="form-control" 
                                                       name="email" 
                                                       value="${user.email}" 
                                                       placeholder="exemple@email.com"
                                                       required />
                                            </div>

                                            <!-- Mot de passe -->
                                            <div class="form-group">
                                                <label class="form-label">
                                                    <i class="bi bi-lock-fill"></i>
                                                    Mot de passe
                                                </label>
                                                <input type="password" 
                                                       class="form-control" 
                                                       name="motDePasse" 
                                                       placeholder="••••••••" />
                                                <div class="password-hint">
                                                    <i class="bi bi-info-circle"></i> Laissez vide pour conserver le mot de passe actuel
                                                </div>
                                            </div>

                                            <!-- Input file caché -->
                                            <div class="file-input-wrapper">
                                                <input type="file" 
                                                       name="photoProfile" 
                                                       id="photoProfile"
                                                       accept="image/*" 
                                                       onchange="previewImage(event)" />
                                            </div>

                                            <!-- Bouton de soumission -->
                                            <button type="submit" class="btn-update">
                                               
                                                Modifier le profil
                                            </button>
                                        </div>
                                    </form>
                                </c:if>

                                <c:if test="${empty user}">
                                    <div class="profile-body">
                                        <div class="alert alert-warning">
                                            <i class="bi bi-exclamation-triangle-fill"></i> 
                                            Aucun utilisateur connecté. Veuillez vous connecter.
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

    </main>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Prévisualisation de l'image
        function previewImage(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('profileImage').src = e.target.result;
                }
                reader.readAsDataURL(file);
            }
        }
    </script>
</body>
</html>