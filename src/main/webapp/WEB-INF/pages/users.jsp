<%@ page language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%@ page session="false" %>
<style>
	.tg {
		border-collapse: collapse;
		border-spacing: 0;
		border-color: gray;
		word-wrap: normal;
	}
	
	.tg td {
		font-family: "Bell MT", serif;
		padding: 2px;
		font-size: 12px;
	}
	
	.tg th {
		font-family: "Arial Black", sans-serif;
		font-size: 16px;
		font-style: italic;
		padding: 10px 4px;
		border-style: solid;
		color: darkblue;
		background: aqua;
	}
	
</style>
<html>

<head>
	
	
	<title>Test task</title>
	<link rel="stylesheet"
	      href="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
	<link rel="stylesheet"
	      href="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.5.1/moment.min.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.4.0/lang/en-gb.js"></script>
	<script src="http://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/3.0.0/js/bootstrap-datetimepicker.min.js"></script>
	<script>

        jQuery(function () {
            jQuery('#createdDate').datetimepicker({
                format: 'YYYY-MM-DD HH:mm:ss',
	            maskInput: true,           // disables the text input mask
                pickDate: true,            // disables the date picker
                pickTime: true,            // disables de time picker
                pickSeconds: false,         // disables seconds in the time picker
                ignoreReadonly: true,
                defaultDate: Date.now()
            });
        });
	</script>
</head>
<body>
<a href="../../index.jsp">Back to the main page</a>
<br>

<form action="<c:url value="/users/search/"/>" method="get">
<input type="text" name="text" title="Search">
	<input type="submit" value="Search">
</form>

<c:if test="${!empty searchedUsers}">
	<h3>Found Users</h3>
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
		<c:forEach items="${searchedUsers}" var="user">
			<tr>
				<td>${user.id}</td>
				<td>${user.name}</td>
				<td>${user.age}</td>
				<td><fmt:formatDate value="${user.createdDate}" pattern="dd.MM.yyyy HH:mm"/></td>
				<td>${user.isAdmin == true ? "+" : "-"}</td>
				<td><a href="/edit/${user.id}">Edit</a></td>
				<td><a href="/remove/${user.id}">Delete</a></td>
			</tr>
		</c:forEach>
	
	</table>
</c:if>
<c:if test="${!empty listUsers}">
	<h3>User list</h3>
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
				<td><fmt:formatDate value="${user.createdDate}" pattern="dd.MM.yyyy HH:mm"/></td>
				<td>${user.isAdmin == true ? "+" : "-"}</td>
				<td><a href="/edit/${user.id}">Edit</a></td>
				<td><a href="/remove/${user.id}">Delete</a></td>
			</tr>
		</c:forEach>
	
	</table>
</c:if>
<br>
<br>
<h3>Add a user</h3>
<c:url var="addAction" value="/users/add"/>
<form:form action="${addAction}" commandName="user">
	<table border="1">
		<c:if test="${!empty user.name}">
			<tr>
				<td>
					<form:label path="id">
						<spring:message text="ID"/>
					</form:label>
				</td>
				<td>
					<form:input path="id" readonly="true" size="8"
					            disabled="true"/>
					<form:hidden path="id"/>
				</td>
			</tr>
		</c:if>
		<tr>
			<td>
				<form:label path="name">
					<spring:message text="Name"/>
				</form:label>
			</td>
			<td>
				<form:input path="name" title="Your name, have to be completed"/>
			</td>
			<td>
				<form:label path="age">
					<spring:message text="Age"/>
				</form:label>
			</td>
			<td>
				<form:input path="age" title="Integer representation of your age (full years)"/>
			</td>
			<td>
				<form:label path="createdDate">
					<spring:message text="Created Date"/>
				</form:label>
			</td>
			<td>
				<form:input path="createdDate" readonly="true"/>
			
			</td>
			
			<td>
				<form:label path="isAdmin">
					<spring:message text="Is Admin"/>
				</form:label>
			</td>
			<td width="50">
				<form:checkbox path="isAdmin"/>
			</td>
			<td colspan="2">
				<c:if test="${!empty user.name}">
					<input type="submit" value="<spring:message text="Edit user"/>">
				</c:if>
				<c:if test="${empty user.name}">
					<input type="submit" value="<spring:message text="Add user"/>">
				</c:if>
			</td>
		</tr>
	</table>
</form:form>
<br>
<div id="pagination" align="center">
	
	<c:url value="/users" var="prev">
		<c:param name="page" value="${page-1}"/>
	</c:url>
	<c:if test="${page > 1}">
		<a href="<c:out value="${prev}" />" class="pn prev">Prev</a>
	</c:if>
	
	<c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
		<c:choose>
			<c:when test="${page == i.index}">
				<span>${i.index}</span>
			</c:when>
			<c:otherwise>
				<c:url value="/users" var="url">
					<c:param name="page" value="${i.index}"/>
				</c:url>
				<a href='<c:out value="${url}" />'>${i.index}</a>
			</c:otherwise>
		</c:choose>
	</c:forEach>
	<c:url value="/users" var="next">
		<c:param name="page" value="${page + 1}"/>
	</c:url>
	<c:if test="${page + 1 <= maxPages}">
		<a href='<c:out value="${next}" />' class="pn next">Next</a>
	</c:if>
</div>
</body>
</html>
