<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Liste des étudiants</title>
</head>
<body>
<h2>Étudiants inscrits</h2>
<a href="index.jsp">Accueil</a> | <a href="ajouter-etudiant">Ajouter un étudiant</a>

<table border="1" cellpadding="5">
    <tr>
        <th>INE</th>
        <th>Prénom</th>
        <th>Nom</th>
        <th>Email</th>
        <th>Date de naissance</th>
        <th>Sexe</th>
        <th>Adresse</th>
        <th>Groupe TD</th>
        <th>Groupe TP</th>
        <th>Formation</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="e" items="${etudiants}">
        <tr>
            <td>${e.ine}</td>
            <td>${e.prenom}</td>
            <td>${e.nom}</td>
            <td>${e.email}</td>

            <td>
                <c:choose>
                    <c:when test="${not empty e.dateNaissance}">
                        <fmt:formatDate value="${e.dateNaissance}" pattern="dd/MM/yyyy"/>
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:choose>
                    <c:when test="${not empty e.sexe}">
                        ${e.sexe}
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:choose>
                    <c:when test="${not empty e.adresse}">
                        ${e.adresse}
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:choose>
                    <c:when test="${not empty e.groupeTD}">
                        ${e.groupeTD}
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:choose>
                    <c:when test="${not empty e.groupeTP}">
                        ${e.groupeTP}
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:choose>
                    <c:when test="${not empty e.formation}">
                        ${e.formation.libelle}
                    </c:when>
                    <c:otherwise></c:otherwise>
                </c:choose>
            </td>

            <td>
                <a href="modifier-etudiant?ine=${e.ine}">Modifier</a> |
                <a href="${pageContext.request.contextPath}/supprimer-etudiant?ine=${e.ine}" 
                    onclick="return confirm('Voulez-vous vraiment supprimer cet étudiant ?');">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
