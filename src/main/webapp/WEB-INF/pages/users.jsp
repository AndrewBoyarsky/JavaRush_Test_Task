<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri ="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri ="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri ="http://www.springframework.org/tags/form" prefix="from"%>

<%@page session="false" %>
<style>
	tg {
		border-collapse: collapse;
		border-spacing: 0px;
		border-color: gray;
		word-wrap: normal;
	}
	.tg td {
		font-family: "Bell MT";
		padding: 2px;
		font-size: 12px;
	}
	.tg th {
		font-family: "Arial Black";
		font-size: 16px;
		font-style: italic;
		padding: 10px 4px;
		border-style: solid;
		color: darkblue;
		background: aqua;
	}
	.tg .tg-4eph {
		background: yellow;
	}
	
</style>
<html>
<head>
	<title>Test task</title>
</head>
<body>
	<a href="../../index.jsp">Back to the main page</a>
	<br>
	<br>
	<br>
<h3>User list</h3>
	<jsp:useBean id="controller" scope="request" type="com.bocco.test.controller.UserController"/>
<c:if test="${!empty listUsers}">
	<table class="tg">
		<tr>
			<th width="50">ID</th>
			<th width="100">Name</th>
			<th width="30">Age</th>
			<th width="125">Created date</th>
			<th width="50">is Admin</th>
			<th width="40">Edit</th>
			<th width="40">Delete</th>
		</tr>
		<c:forEach items="${listUsers}" var="user">
		<tr>
			<td>${user.id}</td>
			<td>${user.name}</td>
			<td>${user.age}</td>
			<td>${user.createdDate}</td>
			<td>${user.isAdmin}</td>
			<td><a href="<c:url value="/edit/${user.id}"/>">Edit</a> </td>
			<td><a href="<c:url value="/remove/${user.id}"/>">Delete</a> </td>
		</tr>
		</c:forEach>
	</table>
</c:if>
</body>
</html>
