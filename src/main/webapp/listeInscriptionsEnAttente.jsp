<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Liste des inscriptions en attente</title>
    <style>
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ddd; padding: 8px; }
        th { background-color: #f2f2f2; }
        .empty-message { font-style: italic; color: #666; margin-top: 20px; }
    </style>
</head>
<body>

<h1>Liste des inscriptions en attente</h1>


<c:choose>
    <c:when test="${not empty etudiants}">
        <table>
            <thead>
                <tr>
                    <th>INE</th>
                    <th>Nom</th>
                    <th>Prénom</th>
                    <th>Email</th>
                    <th>Formation</th>
                    <th>Date d'inscription</th>
                </tr>
            </thead>
           <tbody>
    <c:forEach var="etudiant" items="${etudiants}">
        <tr>
            <td>${etudiant.ine}</td>
            <td>${etudiant.nom}</td>
            <td>${etudiant.prenom}</td>
            <td>${etudiant.email}</td>
            <td>${etudiant.formation.nom}</td>
            <td>${etudiant.dateNaissance}</td>
            <td>
                <form action="${pageContext.request.contextPath}/RefuserInscriptionServlet" method="post">
                    <input type="hidden" name="ine" value="${etudiant.ine}" />
                    <button type="submit" class="btn btn-danger btn-sm">Refuser</button>
                </form>
            </td>
        </tr>
    </c:forEach>
</tbody>
>
        </table>
    </c:when>
    <c:otherwise>
        <p class="empty-message">Aucune inscription en attente</p>
    </c:otherwise>
</c:choose>

</body>
</html>
