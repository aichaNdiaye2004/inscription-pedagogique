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
        <th>Nom</th>
        <th>Prénom</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="e" items="${etudiants}">
        <tr>
            <td>${e.ine}</td>
            <td>${e.nom}</td>
            <td>${e.prenom}</td>
            <td>${e.email}</td>
            <td>
                <a href="modifier-etudiant?ine=${e.ine}">Modifier</a> |
                <a href="supprimer-etudiant?ine=${e.ine}" 
                   onclick="return confirm('Voulez-vous vraiment supprimer cet étudiant ?');">Supprimer</a>
            </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>
