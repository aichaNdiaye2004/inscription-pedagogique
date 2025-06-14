<%@ page isErrorPage="true" contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>Erreur Technique</title>
  <style>
    body { font-family: sans-serif; background: #fee; padding: 20px; }
    pre { background: #fff; padding: 10px; border: 1px solid #ddd; overflow: auto; }
  </style>
</head>
<body>
  <h1>Une erreur est survenue</h1>
  <p><strong>Message :</strong> ${error}</p>

  <c:if test="${not empty exception}">
    <h2>Détails de l’exception :</h2>
    <pre>
      <% exception.printStackTrace(new java.io.PrintWriter(out)); %>
    </pre>
  </c:if>

  <p><a href="${pageContext.request.contextPath}/liste-etudiants">Retour à la liste</a></p>
</body>
</html>
