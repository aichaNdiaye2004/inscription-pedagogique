<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des étudiants</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Liste des étudiants</h2>
        <a href="ajouter-etudiant" class="btn btn-primary">+ Ajouter un étudiant</a>
    </div>

    <!-- Affichage message session -->
    <c:if test="${not empty sessionScope.message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${sessionScope.message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Fermer"></button>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>

    <div class="table-responsive">
        <table class="table table-bordered table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th>INE</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Email</th>
                    <th>Date de naissance</th>
                    <th>Sexe</th>
                    <th>Formation</th>
                    <th>Inscription</th>
                    <th>Modifier</th>
                    <th>Supprimer</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="etudiant" items="${etudiants}">
                    <tr>
                        <td>${etudiant.ine}</td>
                        <td>${etudiant.nom}</td>
                        <td>${etudiant.prenom}</td>
                        <td>${etudiant.email}</td>
                        <td>${etudiant.dateNaissanceStr}</td>
                        <td>${etudiant.sexe}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty etudiant.formation}">
                                    ${etudiant.formation.intitule}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Inconnue</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:if test="${!etudiant.inscriptionValidee}">
                                <form method="post" action="valider-inscription" class="d-inline">
                                    <input type="hidden" name="ine" value="${etudiant.ine}" />
                                    <button type="submit" class="btn btn-sm btn-outline-success">Valider</button>
                                </form>
                            </c:if>
                            <c:if test="${etudiant.inscriptionValidee}">
                                <span class="badge bg-success">✅ Validée</span>
                            </c:if>
                        </td>
                        <td>
                            <a href="modifier-etudiant?ine=${etudiant.ine}" class="btn btn-sm btn-warning">Modifier</a>
                        </td>
                        <td>
                            <form action="supprimer-etudiant" method="post"
                                  onsubmit="return confirm('Confirmer la suppression de ${etudiant.nom} ?');"
                                  class="d-inline">
                                <input type="hidden" name="ine" value="${etudiant.ine}" />
                                <button type="submit" class="btn btn-sm btn-danger">Supprimer</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
