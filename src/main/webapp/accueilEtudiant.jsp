<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.uasz.inscription.entities.Etudiant" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Etudiant etudiant = (Etudiant) session.getAttribute("etudiant");
    if (etudiant == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Accueil Étudiant</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="text-end mb-3">
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn btn-outline-danger">Se déconnecter</a>
    </div>

    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white">
            <h4>Bienvenue, <%= etudiant.getPrenom() + " " + etudiant.getNom() %> !</h4>
        </div>
        <div class="card-body">
            <h5 class="mb-3">Informations personnelles</h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>INE :</strong> <%= etudiant.getIne() %></li>
                <li class="list-group-item"><strong>Nom :</strong> <%= etudiant.getNom() %></li>
                <li class="list-group-item"><strong>Prénom :</strong> <%= etudiant.getPrenom() %></li>
                <li class="list-group-item"><strong>Email :</strong> <%= etudiant.getEmail() %></li>
                <li class="list-group-item"><strong>Adresse :</strong> <%= etudiant.getAdresse() %></li>
                <li class="list-group-item"><strong>Sexe :</strong> <%= etudiant.getSexe() %></li>
                <li class="list-group-item"><strong>Date de naissance :</strong> <%= etudiant.getDateNaissance() %></li>
                <li class="list-group-item"><strong>Formation :</strong> <%= etudiant.getFormation().getIntitule() %></li>
            </ul>
        </div>
    </div>

    <div class="card shadow mb-4">
        <div class="card-header bg-secondary text-white">
            <h5 class="mb-0">UEs optionnelles choisies</h5>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty etudiant.uesOptionnelles}">
                    <ul class="list-group">
                        <c:forEach var="ue" items="${etudiant.uesOptionnelles}">
                            <li class="list-group-item">
                                ${ue.nom} <span class="text-muted">(Code : ${ue.code})</span>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="text-muted">Aucune UE optionnelle choisie.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="card shadow mb-4">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0">Groupes</h5>
        </div>
        <div class="card-body">
            <ul class="list-group">
                <li class="list-group-item"><strong>Groupe TD :</strong> <%= etudiant.getGroupeTD() %></li>
                <li class="list-group-item"><strong>Groupe TP :</strong> <%= etudiant.getGroupeTP() %></li>
            </ul>
        </div>
    </div>

    <div class="mb-4">
        <c:choose>
            <c:when test="${!etudiant.inscriptionValidee}">
                <div class="alert alert-warning">
                    <p><strong>Votre inscription n'est pas encore validée.</strong></p>
                    <a href="choix-ues.jsp" class="btn btn-outline-primary mt-2">Choisir mes UEs optionnelles</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-success">
                    <p><strong>Votre inscription est validée.</strong></p>
                    <p>Vous ne pouvez plus modifier vos choix.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
