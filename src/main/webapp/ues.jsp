<%@ page import="java.util.List" %>
<%@ page import="sn.uasz.inscription.entities.UE" %>
<%@ page import="sn.uasz.inscription.dao.UEDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    UEDao ueDao = new UEDao();
    List<UE> ues = ueDao.findAll();
%>

<html>
<head>
    <title>Liste des UE</title>
</head>
<body>
<h2>Unités d’Enseignement</h2>
<a href="index.jsp">Accueil</a> | <a href="ajouterUE.jsp">Ajouter une UE</a>
<table border="1" cellpadding="5">
    <tr>
        <th>ID</th>
        <th>Nom</th>
        <th>Crédits</th>
    </tr>
    <% for (UE ue : ues) { %>
        <tr>
            <td><%= ue.getId() %></td>
            <td><%= ue.getNom() %></td>
            <td><%= ue.getCredits() %></td>
        </tr>
    <% } %>
</table>
</body>
</html>
