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
<title>Student</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link rel="icon" href="./images/logo.png" type="image/x-icon">
<style>
.StudentBg{
position:absolute;
bottom:0;
height:200px;
width:100%;
z-index:-10;
}
.StudentBg img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}
</style>
</head>
<body>

	<%@ include file="navbar.jsp"%>
	<div class="StudentBg">
		<img src="./images/studentBg.jpg" alt="studentBg" />
	</div>
	<div class="container mt-5">
		<h1 class="text-center">Add Student</h1>

		<form method="post" action="StudentServlet">
			<div class="row">
				<div class="col-md-6">
					<div class="mb-3">
						<label for="Fname" class="form-label">Enter First name:</label> <input
							type="text" class="form-control" name="fname" id="Fname" required>
					</div>

					<div class="mb-3">
						<label for="Lname" class="form-label">Enter Last name:</label> <input
							type="text" class="form-control" name="lname" id="Lname" required>
					</div>

					<div class="mb-3">
						<label for="Email" class="form-label">Enter email:</label> <input
							type="email" class="form-control" name="email" id="Email"
							required>
					</div>
					<div class="mb-3">
						<label for="DOB" class="form-label">Enter Date of Birth:</label> <input
							type="date" class="form-control" name="dob" id="DOB" required>
					</div>
				</div>

				<div class="col-md-6">


					<div class="mb-3">
						<label for="Pname" class="form-label">Enter Program name:</label>
						<input type="text" class="form-control" name="pname" id="Pname"
							required>
					</div>

					<div class="mb-3">
						<label for="Cname" class="form-label">Enter Course name:</label> <input
							type="text" class="form-control" name="cname" id="Cname" required>
					</div>

					<div class="mb-3">
						<label for="Ctype" class="form-label">Enter Course type:</label> <input
							type="text" class="form-control" name="ctype" id="Ctype" required>
					</div>

					<div class="mb-3">
						<label for="Doe" class="form-label">Enter Enrollment date:</label>
						<input type="date" class="form-control" name="doe" id="Doe"
							required>
					</div>
				</div>
			</div>

			<button type="submit" class="btn btn-primary w-100">Submit</button>
		</form>
	</div>

</body>
</html>
