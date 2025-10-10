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
    <title>${categorie != null ? "Modifier" : "Ajouter"} une Catégorie</title>
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

    /* === Header Admin === */
    .admin-header {
        background: white;
        padding: 25px;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        margin-bottom: 25px;
        /* SUPPRIMÉ: border-top: 4px solid #9b59b6; */
    }

    .admin-header h1 {
        color: #2c3e50;
        margin-bottom: 5px;
        font-size: 1.8rem;
    }

    .admin-header p {
        color: #7f8c8d;
        margin: 0;
    }

    /* === Section de contenu === */
    .content-section {
        background: white;
        padding: 30px;
        border-radius: 15px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.08);
        margin-bottom: 20px;
        /* SUPPRIMÉ: border-top: 4px solid #9b59b6; */
    }

    /* === Grille de formulaire === */
    .form-grid {
        display: grid;
        gap: 25px;
        max-width: 600px;
        margin: 0 auto;
    }

    .form-card {
        background: white;
        padding: 25px;
        border-radius: 12px;
        border: 1px solid #ecf0f1;
        transition: all 0.3s ease;
    }

    .form-card:hover {
        background: white;
        /* SUPPRIMÉ: border-color: #9b59b6; */
        transform: translateY(-2px);
        box-shadow: 0 8px 20px rgba(0,0,0,0.1);
    }

    .form-group {
        margin-bottom: 0;
    }

    .form label { 
        display: block;
        margin-bottom: 10px;
        font-weight: 600;
        color: #2c3e50;
        font-size: 0.95em;
    }

    .form input, .form textarea {
        width: 100%;
        padding: 14px 16px;
        border: 2px solid #dcdfe6;
        border-radius: 10px;
        font-size: 0.95em;
        transition: all 0.3s ease;
        font-family: "Poppins", sans-serif;
        background: white;
        box-sizing: border-box;
    }

    .form input:focus, .form textarea:focus {
        outline: none;
        border-color: #3498db;
        box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1);
        transform: translateY(-1px);
    }

    .form textarea {
        resize: vertical;
        min-height: 120px;
        line-height: 1.5;
    }

    /* Placeholders stylisés */
    .form input::placeholder,
    .form textarea::placeholder {
        color: #aab7c4;
        font-weight: 400;
    }

    /* === Boutons === */
    .button-group {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
        margin-top: 30px;
        padding-top: 25px;
        border-top: 1px solid #ecf0f1;
        justify-content: flex-end;
    }

    .btn-save, .btn-cancel {
        padding: 14px 28px;
        border: none;
        border-radius: 10px;
        cursor: pointer;
        font-size: 0.95em;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: all 0.3s ease;
        font-weight: 600;
        text-align: center;
        min-width: 150px;
        gap: 8px;
    }

    .btn-save { 
        background: #3498db; 
        color: white; 
        border: 2px solid #2980b9;
    }
    .btn-save:hover { 
        background: #2980b9; 
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(52, 152, 219, 0.4);
    }

    .btn-cancel { 
        background: white; 
        color: #7f8c8d;
        border: 2px solid #bdc3c7;
    }
    .btn-cancel:hover {
        background: #f8f9fa;
        color: #5d6d7e;
        border-color: #95a5a6;
        transform: translateY(-3px);
        box-shadow: 0 8px 20px rgba(149, 165, 166, 0.3);
    }

    /* Indicateur de champ requis */
    .form label::after {
        content: " *";
        color: #e74c3c;
    }

    /* Animation de focus */
    @keyframes formFocus {
        0% { transform: scale(1); }
        50% { transform: scale(1.02); }
        100% { transform: scale(1); }
    }

    .form input:focus, .form textarea:focus {
        animation: formFocus 0.3s ease;
    }

    /* === États de validation === */
    .form input:valid, .form textarea:valid {
        border-color: #2ecc71;
        background: #f8fff8;
    }

    /* === Responsive === */
    @media (max-width: 768px) {
        .admin-main {
            margin-left: 70px;
            padding: 15px;
        }
        
        .content-section {
            padding: 20px;
        }
        
        .button-group {
            flex-direction: column;
            justify-content: stretch;
        }
        
        .btn-save, .btn-cancel {
            width: 100%;
            margin-right: 0;
        }
        
        .form-grid {
            max-width: 100%;
        }
        
        .form-card {
            padding: 20px;
        }
    }

    @media (max-width: 480px) {
        .admin-header {
            padding: 20px;
        }
        
        .admin-header h1 {
            font-size: 1.5rem;
        }
        
        .form input, .form textarea {
            padding: 12px 14px;
        }
        
        .btn-save, .btn-cancel {
            min-width: auto;
            padding: 12px 20px;
        }
    }
    </style>
</head>
<body>
<div class="admin-container">
    <jsp:include page="/JSP/secured/includes/admin-sidebar.jsp"/>

    <main class="admin-main">
        <div class="admin-header">
            <h1>${categorie != null ? "Modifier" : "Ajouter"} une Catégorie</h1>
            <p></p>
        </div>

        <div class="content-section">
            <div class="form-grid">
                <div class="form-card">
                    <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="form">
                        <input type="hidden" name="id" value="${categorie != null ? categorie.id : ''}">

                        <div class="form-group">
                            <label for="nom">Nom de la catégorie :</label>
                            <input type="text" id="nom" name="nom" value="${categorie != null ? categorie.nom : ''}" required placeholder="Ex: Électricité, Plomberie...">
                        </div>

                        <div class="form-group">
                            <label for="description">Description :</label>
                            <textarea id="description" name="description" rows="4" required placeholder="Décrivez cette catégorie de services...">${categorie != null ? categorie.description : ''}</textarea>
                        </div>

                        <div class="button-group">
                            <button type="submit" class="btn-save">💾 Enregistrer</button>
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn-cancel">❌ Annuler</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </main>
</div>
</body>
</html>