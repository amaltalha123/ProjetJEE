<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    if (session.getAttribute("sessionUser") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    com.projet.jee.dto.SessionUser sessionUser = (com.projet.jee.dto.SessionUser) session.getAttribute("sessionUser");
    if (sessionUser.getRole() != com.projet.jee.model.Role.ADMIN) {
        response.sendRedirect(request.getContextPath() + "/access-denied");
        return;
    }
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Admin</title>
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

    h1, h2 {
        color: #2c3e50;
        margin-bottom: 15px;
    }

    /* === Cartes de statistiques === */
    .stats-cards {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 20px;
        margin-bottom: 30px;
    }

    .stat-card {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        text-align: center;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .stat-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 30px rgba(0,0,0,0.15);
    }

    .stat-card i {
        font-size: 2.5em;
        margin-bottom: 10px;
        display: block;
    }

    .stat-card h3 {
        font-size: 2em;
        margin: 10px 0;
        color: #34495e;
    }

    .stat-card p {
        color: #7f8c8d;
        font-size: 0.95em;
    }

    .card-users { border-top: 4px solid #3498db; }
    .card-categories { border-top: 4px solid #9b59b6; }
    .card-reclamations { border-top: 4px solid #f1c40f; }
    .card-active-reclamations { border-top: 4px solid #e67e22; }

    /* === Sections de contenu === */
    .content-section {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        margin-bottom: 20px;
    }

    /* === Header Admin === */
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

    /* === Tables === */
    .table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
    }

    .table th,
    .table td {
        padding: 14px 12px;
        text-align: left;
        border-bottom: 1px solid #ecf0f1;
        font-size: 0.95em;
    }

    .table th {
        background: #f8f9fa;
        font-weight: 600;
        color: #2c3e50;
    }

    .table tbody tr:hover {
        background-color: #f8f9fa;
    }

    /* === Boutons === */
    .btn {
        padding: 6px 14px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 0.85em;
        text-decoration: none;
        display: inline-block;
        transition: all 0.3s ease;
    }

    .btn-primary { background: #3498db; color: white; }
    .btn-primary:hover { background: #2980b9; }

    .btn-success { background: #2ecc71; color: white; }
    .btn-success:hover { background: #27ae60; }

    .btn-warning { background: #f1c40f; color: #fff; }
    .btn-warning:hover { background: #d4ac0d; }

    .btn-danger { background: #e74c3c; color: white; }
    .btn-danger:hover { background: #c0392b; }

    /* === Badges === */
    .status-badge {
        padding: 5px 10px;
        border-radius: 12px;
        font-size: 0.8em;
        font-weight: bold;
    }

    .status-pending { background: #fff8e1; color: #ffb300; }
    .status-resolved { background: #e0f7fa; color: #006064; }

    .role-badge {
        padding: 5px 10px;
        border-radius: 12px;
        font-size: 0.8em;
        font-weight: bold;
    }

    .role-admin { background: #e8f5e9; color: #2e7d32; }
    .role-manager { background: #e3f2fd; color: #1565c0; }
    .role-client { background: #fff3e0; color: #ef6c00; }

    /* === Statistiques utilisateurs === */
    .users-stats {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
        gap: 15px;
        margin-bottom: 20px;
    }

    .user-stat-card {
        background: #ffffff;
        padding: 20px;
        border-radius: 12px;
        text-align: center;
        box-shadow: 0 4px 12px rgba(0,0,0,0.07);
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }

    .user-stat-card:hover {
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    .user-stat-card h4 {
        font-size: 1.8em;
        margin: 5px 0;
        color: #2c3e50;
    }

    .user-stat-card p { color: #7f8c8d; font-size: 0.9em; }

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
        }
        
        .stats-cards {
            grid-template-columns: 1fr;
        }
    }
</style>

</head>
<body>
    <div class="admin-container">
        <jsp:include page="/JSP/secured/includes/admin-sidebar.jsp"/>
        
        <main class="admin-main">
            <div class="admin-header">
                <h1>Tableau de Bord Administrateur</h1>
                <p>Bienvenue, ${sessionUser.email}</p>
            </div>
            
            <!-- Cartes de statistiques principales -->
            <div class="stats-cards">
                <div class="stat-card card-users">
                    <i>👥</i>
                    <h3>${totalUsers}</h3>
                    <p>Utilisateurs Totaux</p>
                </div>
                <div class="stat-card card-categories">
                    <i>📁</i>
                    <h3>${totalCategories}</h3>
                    <p>Catégories</p>
                </div>
                <div class="stat-card card-reclamations">
                    <i>📝</i>
                    <h3>${totalReclamations}</h3>
                    <p>Réclamations Totales</p>
                </div>
                <div class="stat-card card-active-reclamations">
                    <i>⚠</i>
                    <h3>${activeReclamations}</h3>
                    <p>Réclamations Actives</p>
                </div>
            </div>
            
            <!-- Statistiques détaillées des utilisateurs -->
            <div class="content-section">
                <h2>Répartition des Utilisateurs</h2>
                <div class="users-stats">
                    <div class="user-stat-card">
                        <h4>${adminUsers}</h4>
                        <p>Administrateurs</p>
                    </div>
                    <div class="user-stat-card">
                        <h4>${managerUsers}</h4>
                        <p>Managers</p>
                    </div>
                    <div class="user-stat-card">
                        <h4>${clientUsers}</h4>
                        <p>Clients</p>
                    </div>
                </div>
            </div>
            
            <!-- Réclamations récentes -->
            <div class="content-section">
                <h2>Réclamations Récentes</h2>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Utilisateur</th>
                            <th>Contenu</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentReclamations}">
                                <c:forEach var="reclamation" items="${recentReclamations}">
                                    <tr>
                                        <td>#${reclamation[0]}</td>
                                        <td>${reclamation[1]}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${fn:length(reclamation[2]) > 50}">
                                                    ${fn:substring(reclamation[2], 0, 50)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${reclamation[2]}
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${reclamation[3] == true}">
                                                    <span class="status-badge status-resolved">Résolu</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-pending">En attente</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                           <a href="${pageContext.request.contextPath}/admin/reclamations" 
                                               class="btn btn-primary">Voir</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="5" style="text-align: center; color: #7f8c8d;">
                                        Aucune réclamation trouvée
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            
            <!-- Utilisateurs récemment inscrits -->
            <div class="content-section">
                <h2>Utilisateurs Récemment Inscrits</h2>
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Email</th>
                            <th>Nom</th>
                            <th>Rôle</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty recentUsers}">
                                <c:forEach var="user" items="${recentUsers}">
                                    <tr>
                                        <td>${user[0]}</td>
                                        <td>${user[1]}</td>
                                        <td>${user[3]}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user[2] == 'ADMIN'}">
                                                    <span class="role-badge role-admin">ADMIN</span>
                                                </c:when>
                                                <c:when test="${user[2] == 'MANAGER'}">
                                                    <span class="role-badge role-manager">MANAGER</span>
                                                </c:when>
                                                <c:when test="${user[2] == 'CLIENT'}">
                                                    <span class="role-badge role-client">CLIENT</span>
                                                </c:when>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" style="text-align: center; color: #7f8c8d;">
                                        Aucun utilisateur trouvé
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
    
    <script src="${pageContext.request.contextPath}/JS/admin.js"></script>
</body>
</html>