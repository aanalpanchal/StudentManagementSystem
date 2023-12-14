<%@ page
	import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, com.humber.j2ee.config.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("index.html");
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="./images/logo.png" type="image/x-icon">

<title>Assign Students</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<style>
.horizontal-checkboxes {
	display: flex;
	flex-wrap: wrap;
}

.form-check {
	margin-right: 10px; /* Adjust the margin as needed */
}
</style>
</head>
<body>
	<%
	Connection conn = DBConnect.initializeDB();
	PreparedStatement ps = null;
	ResultSet rs = null;

	try {
		ps = conn.prepareStatement("SELECT faculty_id, first_name, last_name FROM faculty");
		rs = ps.executeQuery();
	%>
	<%@ include file="navbar.jsp"%>

	<div class="container mt-5">
		<h1>Assign Students</h1>
		<form method="post" action="AssignStudentServlet">

			<div class="mb-3">
				<label for="Faculty" class="form-label">Select Faculty:</label> <select
					name="facultyId" id="Faculty" class="form-select" required>
					<%
					while (rs.next()) {
						int facultyId = rs.getInt("faculty_id");
						String facultyName = rs.getString("first_name") + " " + rs.getString("last_name");
						out.println("<option value='" + facultyId + "'>" + facultyName + "</option>");
					}
					%>
				</select>
			</div>

			<div class="mb-3">
				<label for="Students" class="form-label">Select Students:</label>
				<%
				ps = conn.prepareStatement("SELECT student_id, first_name, last_name FROM student");
				rs = ps.executeQuery();

				while (rs.next()) {
					int studentId = rs.getInt("student_id");
					String studentName = rs.getString("first_name") + " " + rs.getString("last_name");
				%>
				<div class='form-check cursor-pointer'>
					<input type='checkbox' class='form-check-input'
						id='student<%=studentId%>' name='studentId' value='<%=studentId%>'>
					<label class='form-check-label' for='student<%=studentId%>'><%=studentName%></label>
				</div>
				<%
				}
				%>
			</div>

			<button type="submit" class="btn btn-primary">Submit</button>
		</form>
	</div>
	<%
	} catch (SQLException ex) {
	ex.printStackTrace();
	} finally {
	try {
		if (conn != null)
			conn.close();
	} catch (SQLException e) {
		e.printStackTrace();
	}
	}
	%>
</body>
</html>
