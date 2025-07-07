<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Inscriptions en attente</title>
</head>
<body>
<h2>Inscriptions en attente de validation</h2>

<c:if test="${empty etudiants}">
    <p>Aucune inscription en attente.</p>
</c:if>

<c:if test="${not empty etudiants}">
    <table border="1" cellpadding="5" cellspacing="0">
        <tr>
            <th>INE</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Email</th>
            <th>Formation</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="etudiant" items="${etudiants}">
            <tr>
                <td>${etudiant.ine}</td>
                <td>${etudiant.nom}</td>
                <td>${etudiant.prenom}</td>
                <td>${etudiant.email}</td>
                <td>${etudiant.formation.intitule}</td>
                <td>
                    <!-- Formulaire pour valider -->
<form action="ValiderInscriptionServlet" method="post">

    <input type="hidden" name="ine" value="${etudiant.ine}">
    <input type="submit" value="Valider">
</form>

<form action="${pageContext.request.contextPath}/RefuserInscriptionServlet" method="post" style="display:inline;" onsubmit="return confirm('Confirmer le refus ?');">
    <input type="hidden" name="ine" value="${etudiant.ine}">
    <input type="submit" value="Refuser" style="color:red;">
</form>

                </td>
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>
