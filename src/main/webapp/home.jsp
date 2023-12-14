

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

<title>Home</title>
<style>
</style>
</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container mt-5">
		<h1 class="text-center mb-3">Enrolled Students</h1>
		<form method="get" action="home.jsp" class="mb-3">
			<div class="row">

				<%@ include file="filterOptions.jsp"%>


			</div>
			<button type="submit" class="btn btn-primary mt-2">Filter</button>
		</form>


		<table class="table table-bordered table-striped">

			<thead>
				<tr>
					<th>First name</th>
					<th>Last name</th>
					<th>Email-id</th>
					<th>Date of birth</th>
					<th>Program name</th>
					<th>Course name</th>
					<th>Course type</th>
					<th>Date of enrollment</th>
					<th>Actions</th>
				</tr>
			</thead>


			<tbody>
				<%
		
				String courseType = request.getParameter("courseType");
				String programName = request.getParameter("programName");
				String courseName = request.getParameter("courseName");
				String firstName = request.getParameter("firstName");
				String lastName = request.getParameter("lastName");

				
			

				Connection conn = null;
				PreparedStatement ps = null;
				ResultSet rs = null;

				try {
					conn = DBConnect.initializeDB();

			
					String sql = "SELECT student_id, first_name, last_name, email, dob, program, course_name, course_type, date_of_enrolled FROM student WHERE 1=1";

					if (courseType != null && !courseType.isEmpty()) {
						sql += " AND course_type = ?";
					}

					if (programName != null && !programName.isEmpty()) {
						sql += " AND program = ?";
					}

					if (courseName != null && !courseName.isEmpty()) {
						sql += " AND course_name = ?";
					}
					if (firstName != null && !firstName.isEmpty()) {
						sql += " AND first_name = ?";
					}
					if (lastName != null && !lastName.isEmpty()) {
						sql += " AND last_name = ?";
					}

					ps = conn.prepareStatement(sql);

				
					int paramIndex = 1;
					if (courseType != null && !courseType.isEmpty()) {
						ps.setString(paramIndex++, courseType);
					}

					if (programName != null && !programName.isEmpty()) {
						ps.setString(paramIndex++, programName);
					}

					if (courseName != null && !courseName.isEmpty()) {
						ps.setString(paramIndex++, courseName);
					}

					if (firstName != null && !firstName.isEmpty()) {
						ps.setString(paramIndex++, firstName);
					}

					if (lastName != null && !lastName.isEmpty()) {
						ps.setString(paramIndex++, lastName);
					}

					

					rs = ps.executeQuery();

				
					while (rs.next()) {
						int sid = rs.getInt("student_id");
						String fname = rs.getString("first_name");
						String lname = rs.getString("last_name");
						String email = rs.getString("email");
						String dob = rs.getString("dob");
						String ptype = rs.getString("program");
						String cname = rs.getString("course_name");
						String ctype = rs.getString("course_type");
						String doe = rs.getString("date_of_enrolled");
				%>
				<tr>
					<td><%=fname%></td>
					<td><%=lname%></td>
					<td><%=email%></td>
					<td><%=dob%></td>
					<td><%=ptype%></td>
					<td><%=cname%></td>
					<td><%=ctype%></td>
					<td><%=doe%></td>
					<td class="d-flex flex-column gap-2"><a
						href="updateStudent.jsp?student_id=<%=sid%>"
						class="btn btn-primary btn-sm"> Update</a> <a
						href="deleteStudent.jsp?student_id=<%=sid%>&action=delete"
						class="btn btn-danger btn-sm">Delete</a></tr>
				<%
				}
				} catch (SQLException e) {
				e.printStackTrace();
				} finally {
				try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (conn != null)
					conn.close();
				} catch (SQLException e) {
				e.printStackTrace();
				}
				}
				%>

			</tbody>
		</table>
	</div>
</body>
</html>

