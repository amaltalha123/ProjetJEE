<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Demandes - MediNest</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- FullCalendar CSS -->
    <link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #667eea;
            --secondary-color: #764ba2;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --info-color: #3498db;
            --light-bg: #f8f9fa;
            --border-color: #dee2e6;
            --text-dark: #2c3e50;
        }

        /* --- Styles généraux (Restauration de la structure originale) --- */
        body { margin:0; display:flex; flex-direction:column; min-height:100vh; }
        .main { flex:1; display:flex; flex-direction:column; }
        .sidebar-column { flex:0 0 300px; } /* Largeur fixe pour la sidebar */
        .content-column { flex:1; display:flex; flex-direction:column; }

        /* --- Styles sidebar (Restauration du style original) --- */
        .sidebar { background-color:#f8f9fa; border-right:1px solid #dee2e6; display:flex; flex-direction:column; min-height:100%; }
        .sidebar nav { flex:1; display:flex; flex-direction:column; }
        .sidebar .nav-link { color:#495057; padding:15px 25px; font-size:1.05rem; text-decoration:none; transition:all 0.3s; }
        .sidebar .nav-link:hover, .sidebar .nav-link.active { background-color:#e9ecef; color:#0d6efd; border-right:4px solid #0d6efd; }
        .sidebar .nav-link i { margin-right:12px; width:22px; text-align:center; font-size:1.1rem; }
        .logout-container { margin-top: auto; } /* Pour pousser le lien de déconnexion en bas */

        /* --- Styles contenu principal --- */
        .main-content { padding:25px; flex:1; overflow-y:auto; background-color:#fff; }
        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-dark);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        /* --- Styles tableau harmonisés (Conservé du nouveau style) --- */
        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            margin-bottom: 30px;
        }

        .table {
            margin: 0;
            border: none;
        }

        .table thead th {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            border: none;
            padding: 16px;
            font-weight: 600;
            font-size: 0.95rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table tbody td {
            padding: 16px;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background-color: var(--light-bg);
            transform: scale(1.01);
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        /* --- Badges de statut (Conservé du nouveau style) --- */
        .badge {
            font-size: 0.8rem;
            padding: 6px 12px;
            border-radius: 20px;
            font-weight: 600;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .badge-warning { background-color: #fff3cd !important; color: #856404 !important; }
        .badge-info { background-color: #d1ecf1 !important; color: #0c5460 !important; }
        .badge-success { background-color: #d4edda !important; color: #155724 !important; }
        .badge-danger { background-color: #f8d7da !important; color: #721c24 !important; }
        .badge-secondary { background-color: #e9ecef !important; color: #495057 !important; }

        /* --- Boutons (Conservé du nouveau style) --- */
        .btn {
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-success {
            background: linear-gradient(135deg, var(--success-color) 0%, #20c997 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(39, 174, 96, 0.3);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(39, 174, 96, 0.4);
            color: white;
        }

        .btn-danger {
            background: linear-gradient(135deg, var(--danger-color) 0%, #c0392b 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.3);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.4);
            color: white;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.85rem;
        }

        .btn-group-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        /* --- Alertes (Conservé du nouveau style) --- */
        .alert {
            border-radius: 10px;
            border: none;
            padding: 16px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .alert-info {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .alert-link {
            color: #0c5460;
            font-weight: 600;
        }

        /* --- Calendrier (Conservé du nouveau style) --- */
        #calendar {
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(0, 0, 0, 0.08);
            padding: 20px;
            margin-top: 30px;
        }

        .fc {
            font-family: inherit;
        }

        .fc-button-primary {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }

        .fc-button-primary:hover {
            background-color: var(--secondary-color) !important;
            border-color: var(--secondary-color) !important;
        }

        .fc-button-primary.fc-button-active {
            background-color: var(--secondary-color) !important;
            border-color: var(--secondary-color) !important;
        }

        /* --- Responsive (Restauration de la structure originale + ajustements) --- */
        @media(max-width:991.98px){
            .sidebar-column{flex:none;}
            .table-responsive { border:1px solid #dee2e6; border-radius:8px; }
        }

        @media (max-width: 576px) {
            .page-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .table-responsive {
                font-size: 0.85rem;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }

            .btn-group-actions {
                flex-direction: column;
            }

            .btn-group-actions .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<main class="main">

    <div class="container-fluid" style="display:flex; flex:1;">
        <!-- Sidebar (Structure originale) -->
        <div class="col-lg-4 col-xl-3 sidebar-column">
            <div class="sidebar">
                <nav class="nav flex-column">
                    <a class="nav-link" href="#"><i class="fas fa-user-circle"></i> Profile</a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/manager/mes-demandes">
                        <i class="fas fa-envelope-open-text"></i> Mes Demandes
                    </a>
                    <a class="nav-link" href="#"><i class="fas fa-exclamation-triangle"></i> Réclamations</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/JSP/secured/manager/services.jsp"><i class="fas fa-concierge-bell"></i> Services</a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/JSP/secured/manager/statistiques.jsp"><i class="fas fa-chart-line"></i> Statistiques</a>
                    <div class="logout-container">
                        <a href="${pageContext.request.contextPath}/logout" class="nav-link"><i class="fas fa-sign-out-alt"></i> Déconnexion</a>
                    </div>
                </nav>
            </div>
        </div>

        <!-- Contenu principal -->
        <div class="col-lg-8 col-xl-9 content-column">
            <div class="main-content">

                <!-- En-tête de page -->
                <div class="d-flex justify-content-between align-items-center flex-wrap mb-4">
                    <h1 class="page-title">
                        <i class="bi bi-calendar-event"></i> Mes Demandes
                    </h1>
                    <a href="${pageContext.request.contextPath}/manager/addDemande" class="btn btn-primary">
                        <i class="bi bi-plus-circle"></i> Nouvelle Demande
                    </a>
                </div>

                <!-- Message si aucune demande -->
                <c:if test="${empty demandes}">
                    <div class="alert alert-info">
                        <i class="bi bi-info-circle"></i>
                        <div>
                            Aucune demande trouvée.
                            <a href="${pageContext.request.contextPath}/manager/addDemande" class="alert-link">Créer votre première demande</a>
                        </div>
                    </div>
                </c:if>

                <!-- Tableau des demandes -->
                <c:if test="${not empty demandes}">
                    <div class="table-container">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th><i class="bi bi-briefcase"></i> Service</th>
                                        <th><i class="bi bi-file-text"></i> Description</th>
                                        <th><i class="bi bi-calendar-check"></i> Date d'intervention</th>
                                        <th><i class="bi bi-flag"></i> Statut</th>
                                        <th><i class="bi bi-gear"></i> Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="d" items="${demandes}">
                                        <tr>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${d.service != null}">
                                                        <strong>${d.service.titre}</strong>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Service non trouvé</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${d.description}</td>
                                            <td>
                                                <fmt:formatDate value="${d.dateIntervention}" pattern="dd/MM/yyyy" />
                                            </td>
                                            <td>
                                                <span class="badge
                                                    <c:choose>
                                                        <c:when test="${d.statut == 'EN_ATTENTE'}">badge-warning</c:when>
                                                        <c:when test="${d.statut == 'EN_COURS'}">badge-info</c:when>
                                                        <c:when test="${d.statut == 'TERMINE'}">badge-success</c:when>
                                                        <c:when test="${d.statut == 'ANNULE'}">badge-danger</c:when>
                                                        <c:otherwise>badge-secondary</c:otherwise>
                                                    </c:choose>">
                                                    ${d.statut}
                                                </span>
                                            </td>
                                            <td>
                                                <div class="btn-group-actions">
                                                    <a href="${pageContext.request.contextPath}/manager/addDemande?id=${d.id}"
                                                       class="btn btn-primary btn-sm"
                                                       title="Modifier">
                                                        <i class="bi bi-pencil"></i> Modifier
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/manager/demandeAction?action=delete&id=${d.id}"
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette demande ?');"
                                                       title="Supprimer">
                                                        <i class="bi bi-trash"></i> Supprimer
                                                    </a>
                                                    <c:if test="${d.statut == 'EN_ATTENTE'}">
                                                        <a href="${pageContext.request.contextPath}/manager/demandeAction?action=confirm&id=${d.id}"
                                                           class="btn btn-success btn-sm"
                                                           title="Confirmer">
                                                            <i class="bi bi-check-circle"></i> Confirmer
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/manager/demandeAction?action=cancel&id=${d.id}"
                                                           class="btn btn-danger btn-sm"
                                                           title="Annuler">
                                                            <i class="bi bi-x-circle"></i> Annuler
                                                        </a>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>

                <!-- Calendrier -->
                <div id="calendar"></div>

            </div>
        </div>
    </div>
</main>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.7/index.global.min.js"></script>

<script>
    // Initialiser le calendrier
    document.addEventListener('DOMContentLoaded', function() {
        const calendarEl = document.getElementById('calendar');
        const calendar = new FullCalendar.Calendar(calendarEl, {
            initialView: 'dayGridMonth',
            locale: 'fr',
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            events: [
                <c:if test="${not empty demandes}">
                <c:forEach var="d" items="${demandes}">
                {
                    title: '${d.service != null ? d.service.titre : "Demande"}',
                    start: '<fmt:formatDate value="${d.dateIntervention}" pattern="yyyy-MM-dd" />',
                    color:
                        <c:choose>
                            <c:when test="${d.statut == 'EN_ATTENTE'}">'#f39c12'</c:when>
                            <c:when test="${d.statut == 'EN_COURS'}">'#3498db'</c:when>
                            <c:when test="${d.statut == 'TERMINE'}">'#27ae60'</c:when>
                            <c:when test="${d.statut == 'ANNULE'}">'#e74c3c'</c:when>
                            <c:otherwise>'#95a5a6'</c:otherwise>
                        </c:choose>
                },
                </c:forEach>
                </c:if>
            ],
            dateClick: function(info) {
                window.location.href = '${pageContext.request.contextPath}/manager/demandeAction?date=' + info.dateStr;
            }
        });
        calendar.render();
    });
</script>
</body>
</html>
