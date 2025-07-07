<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Liste des UE de la formation ${formation.intitule}</title>
</head>
<body>

<h2>UE de la formation : ${formation.intitule}</h2>

<form method="get" action="ListerUEFormationServlet">
    <input type="hidden" name="formationId" value="${formation.id}" />
    <label for="type">Filtrer par type :</label>
    <select name="type" id="type" onchange="this.form.submit()">
        <option value="obligatoire" ${param.type == 'obligatoire' ? 'selected' : ''}>Obligatoire</option>
        <option value="optionnelle" ${param.type == 'optionnelle' ? 'selected' : ''}>Optionnelle</option>
    </select>
</form>

<table border="1" cellpadding="5" cellspacing="0">
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
                <a href="ModifierTypeUEServlet?code=${ue.code}">
                    <c:choose>
                        <c:when test="${ue.obligatoire}">
                            Rendre optionnelle
                        </c:when>
                        <c:otherwise>
                            Rendre obligatoire
                        </c:otherwise>
                    </c:choose>
                </a>
                <c:if test="${!ue.obligatoire}">
                    | <a href="RetirerUEServlet?code=${ue.code}" onclick="return confirm('Retirer cette UE ?');">Retirer</a>
                </c:if>
            </td>
        </tr>
    </c:forEach>
</table>

<br>
<a href="formations">Retour aux formations</a>

</body>
</html>
