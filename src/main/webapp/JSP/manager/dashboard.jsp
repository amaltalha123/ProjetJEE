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
  </c:when>
  <c:otherwise>
    <c:redirect url="${pageContext.request.contextPath}/JSP/login.jsp"/>
  </c:otherwise>
</c:choose>
</body>
</html>
