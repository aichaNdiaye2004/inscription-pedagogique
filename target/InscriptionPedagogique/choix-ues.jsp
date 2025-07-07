<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Choix des UEs optionnelles</title>
    <script defer>
      const maxChoices = 3;
      document.addEventListener('DOMContentLoaded', () => {
        const checkboxes = document.querySelectorAll('input[name="ueCodes"]');
        checkboxes.forEach(cb => {
          cb.addEventListener('change', () => {
            const checkedCount = [...checkboxes].filter(c => c.checked).length;
            if (checkedCount > maxChoices) {
              alert("Vous ne pouvez choisir que " + maxChoices + " UEs optionnelles.");
              cb.checked = false;
            }
          });
        });
      });
    </script>
</head>
<body>

<h2>Choisissez vos UEs optionnelles</h2>

<form action="ChoixUEEtudiantServlet" method="post">
    <input type="hidden" name="etudiantIne" value="${etudiant.ine}"/>

    <fieldset>
      <legend>Liste des UE optionnelles</legend>
      <c:forEach var="ue" items="${uesOptionnelles}">
          <label>
            <input type="checkbox" name="ueCodes" value="${ue.code}"
              <c:if test="${ueSelectedCodes != null && ueSelectedCodes.contains(ue.code)}">checked</c:if> />
            ${ue.nom} (${ue.code}) - Coefficient: ${ue.coefficient}
          </label><br/>
      </c:forEach>
    </fieldset>

    <br>
    <input type="submit" value="Valider mes choix"
       onclick="return confirm('Confirmer les UEs sélectionnées ?');">
</form>

<c:if test="${not empty message}">
    <p style="color: ${message.startsWith('Vous ne pouvez') ? 'red' : 'green'}">${message}</p>
</c:if>

</body>
</html>
