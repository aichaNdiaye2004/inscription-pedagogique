<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Liste des formations</title>
</head>
<body>
<h2>Liste des formations</h2>

<a href="formations?action=add">Ajouter une formation</a>

<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>Code</th>
        <th>Intitulé</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="formation" items="${formations}">
        <tr>
            <td>${formation.id}</td>
            <td>${formation.code}</td>
            <td>${formation.intitule}</td>
            <td>
                <a href="formations?action=edit&id=${formation.id}">Modifier</a>
                |
                <a href="formations?action=delete&id=${formation.id}"
                   onclick="return confirm('Confirmer la suppression ?');">Supprimer</a>
                   <a href="ajouter-formation.jsp">➕ Ajouter une nouvelle formation</a>
                   <a href="formations">Retour à la liste</a>
                   
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>
