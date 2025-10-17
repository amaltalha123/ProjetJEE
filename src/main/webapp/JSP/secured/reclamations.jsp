<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Réclamations</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #6366f1;
            --success-color: #10b981;
            --error-color: #ef4444;
            --bg-light: #f3f4f6;
            --text-dark: #111827;
            --text-light: #6b7280;
        }

        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
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
            font-size: 2rem;
            color: var(--primary-color);
        }

        .header div {
            font-size: 0.95rem;
        }

        .header a {
            margin-left: 15px;
            color: var(--secondary-color);
            text-decoration: none;
            font-weight: 600;
        }

        .header a:hover {
            text-decoration: underline;
        }

        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            font-weight: 500;
        }

        .success {
            background-color: #d1fae5;
            color: var(--success-color);
        }

        .error {
            background-color: #fee2e2;
            color: var(--error-color);
        }

        .reclamation-form {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            margin-bottom: 40px;
            transition: transform 0.2s;
        }

        .reclamation-form:hover {
            transform: translateY(-3px);
        }

        .reclamation-form h3 {
            margin-bottom: 15px;
            color: var(--primary-color);
        }

        .reclamation-form textarea {
            width: 100%;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #d1d5db;
            font-size: 1rem;
            resize: vertical;
        }

        .reclamation-form button {
            margin-top: 15px;
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: background 0.3s;
        }

        .reclamation-form button:hover {
            background: var(--secondary-color);
        }

        .reclamation-list h3 {
            margin-bottom: 20px;
            color: var(--primary-color);
        }

        .reclamation-item {
            background: white;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            transition: transform 0.2s, box-shadow 0.2s;
        }

        .reclamation-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 25px rgba(0,0,0,0.1);
        }

        .reclamation-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            align-items: center;
        }

        .reclamation-user {
            font-weight: 600;
        }

        .reclamation-status {
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-resolved {
            background: #dbeafe;
            color: #1e3a8a;
        }

        .reclamation-content {
            font-size: 0.95rem;
            line-height: 1.6;
            color: var(--text-dark);
        }

        .reclamation-user-info {
            margin-top: 10px;
            font-size: 0.85rem;
            color: var(--text-light);
        }

        .nav-links {
            margin-top: 30px;
        }

        .nav-links a {
            display: inline-block;
            background: var(--primary-color);
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
        }

        .nav-links a:hover {
            background: var(--secondary-color);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Gestion des Réclamations</h1>
            <div>
                Bienvenue <strong>${sessionScope.sessionUser.email}</strong> !
                <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
            </div>
        </div>

        <c:if test="${not empty successMessage}">
            <div class="message success">${successMessage}</div>
        </c:if>

        <c:if test="${not empty errorMessage}">
            <div class="message error">${errorMessage}</div>
        </c:if>

        <c:if test="${param.success == 'created'}">
            <div class="message success">Réclamation créée avec succès !</div>
        </c:if>

        <div class="reclamation-form">
            <h3>Créer une nouvelle réclamation</h3>
            <form action="${pageContext.request.contextPath}/secured/reclamations" method="post">
                <input type="hidden" name="action" value="create">
                <textarea name="contenu" placeholder="Décrivez votre réclamation ici..." required></textarea>
                <br>
                <button type="submit">Soumettre</button>
            </form>
        </div>

        <div class="reclamation-list">
            <h3>
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
                <p>Aucune réclamation trouvée.</p>
            </c:if>

            <c:forEach var="reclamation" items="${reclamations}">
                <div class="reclamation-item">
                    <div class="reclamation-header">
                        <div class="reclamation-user">Réclamation #${reclamation.id}</div>
                        <div class="reclamation-status ${reclamation.etat ? 'status-resolved' : 'status-pending'}">
                            ${reclamation.etat ? 'Résolue' : 'En attente'}
                        </div>
                    </div>
                    <div class="reclamation-content">${reclamation.contenu}</div>
                    <c:if test="${sessionScope.sessionUser.role == 'ADMIN'}">
                        <div class="reclamation-user-info">
                            Déposée par: ${reclamation.utilisateur.nom} (${reclamation.utilisateur.email})
                        </div>
                    </c:if>
                </div>
            </c:forEach>
        </div>

        <div class="nav-links">
            <c:choose>
                <c:when test="${sessionScope.sessionUser.role == 'MANAGER'}">
                    <a href="${pageContext.request.contextPath}/JSP/secured/manager/dashboard.jsp">Retour au Dashboard</a>
                </c:when>
                <c:when test="${sessionScope.sessionUser.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">Retour au Dashboard Admin</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/JSP/secured/user/dashboard.jsp">Retour au Dashboard</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
