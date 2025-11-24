<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ajouter ou modifier une demande</title>
    
    <!-- Mêmes imports que service.jsp -->
    <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="<%= request.getContextPath() %>/JSP/secured/assets/css/main.css" rel="stylesheet">
    
    <style>
        /* Reset et styles généraux cohérents avec service.jsp */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }
        
        .main-container {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        
        /* Header cohérent avec service.jsp */
        .page-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 15px 0;
            box-shadow: 0 2px 20px rgba(0, 0, 0, 0.1);
        }
        
        .breadcrumbs {
            background: transparent;
            border: none;
            padding: 10px 0;
        }
        
        .breadcrumbs ol {
            margin: 0;
            padding: 0;
            list-style: none;
            display: flex;
            gap: 10px;
        }
        
        .breadcrumbs a {
            color: #667eea;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .breadcrumbs a:hover {
            color: #764ba2;
        }
        
        /* Container principal */
        .form-container {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }
        
        .form-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            width: 100%;
            max-width: 600px;
            overflow: hidden;
        }
        
        .form-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .form-header::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 20px 20px;
            animation: float 20s linear infinite;
        }
        
        @keyframes float {
            0% { transform: translate(0, 0) rotate(0deg); }
            100% { transform: translate(-20px, -20px) rotate(360deg); }
        }
        
        .form-title {
            font-size: 2rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 1;
        }
        
        .form-body {
            padding: 40px;
        }
        
        /* Styles des champs de formulaire cohérents avec service.jsp */
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 8px;
            display: block;
        }
        
        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 12px 16px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }
        
        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
        }
        
        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }
        
        /* NOUVEAUX STYLES DES BOUTONS - Design moderne et élégant */
        .btn-group {
            display: flex;
            gap: 15px;
            justify-content: space-between;
            margin-top: 30px;
            flex-wrap: wrap;
        }
        
        .btn {
            padding: 14px 32px;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
            border: none;
            cursor: pointer;
            font-size: 1rem;
            flex: 1;
            min-width: 150px;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: left 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        /* Bouton Mettre à jour/Créer - Style moderne bleu */
        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            border: 2px solid transparent;
        }
        
        .btn-submit:hover {
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 12px 30px rgba(102, 126, 234, 0.6);
            color: white;
        }
        
        .btn-submit:active {
            transform: translateY(-1px) scale(1.01);
        }
        
        /* Bouton Annuler - Style élégant gris */
        .btn-cancel {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #6c757d;
            border: 2px solid #dee2e6;
            box-shadow: 0 4px 15px rgba(108, 117, 125, 0.15);
        }
        
        .btn-cancel:hover {
            background: linear-gradient(135deg, #e9ecef 0%, #dee2e6 100%);
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(108, 117, 125, 0.25);
            color: #495057;
            border-color: #adb5bd;
        }
        
        /* Bouton Supprimer - Style moderne rouge */
        .btn-delete {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            color: white;
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
            border: 2px solid transparent;
        }
        
        .btn-delete:hover {
            background: linear-gradient(135deg, #ff5252 0%, #e53e3e 100%);
            transform: translateY(-3px) scale(1.02);
            box-shadow: 0 12px 30px rgba(255, 82, 82, 0.6);
            color: white;
        }
        
        .btn-delete:active {
            transform: translateY(-1px) scale(1.01);
        }
        
        /* Effet de brillance au survol pour tous les boutons */
        .btn::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255,255,255,0.1), transparent);
            transform: rotate(45deg);
            transition: all 0.6s;
            opacity: 0;
        }
        
        .btn:hover::after {
            opacity: 1;
            transform: rotate(45deg) translate(50%, 50%);
        }
        
        /* Animation des icônes dans les boutons */
        .btn i {
            transition: transform 0.3s ease;
        }
        
        .btn:hover i {
            transform: scale(1.2);
        }
        
        /* Footer cohérent */
        .page-footer {
            background: rgba(255, 255, 255, 0.95);
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            padding: 20px 0;
            text-align: center;
            margin-top: auto;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .form-container {
                padding: 20px 15px;
            }
            
            .form-body {
                padding: 25px;
            }
            
            .form-header {
                padding: 20px;
            }
            
            .form-title {
                font-size: 1.5rem;
            }
            
            .btn-group {
                flex-direction: column;
                gap: 12px;
            }
            
            .btn {
                width: 100%;
                padding: 12px 24px;
            }
        }
        
        @media (max-width: 576px) {
            .form-card {
                margin: 10px;
            }
            
            .form-body {
                padding: 20px;
            }
            
            .btn {
                min-width: auto;
                font-size: 0.9rem;
                padding: 10px 20px;
            }
        }
        
        /* Animation d'entrée */
        .form-card {
            animation: slideUp 0.6s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Animation spécifique pour les boutons */
        .btn {
            animation: buttonEntrance 0.8s ease-out;
        }
        
        @keyframes buttonEntrance {
            from {
                opacity: 0;
                transform: translateY(20px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <!-- Header cohérent avec service.jsp -->
        <div class="page-header">
            <nav class="breadcrumbs">
                <div class="container">
                    <ol>
                        <li><a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/manager/mes-demandes">Demandes</a></li>
                        <li class="current">${empty demande ? 'Nouvelle demande' : 'Modifier demande'}</li>
                    </ol>
                </div>
            </nav>
        </div>

        <!-- Container du formulaire -->
        <div class="form-container">
            <div class="form-card">
                <div class="form-header">
                    <h1 class="form-title">
                        <i class="fas fa-calendar-plus me-2"></i>
                        ${empty demande ? '🗓️ Nouvelle demande' : '✏️ Modifier la demande'}
                    </h1>
                </div>
                
                <div class="form-body">
                    <form action="${pageContext.request.contextPath}/manager/demandeAction" method="post">
                        <input type="hidden" name="action" value="${empty demande ? 'add' : 'update'}" />
                        <input type="hidden" name="demandeId" value="${demande.id}" />

                        <div class="mb-4">
                            <label for="service" class="form-label">
                                <i class="fas fa-concierge-bell me-2"></i>Service
                            </label>
                            <select name="serviceId" id="service" class="form-select" required>
                                <option value="">-- Sélectionner un service --</option>
                                <c:forEach var="s" items="${services}">
                                    <option value="${s.id}" ${demande.service.id == s.id ? 'selected' : ''}>
                                        ${s.titre}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

	                        <div class="mb-4">
	                            <label class="form-label">
	                                <i class="fas fa-align-left me-2"></i>Description
	                            </label>
	                            <textarea name="description" class="form-control" rows="4" 
	                                      placeholder="Décrivez votre demande en détail..." required>${demande.description}</textarea>
	                        </div>

                        <div class="mb-4">
                            <label class="form-label">
                                <i class="fas fa-calendar-day me-2"></i>Date d'intervention
                            </label>
                            <input type="date" name="dateIntervention" class="form-control" 
                                   value="${demande.dateIntervention != null ? String.format('%tF', demande.dateIntervention) : ''}" required />
                        </div>

                        <c:if test="${not empty demande}">
                        <div class="mb-4">
                            <label class="form-label">
                                <i class="fas fa-tasks me-2"></i>Statut
                            </label>
                            <select name="statut" class="form-select">
                                <option value="EN_ATTENTE" ${demande.statut == 'EN_ATTENTE' ? 'selected' : ''}>
                                    ⏳ En attente
                                </option>
                                <option value="EN_COURS" ${demande.statut == 'EN_COURS' ? 'selected' : ''}>
                                    🔄 En cours
                                </option>
                                <option value="TERMINE" ${demande.statut == 'TERMINE' ? 'selected' : ''}>
                                    ✅ Terminée
                                </option>
                                <option value="ANNULE" ${demande.statut == 'ANNULE' ? 'selected' : ''}>
                                    ❌ Annulée
                                </option>
                            </select>
                        </div>
                        </c:if>

                        <div class="btn-group">
                            <button type="submit" class="btn btn-submit">
                                <i class="fas fa-save me-2"></i>
                                ${empty demande ? 'Créer la demande' : 'Mettre à jour'}
                            </button>

                            <a href="${pageContext.request.contextPath}/manager/mes-demandes"
                               class="btn btn-cancel">
                               <i class="fas fa-times me-2"></i>Annuler
                            </a>

                            <c:if test="${not empty demande}">
                                <a href="${pageContext.request.contextPath}/manager/demandeAction?action=delete&id=${demande.id}"
                                   class="btn btn-delete"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette demande ?')">
                                   <i class="fas fa-trash me-2"></i>Supprimer
                                </a>
                            </c:if>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Footer cohérent -->
        <div class="page-footer">
            <div class="container">
                <div class="copyright">
                    &copy; Copyright <strong><span>MediNest</span></strong>. All Rights Reserved
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts cohérents avec service.jsp -->
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/fontawesome-free/js/all.min.js"></script>
    
    <script>
        // Animation pour les champs du formulaire
        document.addEventListener('DOMContentLoaded', function() {
            const formElements = document.querySelectorAll('.form-control, .form-select');
            
            formElements.forEach((element, index) => {
                element.style.animationDelay = `${index * 0.1}s`;
                element.classList.add('animate__animated', 'animate__fadeInUp');
            });
            
            // Animation spécifique pour les boutons
            const buttons = document.querySelectorAll('.btn');
            buttons.forEach((button, index) => {
                button.style.animationDelay = `${0.5 + (index * 0.1)}s`;
            });
        });
    </script>
</body>
</html>