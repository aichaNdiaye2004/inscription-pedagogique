<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Modifier une UE</title>
</head>
<body>
<h2>Modifier une UE</h2>

<form action="ModifierUEServlet" method="post">
    <input type="hidden" name="code" value="${ue.code}"/>

    <label for="nom">Nom :</label>
    <input type="text" name="nom" id="nom" value="${ue.nom}" required><br><br>

    <label for="volumeHoraire">Volume horaire :</label>
    <input type="number" name="volumeHoraire" id="volumeHoraire" value="${ue.volumeHoraire}" required><br><br>

    <label for="coefficient">Coefficient :</label>
    <input type="number" step="0.1" name="coefficient" id="coefficient" value="${ue.coefficient}" required><br><br>

    <label for="credits">Crédits :</label>
    <input type="number" name="credits" id="credits" value="${ue.credits}" required><br><br>

    <label for="enseignant">Enseignant :</label>
    <input type="text" name="enseignant" id="enseignant" value="${ue.enseignant}" required><br><br>

    <label for="obligatoire">Type :</label>
    <select name="obligatoire" id="obligatoire">
        <option value="true" ${ue.obligatoire ? 'selected' : ''}>Obligatoire</option>
        <option value="false" ${!ue.obligatoire ? 'selected' : ''}>Optionnelle</option>
    </select><br><br>

    <input type="submit" value="Enregistrer">
</form>

<a href="lister-ues">Retour à la liste</a>
</body>
</html>
