<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Authentification</title>
  <link rel="stylesheet" href="CSS/style.css">
</head>
<body>
  <div class="login-wrap">
    <div class="login-html">
    
      <!-- Onglets -->
      <input id="tab-1" type="radio" name="tab" class="sign-in" checked>
      <label for="tab-1" class="tab">Sign In</label>
      <input id="tab-2" type="radio" name="tab" class="sign-up">
      <label for="tab-2" class="tab">Sign Up</label>

      <!-- Formulaires -->
      <div class="login-form">
      
        <!-- Connexion -->
        <div class="sign-in-htm">
          <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="group">
              <label class="label">Email</label>
              <input name="email" type="email" class="input" required>
            </div>
            <div class="group">
              <label class="label">Password</label>
              <input name="password" type="password" class="input" required>
            </div>
            <div class="group">
              <button type="submit" class="button">Se connecter</button>
            </div>
            <c:if test="${not empty error}">
              <p style="color:red">${error}</p>
            </c:if>
          </form>
        </div>
        
        <!-- Inscription -->
        <div class="sign-up-htm">
          <form action="UserServlet" method="post" enctype="multipart/form-data">
            <div class="group">
              <label class="label">Nom</label>
              <input name="nom" type="text" class="input" required>
            </div>
            <div class="group">
              <label class="label">Email</label>
              <input name="email" type="email" class="input" required>
            </div>
            <div class="group">
              <label class="label">Password</label>
              <input name="password" type="password" class="input" required>
            </div>
            <div class="group">
              <label class="label">Rôle</label>
              <select name="role" id="roleSelect" class="input" required>
                <option value="">-- Sélectionner Rôle --</option>
                <option value="MANAGER">Manager</option>
                <option value="CLIENT">Client</option>
              </select>
            </div>
            <div class="group" id="telephoneField" style="display:none;">
              <label class="label">Téléphone</label>
              <input name="telephone" type="text" class="input">
            </div>
            <div class="group" id="abonnementField" style="display:none;">
              <label class="label">Abonnement</label>
              <select name="abonnement" class="input">
                <option value="">-- Sélectionner --</option>
                <option value="mensuel">Mensuel</option>
                <option value="annuel">Annuel</option>
              </select>
            </div>
            <div class="group">
              <label class="label">Photo</label>
              <input type="file" name="photo" accept="image/*">
            </div>
            <div class="group">
              <button type="submit" class="button">S’inscrire</button>
            </div>
            <c:if test="${not empty message}">
              <p>${message}</p>
            </c:if>
          </form>
        </div>
        
      </div>
    </div>
  </div>

  <script src="JS/userForm.js"></script>
</body>
</html>
