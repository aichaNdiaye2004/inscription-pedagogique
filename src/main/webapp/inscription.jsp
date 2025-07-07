<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea, #764ba2);
            height: 100vh;
            font-family: 'Inter', sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.3);
            animation: fadeInUp 0.8s ease forwards;
            background: #fff;
            width: 90%;
            max-width: 350px;
            margin: 0 auto;
            padding: 20px;
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
        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .card-header h2 {
            font-size: 22px;
            font-weight: 700;
            color: #4b2995;
            margin: 0;
        }
        .card-header .close {
            cursor: pointer;
            font-size: 24px;
            color: #333;
            line-height: 1;
            transition: color 0.3s ease;
        }
        .card-header .close:hover {
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
        .form-label {
            font-weight: 600;
            font-size: 14px;
            color: #4b2995;
        }
        .form-control, .form-select {
            font-size: 14px;
            padding: 8px;
            border-radius: 4px;
        }
        .btn-primary {
            background: #4b2995;
            border: none;
            font-size: 14px;
            padding: 10px;
            width: 100%;
            border-radius: 4px;
        }
        .btn-primary:hover {
            background: #38216b;
        }
        .alert {
            font-size: 14px;
            margin-top: 15px;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center vh-100">
    <div class="card">
        <div class="card-header">
            <h2>Inscription Étudiant</h2>
            <span class="close" onclick="window.location.href='index.jsp'">×</span>
        </div>
        <div class="logo"></div>
        <c:if test="${not empty message}">
            <div class="alert alert-success text-center" role="alert">
                ${message}
            </div>
        </c:if>
        <form action="inscription" method="post" novalidate>
            <div class="mb-3">
                <label for="ine" class="form-label">INE :</label>
                <input type="text" class="form-control" id="ine" name="ine" placeholder="Numéro INE" required>
            </div>
            <div class="mb-3">
                <label for="prenom" class="form-label">Prénom :</label>
                <input type="text" class="form-control" id="prenom" name="prenom" placeholder="Votre prénom" required>
            </div>
            <div class="mb-3">
                <label for="nom" class="form-label">Nom :</label>
                <input type="text" class="form-control" id="nom" name="nom" placeholder="Votre nom" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email :</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="exemple@exemple.com" required>
            </div>
            <div class="mb-3">
                <label for="motDePasse" class="form-label">Mot de passe :</label>
                <input type="password" class="form-control" id="motDePasse" name="motDePasse" placeholder="Votre mot de passe" required>
            </div>
            <div class="mb-3">
                <label for="sexe" class="form-label">Sexe :</label>
                <select class="form-select" id="sexe" name="sexe" required>
                    <option value="M">Masculin</option>
                    <option value="F">Féminin</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="dateNaissance" class="form-label">Date de naissance :</label>
                <input type="date" class="form-control" id="dateNaissance" name="dateNaissance" required>
            </div>
            <div class="mb-3">
                <label for="adresse" class="form-label">Adresse :</label>
                <input type="text" class="form-control" id="adresse" name="adresse" placeholder="Votre adresse">
            </div>
            <div class="mb-3">
                <label for="groupeTD" class="form-label">Groupe TD :</label>
                <input type="number" class="form-control" id="groupeTD" name="groupeTD" placeholder="Numéro groupe TD">
            </div>
            <div class="mb-3">
                <label for="groupeTP" class="form-label">Groupe TP :</label>
                <input type="number" class="form-control" id="groupeTP" name="groupeTP" placeholder="Numéro groupe TP">
            </div>
            <div class="mb-3">
                <label for="formationId" class="form-label">Formation :</label>
                <select class="form-select" id="formationId" name="formationId" required>
                    <option value="">-- Sélectionnez une formation --</option>
                    <c:forEach var="formation" items="${formations}">
                        <option value="${formation.id}">${formation.intitule} - ${formation.niveau}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="mb-3">
                <label for="ueOptionnelle" class="form-label">UE Optionnelle :</label>
                <select class="form-select" id="ueOptionnelle" name="ueOptionnelle">
                    <option value="">-- Sélectionnez une UE optionnelle --</option>
                    <c:forEach var="ue" items="${uesOptionnelles}">
                        <option value="${ue.code}">${ue.nom}</option>
                    </c:forEach>
                </select>
            </div>
            <div class="d-grid mb-3">
                <button type="submit" class="btn btn-primary">S'inscrire</button>
            </div>
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>