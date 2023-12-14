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
<title>Update Student</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="icon" href="./images/logo.png" type="image/x-icon">
</head>
<body>

	<jsp:include page="navbar.jsp" />

	<%
	int studentId = Integer.parseInt(request.getParameter("student_id"));

	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	try {
		conn = DBConnect.initializeDB();
		ps = conn.prepareStatement(
		"SELECT first_name, last_name, email, dob, program, course_name, course_type, date_of_enrolled "
				+ "FROM student WHERE student_id = ?");
		ps.setInt(1, studentId);
		rs = ps.executeQuery();

		while (rs.next()) {
			String fname = rs.getString("first_name");
			String lname = rs.getString("last_name");
			String email = rs.getString("email");
			String dob = rs.getString("dob");
			String program = rs.getString("program");
			String course = rs.getString("course_name");
			String course_type = rs.getString("course_type");
			String enrollment_date = rs.getString("date_of_enrolled");
	%>

	<div class="container mt-5">
		<h1 class="mb-4 text-center">Update Student Information</h1>
		<form method="post" action="StudentServlet">
			<div class="row">
				<div class="col-md-6">
					<div class="mb-3">
						<label for="Fname" class="form-label">First Name:</label> <input
							type="text" name="fname" id="Fname" class="form-control"
							value="<%=fname%>" required>
					</div>
					<div class="mb-3">
						<label for="Lname" class="form-label">Last Name:</label> <input
							type="text" name="lname" id="Lname" class="form-control"
							value="<%=lname%>" required>
					</div>
					<div class="mb-3">
						<label for="Email" class="form-label">Email:</label> <input
							type="email" name="email" id="Email" class="form-control"
							value="<%=email%>" required>
					</div>
					<div class="mb-3">
						<label for="DOB" class="form-label">Date of Birth:</label> <input
							type="date" name="dob" id="DOB" class="form-control"
							value="<%=dob%>" required>
					</div>
				</div>
				<div class="col-md-6">

					<div class="mb-3">
						<label for="Pname" class="form-label">Program Name:</label> <input
							type="text" name="pname" id="Pname" class="form-control"
							value="<%=program%>" required>
					</div>
					<div class="mb-3">
						<label for="Cname" class="form-label">Course Name:</label> <input
							type="text" name="cname" id="Cname" class="form-control"
							value="<%=course%>" required>
					</div>
					<div class="mb-3">
						<label for="Ctype" class="form-label">Course Type:</label> <input
							type="text" name="ctype" id="Ctype" class="form-control"
							value="<%=course_type%>" required>
					</div>
					<div class="mb-3">
						<label for="Doe" class="form-label">Enrollment Date:</label> <input
							type="date" name="doe" id="Doe" class="form-control"
							value="<%=enrollment_date%>" required>
					</div>
				</div>
			</div>

			<input type="hidden" name="student_id" id="Student_id"
				value="<%=studentId%>" required>

			<button type="submit" class="btn btn-primary w-100">Update</button>
		</form>
	</div>


	<%
	}
	rs.close();
	ps.close();
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

</body>
</html>
