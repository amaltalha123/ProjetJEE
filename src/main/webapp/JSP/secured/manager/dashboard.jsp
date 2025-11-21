<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Dashboard Manager</title>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
<style>
    :root {
        --primary: #667eea;
        --secondary: #0290d2;
        --bg-light: #f8f9fa;
        --card-bg: #ffffff;
        --text-dark: #2c3e50;
        --text-light: #6c757d;
        --border-color: #e9ecef;
        --success: #28a745;
        --warning: #ffc107;
        --danger: #dc3545;
    }

    body {
        font-family: 'Inter', sans-serif;
        margin: 0;
        background-color: var(--bg-light);
        color: var(--text-dark);
        min-height: 100vh;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 20px;
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
        padding: 20px 0;
        border-bottom: 1px solid var(--border-color);
    }

    .header h1 {
        color: var(--text-dark);
        font-size: 2rem;
        font-weight: 700;
        margin: 0;
    }

    .logout-btn {
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
        border: none;
        padding: 12px 24px;
        border-radius: 6px;
        font-weight: 600;
        font-size: 1rem;
        text-decoration: none;
        transition: all 0.3s ease;
        box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        display: inline-flex;
        align-items: center;
        gap: 8px;
    }

    .logout-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
        color: white;
        text-decoration: none;
    }

    .profile-section {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 40px;
        padding: 25px;
        background: var(--card-bg);
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        border: 1px solid var(--border-color);
    }

    .profile-photo, .default-avatar {
        width: 90px;
        height: 90px;
        border-radius: 50%;
        border: 3px solid var(--primary);
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 28px;
        font-weight: bold;
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
    }

    .profile-photo {
        object-fit: cover;
        background-color: transparent;
    }

    .profile-info h2 {
        margin: 0;
        font-size: 1.5rem;
        font-weight: 600;
        color: var(--text-dark);
    }

    .profile-info p {
        margin: 5px 0 0 0;
        color: var(--text-light);
        font-size: 1rem;
    }

    .menu-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
        gap: 25px;
    }

    .menu-card {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 30px 25px;
        text-decoration: none;
        color: var(--text-dark);
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        border: 1px solid var(--border-color);
        transition: all 0.3s ease;
        display: flex;
        flex-direction: column;
        align-items: center;
        text-align: center;
    }

    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        background: linear-gradient(135deg, var(--primary) 0%, var(--secondary) 100%);
        color: white;
        text-decoration: none;
    }

    .menu-card:hover h3,
    .menu-card:hover p {
        color: white;
    }

    .menu-card h3 {
        margin: 15px 0 10px 0;
        font-size: 1.3rem;
        font-weight: 600;
        color: var(--text-dark);
        transition: color 0.3s ease;
    }

    .menu-card p {
        font-size: 0.95rem;
        color: var(--text-light);
        margin: 0;
        line-height: 1.5;
        transition: color 0.3s ease;
    }

    .menu-icon {
        font-size: 2.5rem;
        margin-bottom: 10px;
        opacity: 0.8;
        transition: opacity 0.3s ease;
    }

    .menu-card:hover .menu-icon {
        opacity: 1;
    }

    /* Animation pour les cartes */
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

    .menu-card {
        animation: fadeInUp 0.6s ease forwards;
    }

    .menu-card:nth-child(1) { animation-delay: 0.1s; }
    .menu-card:nth-child(2) { animation-delay: 0.2s; }
    .menu-card:nth-child(3) { animation-delay: 0.3s; }
    .menu-card:nth-child(4) { animation-delay: 0.4s; }

    /* Responsive */
    @media (max-width: 768px) {
        .container {
            padding: 15px;
        }
        
        .header {
            flex-direction: column;
            gap: 15px;
            text-align: center;
        }
        
        .header h1 {
            font-size: 1.7rem;
        }
        
        .profile-section {
            flex-direction: column;
            text-align: center;
            padding: 20px;
        }
        
        .menu-grid {
            grid-template-columns: 1fr;
            gap: 20px;
        }
        
        .menu-card {
            padding: 25px 20px;
        }
    }

    @media (max-width: 480px) {
        .profile-photo, .default-avatar {
            width: 70px;
            height: 70px;
            font-size: 22px;
        }
        
        .profile-info h2 {
            font-size: 1.3rem;
        }
        
        .menu-card h3 {
            font-size: 1.2rem;
        }
        
        .menu-icon {
            font-size: 2rem;
        }
    }
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Dashboard Manager</h1>
        <a href="${pageContext.request.contextPath}/logout" class="logout-btn">
            <i class="fas fa-sign-out-alt"></i> Se déconnecter
        </a>
    </div>

    <c:if test="${not empty sessionScope.sessionUser}">
        <div class="profile-section">
            <c:choose>
                <c:when test="${not empty sessionScope.sessionUser.id}">
                    <img src="${pageContext.request.contextPath}/user-photo?id=${sessionScope.sessionUser.id}" 
                         alt="Photo de profil" class="profile-photo"
                         onerror="this.style.display='none'; document.getElementById('defaultAvatar').style.display='flex';">
                    <div id="defaultAvatar" class="default-avatar" style="display:none;">
                        ${sessionScope.sessionUser.email.charAt(0)}
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="default-avatar">
                        ${sessionScope.sessionUser.email.charAt(0)}
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="profile-info">
                <h2>Bienvenue <c:out value="${sessionScope.sessionUser.email}" /> !</h2>
                <p>Rôle: Manager </p>
            </div>
        </div>

        <div class="menu-grid">
            <a href="${pageContext.request.contextPath}/secured/reclamations" class="menu-card">
                <div class="menu-icon">📝</div>
                <h3>Gestion des Réclamations</h3>
                <p>Gérer vos réclamations et suivre leur statut</p>
            </a>

            <a href="${pageContext.request.contextPath}/secured/GetServicesPage" class="menu-card">
                <div class="menu-icon">📊</div>
                <h3>Gestion des Services</h3>
                <p>Gérer vos services proposés</p>

            <a href="#" class="menu-card">
                <div class="menu-icon">👥</div>
                <h3>Gestion des Clients</h3>
                <p>Voir la liste de vos clients</p>
            </a>

            <a href="${pageContext.request.contextPath}/JSP/secured/manager/statistiques.jsp" class="menu-card">
                <div class="menu-icon">📈</div>
                <h3>Tableau de Bord Statistiques</h3>
                <p>Consulter vos statistiques de performance</p>
            </a>
            <a href="${pageContext.request.contextPath}/manager/mes-demandes" class="menu-card">
        <div class="menu-icon">📋</div>
        <h3>Gestion des demandes</h3>
        <p>Consultez et gérez les demandes des clients.</p>
    </a>
        </div>
    </c:if>
</div>

<!-- Ajout de Font Awesome pour les icônes -->
<script src="https://kit.fontawesome.com/your-fontawesome-kit.js" crossorigin="anonymous"></script>
</body>
</html>