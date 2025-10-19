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
        --primary: #4f46e5;
        --secondary: #6366f1;
        --bg-light: #f3f4f6;
        --card-bg: #ffffff;
        --text-dark: #111827;
        --text-light: #6b7280;
    }

    body {
        font-family: 'Inter', sans-serif;
        margin: 0;
        background-color: var(--bg-light);
        color: var(--text-dark);
    }

    .container {
        max-width: 1200px;
        margin: 40px auto;
        padding: 20px;
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 30px;
    }

    .header h1 {
        color: var(--primary);
        font-size: 2rem;
    }

    .header a {
        color: var(--secondary);
        text-decoration: none;
        font-weight: 600;
        transition: color 0.3s;
    }

    .header a:hover {
        color: var(--primary);
    }

    .profile-section {
        display: flex;
        align-items: center;
        gap: 20px;
        margin-bottom: 40px;
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
        background-color: var(--primary);
        color: white;
    }

    .profile-photo {
        object-fit: cover;
        background-color: transparent;
    }

    .profile-section h2 {
        margin: 0;
        font-size: 1.5rem;
    }

    .profile-section p {
        margin: 5px 0 0 0;
        color: var(--text-light);
    }

    .menu-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 25px;
    }

    .menu-card {
        background: var(--card-bg);
        border-radius: 12px;
        padding: 25px;
        text-align: center;
        text-decoration: none;
        color: var(--text-dark);
        box-shadow: 0 6px 20px rgba(0,0,0,0.08);
        transition: transform 0.3s, box-shadow 0.3s, background 0.3s, color 0.3s;
    }

    .menu-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 25px rgba(0,0,0,0.15);
        background: var(--primary);
        color: white;
    }

    .menu-card h3 {
        margin-bottom: 10px;
        font-size: 1.2rem;
    }

    .menu-card p {
        font-size: 0.9rem;
        color: inherit;
        opacity: 0.8;
    }
</style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1>Dashboard Manager</h1>
        <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
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
            <div>
                <h2>Bienvenue <c:out value="${sessionScope.sessionUser.email}" /> !</h2>
                <p>Rôle: Manager</p>
            </div>
        </div>

        <div class="menu-grid">
            <a href="${pageContext.request.contextPath}/secured/reclamations" class="menu-card">
                <h3>📝 Réclamations</h3>
                <p>Gérer vos réclamations et suivre leur statut</p>
            </a>

            <a href="${pageContext.request.contextPath}/JSP/secured/manager/services.jsp" class="menu-card">
                <h3>📊 Services</h3>
                <p>Gérer vos services proposés</p>
            </a>

            <a href="#" class="menu-card">
                <h3>👥 Clients</h3>
                <p>Voir la liste de vos clients</p>
            </a>

            <a href="#" class="menu-card">
                <h3>📈 Statistiques</h3>
                <p>Consulter vos statistiques de performance</p>
            </a>
        </div>
    </c:if>
</div>
</body>
</html>
