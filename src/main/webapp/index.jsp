<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <title>Services Interventions</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="CSS/index.css">
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top shadow-sm">
  <div class="container">
    <a class="navbar-brand fw-bold" href="#hero">Services Interventions</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="#hero">Accueil</a></li>
        <li class="nav-item"><a class="nav-link" href="#services">Services</a></li>
        <li class="nav-item"><a class="nav-link" href="#about">À propos</a></li>
        <li class="nav-item"><a class="nav-link" href="#contact">Contact</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero Carousel -->
<section id="hero">
  <div id="heroCarousel" class="carousel slide carousel-fade" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="CSS/electricity.jpeg" class="d-block w-100" alt="Plomberie">
        <div class="carousel-caption d-flex flex-column justify-content-center h-100 text-white">
          <h1 class="display-4 fw-bold">Services de Plomberie</h1>
          <p class="lead">Interventions rapides et efficaces pour tous vos problèmes de plomberie.</p>
          <a href="/ProjetJEE/login" class="btn btn-light btn-lg mt-3">
  Réserver un service
</a>
        </div>
      </div>
      <!--<div class="carousel-item">
        <img src="CSS/electricity.jpeg" class="d-block w-100" alt="Électricité">
        <div class="carousel-caption d-flex flex-column justify-content-center h-100 text-white">
          <h1 class="display-4 fw-bold">Services d'Électricité</h1>
          <p class="lead">Électriciens qualifiés pour tous types d'interventions électriques.</p>
          <a href="#services" class="btn btn-light btn-lg mt-3">Découvrir</a>
        </div>
      </div> === -->
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
      <span class="carousel-control-prev-icon"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
      <span class="carousel-control-next-icon"></span>
    </button>
  </div>
</section>

<!-- À propos -->
<section id="about" class="py-5 text-center">
  <div class="container">
    <h2 class="fw-bold">À propos</h2>
    <p class="text-muted">
      Notre plateforme permet de réserver rapidement des interventions à domicile, telles que plomberie, électricité, nettoyage et plus. Elle propose différents types d'abonnements : l'abonnement mensuel offre un accès à tous les services pendant un mois avec interventions illimitées et support client prioritaire, tandis que l'abonnement annuel permet un accès à tous les services pendant douze mois avec interventions illimitées, support client prioritaire et une remise de 10 % par rapport au tarif mensuel.
    </p>
  </div>
</section>




<!-- Services -->
<section id="services" class="py-5 bg-light">
  <div class="container">
    <h2 class="fw-bold text-center mb-4">Nos Services</h2>
    <div class="row text-center g-4">
      <div class="col-md-3">
        <div class="card p-3 shadow-sm">
          <h5>Plomberie</h5>
          <p>Réparations et installations de plomberie rapides et fiables.</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card p-3 shadow-sm">
          <h5>Électricité</h5>
          <p>Interventions électriques sécurisées par des professionnels qualifiés.</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card p-3 shadow-sm">
          <h5>Nettoyage</h5>
          <p>Services de nettoyage à domicile ou en entreprise.</p>
        </div>
      </div>
      <div class="col-md-3">
        <div class="card p-3 shadow-sm">
          <h5>Autres Services</h5>
          <p>Peinture, bricolage et maintenance générale.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Contact -->
<section id="contact" class="py-5 bg-light">
  <div class="container">
    <h2 class="fw-bold text-center mb-4">Contact</h2>
    <form class="w-75 mx-auto">
      <div class="mb-3">
        <input type="text" class="form-control" placeholder="Nom"/>
      </div>
      <div class="mb-3">
        <input type="email" class="form-control" placeholder="Email"/>
      </div>
      <div class="mb-3">
        <textarea class="form-control" rows="4" placeholder="Votre message"></textarea>
      </div>
      <button type="submit" class="btn btn-dark w-100">Envoyer</button>
    </form>
  </div>
</section>

<!-- Footer --
