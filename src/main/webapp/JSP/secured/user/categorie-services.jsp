<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">

<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Services - MediNest</title>

  <!-- Favicons -->
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/img/favicon.png" rel="icon">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

  <!-- Fonts -->
  <link href="https://fonts.googleapis.com" rel="preconnect">
  <link href="https://fonts.gstatic.com" rel="preconnect" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Poppins:wght@300;400;500;600;700&family=Ubuntu:wght@300;400;500;700&display=swap" rel="stylesheet">

  <!-- Vendor CSS Files -->
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/aos/aos.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

  <!-- Main CSS File -->
  <link href="<%= request.getContextPath() %>/JSP/secured/assets/css/main.css" rel="stylesheet">

  <style>
    *{margin:0;padding:0;box-sizing:border-box}
    body{
      margin:0;height:100vh;
      display:flex;flex-direction:column;
      padding-top: 80px; 
    }
    .main{flex:1;display:flex;flex-direction:column}
    .page-title{flex-shrink:0}
    .breadcrumbs{
      margin:0;padding:10px 0;border-bottom:1px solid #dee2e6;
    }

    .services.section{flex:1;display:flex;flex-direction:column;margin:0;padding:0}
    .services-section-container{
      flex:1;display:flex;flex-direction:column;
      max-width:100%;margin:0;padding:0;
    }
    .no-gutters-row{flex:1;display:flex;margin:0}

    .sidebar-column{padding:0;display:flex;flex-direction:column}
    .sidebar{
      background:#f8f9fa;border-right:1px solid #dee2e6;
      flex:1;display:flex;flex-direction:column;min-height:100%;
    }
    .sidebar nav{flex:1;display:flex;flex-direction:column}
    .sidebar .nav-link{
      color:#495057;padding:15px 25px;border-radius:0;border:none;
      transition:.2s;margin:0;flex-shrink:0;font-size:1.05rem;
    }
    .sidebar .nav-link:hover,
    .sidebar .nav-link.active{
      background:#e9ecef;color:#0d6efd;border-right:4px solid #0d6efd;
    }
    .sidebar .nav-link i{
      margin-right:12px;width:22px;text-align:center;font-size:1.1rem;
    }

    .content-column{flex:1;display:flex;flex-direction:column;padding:0}
    .main-content{
      flex:1;overflow-y:auto;background:#fff;padding:25px;
    }

    .services-grid{margin:0}

    .service-card{
      height:100%;display:flex;flex-direction:column;
      background:#fff;border-radius:12px;
      padding:18px 18px 16px;
      box-shadow:0 8px 20px rgba(15,23,42,.08);
      border:1px solid rgba(226,232,240,.9);
    }
    .service-header{
      display:flex;align-items:center;justify-content:space-between;margin-bottom:12px;
    }
    .service-icon{
      width:44px;height:44px;border-radius:12px;
      background:linear-gradient(135deg,#667eea 0%,#0290d2 100%);
      display:flex;align-items:center;justify-content:center;
      color:#fff;font-size:1.4rem;
      box-shadow:0 8px 20px rgba(102,126,234,.4);
    }
    .service-category{
      font-size:.9rem;font-weight:600;padding:6px 10px;border-radius:999px;
      background:#eef2ff;color:#3730a3;
    }
    .service-body{flex:1}
    .service-body h4{font-size:1.1rem;font-weight:600;margin-bottom:6px}
    .service-body p{font-size:.95rem;color:#6b7280;margin-bottom:10px}
    .service-features{display:flex;flex-wrap:wrap;gap:6px}
    .feature-badge{
      display:inline-block;padding:4px 9px;border-radius:999px;
      background:#f3f4ff;color:#4f46e5;font-size:.8rem;font-weight:500;
    }
    .service-footer{margin-top:12px;display:flex;justify-content:flex-end}
    .service-btn{
      display:inline-flex;align-items:center;gap:6px;
      padding:8px 14px;border-radius:999px;
      border:1px solid #0d6efd;color:#0d6efd;
      font-size:.9rem;font-weight:500;text-decoration:none;
      transition:.2s;
    }
    .service-btn:hover{background:#0d6efd;color:#fff}

    .edit-section{
      margin-bottom:20px;padding:20px;background:#fff;
      border-radius:8px;border:1px solid #fff;
    }
    .edit-header{
      display:flex;justify-content:space-between;align-items:center;
      margin-bottom:10px;gap:20px;flex-wrap:wrap;
    }
    .edit-title{font-size:1.3rem;font-weight:600;color:#2c3e50;margin:0}
    .search-container{flex:1;min-width:260px;max-width:520px}
    .search-box{
      position:relative;display:flex;align-items:center;
      background:#fff;border:1px solid #ced4da;border-radius:6px;
      padding:0 15px;box-shadow:0 2px 5px rgba(0,0,0,.05);
      margin-bottom:8px;
    }
    .search-box:focus-within{
      border-color:#667eea;box-shadow:0 0 0 .2rem rgba(102,126,234,.25);
    }
    .search-icon{color:#6c757d;margin-right:10px;font-size:1rem}
    .search-input{
      border:none;outline:none;padding:12px 0;width:100%;
      font-size:1rem;background:transparent;
    }
    .clear-search{
      background:none;border:none;color:#6c757d;cursor:pointer;
      padding:5px;border-radius:50%;display:flex;align-items:center;justify-content:center;
      transition:.2s;
    }
    .clear-search:hover{background:#f8f9fa;color:#495057}

    .category-filter{width:100%}

    @media (max-width: 991.98px){
      .no-gutters-row{flex-direction:column}
      .sidebar{
        height:auto;border-right:none;border-bottom:1px solid #dee2e6;min-height:auto;
      }
      .sidebar-column{flex:none}
      .main-content{padding:20px;overflow-y:visible}
      .sidebar .nav-link{padding:12px 20px;font-size:1rem}
    }
    @media (min-width:992px){
      .sidebar-column{flex:0 0 300px}
      .content-column{flex:1}
    }
    @media (min-width:1200px){
      .sidebar-column{flex:0 0 350px}
    }
     .navbar {
  transition: all 0.3s ease;
}

.navbar-brand {
  font-size: 1.4rem;
  color: #0d6efd !important;
}

.navbar .nav-link {
  font-weight: 500;
  margin-left: 15px;
  transition: color 0.3s ease;
}

.navbar .nav-link:hover {
  color: #0d6efd;
}
/* ----------------------------- */
/* STYLE DU SELECT CATÉGORIE     */
/* ----------------------------- */

.category-filter-container {
  min-width: 230px;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}

/* Select stylé façon dashboard moderne */
.styled-select {
  appearance: none;
  -webkit-appearance: none;
  -moz-appearance: none;

  background-color: #ffffff;
  padding: 12px 40px 12px 16px;
  border-radius: 6px;
  border: 1px solid #ced4da;

  font-size: 1rem;
  font-weight: 500;
  color: #374151;

  cursor: pointer;
  transition: all 0.3s ease;
  outline: none;

  background-image: url("data:image/svg+xml;utf8,<svg width='14' height='10' xmlns='http://www.w3.org/2000/svg'><polyline points='1,1 7,9 13,1' stroke='%23667eea' stroke-width='2' fill='none' stroke-linecap='round'/></svg>");
  background-repeat: no-repeat;
  background-position: right 14px center;
}

/* Effet focus */
.styled-select:focus {
  border-color: #667eea;
  box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.25);
}

/* Effet hover */
.styled-select:hover {
  border-color: #667eea;
}

/* Option */
.styled-select option {
  font-size: 1rem;
  padding: 10px;
}

/* Adaptation responsive */
@media (max-width: 992px) {
  .category-filter-container {
    margin-top: 12px;
    width: 100%;
    justify-content: stretch;
  }
  
  .styled-select {
    width: 100%;
  }
}

  </style>
</head>

<body class="services-page">
<!-- Navbar --> 
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top shadow-sm">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#hero">Services Interventions</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link " href="${pageContext.request.contextPath}">Accueil</a></li>
                    <li class="nav-item"><a class="nav-link active" href="${pageContext.request.contextPath}/services">Services</a></li>
                    <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/secured/ClientReclamation">Reclamation</a></li>
                </ul>
            </div>
        </div>
    </nav>
<main class="main">


  <!-- Services Section -->
 <section id="services" class="services section">
  <div class="container-fluid services-section-container" data-aos="fade-up" data-aos-delay="100">
    <div class="row no-gutters-row">

      <!-- Contenu principal -->
      <div class="col-lg-8 col-xl-9 content-column">
        <div class="main-content">

          <!-- Barre de recherche (à gauche) + filtre catégorie (à droite) -->
          <div class="edit-section" data-aos="fade-up">
            <div class="edit-header">

              <!-- 🔹 À GAUCHE : barre de recherche uniquement -->
              <div class="search-container" style="flex:1;">
                <div class="search-box">
                  <i class="fas fa-search search-icon"></i>
                  <input type="text"
                         id="serviceSearch"
                         class="search-input"
                         placeholder="Rechercher un service par titre ou description...">
                  <button type="button" class="clear-search" id="clearSearchBtn" style="display:none;">
                    <i class="fas fa-times"></i>
                  </button>
                </div>
              </div>

              <!-- 🔹 À DROITE : filtre par catégorie uniquement -->
              <div>
                <select id="categoryFilter" class="form-select category-filter">
                  <option value="">Toutes les catégories</option>
                  <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">
                      <c:out value="${cat.nom}"/>
                    </option>
                  </c:forEach>
                </select>
              </div>

            </div>
          </div>

          <!-- Grille des services -->
          <div class="services-grid">
            <div class="row g-4" id="servicesRow">

              <c:if test="${empty services}">
                <p>Aucun service enregistré pour le moment.</p>
              </c:if>

              <c:forEach var="s" items="${services}">
                <div class="col-lg-4 col-md-6 service-item"
                     data-category-id="${s.categorie != null ? s.categorie.id : ''}">
                  <div class="service-card primary-care">
                    <div class="service-header">
                      <div class="service-icon">
                        <i class="fas fa-tools"></i>

                      </div>
                      <span class="service-category">
                        <c:out value="${s.categorie != null ? s.categorie.nom : 'Sans catégorie'}"/>
                      </span>
                    </div>
                    <div class="service-body">
                      <h4><c:out value="${s.titre}"/></h4>
                      <p><c:out value="${s.description}"/></p>

                      <div class="service-features">
                        <!-- On affiche au max 3 fonctionnalités -->
                        <c:forEach var="f" items="${s.fonctionnalites}" varStatus="st">
                          <c:if test="${st.index < 3}">
                            <span class="feature-badge">
                              <c:out value="${f.description}"/>
                            </span>
                          </c:if>
                        </c:forEach>
                      </div>
                    </div>
                  <div class="service-footer">
                        <a href="http://localhost:8082/ProjetJEE/ServiceDetailsClientServlet?id=${s.id}" class="service-btn">
                           Voir details du service
                          <i class="fas fa-arrow-right"></i>
                        </a>
                      </div>
                  </div>
                </div>
              </c:forEach>

            </div>
          </div>

        </div>
      </div>

    </div>
  </div>
</section>
 
</main>

<!-- Scroll Top -->
<a href="#" id="scroll-top" class="scroll-top d-flex align-items-center justify-content-center">
  <i class="bi bi-arrow-up-short"></i>
</a>

<div id="preloader"></div>

<!-- Vendor JS -->
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/aos/aos.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/purecounter/purecounter_vanilla.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/imagesloaded/imagesloaded.pkgd.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/vendor/swiper/swiper-bundle.min.js"></script>
<script src="<%= request.getContextPath() %>/JSP/secured/assets/js/main.js"></script>

<!-- JS : recherche + filtre catégorie -->
<script>
document.addEventListener("DOMContentLoaded", function() {
  const searchInput    = document.getElementById('serviceSearch');
  const clearSearchBtn = document.getElementById('clearSearchBtn');
  const categoryFilter = document.getElementById('categoryFilter');
  const cards          = document.querySelectorAll('.service-item');

  function applyFilters() {
    const term  = (searchInput.value || '').toLowerCase().trim();
    const catId = categoryFilter.value;

    cards.forEach(card => {
      const titleEl = card.querySelector('h4');
      const descEl  = card.querySelector('p');

      const title = titleEl ? titleEl.textContent.toLowerCase() : '';
      const desc  = descEl ? descEl.textContent.toLowerCase() : '';
      const cardCatId = card.getAttribute('data-category-id');

      const matchText = !term || title.includes(term) || desc.includes(term);
      const matchCat  = !catId || cardCatId === catId;

      card.style.display = (matchText && matchCat) ? 'block' : 'none';
    });
  }

  searchInput.addEventListener('input', function() {
    clearSearchBtn.style.display = this.value.trim() ? 'flex' : 'none';
    applyFilters();
  });

  clearSearchBtn.addEventListener('click', function() {
    searchInput.value = '';
    this.style.display = 'none';
    applyFilters();
  });

  categoryFilter.addEventListener('change', applyFilters);
});
</script>

</body>
</html>
