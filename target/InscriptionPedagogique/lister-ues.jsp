<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Liste des UEs</title>
</head>
<body>
<h2>Liste des UEs par formation et type</h2>

<form method="get" action="${pageContext.request.contextPath}/ListerUEsServlet">
    <label for="formationId">Formation :</label>
    <select name="formationId" id="formationId" required>
        <c:forEach var="f" items="${formations}">
            <option value="${f.id}" <c:if test="${f.id == selectedFormationId}">selected</c:if>>
                ${f.intitule}
            </option>
        </c:forEach>
    </select>

    <label for="type">Type :</label>
    <select name="type" id="type">
        <option value="obligatoire" <c:if test="${selectedType == 'obligatoire'}">selected</c:if>>Obligatoire</option>
        <option value="optionnelle" <c:if test="${selectedType == 'optionnelle'}">selected</c:if>>Optionnelle</option>
    </select>

    <input type="submit" value="Filtrer">
</form>

<c:if test="${not empty ues}">
    <table border="1">
        <tr>
            <th>Code</th>
            <th>Nom</th>
            <th>Volume Horaire</th>
            <th>Coefficient</th>
            <th>Crédits</th>
            <th>Enseignant</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="ue" items="${ues}">
            <tr>
                <td>${ue.code}</td>
                <td>${ue.nom}</td>
                <td>${ue.volumeHoraire}</td>
                <td>${ue.coefficient}</td>
                <td>${ue.credits}</td>
                <td>${ue.enseignant}</td>
                <td>
    <a href="modifier-ue.jsp?code=${ue.code}">Modifier</a> |
    <a href="SupprimerUEServlet?code=${ue.code}" onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
    <a href="ListerEtudiantsParUE?ueId=${ue.code}">📋 Étudiants</a>
</td>

            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>
