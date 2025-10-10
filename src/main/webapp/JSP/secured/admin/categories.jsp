<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
    <title>Gestion des Catégories</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css">
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
            <h1>Gestion des Catégories</h1>
            <p> </p>
        </div>

        <div class="content-section">
            <a href="${pageContext.request.contextPath}/admin/categories?action=new" class="btn btn-success" style="margin-bottom: 25px;">+ Nouvelle Catégorie</a>

            <div class="categories-grid">
                <c:choose>
                    <c:when test="${not empty categories}">
                        <c:forEach var="c" items="${categories}">
                            <div class="category-card">
                                <div class="category-header">
                                    <h3 class="category-title">${c.nom}</h3>
                                    <span class="category-id">#${c.id}</span>
                                </div>
                                <div class="category-body">
                                    <p class="category-description">${c.description}</p>
                                </div>
                                <div class="category-actions">
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${c.id}" class="btn btn-warning btn-sm">✏️ Modifier</a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.id}" class="btn btn-danger btn-sm"
                                       onclick="return confirm('Supprimer cette catégorie ?');">🗑️ Supprimer</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-categories">
                            <div class="no-data-icon">📂</div>
                            <h3>Aucune catégorie trouvée</h3>
                            <p>Commencez par créer votre première catégorie</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

<style>
    .categories-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
        gap: 20px;
        margin-top: 20px;
    }

    .category-card {
        background: white;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        padding: 20px;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border-top: 4px solid #9b59b6;
    }

    .category-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 30px rgba(0,0,0,0.15);
    }

    .category-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 15px;
        border-bottom: 1px solid #ecf0f1;
        padding-bottom: 10px;
    }

    .category-title {
        color: #2c3e50;
        margin: 0;
        font-size: 1.2em;
        font-weight: 600;
    }

    .category-id {
        background: #f8f9fa;
        color: #7f8c8d;
        padding: 4px 8px;
        border-radius: 12px;
        font-size: 0.8em;
        font-weight: 500;
    }

    .category-body {
        margin-bottom: 20px;
    }

    .category-description {
        color: #5d6d7e;
        font-size: 0.9em;
        line-height: 1.5;
        margin: 0;
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
    }

    .category-actions {
        display: flex;
        gap: 10px;
        justify-content: flex-end;
    }

    .btn-sm {
        padding: 6px 12px;
        font-size: 0.8em;
    }

    .no-categories {
        text-align: center;
        padding: 60px 20px;
        grid-column: 1 / -1;
    }

    .no-data-icon {
        font-size: 4em;
        margin-bottom: 20px;
        opacity: 0.5;
    }

    .no-categories h3 {
        color: #7f8c8d;
        margin-bottom: 10px;
    }

    .no-categories p {
        color: #bdc3c7;
        margin: 0;
    }

    /* Responsive */
    @media (max-width: 768px) {
        .categories-grid {
            grid-template-columns: 1fr;
        }
        
        .category-actions {
            flex-direction: column;
        }
        
        .btn-sm {
            width: 100%;
            text-align: center;
        }
    }
</style>
</body>
</html>
