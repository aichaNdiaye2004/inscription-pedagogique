<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<html>
<head>
    <title>Inscription Étudiant</title>
</head>
<body>
<h2>Inscription Étudiant</h2>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>

<form action="inscription" method="post">
    <label>INE:</label><input type="text" name="ine" required><br>
    <label>Prénom:</label><input type="text" name="prenom" required><br>
    <label>Nom:</label><input type="text" name="nom" required><br>
    <label>Email:</label><input type="email" name="email" required><br>
    <label>Mot de passe:</label><input type="password" name="motDePasse" required><br>
    
    <label>Sexe:</label>
    <select name="sexe">
        <option value="M">Masculin</option>
        <option value="F">Féminin</option>
    </select><br>
    <label>Date de naissance:</label><input type="date" name="dateNaissance" required><br>
    <label>Adresse:</label><input type="text" name="adresse"><br>
    <label>Groupe TD:</label><input type="number" name="groupeTD"><br>
    <label>Groupe TP:</label><input type="number" name="groupeTP"><br>

    <label>Formation:</label>
    <select name="formationId" required>
    <option value="">-- Sélectionnez une formation --</option>
    <c:forEach var="formation" items="${formations}">
        <option value="${formation.id}">${formation.intitule} - ${formation.niveau}</option>
    </c:forEach>
</select><br/><br/>


    <label>UEs optionnelles:</label><br>
    <!-- Liste à remplir dynamiquement dans une autre version -->
    <input type="checkbox" name="uesOptionnelles" value="UE101"> UE101<br>
    <input type="checkbox" name="uesOptionnelles" value="UE102"> UE102<br>

    <input type="submit" value="S'inscrire">
</form>
</body>
</html>
