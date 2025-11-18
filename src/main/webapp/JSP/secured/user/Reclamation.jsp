<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Réclamations - MediNest</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
    <link rel="stylesheet" href="../../../CSS/index.css">
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
            background-color: #f8f9fa;
            font-family: 'Roboto', sans-serif;
            padding-top: 80px; /* Compensation pour la navbar fixe */
        }
        
        /* Container principal sans marges */
        .container-fluid {
            padding: 0;
            margin: 0;
            margin-right: 2rem;
            max-width: 100%;
        }
        
       .navbar {
  transition: all 0.3s ease;
}

.navbar-brand {
  font-size: 1.4rem;
  color: #0d6efd !important;
}

.navbar .nav-link {
  font-weight: 500;
  margin-left: 15px;
  transition: color 0.3s ease;
}

.navbar .nav-link:hover {
  color: #0d6efd;
}

        
        /* En-tête de page ajusté */
        .page-header {
            background-color: #fff;
            padding: 20px 0;
            border-bottom: 1px solid #dee2e6;
            margin: 0;
        }
        
        .page-title {
            margin: 0;
            font-size: 1.8rem;
            font-weight: 600;
            color: #2c3e50;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        /* Style pour la section utilisateur */
        .user-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 10px;
        }
        
        .welcome-section {
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        .welcome-text {
            color: #6c757d;
            font-size: 1rem;
        }
        
        .welcome-user {
            font-weight: 600;
            color: #2c3e50;
        }
        
        .logout-section {
            display: flex;
            align-items: center;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #4dabf7 0%, #339af0 100%);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(77, 171, 247, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(77, 171, 247, 0.4);
            color: white;
            text-decoration: none;
        }
        
        /* Contenu principal sans marges */
        .main-content {
            padding: 25px;
            background-color: #f8f9fa;
            min-height: calc(100vh - 160px);
        }
        
        /* Messages */
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
        
        /* Carte de formulaire */
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
            font-family: 'Roboto', sans-serif;
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
        
        /* Liste des réclamations */
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
        
        .status-replied {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }
        
        .reclamation-content {
            font-size: 1rem;
            line-height: 1.6;
            color: #2c3e50;
            margin-bottom: 15px;
        }
        
        .reclamation-response {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #28a745;
            margin-top: 15px;
        }
        
        .response-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
            color: #28a745;
            font-weight: 600;
        }
        
        .response-content {
            color: #2c3e50;
            line-height: 1.6;
            white-space: pre-wrap;
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
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
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
        
        /* Badge pour nouvelle réponse */
        .new-response-badge {
            background: #dc3545;
            color: white;
            padding: 4px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-left: 8px;
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            body {
                padding-top: 70px;
            }
            
            .page-header {
                padding: 15px 0;
            }
            
            .page-title {
                font-size: 1.5rem;
            }
            
            .main-content {
                padding: 15px;
            }
            
            .reclamation-form-card {
                padding: 20px;
            }
            
            .reclamation-item {
                padding: 20px;
            }
            
            .reclamation-item-header {
                flex-direction: column;
                align-items: flex-start;
            }
            
            .user-header {
                flex-direction: column;
                gap: 15px;
                align-items: flex-start;
            }
            
            .welcome-section {
                width: 100%;
            }
            
            .logout-section {
                width: 100%;
                justify-content: flex-start;
            }
        }
    </style>
</head>

<body class="reclamations-page">

    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#hero">Services Interventions</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}">Accueil</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/services">Services</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/secured/ClientReclamation">Reclamation</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- En-tête de page -->
    <div class="page-header">
        <div class="container-fluid">
            <div class="user-header">
                <!-- Section bienvenue à gauche -->
                <div class="welcome-section">
                    <span class="welcome-text">Bienvenue <strong class="welcome-user">${sessionScope.sessionUser.email}</strong></span>
                </div>
                
                <!-- Bouton de déconnexion à droite -->
                <div class="logout-section">
                    <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        Déconnexion
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Contenu principal -->
    <div class="container-fluid">
        <div class="main-content">
            
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
                <form action="${pageContext.request.contextPath}/secured/ClientReclamation" method="post">
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
                            <div class="reclamation-id">
                                Réclamation #${reclamation.id}
                                <c:if test="${not empty reclamation.reponseAdmin && !reclamation.etat}">
                                    <span class="new-response-badge">Nouvelle réponse</span>
                                </c:if>
                            </div>
                            <div class="reclamation-status 
                                ${not empty reclamation.reponseAdmin ? 'status-replied' : 
                                  reclamation.etat ? 'status-resolved' : 'status-pending'}">
                                <i class="fas 
                                    ${not empty reclamation.reponseAdmin ? 'fa-reply' : 
                                      reclamation.etat ? 'fa-check-circle' : 'fa-clock'}"></i>
                                ${not empty reclamation.reponseAdmin ? 'Répondu' : 
                                  reclamation.etat ? 'Résolue' : 'En attente'}
                            </div>
                        </div>
                        <div class="reclamation-content">
                            <strong>Votre message :</strong><br>
                            ${reclamation.contenu}
                        </div>
                        
                        <!-- Section réponse de l'admin -->
                        <c:if test="${not empty reclamation.reponseAdmin}">
                            <div class="reclamation-response">
                                <div class="response-header">
                                    <i class="fas fa-reply"></i>
                                    <span>Réponse de l'administrateur :</span>
                                </div>
                                <div class="response-content">
                                    ${reclamation.reponseAdmin}
                                </div>
                            </div>
                        </c:if>
                        
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

            // Marquer les réclamations comme lues lorsqu'elles sont affichées
            const reclamationItems = document.querySelectorAll('.reclamation-item');
            reclamationItems.forEach(item => {
                const hasNewResponse = item.querySelector('.new-response-badge');
                if (hasNewResponse) {
                    // Ici vous pourriez appeler une API pour marquer comme lu
                    console.log('Nouvelle réponse détectée, marquer comme lue');
                }
            });
        });
    </script>

</body>
</html>