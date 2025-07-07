<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>Configuration Taille des Groupes</title>
</head>
<body>

<h2>Configurer la taille des groupes de TD et TP</h2>

<c:if test="${not empty sessionScope.message}">
    <div style="color: green; font-weight: bold;">
        ${sessionScope.message}
    </div>
    <c:remove var="message" scope="session"/>
</c:if>

<form action="${pageContext.request.contextPath}/configurations" method="post">

    <label for="tailleMaxGroupeTD">Taille max groupe TD :</label>
    <input type="number" id="tailleMaxGroupeTD" name="tailleMaxGroupeTD" min="1" value="${configuration.tailleMaxGroupeTD}" required /><br/><br/>

    <label for="tailleMaxGroupeTP">Taille max groupe TP :</label>
    <input type="number" id="tailleMaxGroupeTP" name="tailleMaxGroupeTP" min="1" value="${configuration.tailleMaxGroupeTP}" required /><br/><br/>

    <button type="submit">Enregistrer</button>
</form>

</body>
</html>
