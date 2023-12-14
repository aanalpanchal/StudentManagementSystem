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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="icon" href="./images/logo.png" type="image/x-icon">

<title>Assigned Students</title>
<style>
</style>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container mt-5">
		<h1>Assigned Students</h1>
		<%
		Connection conn = DBConnect.initializeDB();
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBConnect.initializeDB();
			ps = conn.prepareStatement("SELECT a.marks, f.faculty_id, f.first_name AS faculty_fname, f.last_name AS faculty_lname, "
			+ "GROUP_CONCAT(CONCAT(s.first_name, ' ', s.last_name) SEPARATOR ', ') AS students "
			+ "FROM assign_students a " + "JOIN student s ON a.student_id = s.student_id "
			+ "JOIN faculty f ON a.faculty_id = f.faculty_id " + "GROUP BY a.marks, f.faculty_id");
			rs = ps.executeQuery();
		%>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Faculty name</th>
					<th>Assigned Students</th>
					<th>Marks</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				while (rs.next()) {
					Integer facultyId = rs.getInt("faculty_id");
					String facultyFirstName = rs.getString("faculty_fname");
					String facultyLastName = rs.getString("faculty_lname");
					String facultyName = facultyFirstName + " " + facultyLastName;
					String assignedStudents = rs.getString("students");
					int marks = rs.getInt("marks");
				%>
				<tr>
					<td><%=facultyName%></td>
					<td><%=assignedStudents%></td>
					<td><%=marks%></td>
					<td class="d-flex flex-column gap-2"><a class="btn btn-primary btn-sm" href="assignMarks.jsp?faculty_id=<%=facultyId%>">Add marks</a></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} catch (SQLException e) {
		e.printStackTrace();
		} finally {
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		}
		%>
	</div>

</body>
</html>