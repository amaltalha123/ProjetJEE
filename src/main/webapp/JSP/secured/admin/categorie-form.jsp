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
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${categorie != null ? "Modifier" : "Ajouter"} une Catégorie</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/admin.css">
    
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2c3e50;
            --success-color: #2ecc71;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #17a2b8;
        }

        body {
            font-family: "Poppins", "Segoe UI", Roboto, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
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
            transition: all 0.3s ease;
        }

        /* Sidebar Styles */
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
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
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
            color: var(--danger-color) !important;
        }

        .logout-link:hover {
            background: rgba(231, 76, 60, 0.1) !important;
        }

        /* Header Styles */
        .admin-header {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            margin-bottom: 25px;
            border-left: 5px solid var(--primary-color);
            transition: all 0.3s ease;
        }

        .admin-header:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.12);
        }

        .admin-header h1 {
            color: var(--secondary-color);
            margin-bottom: 5px;
            font-size: 1.8rem;
            font-weight: 700;
        }

        .admin-header p {
            color: #7f8c8d;
            margin: 0;
        }

        /* Content Section */
        .content-section {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 6px 18px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border-left: 5px solid var(--primary-color);
        }

        .content-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 25px rgba(0,0,0,0.12);
        }

        /* Form Styles */
        .form-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            border: 1px solid #ecf0f1;
            transition: all 0.3s ease;
        }

        .form-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: var(--secondary-color);
            margin-bottom: 10px;
            display: block;
        }

        .form-control {
            padding: 14px 16px;
            border: 2px solid #dcdfe6;
            border-radius: 10px;
            font-size: 0.95em;
            transition: all 0.3s ease;
            font-family: "Poppins", sans-serif;
            background: white;
        }

        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }

        .form-control::placeholder {
            color: #aab7c4;
            font-weight: 400;
        }

        /* Button Styles */
        .btn-save {
            background: linear-gradient(135deg, var(--success-color) 0%, #27ae60 100%);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 14px 28px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(46, 204, 113, 0.3);
        }

        .btn-save:hover {
            background: linear-gradient(135deg, #27ae60 0%, #219653 100%);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(46, 204, 113, 0.4);
            color: white;
        }

        .btn-save:active {
            transform: translateY(-1px);
        }

        .btn-cancel {
            background: linear-gradient(135deg, #ffffff 0%, #f8f9fa 100%);
            color: #7f8c8d;
            border: 2px solid #bdc3c7;
            border-radius: 10px;
            padding: 14px 28px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
        }

        .btn-cancel:hover {
            background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
            color: #5d6d7e;
            border-color: #95a5a6;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(149, 165, 166, 0.3);
        }

        .btn-cancel:active {
            transform: translateY(-1px);
        }

        /* Animation for form elements */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-card {
            animation: fadeInUp 0.5s ease;
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .admin-main {
                margin-left: 0;
                padding: 15px;
            }
            
            .admin-sidebar {
                width: 70px;
                overflow: hidden;
            }
            
            .sidebar-header h3, 
            .sidebar-menu li a span {
                display: none;
            }
            
            .sidebar-menu li a {
                justify-content: center;
                padding: 15px;
            }
            
            .sidebar-menu li a i {
                margin-right: 0;
                font-size: 1.2rem;
            }
            
            .content-section {
                padding: 20px;
            }
            
            .button-group {
                flex-direction: column;
            }
            
            .btn-save, .btn-cancel {
                width: 100%;
                margin-bottom: 10px;
            }
        }

        @media (max-width: 480px) {
            .admin-header {
                padding: 20px;
            }
            
            .admin-header h1 {
                font-size: 1.5rem;
            }
            
            .form-control {
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
            <p class="mb-0">Gérez les catégories de services proposés</p>
        </div>

        <div class="content-section">
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="form-card">
                        <form action="${pageContext.request.contextPath}/admin/categories" method="post" class="form">
                            <input type="hidden" name="id" value="${categorie != null ? categorie.id : ''}">

                            <div class="form-group">
                                <label for="nom" class="form-label">Nom de la catégorie :</label>
                                <input type="text" id="nom" name="nom" class="form-control" 
                                       value="${categorie != null ? categorie.nom : ''}" required 
                                       placeholder="Ex: Électricité, Plomberie...">
                            </div>

                            <div class="form-group">
                                <label for="description" class="form-label">Description :</label>
                                <textarea id="description" name="description" class="form-control" rows="4" required 
                                          placeholder="Décrivez cette catégorie de services...">${categorie != null ? categorie.description : ''}</textarea>
                            </div>

                            <div class="d-flex justify-content-end gap-3 mt-4 pt-3 border-top">
                                <button type="submit" class="btn btn-save">
                                    <i class="bi bi-check-circle me-2"></i>Enregistrer
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-cancel">
                                    <i class="bi bi-x-circle me-2"></i>Annuler
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JS for animations -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Add animation to form elements on focus
        const formControls = document.querySelectorAll('.form-control');
        formControls.forEach(control => {
            control.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });
            
            control.addEventListener('blur', function() {
                if (this.value === '') {
                    this.parentElement.classList.remove('focused');
                }
            });
        });
        
        // Add loading animation to submit button
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function() {
                const submitBtn = this.querySelector('button[type="submit"]');
                if (submitBtn) {
                    submitBtn.innerHTML = '<i class="bi bi-arrow-repeat spinner me-2"></i>Enregistrement...';
                    submitBtn.disabled = true;
                }
            });
        }
    });
</script>
</body>
</html>