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
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <jsp:include page="/JSP/secured/includes/admin-sidebar.jsp"/>
        
        <main class="admin-main">
            <div class="admin-header">
                <a href="${pageContext.request.contextPath}/admin/reclamations" class="back-link">
                    <i class="fas fa-arrow-left"></i>
                    Retour aux réclamations
                </a>
                <h1>Détail de la Réclamation</h1>
            </div>
            
            <div class="content-section">
                <div class="reclamation-detail">
                    <div class="reclamation-header">
                        <h2>Réclamation #${reclamation.id}</h2>
                        <div class="user-info">
                            <p style="margin: 0;">
                                <strong>De:</strong> 
                                <c:choose>
                                    <c:when test="${not empty reclamation.utilisateur}">
                                        ${reclamation.utilisateur.nom} (${reclamation.utilisateur.email})
                                    </c:when>
                                    <c:otherwise>
                                        Utilisateur inconnu
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                    
                    <div class="message-section">
                        <h3>Message:</h3>
                        <div class="message-content">
                            ${reclamation.contenu}
                        </div>
                    </div>
                    
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/reclamations" class="back-link">
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