<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.uasz.inscription.entities.Etudiant" %>
<%
    Etudiant etudiant = (Etudiant) request.getAttribute("etudiant");
%>
<html>
<head>
    <title>Modifier un étudiant</title>
</head>
<body>
    <h2>Modifier un étudiant</h2>
    <a href="listeEtudiants.jsp">Retour à la liste</a>
    <form action="etudiant" method="post">
        INE : <input type="text" name="ine" value="<%= etudiant.getIne() %>" readonly /><br/><br/>
        Nom : <input type="text" name="nom" value="<%= etudiant.getNom() %>" required /><br/><br/>
        Prénom : <input type="text" name="prenom" value="<%= etudiant.getPrenom() %>" required /><br/><br/>
        Email : <input type="email" name="email" value="<%= etudiant.getEmail() %>" required /><br/><br/>
        <input type="submit" value="Modifier" />
    </form>
</body>
</html>
