<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EduManager - Gestion des Inscriptions Pédagogiques</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            margin: 0;
            padding: 0;
            background: #f5f6fa;
        }
        .navbar {
            background-color: #fff;
            padding: 15px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 999;
        }
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .nav-brand {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: 600;
            color: #4b2995;
        }
        .nav-brand i {
            margin-right: 10px;
        }
        .nav-links {
            display: flex;
            align-items: center;
        }
        .nav-link {
            margin: 0 15px;
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }
        .nav-link:hover {
            color: #4b2995;
        }
        .auth-buttons .btn {
            margin-left: 10px;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn-outline {
            border: 1px solid #4b2995;
            color: #4b2995;
            background: transparent;
        }
        .btn-outline:hover {
            background: #4b2995;
            color: #fff;
        }
        .btn-primary {
            background: #4b2995;
            color: #fff;
            border: none;
        }
        .btn-primary:hover {
            background: #38216b;
        }
        .hero {
            position: relative;
            padding: 60px 20px;
            text-align: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
        }
        .hero-content {
            max-width: 1200px;
            margin: 0 auto;
        }
        .hero-title {
            font-size: 48px;
            font-weight: 700;
        }
        .highlight {
            color: #ffd700;
        }
        .hero-subtitle {
            font-size: 20px;
            margin: 20px 0;
        }
        .hero-buttons .btn {
            margin: 10px;
            padding: 12px 24px;
            font-size: 16px;
        }
        .hero-image {
            margin-top: 30px;
        }
        .floating-card {
            display: inline-block;
            margin: 10px;
            padding: 20px;
            background: #fff;
            color: #4b2995;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .modal-content {
            background-color: #fff;
            padding: 20px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
            width: 90%;
            max-width: 350px;
            animation: fadeInUp 0.8s ease forwards;
        }
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .modal-header h2 {
            font-size: 22px;
            font-weight: 700;
            color: #4b2995;
            margin: 0;
        }
        .modal-header .close {
            cursor: pointer;
            font-size: 24px;
            color: #333;
            line-height: 1;
            transition: color 0.3s ease;
        }
        .modal-header .close:hover {
            color: #4b2995;
        }
        .logo {
            display: block;
            margin: 0 auto 20px;
            width: 80px;
            height: 80px;
            background: url('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Logo_UASZ.png/600px-Logo_UASZ.png') no-repeat center/contain;
            border-radius: 50%;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: 600;
            color: #4b2995;
            font-size: 14px;
        }
        .form-group input, .form-group select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .form-actions {
            margin-top: 20px;
        }
        .btn-full {
            width: 100%;
            padding: 10px;
            background: #4b2995;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn-full:hover {
            background: #38216b;
        }
        .modal-footer {
            margin-top: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }
        .modal-footer .text-link {
            text-decoration: none;
            color: #4b2995;
            font-size: 14px;
            font-weight: 500;
            transition: color 0.3s ease;
        }
        .modal-footer .text-link:hover {
            color: #38216b;
            text-decoration: underline;
        }
        .modal-footer .separator {
            color: #666;
            font-size: 14px;
        }
        body.modal-open .hero {
            filter: blur(2px);
        }
        body.modal-open {
            overflow: hidden;
        }
        .modal-body {
            padding: 0 10px;
        }
        .alert {
            font-size: 14px;
            margin-top: 15px;
        }
        .features {
            padding: 60px 20px;
            background: #fff;
        }
        .section-header {
            text-align: center;
            margin-bottom: 40px;
        }
        .section-header h2 {
            font-size: 32px;
            font-weight: 700;
            color: #4b2995;
        }
        .section-header p {
            font-size: 18px;
            color: #666;
        }
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .feature-card {
            background: #f5f6fa;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .feature-icon {
            font-size: 40px;
            color: #4b2995;
            margin-bottom: 15px;
        }
        .feature-card h3 {
            font-size: 20px;
            font-weight: 600;
            color: #333;
        }
        .feature-card p {
            font-size: 14px;
            color: #666;
        }
        .feature-card ul {
            list-style: none;
            padding: 0;
            font-size: 14px;
            color: #666;
        }
        .stats {
            padding: 40px 20px;
            background: #f5f6fa;
            text-align: center;
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .stat-item {
            padding: 20px;
        }
        .stat-number {
            font-size: 36px;
            font-weight: 700;
            color: #4b2995;
        }
        .stat-label {
            font-size: 16px;
            color: #666;
        }
        .cta {
            padding: 60px 20px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #fff;
            text-align: center;
        }
        .cta-content h2 {
            font-size: 32px;
            font-weight: 700;
        }
        .cta-content p {
            font-size: 18px;
            margin: 20px 0;
        }
        .cta-buttons .btn {
            margin: 10px;
            padding: 12px 24px;
        }
        .footer {
            padding: 40px 20px;
            background: #333;
            color: #fff;
        }
        .footer-content {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        .footer-brand {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: 600;
        }
        .footer-brand i {
            margin-right: 10px;
        }
        .footer-section h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        .footer-section ul {
            list-style: none;
            padding: 0;
        }
        .footer-section ul li {
            margin-bottom: 10px;
        }
        .footer-section ul li a {
            color: #ccc;
            text-decoration: none;
        }
        .footer-section ul li a:hover {
            color: #fff;
        }
        .footer-bottom {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="nav-container">
        <div class="nav-brand">
            <i class="fas fa-graduation-cap"></i>
            <span>EduManager</span>
        </div>
        <div class="nav-links">
            <a href="#features" class="nav-link">Fonctionnalités</a>
            <a href="#about" class="nav-link">À propos</a>
            <a href="#contact" class="nav-link">Contact</a>
            <div class="auth-buttons">
                <button class="btn btn-outline" onclick="openLoginModal('etudiant')">
                    <i class="fas fa-user-graduate"></i>
                    Étudiant
                </button>
                <button class="btn btn-primary" onclick="openLoginModal('responsable')">
                    <i class="fas fa-user-tie"></i>
                    Responsable
                </button>
            </div>
        </div>
    </div>
</nav>

<section class="hero">
    <div class="hero-content">
        <div class="hero-text">
            <h1 class="hero-title">
                Simplifiez vos
                <span class="highlight">Inscriptions Pédagogiques</span>
            </h1>
            <p class="hero-subtitle">
                Une plateforme moderne et intuitive pour gérer efficacement
                les inscriptions, les formations et les groupes d'étudiants.
            </p>
            <div class="hero-buttons">
                <button class="btn btn-primary btn-large" onclick="openLoginModal('etudiant')">
                    <i class="fas fa-rocket"></i>
                    Commencer maintenant
                </button>
                <button class="btn btn-outline btn-large">
                    <i class="fas fa-play"></i>
                    Voir la démo
                </button>
            </div>
        </div>
        <div class="hero-image">
            <div class="floating-card card-1">
                <i class="fas fa-book-open"></i>
                <span>Formations</span>
            </div>
            <div class="floating-card card-2">
                <i class="fas fa-users"></i>
                <span>Groupes</span>
            </div>
            <div class="floating-card card-3">
                <i class="fas fa-chart-line"></i>
                <span>Statistiques</span>
            </div>
        </div>
    </div>
</section>

<section id="features" class="features">
    <div class="container">
        <div class="section-header">
            <h2>Fonctionnalités Principales</h2>
            <p>Découvrez les outils qui facilitent la gestion pédagogique</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-user-graduate"></i>
                </div>
                <h3>Inscription Étudiante</h3>
                <p>Interface intuitive pour que les étudiants puissent s'inscrire facilement et choisir leurs UEs optionnelles.</p>
                <ul>
                    <li>Sélection des UEs</li>
                    <li>Visualisation des groupes</li>
                    <li>Notifications par email</li>
                </ul>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-cogs"></i>
                </div>
                <h3>Gestion des Formations</h3>
                <p>Outils complets pour créer, modifier et gérer les formations et leurs unités d'enseignement.</p>
                <ul>
                    <li>Création de formations</li>
                    <li>Gestion des UEs</li>
                    <li>Configuration des groupes</li>
                </ul>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3>Répartition Automatique</h3>
                <p>Système intelligent de répartition des étudiants dans les groupes de TD et TP.</p>
                <ul>
                    <li>Répartition équilibrée</li>
                    <li>Gestion des capacités</li>
                    <li>Ajustements manuels</li>
                </ul>
            </div>
            <div class="feature-card">
                <div class="feature-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h3>Rapports & Exports</h3>
                <p>Génération de rapports détaillés et exports en différents formats pour le suivi.</p>
                <ul>
                    <li>Listes d'étudiants</li>
                    <li>Export PDF/CSV</li>
                    <li>Statistiques avancées</li>
                </ul>
            </div>
        </div>
    </div>
</section>

<section class="stats">
    <div class="container">
        <div class="stats-grid">
            <div class="stat-item">
                <div class="stat-number">500+</div>
                <div class="stat-label">Étudiants inscrits</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">25+</div>
                <div class="stat-label">Formations actives</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">150+</div>
                <div class="stat-label">UEs disponibles</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">98%</div>
                <div class="stat-label">Satisfaction utilisateurs</div>
            </div>
        </div>
    </div>
</section>

<section class="cta">
    <div class="container">
        <div class="cta-content">
            <h2>Prêt à commencer ?</h2>
            <p>Rejoignez des milliers d'étudiants et d'enseignants qui utilisent déjà EduManager</p>
            <div class="cta-buttons">
                <button class="btn btn-primary btn-large" onclick="openLoginModal('etudiant')">
                    <i class="fas fa-user-graduate"></i>
                    Connexion Étudiant
                </button>
                <button class="btn btn-outline btn-large" onclick="openLoginModal('responsable')">
                    <i class="fas fa-user-tie"></i>
                    Connexion Responsable
                </button>
            </div>
        </div>
    </div>
</section>

<footer class="footer">
    <div class="container">
        <div class="footer-content">
            <div class="footer-section">
                <div class="footer-brand">
                    <i class="fas fa-graduation-cap"></i>
                    <span>EduManager</span>
                </div>
                <p>Plateforme de gestion des inscriptions pédagogiques moderne et efficace.</p>
            </div>
            <div class="footer-section">
                <h4>Liens rapides</h4>
                <ul>
                    <li><a href="#features">Fonctionnalités</a></li>
                    <li><a href="#about">À propos</a></li>
                    <li><a href="#contact">Contact</a></li>
                    <li><a href="#">Support</a></li>
                </ul>
            </div>
            <div class="footer-section">
                <h4>Contact</h4>
                <ul>
                    <li><i class="fas fa-envelope"></i> contact@edumanager.fr</li>
                    <li><i class="fas fa-phone"></i> +33 1 23 45 67 89</li>
                    <li><i class="fas fa-map-marker-alt"></i> Campus Universitaire</li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
            <p>© 2025 EduManager. Tous droits réservés.</p>
        </div>
    </div>
</footer>

<!-- Login Modal -->
<div id="loginModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2 id="loginModalTitle">Connexion</h2>
            <span class="close" onclick="closeModal('loginModal')">×</span>
        </div>
        <div class="modal-body">
            <div class="logo"></div>
            <c:if test="${not empty error}">
                <div class="alert alert-danger text-center" role="alert">
                    ${error}
                </div>
            </c:if>
            <form id="loginForm" action="" method="post" novalidate>
                <input type="hidden" id="userType" name="userType" value="">
                <div class="form-group">
                    <label for="email">Adresse Email :</label>
                    <input type="email" class="form-control" id="email" name="email" placeholder="exemple@exemple.com" required autofocus>
                </div>
                <div class="form-group">
                    <label for="password">Mot de passe :</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Votre mot de passe" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary btn-full">
                        <i class="fas fa-sign-in-alt"></i>
                        Se connecter
                    </button>
                </div>
            </form>
            <div class="modal-footer">
                <a href="#" class="text-link" onclick="openModal('inscriptionModal')">S'inscrire</a>
                <span class="separator">|</span>
                <a href="forgot-password.jsp" class="text-link">Mot de passe oublié ?</a>
            </div>
        </div>
    </div>
</div>

<!-- Inscription Modal -->
<div id="inscriptionModal" class="modal">
    <div class="modal-content">
        <div class="modal-header">
            <h2>Inscription Étudiant</h2>
            <span class="close" onclick="closeModal('inscriptionModal')">×</span>
        </div>
        <div class="modal-body">
            <div class="logo"></div>
            <c:if test="${not empty message}">
                <div class="alert alert-success text-center" role="alert">
                    ${message}
                </div>
            </c:if>
            <form action="InscriptionServlet" method="post" novalidate>
                <div class="form-group">
                    <label for="ine" class="form-label">INE :</label>
                    <input type="text" class="form-control" id="ine" name="ine" placeholder="Numéro INE" required>
                </div>
                <div class="form-group">
                    <label for="prenom" class="form-label">Prénom :</label>
                    <input type="text" class="form-control" id="prenom" name="prenom" placeholder="Votre prénom" required>
                </div>
                <div class="form-group">
                    <label for="nom" class="form-label">Nom :</label>
                    <input type="text" class="form-control" id="nom" name="nom" placeholder="Votre nom" required>
                </div>
                <div class="form-group">
                    <label for="emailInscription" class="form-label">Email :</label>
                    <input type="email" class="form-control" id="emailInscription" name="email" placeholder="exemple@exemple.com" required>
                </div>
                <div class="form-group">
                    <label for="motDePasse" class="form-label">Mot de passe :</label>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse" placeholder="Votre mot de passe" required>
                </div>
                <div class="form-group">
                    <label for="sexe" class="form-label">Sexe :</label>
                    <select class="form-control" id="sexe" name="sexe" required>
                        <option value="M">Masculin</option>
                        <option value="F">Féminin</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dateNaissance" class="form-label">Date de naissance :</label>
                    <input type="date" class="form-control" id="dateNaissance" name="dateNaissance" required>
                </div>
                <div class="form-group">
                    <label for="adresse" class="form-label">Adresse :</label>
                    <input type="text" class="form-control" id="adresse" name="adresse" placeholder="Votre adresse">
                </div>
                <div class="form-group">
                    <label for="formationId" class="form-label">Formation :</label>
                    <select class="form-control" id="formationId" name="formationId" required>
                        <option value="">-- Sélectionnez une formation --</option>
                        <c:forEach var="formation" items="${formations}">
                            <option value="${formation.id}">${formation.intitule} - ${formation.niveau}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label for="ueOptionnelle" class="form-label">UE Optionnelle :</label>
                    <select class="form-control" id="ueOptionnelle" name="ueOptionnelle">
                        <option value="">-- Sélectionnez une UE optionnelle --</option>
                        <c:forEach var="ue" items="${uesOptionnelles}">
                            <option value="${ue.code}">${ue.nom}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary btn-full">S'inscrire</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function openLoginModal(userType) {
        const modal = document.getElementById('loginModal');
        const userTypeInput = document.getElementById('userType');
        const modalTitle = document.getElementById('loginModalTitle');
        const loginForm = document.getElementById('loginForm');
        userTypeInput.value = userType;
        modalTitle.textContent = userType === 'etudiant' ? 'Connexion Étudiant' : 'Connexion Responsable';
        loginForm.action = userType === 'etudiant' ? 'LoginServlet' : 'LoginResponsableServlet';
        modal.style.display = 'flex';
        document.getElementById('inscriptionModal').style.display = 'none';
        document.body.classList.add('modal-open');
    }

    function openModal(modalId) {
        document.querySelectorAll('.modal').forEach(modal => modal.style.display = 'none');
        const modal = document.getElementById(modalId);
        modal.style.display = 'flex';
        document.body.classList.add('modal-open');
    }

    function closeModal(modalId) {
        const modal = document.getElementById(modalId);
        modal.style.display = 'none';
        document.body.classList.remove('modal-open');
    }

    document.querySelectorAll('.modal .close').forEach(button => {
        button.addEventListener('click', function() {
            const modal = button.closest('.modal');
            modal.style.display = 'none';
            document.body.classList.remove('modal-open');
        });
    });

    window.addEventListener('click', function(event) {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            if (event.target === modal) {
                modal.style.display = 'none';
                document.body.classList.remove('modal-open');
            }
        });
    });
</script>

<!-- Messages d'erreur/succès -->
<c:if test="${param.error == 'access_denied'}">
    <div class="alert alert-warning">Accès refusé. Connexion responsable requise.</div>
</c:if>
<c:if test="${param.message == 'logout_success'}">
    <div class="alert alert-success">Déconnexion réussie.</div>
</c:if>
</body>
</html>