<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
if (request.getAttribute("servlet_executed") == null) {
    response.sendRedirect(request.getContextPath() + "/admin/reclamations");
    return;
}
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Réclamations</title>
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
            background: #f0f2f5;
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

        h1 { 
            margin: 0; 
            font-size: 1.9em; 
            color: #222; 
        }

        .content-section {
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        /* === STATISTIQUES MODERNES OUVERTES === */
        .stats-container {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }
        .stat-card {
            flex: 1;
            background: #ffffff;
            padding: 25px;
            border-radius: 20px;
            text-align: center;
            position: relative;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            min-width: 200px;
        }
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 20px rgba(0,0,0,0.1);
        }
        .stat-number {
            font-size: 2.5em;
            font-weight: 700;
            margin-bottom: 5px;
        }

        /* Couleurs modernes et ouvertes */
        .stat-total { 
            border-left: 6px solid #3498db;
            color: #3498db;
        }
        .stat-unread { 
            border-left: 6px solid #5dade2;
            color: #5dade2;
        }
        .stat-read { 
            border-left: 6px solid #85c1e9;
            color: #85c1e9;
        }

        .stat-label {
            font-size: 0.95em;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #555;
        }

        /* Info pagination */
        .pagination-info {
            background: #ffffff;
            padding: 12px 18px;
            border-radius: 12px;
            margin-bottom: 20px;
            font-size: 0.95em;
            color: #666;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }

        /* Liste réclamations */
        .reclamation-list {
            margin-bottom: 20px;
        }

        .reclamation-item {
            padding: 18px;
            border-radius: 15px;
            background: #ffffff;
            margin-bottom: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: 0.3s ease;
            border: 1px solid #e0e0e0;
        }
        .reclamation-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        .reclamation-item.new {
            border-left: 6px solid #3498db;
            background: #f0f7ff;
            font-weight: 600;
        }
        .reclamation-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 0.95em;
        }
        .reclamation-sender { 
            font-weight: 600; 
            color: #222; 
        }
        .reclamation-content { 
            color: #555; 
            font-size: 0.95em; 
            margin-bottom: 10px; 
        }
        .reclamation-content.preview {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 650px;
        }
        .reclamation-item a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }
        .reclamation-item a:hover { 
            text-decoration: underline; 
        }

        .empty-message {
            text-align: center;
            padding: 40px;
            color: #7f8c8d;
            font-size: 1.1em;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            margin: 25px 0;
            gap: 8px;
            flex-wrap: wrap;
        }
        .pagination a, .pagination span {
            padding: 10px 16px;
            border-radius: 10px;
            text-decoration: none;
            font-size: 0.95em;
            font-weight: 500;
            transition: all 0.2s;
        }
        .pagination a {
            background: #ffffff;
            border: 1px solid #ddd;
            color: #3498db;
        }
        .pagination a:hover { 
            background: #3498db; 
            color: white; 
        }
        .pagination .current {
            background: #3498db;
            color: white;
            border: 1px solid #3498db;
        }
        .pagination .disabled {
            background: #f0f0f0;
            border: 1px solid #ddd;
            color: #aaa;
            cursor: not-allowed;
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
            
            .stats-container {
                flex-direction: column;
            }
            
            .stat-card {
                min-width: auto;
            }
            
            .reclamation-content.preview {
                max-width: 300px;
            }
        }
    </style>
</head>
<body>
    <div class="admin-container">
        <jsp:include page="/JSP/secured/includes/admin-sidebar.jsp"/>
        <main class="admin-main">
            <div class="admin-header">
                <h1>📑 Réclamations</h1>
            </div>

            <div class="content-section">
                <!-- Statistiques -->
                <div class="stats-container">
                    <div class="stat-card stat-total">
                        <div class="stat-number">${totalCount}</div>
                        <div class="stat-label">Total</div>
                    </div>
                    <div class="stat-card stat-unread">
                        <div class="stat-number">${unreadCount}</div>
                        <div class="stat-label">Non lues</div>
                    </div>
                    <div class="stat-card stat-read">
                        <div class="stat-number">${readCount}</div>
                        <div class="stat-label">Lues</div>
                    </div>
                </div>

                <!-- Info pagination -->
                <div class="pagination-info">
                    Affichage des réclamations ${startItem} à ${endItem} sur ${totalCount}  
                    | Page ${currentPage} / ${totalPages}
                </div>

                <!-- Liste des réclamations -->
                <div class="reclamation-list">
                    <c:choose>
                        <c:when test="${not empty reclamationsWithStatus}">
                            <c:forEach var="entry" items="${reclamationsWithStatus}">
                                <c:set var="reclamation" value="${entry.key}" />
                                <c:set var="isNew" value="${entry.value}" />

                                <div class="reclamation-item ${isNew ? 'new' : ''}">
                                    <div class="reclamation-header">
                                        <span class="reclamation-sender">
                                            <c:choose>
                                                <c:when test="${not empty reclamation.utilisateur}">
                                                    ${reclamation.utilisateur.nom} (${reclamation.utilisateur.email})
                                                </c:when>
                                                <c:otherwise>Utilisateur inconnu</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <span style="color: #999;">#${reclamation.id}</span>
                                    </div>
                                    <div class="reclamation-content preview">${reclamation.contenu}</div>
                                    <div>
                                        <a href="${pageContext.request.contextPath}/admin/reclamation-detail?id=${reclamation.id}">Voir détails →</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-message">📭 Aucune réclamation trouvée</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/admin/reclamations?page=1">« Premier</a>
                                <a href="${pageContext.request.contextPath}/admin/reclamations?page=${currentPage - 1}">‹ Préc</a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled">« Premier</span>
                                <span class="disabled">‹ Préc</span>
                            </c:otherwise>
                        </c:choose>

                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <span class="current">${i}</span>
                                </c:when>
                                <c:when test="${i >= currentPage - 2 && i <= currentPage + 2}">
                                    <a href="${pageContext.request.contextPath}/admin/reclamations?page=${i}">${i}</a>
                                </c:when>
                            </c:choose>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/admin/reclamations?page=${currentPage + 1}">Suiv ›</a>
                                <a href="${pageContext.request.contextPath}/admin/reclamations?page=${totalPages}">Dernier »</a>
                            </c:when>
                            <c:otherwise>
                                <span class="disabled">Suiv ›</span>
                                <span class="disabled">Dernier »</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>