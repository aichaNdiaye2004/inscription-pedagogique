<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head><title>Liste des formations</title></head>
<body>
<h2>Liste des formations</h2>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>

<a href="ajouter-formation.jsp">Ajouter une nouvelle formation</a><br><br>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
        <tr>
            <th>Intitulé</th>
            <th>Niveau</th>
            <th>Email Responsable</th>
            <th>UEs</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>
    <c:forEach var="f" items="${formations}">
        <tr>
            <td>${f.intitule}</td>
            <td>${f.niveau}</td>
            <td>${f.emailResponsable}</td>
            <td>
                <ul>
                <c:forEach var="ue" items="${f.ues}">
                    <li>${ue.nom} (${ue.code}) - Coeff: ${ue.coefficient}</li>
                </c:forEach>
                </ul>
            </td>
            <td>
                <a href="formations?action=edit&id=${f.id}">Modifier</a> |
                <a href="formations?action=delete&id=${f.id}"
                   onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>


</body>
</html>
