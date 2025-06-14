<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Ajouter un Étudiant</title>
    <style>.error { color: red; }</style>
</head>
<body>
    <h1>Ajouter un Étudiant</h1>

    <c:if test="${not empty error}">
        <div class="error">${error}</div>
    </c:if>

    <form method="post" action="ajouter-etudiant">
        <div>
            <label>INE* (15 caractères max):</label>
            <input type="text" name="ine" required maxlength="15" 
                   value="${param.ine}">
        </div>
        
        <div>
            <label>Prénom*:</label>
            <input type="text" name="prenom" required
                   value="${param.prenom}">
        </div>
        
        <div>
            <label>Nom*:</label>
            <input type="text" name="nom" required
                   value="${param.nom}">
        </div>
        
        <div>
            <label>Email*:</label>
            <input type="email" name="email" required
                   value="${param.email}">
        </div>
        
        <div>
            <label>Date de naissance :</label>
            <input type="date" name="dateNaissance"
                   value="${param.dateNaissance}">
        </div>
        
        <div>
            <label>Sexe :</label>
            <select name="sexe">
                <option value="" <c:if test="${param.sexe == ''}">selected</c:if>>--Choisir--</option>
                <option value="M" <c:if test="${param.sexe == 'M'}">selected</c:if>>Masculin</option>
                <option value="F" <c:if test="${param.sexe == 'F'}">selected</c:if>>Féminin</option>
                <option value="Autre" <c:if test="${param.sexe == 'Autre'}">selected</c:if>>Autre</option>
            </select>
        </div>
        
        <div>
            <label>Adresse :</label><br>
            <textarea name="adresse" rows="3" cols="30">${param.adresse}</textarea>
        </div>
        
        <div>
            <label>Groupe TD :</label>
            <input type="text" name="groupeTd" maxlength="10"
                   value="${param.groupeTd}">
        </div>
        
        <div>
            <label>Groupe TP :</label>
            <input type="text" name="groupeTp" maxlength="10"
                   value="${param.groupeTp}">
        </div>
        
        <div>
            <label>Formation ID :</label>
            <input type="text" name="formationId" maxlength="10"
                   value="${param.formationId}">
        </div>
        
        <button type="submit">Enregistrer</button>
    </form>
</body>
</html>
