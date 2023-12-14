<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException, com.humber.j2ee.config.DBConnect" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("index.html");
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Student</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="icon" href="./images/logo.png" type="image/x-icon">
</head>
<body>

<jsp:include page="navbar.jsp" />

<%
    int studentId = Integer.parseInt(request.getParameter("student_id"));    
%>

<div class="container mt-5 d-flex flex-column align-items-center">
    <h1>Delete Student</h1>

    <form method="post" action="DeleteStudentServlet">
        <p>Are you sure you want to delete this student?</p>

        <input type="hidden" name="student_id" value="<%= studentId %>">
	<div class="d-flex flex-column justify-content-center gap-3">
        <button type="submit" class="btn btn-danger" name="action" value="delete">Delete</button>
        <a href="home.jsp" class="btn btn-secondary">Cancel</a>
	</div>
    </form>
</div>
</body>
</html>
