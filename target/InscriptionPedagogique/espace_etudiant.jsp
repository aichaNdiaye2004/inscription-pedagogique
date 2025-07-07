<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.uasz.inscription.entities.Etudiant" %>
<%@ page import="sn.uasz.inscription.entities.UE" %>
<%@ page import="java.util.List" %>
<%
    Etudiant etudiant = (Etudiant) session.getAttribute("etudiant");

    if (etudiant == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<UE> listeUEs = (List<UE>) request.getAttribute("listeUEs");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Espace Étudiant</title>
</head>
<body>
    <h1>Bienvenue <%= etudiant.getPrenom() %> <%= etudiant.getNom() %> !</h1>

    <h3>Informations personnelles</h3>
    <ul>
        <li>Ine : <%= etudiant.getIne() %></li>
        <li>Email : <%= etudiant.getEmail() %></li>
        <li>Formation : <%= (etudiant.getFormation() != null ? etudiant.getFormation().getIntitule() : "Non défini") %></li>
    </ul>

    <h3>Mes UE</h3>
    <ul>
        <%
            if (listeUEs != null && !listeUEs.isEmpty()) {
                for (UE ue : listeUEs) {
        %>
            <li><%= ue.getCode() %> - <%= ue.getNom() %></li>
        <%
                }
            } else {
        %>
            <li>Aucune UE inscrite.</li>
        <%
            }
        %>
    </ul>

    <p><a href="InscriptionUE.jsp">S'inscrire à une UE</a></p>
    <p><a href="logout.jsp">Se déconnecter</a></p>
</body>
</html>
