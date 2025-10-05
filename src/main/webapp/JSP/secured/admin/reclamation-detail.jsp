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
</head>
<body>
    <div class="admin-container">
        <jsp:include page="/JSP/secured/includes/admin-sidebar.jsp"/>
        
        <main class="admin-main">
            <div class="admin-header">
                <a href="${pageContext.request.contextPath}/admin/reclamations" style="color: #3498db; text-decoration: none;">← Retour</a>
                <h1>Détail de la Réclamation</h1>
            </div>
            
            <div class="content-section">
                <div style="background: white; padding: 20px; border-radius: 8px;">
                    <div style="border-bottom: 1px solid #eee; padding-bottom: 15px; margin-bottom: 15px;">
                        <h2>Réclamation #${reclamation.id}</h2>
                        <p><strong>De:</strong> 
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
                    
                    <div style="margin-bottom: 20px;">
                        <h3>Message:</h3>
                        <div style="background: #f9f9f9; padding: 15px; border-radius: 4px; border-left: 4px solid #3498db; white-space: pre-wrap;">
                            ${reclamation.contenu}
                        </div>
                    </div>
                    
                    <div>
                        <a href="${pageContext.request.contextPath}/admin/reclamations" style="color: #3498db; text-decoration: none;">
                            ← Retour à la liste
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>