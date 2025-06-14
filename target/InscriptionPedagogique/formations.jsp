<%@ page import="java.util.List" %>
<%@ page import="sn.uasz.inscription.entities.Formation" %>
<%@ page import="sn.uasz.inscription.dao.FormationDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    FormationDao formationDao = new FormationDao();
    List<Formation> formations = formationDao.findAll();
%>

<html>
<head>
    <title>Liste des formations</title>
</head>
<body>
<h2>Formations disponibles</h2>
<a href="index.jsp">Accueil</a> | <a href="ajouterFormation.jsp">Ajouter une formation</a>
<table border="1" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Nom (Intitulé)</th>
        <th>Description</th>
    </tr>
    <% for (Formation f : formations) { %>
        <tr>
            <td><%= f.getId() %></td>
            <!-- Option 1: Utiliser directement getIntitule() -->
            <td><%= f.getIntitule() %></td>
            
            <!-- Option 2: Utiliser getNom() si vous avez ajouté la méthode -->
            <%-- <td><%= f.getNom() %></td> --%>
            
            <td><%= f.getDescription() != null ? f.getDescription() : "" %></td>
        </tr>
    <% } %>
</table>
</body>
</html>