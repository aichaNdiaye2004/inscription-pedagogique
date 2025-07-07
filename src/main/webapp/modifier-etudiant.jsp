<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Ajouter un étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Ajouter un étudiant</h4>
        </div>
        <div class="card-body">
            <form method="post" action="ajouter-etudiant">
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="ine" class="form-label">INE</label>
                        <input type="text" class="form-control" id="ine" name="ine" required>
                    </div>
                    <div class="col-md-6">
                        <label for="prenom" class="form-label">Prénom</label>
                        <input type="text" class="form-control" id="prenom" name="prenom" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="nom" class="form-label">Nom</label>
                        <input type="text" class="form-control" id="nom" name="nom" required>
                    </div>
                    <div class="col-md-6">
                        <label for="dateNaissance" class="form-label">Date de naissance</label>
                        <input type="date" class="form-control" id="dateNaissance" name="dateNaissance" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="sexe" class="form-label">Sexe</label>
                        <select class="form-select" id="sexe" name="sexe" required>
                            <option value="">-- Sélectionnez --</option>
                            <option value="M">Masculin</option>
                            <option value="F">Féminin</option>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="adresse" class="form-label">Adresse</label>
                        <input type="text" class="form-control" id="adresse" name="adresse">
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    <div class="col-md-6">
                        <label for="password" class="form-label">Mot de passe</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                </div>

                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="groupeTD" class="form-label">Groupe TD</label>
                        <input type="number" class="form-control" id="groupeTD" name="groupeTD">
                    </div>
                    <div class="col-md-6">
                        <label for="groupeTP" class="form-label">Groupe TP</label>
                        <input type="number" class="form-control" id="groupeTP" name="groupeTP">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="formationId" class="form-label">Formation</label>
                    <select class="form-select" id="formationId" name="formationId" required>
                        <option value="">-- Sélectionnez une formation --</option>
                        <c:forEach var="formation" items="${formations}">
                            <option value="${formation.id}">
                                ${formation.intitule} - ${formation.niveau}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-4">
                    <label for="ueId" class="form-label">UE optionnelle</label>
                    <select class="form-select" id="ueId" name="ueId">
                        <option value="">-- Sélectionnez une UE optionnelle --</option>
                        <c:forEach var="ue" items="${uesOptionnelles}">
                            <option value="${ue.code}">${ue.nom}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-success">Ajouter</button>
                </div>
            </form>

            <!-- Affichage des erreurs -->
            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3" role="alert">
                    ${error}
                </div>
            </c:if>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
