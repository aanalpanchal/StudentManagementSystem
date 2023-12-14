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
<title>Assign Students</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="icon" href="./images/logo.png" type="image/x-icon">
</head>
<body>
	<%
	Connection conn = DBConnect.initializeDB();
	PreparedStatement ps = null;
	ResultSet rs = null;

	int facultyId = Integer.parseInt(request.getParameter("faculty_id"));

	try {
		ps = conn.prepareStatement("SELECT faculty_id, first_name, last_name FROM faculty WHERE faculty_id = ?");
		ps.setInt(1, facultyId);
		rs = ps.executeQuery();
		String facultyName = "";

		if (rs.next()) {
			facultyName = rs.getString("first_name") + " " + rs.getString("last_name");
		}

		ps = conn.prepareStatement("SELECT s.student_id, s.first_name, s.last_name " + "FROM assign_students a "
		+ "JOIN student s ON a.student_id = s.student_id " + "JOIN faculty f ON a.faculty_id = f.faculty_id "
		+ "WHERE f.faculty_id = ? " + "GROUP BY s.student_id");
		ps.setInt(1, facultyId);
		rs = ps.executeQuery();
	%>
	<%@ include file="navbar.jsp"%>

	<div class="container mt-5">
		<h1>Assign Student's marks</h1>
		<form method="post" action="AddMarksServlet">
			<div class="mb-3">
				<label class="form-label" for="Faculty">Faculty Name: </label> <input
					class="form-control" type="text" name="facultyName" id="Faculty"
					value="<%=facultyName%>" readonly>
					<input type="hidden" name="facultyId" value="<%=facultyId%>">
			</div>
			<div class="mb-3">
				<label class="form-label" for="Students">Select Students: </label><select
					class="form-select" name="studentId" id="Students" required>
					<%
					while (rs.next()) {
						int studentId = rs.getInt("student_id");
						String studentName = rs.getString("first_name") + " " + rs.getString("last_name");
						out.println("<option value='" + studentId + "'>" + studentName + "</option>");
					}
					%>
				</select>
			</div>
			<div class="mb-3">
				<label class="form-label" for="marks">Enter Marks: </label> <input
					class="form-control" type="text" name="marks" id="Marks" required>
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
