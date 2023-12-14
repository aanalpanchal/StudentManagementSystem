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
<title>Update Faculty</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="icon" href="./images/logo.png" type="image/x-icon">
</head>
<body>
	<jsp:include page="navbar.jsp" />
	<div class="container mt-5">
		<h1 class="mb-4 text-center">Update Faculty</h1>
		<%
		String facultyIdParam = request.getParameter("faculty_id");
		if (facultyIdParam != null) {
			int facultyId = Integer.parseInt(facultyIdParam);
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;

			try {
				conn = DBConnect.initializeDB();
				ps = conn.prepareStatement("SELECT * FROM faculty WHERE faculty_id = ?");
				ps.setInt(1, facultyId);
				rs = ps.executeQuery();

				if (rs.next()) {
			String fname = rs.getString("first_name");
			String lname = rs.getString("last_name");
			String email = rs.getString("email");
			String address = rs.getString("address");
			String qualification = rs.getString("qualification");
			String department = rs.getString("department");
			String position = rs.getString("position");
			String doj = rs.getString("date_of_join");
		%>
		<form method="post" action="FacultyServlet">
			<div class="row">
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label" for="Fname">Enter First name: </label> <input
							type="text" class="form-control" name="fname" id="Fname"
							value="<%=fname%>" required>
					</div>
					<div class="mb-3">
						<label class="form-label" for="Lname">Enter Last name: </label> <input
							type="text" class="form-control" name="lname" id="Lname"
							value="<%=lname%>" required>
					</div>
					<div class="mb-3">
						<label class="form-label" for="Email">Enter email: </label><br>
						<input type="email" class="form-control" name="email" id="Email"
							value="<%=email%>" required>
					</div>
					<div class="mb-3">
						<label class="form-label" for="Address">Enter Address: </label> <input
							type="text" class="form-control" name="address" id="Address"
							value="<%=address%>" required>
					</div>
				</div>
				<div class="col-md-6">
					<div class="mb-3">
						<label class="form-label" for="Qualification">Enter Qualification: </label> <input
							type="text"  class="form-control" name="qualification" id="Qualification"
							value="<%=qualification%>" required>
					</div>
					<div class="mb-3">
						<label class="form-label" for="Department">Enter
							Department: </label> <input type="text" class="form-control"
							name="department" id="Department" value="<%=department%>"
							required>
					</div>
					<div class="mb-3">
						<label class="form-label" for="Position">Enter Position: </label> <input class="form-control" type="text"
							class="form-control" name="position" id="Position"
							value="<%=position%>" required>
					</div>
					<div class="mb-3">
						<label class="form-label" for="DOJ">Enter Date of joining: </label> <input
							type="date" class="form-control" name="doj" id="DOJ" value="<%=doj%>" required>
					</div>
				</div>
				<button type="submit" class="btn btn-primary w-100">Update</button>
			</div>
		</form>
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
		}
		%>
	</div>
</body>
</html>
