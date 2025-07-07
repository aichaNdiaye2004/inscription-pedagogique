<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="sn.uasz.inscription.entities.Etudiant" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    Etudiant etudiant = (Etudiant) session.getAttribute("etudiant");
    if (etudiant == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Accueil Étudiant</title>
</head>
<body>

<h2>Bienvenue, <%= etudiant.getPrenom() + " " + etudiant.getNom() %> !</h2>

<h3>Infos personnelles</h3>
<ul>
    <li>INE : <%= etudiant.getIne() %></li>
    <li>Nom : <%= etudiant.getNom() %></li>
    <li>Prénom : <%= etudiant.getPrenom() %></li>
    <li>Email : <%= etudiant.getEmail() %></li>
    <li>Adresse : <%= etudiant.getAdresse() %></li>
    <li>Sexe : <%= etudiant.getSexe() %></li>
    <li>Date de naissance : <%= etudiant.getDateNaissance() %></li>
    <li>Formation : <%= etudiant.getFormation().getIntitule() %></li>
</ul>

<h3>UEs choisies</h3>
<c:if test="${not empty etudiant.uesOptionnelles}">
    <ul>
        <c:forEach var="ue" items="${etudiant.uesOptionnelles}">
            <li><c:out value="${ue.nom}" /> (Code : <c:out value="${ue.code}" />)</li>
        </c:forEach>
    </ul>
</c:if>
<c:if test="${empty etudiant.uesOptionnelles}">
    <p>Aucune UE optionnelle choisie.</p>
</c:if>

<h3>Groupes</h3>
<ul>
    <li>Groupe TD : <%= etudiant.getGroupeTD() %></li>
    <li>Groupe TP : <%= etudiant.getGroupeTP() %></li>
</ul>

<c:choose>
    <c:when test="${!etudiant.inscriptionValidee}">
        <a href="choix-ues.jsp">Choisir mes UEs optionnelles</a><br>
        <p style="color:orange;"><strong>En attente de validation par le responsable pédagogique.</strong></p>
    </c:when>
    <c:otherwise>
        <p style="color:green;"><strong>Votre inscription est validée. Vous ne pouvez plus modifier vos choix.</strong></p>
    </c:otherwise>
</c:choose>

<a href="${pageContext.request.contextPath}/LogoutServlet">Se déconnecter</a>

</body>
</html>
