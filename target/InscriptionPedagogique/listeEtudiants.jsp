<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>Liste des étudiants</title>
</head>
<body>

<h2>Liste des étudiants</h2>

<!-- Affichage message session -->
<c:if test="${not empty sessionScope.message}">
    <div style="color: green; font-weight: bold;">
        ${sessionScope.message}
    </div>
    <c:remove var="message" scope="session"/>
</c:if>

<!-- Bouton pour ajouter un étudiant -->
<p>
    <a href="ajouter-etudiant" class="btn btn-primary">Ajouter un étudiant</a>
</p>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
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
            <td>
              ${etudiant.dateNaissanceStr}



            </td>
            <td>${etudiant.sexe}</td>
            <td>
                <c:choose>
                    <c:when test="${not empty etudiant.formation}">
                        ${etudiant.formation.intitule}
                    </c:when>
                    <c:otherwise>
                        Formation inconnue
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                <c:if test="${!etudiant.inscriptionValidee}">
                    <form method="post" action="valider-inscription" style="margin:0;">
                        <input type="hidden" name="ine" value="${etudiant.ine}" />
                        <button type="submit">Valider</button>
                    </form>
                </c:if>
                <c:if test="${etudiant.inscriptionValidee}">
                    ✅ Validée
                </c:if>
            </td>
            <td>
                <a href="modifier-etudiant?ine=${etudiant.ine}">Modifier</a>
            </td>
            <td>
                <form action="supprimer-etudiant" method="post" onsubmit="return confirm('Confirmer la suppression de ${etudiant.nom} ?');" style="margin:0;">
                    <input type="hidden" name="ine" value="${etudiant.ine}" />
                    <input type="submit" value="Supprimer" />
                </form>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
