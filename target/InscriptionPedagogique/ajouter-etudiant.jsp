<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <title>Ajouter un étudiant</title>
</head>
<body>
    <h1>Ajouter un étudiant</h1>

    <form method="post" action="ajouter-etudiant">
        <!-- INE -->
        INE : <input type="text" name="ine" required /><br/>

        <!-- Prénom -->
        Prénom : <input type="text" name="prenom" required /><br/>

        <!-- Nom -->
        Nom : <input type="text" name="nom" required /><br/>

        <!-- Date de naissance -->
        Date de naissance : <input type="date" name="dateNaissance" required /><br/>

        <!-- Sexe -->
        Sexe : 
        <select name="sexe" required>
            <option value="M">Masculin</option>
            <option value="F">Féminin</option>
        </select><br/>

        <!-- Adresse -->
        Adresse : <input type="text" name="adresse" /><br/>

        <!-- Email -->
        Email : <input type="email" name="email" required /><br/>
	<!-- Groupe TD -->
		Groupe TD : <input type="number" name="groupeTD" /><br/>
		
		<!-- Groupe TP -->
		Groupe TP : <input type="number" name="groupeTP" /><br/>
		<!-- Mot de passe -->
		Mot de passe : <input type="password" name="password" required /><br/>
		
	
        <!-- Formation -->
        Formation :
       <select name="formationId" required>
    <option value="">-- Sélectionnez une formation --</option>
    <c:forEach var="formation" items="${formations}">
        <option value="${formation.id}">
            ${formation.intitule} - ${formation.niveau}
        </option>
    </c:forEach>
</select> <br/> <br/>

UE optionnelles : 
<select name="ueId">
    <option value="">-- Sélectionnez une UE optionnelle --</option>
    <c:forEach var="ue" items="${uesOptionnelles}">
        <option value="${ue.code}">${ue.nom}</option>
    </c:forEach>
</select><br/><br/>




        <input type="submit" value="Ajouter" />
    </form>

    <!-- Affichage des erreurs -->
    <c:if test="${not empty error}">
        <p style="color:red;">${error}</p>
    </c:if>
    
    
   
    
  
</body>
</html>
