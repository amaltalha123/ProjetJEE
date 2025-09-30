<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajouter Utilisateur</title>
</head>
<body>
    <form action="UserServlet" method="post">
        <label>Email: 
            <input type="email" name="email" required />
        </label><br>

        <label>Password: 
            <input type="password" name="password" required />
        </label><br>

        <label>Telephone: 
            <input type="text" name="telephone" required />
        </label><br>
        <label>Rôle:
            <select name="role" required>
                <option value="ADMIN">Admin</option>
                <option value="MANAGER">Manager</option>
                <option value="CLIENT">Client</option>
            </select>
        </label><br><br>
        <label>Abonnement:
            <select name="abonnement" required>
                <option value="mensuel">mentuel</option>
                <option value="annuel">annuel</option>
                
            </select>
        </label><br><br>

        <button type="submit">Ajouter</button>
    </form>

    <c:if test="${not empty message}">
        <p>${message}</p>
    </c:if>
</body>
</html>
