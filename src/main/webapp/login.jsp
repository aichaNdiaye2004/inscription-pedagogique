<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8" />
    <title>Connexion</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease forwards;
            background: #fff;
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
        .logo {
            display: block;
            margin: 0 auto 20px;
            width: 80px;
            height: 80px;
            background: url('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Logo_UASZ.png/600px-Logo_UASZ.png') no-repeat center/contain;
            border-radius: 50%;
        }
        h4 {
            font-weight: 700;
            color: #4b2995;
        }
        .btn-primary {
            background: #4b2995;
            border: none;
        }
        .btn-primary:hover {
            background: #38216b;
        }
        .form-label {
            font-weight: 600;
        }
        /* Style pour les liens textuels */
        .text-link {
            text-decoration: none;
            color: #4b2995;
            font-size: 16px;
            font-weight: 500;
            margin: 0 10px;
            transition: color 0.3s ease;
        }
        .text-link:hover {
            color: #38216b;
            text-decoration: underline;
        }
        .link-container {
            text-align: center;
            margin-top: 15px;
            display: flex; /* Utilisation de flexbox pour aligner les liens horizontalement */
            justify-content: center; /* Centrer les liens */
            align-items: center; /* Aligner verticalement */
        }
        .link-container span {
            color: #666;
            margin: 0 10px;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4 shadow" style="min-width: 400px;">
        <div class="logo"></div>
        <h4 class="text-center mb-4">Bienvenue à l'UASZ</h4>
        <form action="LoginServlet" method="post" novalidate>
            <div class="mb-3">
                <label for="email" class="form-label">Adresse Email :</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="exemple@exemple.com" required autofocus>
            </div>

            <div class="mb-4">
                <label for="password" class="form-label">Mot de passe :</label>
                <input type="password" class="form-control" id="password" name="password" placeholder="Votre mot de passe" required>
            </div>

            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary btn-lg">Se connecter</button>
            </div>
            <div class="link-container">
                <a href="inscription.jsp" class="text-link">S'inscrire</a>
                <span>|</span>
                <a href="forgot-password.jsp" class="text-link">Mot de passe oublié ?</a>
            </div>
        </form>

      
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>