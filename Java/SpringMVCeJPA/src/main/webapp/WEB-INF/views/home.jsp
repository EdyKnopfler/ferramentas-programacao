<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page session="false" %>

<!DOCTYPE html>
<html>

<head>
	<meta charset="utf-8">
	<title>Tarefas</title>
</head>

<body>
	<h1>Lista de Tarefas</h1>
	
	<p>
	   <a href="<c:url value="novaTarefa" />">Cadastrar Nova Tarefa</a>
	</p>
	
	<table>
		<tr>
			<th>ID</th>
			<th>Descrição</th>
			<th>Finalizada em</th>
		</tr>
		<c:forEach var="tarefa" items="${tarefas}">
			<tr>
				<td>${tarefa.id}</td>
				<td>${tarefa.descricao}</td>
				<td>
				   <c:choose>
					   <c:when test="${tarefa.finalizado}">
						   <fmt:formatDate value="${tarefa.dataFinalizacao.time}" />
					   </c:when>
					   <c:otherwise>
					   		-
					   </c:otherwise>
				   </c:choose>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>

</html>
