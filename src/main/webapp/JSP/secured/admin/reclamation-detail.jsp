<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    if (session.getAttribute("sessionUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détail Réclamation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* === Styles pour le sidebar === */
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
        }

        .admin-sidebar {
            width: 250px;
            background: var(--secondary-color);
            color: white;
            height: 100vh;
            display: flex;
            flex-direction: column;
            position: fixed;
            left: 0;
            top: 0;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            background: rgba(0, 0, 0, 0.2);
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-header h3 {
            color: white;
            margin: 0;
            font-size: 1.2rem;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .sidebar-menu li {
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-menu li a {
            display: flex;
            align-items: center;
            padding: 15px 20px;
            color: #bdc3c7;
            text-decoration: none;
            transition: all 0.3s;
        }

        .sidebar-menu li a i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }

        .sidebar-menu li a:hover {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            padding-left: 25px;
        }

        .sidebar-menu li.active a {
            background: var(--primary-color);
            color: white;
        }

        .logout-item {
            margin-top: auto;
        }

        .logout-link {
            color: #e74c3c !important;
        }

        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1) !important;
        }

        /* === Styles généraux === */
        body {
            font-family: "Poppins", "Segoe UI", Roboto, sans-serif;
            background: #f5f6fa;
            margin: 0;
            color: #333;
        }

        .admin-container {
            display: flex;
            min-height: 100vh;
        }

        .admin-main {
            flex: 1;
            margin-left: 250px;
            padding: 20px;
        }

        .admin-header {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .admin-header h1 {
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .content-section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        /* === Styles spécifiques pour le détail de réclamation === */
        .reclamation-detail {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }

        .reclamation-header {
            border-bottom: 2px solid #f0f2f5;
            padding-bottom: 20px;
            margin-bottom: 25px;
        }

        .reclamation-header h2 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 1.8em;
        }

        .reclamation-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            color: #7f8c8d;
            font-size: 0.95em;
        }

        .reclamation-meta strong {
            color: #2c3e50;
        }

        .message-section {
            margin-bottom: 30px;
        }

        .message-section h3 {
            color: #2c3e50;
            margin-bottom: 15px;
            font-size: 1.3em;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .message-content {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border-left: 4px solid #3498db;
            white-space: pre-wrap;
            line-height: 1.6;
            font-size: 0.95em;
            color: #2c3e50;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            padding: 10px 16px;
            border: 1px solid #3498db;
            border-radius: 6px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: #3498db;
            color: white;
            text-decoration: none;
        }

        .user-info {
            background: #e8f4fd;
            padding: 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

        .user-info strong {
            color: #2980b9;
        }

        /* Styles pour les réponses */
        .response-section {
            margin-bottom: 30px;
        }

        .response-form {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            border: 1px solid #e9ecef;
        }

        .response-textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            resize: vertical;
            font-family: inherit;
            font-size: 0.95em;
            margin-bottom: 15px;
        }

        .submit-btn {
            background: #3498db;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.95em;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: background 0.3s;
        }

        .submit-btn:hover {
            background: #2980b9;
        }

        .alert-success {
            color: #27ae60;
            background: #f0f9f0;
            padding: 10px 15px;
            border-radius: 6px;
            border-left: 4px solid #27ae60;
            margin-top: 10px;
        }

        .alert-error {
            color: #e74c3c;
            background: #fdf2f2;
            padding: 10px 15px;
            border-radius: 6px;
            border-left: 4px solid #e74c3c;
            margin-top: 10px;
        }

        .role-badge {
            font-size: 0.8em;
            padding: 4px 10px;
            border-radius: 12px;
            color: white;
            margin-left: 8px;
            font-weight: 500;
        }
        .role-client {
            background: #3498db;
        }
        .role-manager {
            background: #e67e22;
        }
        .role-admin {
            background: #e74c3c;
        }

        .status-badge {
            font-size: 0.8em;
            padding: 4px 10px;
            border-radius: 12px;
            color: white;
            margin-left: 8px;
            font-weight: 500;
        }
        .status-new {
            background: #e74c3c;
        }
        .status-read {
            background: #27ae60;
        }

        /* === Responsive === */
        @media (max-width: 768px) {
            .admin-sidebar {
                width: 70px;
            }
            
            .sidebar-header h3,
            .sidebar-menu li a span {
                display: none;
            }
            
            .sidebar-menu li a i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .admin-main {
                margin-left: 70px;
                padding: 15px;
            }
            
            .reclamation-detail {
                padding: 20px;
            }
            
            .reclamation-meta {
                flex-direction: column;
                gap: 10px;
            }
            
            .reclamation-header h2 {
                font-size: 1.5em;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <jsp:include page="/JSP/secured/includes/admin-sidebar.jsp"/>
        
        <main class="admin-main">
            <div class="admin-header">
                <a href="${pageContext.request.contextPath}/admin/reclamations${not empty param.role ? '?role=' += param.role : ''}" class="back-link">
                    <i class="fas fa-arrow-left"></i>
                    Retour aux réclamations
                </a>
                <h1>Détail de la Réclamation</h1>
            </div>
            
            <div class="content-section">
                <div class="reclamation-detail">
                    <div class="reclamation-header">
                        <div style="display: flex; justify-content: between; align-items: center; margin-bottom: 15px;">
                            <h2>Réclamation #${reclamation.id}</h2>
                            <span class="status-badge ${reclamation.etat ? 'status-read' : 'status-new'}">
                                ${reclamation.etat ? 'Lue' : 'Nouvelle'}
                            </span>
                        </div>
                        <div class="user-info">
                            <p style="margin: 0; display: flex; align-items: center;">
                                <strong>De:</strong> 
                                <c:choose>
                                    <c:when test="${not empty reclamation.utilisateur}">
                                        <span style="margin-left: 8px;">
                                            ${reclamation.utilisateur.nom} (${reclamation.utilisateur.email})
                                        </span>
                                        <span class="role-badge ${reclamation.utilisateur.role == 'CLIENT' ? 'role-client' : reclamation.utilisateur.role == 'MANAGER' ? 'role-manager' : 'role-admin'}">
                                            ${reclamation.utilisateur.role}
                                        </span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="margin-left: 8px;">Utilisateur inconnu</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    
                    <!-- Message de la réclamation -->
                    <div class="message-section">
                        <h3>
                            <i class="fas fa-envelope"></i>
                            Message de la réclamation
                        </h3>
                        <div class="message-content">
                            ${reclamation.contenu}
                        </div>
                    </div>
                    
                    <!-- Section réponse admin existante -->
                    <c:if test="${not empty reclamation.reponseAdmin}">
                    <div class="message-section">
                        <h3 style="color: #27ae60;">
                            <i class="fas fa-reply"></i> 
                            Votre réponse
                        </h3>
                        <div class="message-content" style="border-left-color: #27ae60; background: #f0f9f0;">
                            ${reclamation.reponseAdmin}
                        </div>
                    </div>
                    </c:if>

                    <!-- Formulaire de réponse -->
                    <div class="message-section">
                        <h3>
                            <i class="fas fa-reply"></i> 
                            <c:choose>
                                <c:when test="${not empty reclamation.reponseAdmin}">Modifier la réponse</c:when>
                                <c:otherwise>Répondre à cette réclamation</c:otherwise>
                            </c:choose>
                        </h3>
                        <form action="${pageContext.request.contextPath}/admin/repondre-reclamation" method="post" class="response-form">
                            <input type="hidden" name="id" value="${reclamation.id}">
                            <div style="margin-bottom: 15px;">
                                <textarea name="reponse" rows="6" class="response-textarea" 
                                          placeholder="Tapez votre réponse ici...">${reclamation.reponseAdmin}</textarea>
                            </div>
                            <button type="submit" class="submit-btn">
                                <i class="fas fa-paper-plane"></i> 
                                <c:choose>
                                    <c:when test="${not empty reclamation.reponseAdmin}">Modifier la réponse</c:when>
                                    <c:otherwise>Envoyer la réponse</c:otherwise>
                                </c:choose>
                            </button>
                            
                            <!-- Messages de statut -->
                            <c:if test="${param.success == '1'}">
                                <div class="alert-success">
                                    <i class="fas fa-check-circle"></i> 
                                    Réponse envoyée avec succès!
                                </div>
                            </c:if>
                            <c:if test="${param.error == '1'}">
                                <div class="alert-error">
                                    <i class="fas fa-exclamation-circle"></i> 
                                    Erreur lors de l'envoi de la réponse.
                                </div>
                            </c:if>
                        </form>
                    </div>
                    
                    <!-- Bouton retour -->
                    <div style="margin-top: 30px;">
                        <a href="${pageContext.request.contextPath}/admin/reclamations${not empty param.role ? '?role=' += param.role : ''}" class="back-link">
                            <i class="fas fa-arrow-left"></i>
                            Retour à la liste
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>