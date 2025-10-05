<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String currentPage = request.getRequestURI();
    String activePage = "";

    if (currentPage.contains("dashboard")) {
        activePage = "dashboard";
    } else if (currentPage.contains("categories")) {
        activePage = "categories";
    } else if (currentPage.contains("reclamations")) {
        activePage = "reclamations";
    }
%>

<div class="admin-sidebar" style="display:flex; flex-direction:column; height:100vh;">
    <div class="sidebar-header">
        <h3>Admin Dashboard</h3>
    </div>
    <ul class="sidebar-menu" style="flex:1; display:flex; flex-direction:column;">
        <li class="<%= "dashboard".equals(activePage) ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/admin/dashboard">
                <span>Tableau de Bord</span>
            </a>
        </li>
        <li class="<%= "categories".equals(activePage) ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/admin/categories">
                <span>Catégories</span>
            </a>
        </li>
        <li class="<%= "reclamations".equals(activePage) ? "active" : "" %>">
            <a href="${pageContext.request.contextPath}/admin/reclamations">
                <span>Réclamations</span>
            </a>
        </li>

        <!-- Logout au pied -->
        <li style="margin-top:auto;">
            <a href="${pageContext.request.contextPath}/logout" class="logout-link">
                <span>Déconnexion</span>
            </a>
        </li>
    </ul>
</div>
