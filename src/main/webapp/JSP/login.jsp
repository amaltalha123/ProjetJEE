<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <form action="${pageContext.request.contextPath}/login" method="post">
  Email: <input name="email" type="email" required/><br/>
  Mot de passe: <input name="password" type="password" required/><br/>
  <button type="submit">Se connecter</button>
  <c:if test="${not empty error}">
    <p style="color:red">${error}</p>
  </c:if>
</form>
  
</body>
</html>