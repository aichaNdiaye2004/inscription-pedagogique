<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head><title>${formation != null ? 'Modifier' : 'Ajouter'} une formation</title></head>
<body>

<h2>${formation != null ? 'Modifier' : 'Ajouter'} une formation</h2>

<form action="formations" method="post">
    <c:if test="${formation != null}">
        <input type="hidden" name="id" value="${formation.id}" />
    </c:if>

    <label for="intitule">Intitulé :</label>
    <input type="text" id="intitule" name="intitule" required
           value="${formation != null ? formation.intitule : ''}" /><br><br>

    <label for="niveau">Niveau :</label>
    <input type="text" id="niveau" name="niveau" required
           value="${formation != null ? formation.niveau : ''}" /><br><br>

    <label for="nomResponsable">Nom du Responsable :</label>
    <input type="text" id="nomResponsable" name="nomResponsable" required
           value="${formation != null ? formation.nomResponsable : ''}" /><br><br>

    <label for="emailResponsable">Email Responsable :</label>
    <input type="email" id="emailResponsable" name="emailResponsable" required
           value="${formation != null ? formation.emailResponsable : ''}" /><br><br>

    <label for="ueId">UEs associées à cette formation :</label><br>
    <select id="ueId" name="ueId" multiple required>
        <c:forEach var="ue" items="${ues}">
            <c:set var="selected" value="false" />
            <c:if test="${formation != null && formation.ues != null}">
                <c:forEach var="fue" items="${formation.ues}">
                    <c:if test="${fue.code == ue.code}">
                        <c:set var="selected" value="true" />
                    </c:if>
                </c:forEach>
            </c:if>
            <option value="${ue.code}" ${selected ? 'selected' : ''}>
                ${ue.code} - ${ue.nom} (Volume : ${ue.volumeHoraire}h, Coef : ${ue.coefficient})
            </option>
        </c:forEach>
    </select><br><br>

    <input type="submit" value="${formation != null ? 'Modifier' : 'Ajouter'}" />
</form>

<a href="formations">← Retour à la liste des formations</a>

<c:if test="${not empty message}">
    <p style="color:green">${message}</p>
</c:if>

</body>
</html>
