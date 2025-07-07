<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Étudiants inscrits</title></head>
<body>

<h2>Étudiants inscrits à l’UE : ${ue.nom}</h2>



<c:if test="${not empty etudiants}">
    <table border="1">
        <tr>
            <th>Matricule</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
        </tr>
        <c:forEach var="e" items="${etudiants}">
            <tr>
                <td>${e.matricule}</td>
                <td>${e.nom}</td>
                <td>${e.prenom}</td>
                <td>${e.email}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

<c:if test="${empty etudiants}">
    <p>Aucun étudiant inscrit à cette UE.</p>
</c:if>

<a href="ListerUEsServlet">⬅ Retour à la liste des UEs</a>

</body>
</html>
