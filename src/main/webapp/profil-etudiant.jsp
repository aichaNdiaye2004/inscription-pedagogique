<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Profil Étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Profil de ${etudiant.prenom} ${etudiant.nom}</h4>
        </div>
        <div class="card-body">

            <div class="mb-3">
                <strong>INE :</strong> ${etudiant.ine}
            </div>
            <div class="mb-3">
                <strong>Email :</strong> ${etudiant.email}
            </div>
            <div class="mb-3">
                <strong>Date de naissance :</strong> ${etudiant.dateNaissance}
            </div>
            <div class="mb-3">
                <strong>Formation :</strong> ${etudiant.formation.nom}
            </div>
            <div class="mb-4">
                <strong>Groupes :</strong> TD ${etudiant.groupeTD}, TP ${etudiant.groupeTP}
            </div>

            <c:if test="${etudiant.inscriptionValidee}">
                <h5 class="text-success">UEs optionnelles choisies :</h5>
                <ul class="list-group mt-2">
                    <c:forEach var="ue" items="${etudiant.uesOptionnelles}">
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <span>
                                ${ue.nom}
                            </span>
                            <span class="badge bg-secondary rounded-pill">
                                ${ue.volumeHoraire}h | ${ue.credits} crédits
                            </span>
                        </li>
                    </c:forEach>
                </ul>
            </c:if>

            <c:if test="${!etudiant.inscriptionValidee}">
                <div class="alert alert-warning mt-4">
                    <em>Votre inscription n'est pas encore validée.<br>
                        Les UEs optionnelles et groupes ne sont pas disponibles.</em>
                </div>
            </c:if>

        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
