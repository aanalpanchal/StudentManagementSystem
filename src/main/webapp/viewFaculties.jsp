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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="icon" href="./images/logo.png" type="image/x-icon">

<meta charset="UTF-8">
<title>Faculties</title>

</head>
<body>
	<%@ include file="navbar.jsp"%>
	<div class="container">
		<h1>Faculty List</h1>
		<%
		if (request.getParameter("deleteFaculty") != null) {
			String facultyIdToDelete = request.getParameter("faculty_id");
			if (facultyIdToDelete != null && !facultyIdToDelete.isEmpty()) {
				try {
			Connection connection = DBConnect.initializeDB();
			String deleteQuery = "DELETE FROM faculty WHERE faculty_id = ?";
			PreparedStatement pstmt = connection.prepareStatement(deleteQuery);
			pstmt.setInt(1, Integer.parseInt(facultyIdToDelete));
			int rowsAffected = pstmt.executeUpdate();

			if (rowsAffected > 0) {
				response.sendRedirect("viewFaculties.jsp");
			} else {
				out.println("Failed to delete faculty.");
			}
			pstmt.close();
			connection.close();
				} catch (SQLException e) {
			e.printStackTrace();
			out.println("Database error: " + e.getMessage());
				}
			} else {
				out.println("Invalid faculty ID for deletion.");
			}
		}
		%>

		<table class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>First name</th>
					<th>Last name</th>
					<th>Email</th>
					<th>Address</th>
					<th>Qualification</th>
					<th>Department</th>
					<th>Position</th>
					<th>Date of joining</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				Connection conn = null;
				PreparedStatement ps = null;
				ResultSet rs = null;
				try {
					conn = DBConnect.initializeDB();
					ps = conn.prepareStatement(
					"SELECT faculty_id, first_name, last_name, email, address, qualification, department, position, date_of_join FROM faculty");
					rs = ps.executeQuery();
					while (rs.next()) {
						int fid = rs.getInt("faculty_id");
						String fname = rs.getString("first_name");
						String lname = rs.getString("last_name");
						String email = rs.getString("email");
						String address = rs.getString("address");
						String qualification = rs.getString("qualification");
						String department = rs.getString("department");
						String position = rs.getString("position");
						String doj = rs.getString("date_of_join");
				%>
				<tr>
					<td><%=fname%></td>
					<td><%=lname%></td>
					<td><%=email%></td>
					<td><%=address%></td>
					<td><%=qualification%></td>
					<td><%=department%></td>
					<td><%=position%></td>
					<td><%=doj%></td>
					<td class="d-flex flex-column gap-2"><a
						class="btn btn-primary btn-sm"
						href="updateFaculty.jsp?faculty_id=<%=fid%>">Update</a> <a
						class="btn btn-danger btn-sm"
						href="deleteFaculty.jsp?faculty_id=<%=fid%>&deleteFaculty=true">Delete</a>
					</td>
				</tr>
				<%
				}
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
			</tbody>
		</table>
	</div>
</body>
</html>