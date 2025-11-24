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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Catégories</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css">
    
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #17a2b8;
            --light-blue: #3498db;
            --dark-blue: #2980b9;
        }

        body {
            font-family: "Poppins", "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
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
            transition: all 0.3s ease;
        }

        /* Sidebar Styles */
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
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
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
            color: var(--danger-color) !important;
        }

        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1) !important;
        }

        /* Header Styles */
        .admin-header {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            border-left: 5px solid var(--primary-color);
            transition: all 0.3s ease;
        }

        .admin-header:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
        }

        .admin-header h1 {
            color: var(--secondary-color);
            margin-bottom: 5px;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .admin-header p {
            color: #7f8c8d;
            margin: 0;
        }

        /* Content Section */
        .content-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary-color);
        }

        .content-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.12);
        }

        /* Button Styles */
        .btn-new-category {
            background: linear-gradient(135deg, var(--success-color) 0%, #27ae60 100%);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 12px 24px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
            margin-bottom: 25px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-new-category:hover {
            background: linear-gradient(135deg, #27ae60 0%, #219653 100%);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.4);
            color: white;
        }

        .btn-edit {
            background: linear-gradient(135deg, var(--warning-color) 0%, #e67e22 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(243, 156, 18, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85em;
        }

        .btn-edit:hover {
            background: linear-gradient(135deg, #e67e22 0%, #d35400 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(243, 156, 18, 0.4);
            color: white;
        }

        .btn-delete {
            background: linear-gradient(135deg, var(--danger-color) 0%, #c0392b 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 3px 10px rgba(231, 76, 60, 0.3);
            display: inline-flex;
            align-items: center;
            gap: 5px;
            font-size: 0.85em;
        }

        .btn-delete:hover {
            background: linear-gradient(135deg, #c0392b 0%, #a93226 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
            color: white;
        }

        /* Categories Grid */
        .categories-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 25px;
            margin-top: 20px;
        }

        .category-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            padding: 25px;
            transition: all 0.3s ease;
            border-top: 4px solid var(--primary-color);
            position: relative;
            overflow: hidden;
        }

        .category-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--light-blue), var(--dark-blue));
        }

        .category-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15);
        }

        .category-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 15px;
            border-bottom: 1px solid #ecf0f1;
            padding-bottom: 15px;
        }

        .category-title {
            color: var(--secondary-color);
            margin: 0;
            font-size: 1.3em;
            font-weight: 700;
            flex: 1;
        }

        .category-id {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #7f8c8d;
            padding: 6px 12px;
            border-radius: 15px;
            font-size: 0.8em;
            font-weight: 600;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }

        .category-body {
            margin-bottom: 20px;
        }

        .category-description {
            color: #5d6d7e;
            font-size: 0.95em;
            line-height: 1.6;
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

        .no-categories {
            text-align: center;
            padding: 60px 20px;
            grid-column: 1 / -1;
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .no-categories:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.12);
        }

        .no-data-icon {
            font-size: 4em;
            margin-bottom: 20px;
            opacity: 0.7;
            color: var(--primary-color);
        }

        .no-categories h3 {
            color: var(--secondary-color);
            margin-bottom: 10px;
            font-weight: 600;
        }

        .no-categories p {
            color: #7f8c8d;
            margin: 0;
            font-size: 1.1em;
        }

        /* Animation for cards */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .category-card {
            animation: fadeInUp 0.5s ease;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .admin-main {
                margin-left: 0;
                padding: 15px;
            }
            
            .admin-sidebar {
                width: 70px;
                overflow: hidden;
            }
            
            .sidebar-header h3, 
            .sidebar-menu li a span {
                display: none;
            }
            
            .sidebar-menu li a {
                justify-content: center;
                padding: 15px;
            }
            
            .sidebar-menu li a i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .content-section {
                padding: 20px;
            }
            
            .categories-grid {
                grid-template-columns: 1fr;
            }
            
            .category-actions {
                flex-direction: column;
            }
            
            .btn-edit, .btn-delete {
                width: 100%;
                text-align: center;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .admin-header {
                padding: 20px;
            }
            
            .admin-header h1 {
                font-size: 1.5rem;
            }
            
            .category-card {
                padding: 20px;
            }
            
            .category-header {
                flex-direction: column;
                gap: 10px;
            }
            
            .category-id {
                align-self: flex-start;
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
            <p class="mb-0">Administrez les catégories de services disponibles</p>
        </div>

        <div class="content-section">
            <a href="${pageContext.request.contextPath}/admin/categories?action=new" class="btn btn-new-category">
                <i class="bi bi-plus-circle"></i> Nouvelle Catégorie
            </a>

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
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=edit&id=${c.id}" class="btn btn-edit">
                                        <i class="bi bi-pencil-square"></i> Modifier
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/categories?action=delete&id=${c.id}" class="btn btn-delete"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette catégorie ?');">
                                        <i class="bi bi-trash"></i> Supprimer
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="no-categories">
                            <div class="no-data-icon">
                                <i class="bi bi-folder-x"></i>
                            </div>
                            <h3>Aucune catégorie trouvée</h3>
                            <p>Commencez par créer votre première catégorie de services</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS for animations -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add staggered animation to category cards
        const categoryCards = document.querySelectorAll('.category-card');
        categoryCards.forEach((card, index) => {
            card.style.animationDelay = `${index * 0.1}s`;
        });
        
        // Add confirmation for delete actions
        const deleteButtons = document.querySelectorAll('.btn-delete');
        deleteButtons.forEach(button => {
            button.addEventListener('click', function(e) {
                if (!confirm('Êtes-vous sûr de vouloir supprimer cette catégorie ? Cette action est irréversible.')) {
                    e.preventDefault();
                }
            });
        });
        
        // Add hover effect to no-categories section
        const noCategories = document.querySelector('.no-categories');
        if (noCategories) {
            noCategories.addEventListener('click', function() {
                window.location.href = '${pageContext.request.contextPath}/admin/categories?action=new';
            });
            noCategories.style.cursor = 'pointer';
        }
    });
</script>
</body>
</html>