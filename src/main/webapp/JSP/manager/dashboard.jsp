<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard Manager</title>
</head>
<body>
<c:choose>
  <c:when test="${not empty sessionScope.sessionUser}">
    Bienvenue <c:out value="${sessionScope.sessionUser.email}" /> !
    <a href="${pageContext.request.contextPath}/logout">Se déconnecter</a>
    
    <br>
    <c:if test="${not empty sessionScope.sessionUser.photoProfile}">
        <img src="${pageContext.request.contextPath}${sessionScope.sessionUser.photoProfile}" 
             alt="Photo de profil" width="100" height="100"/>
    </c:if>
  </c:when>

  <c:otherwise>
    <c:redirect url="${pageContext.request.contextPath}/JSP/login.jsp"/>
  </c:otherwise>
</c:choose>

</body>
</html>
