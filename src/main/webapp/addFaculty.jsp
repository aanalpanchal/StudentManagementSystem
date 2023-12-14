<%@ page import="java.io.PrintWriter"%>
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
<title>Add Faculty</title>
<link rel="icon" href="./images/logo.png" type="image/x-icon">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<style>
.ImageContainer {
	position: absolute;
	right: 0%;
	top: 0%;
	width: 550px;
	height: 800px;
}

.ImageContainer img {
	width: 100%;
	height: 100%;
	object-fit: contain;
}
</style>
<body class="position-relative">
	<%@ include file="navbar.jsp"%>

	<div class="ImageContainer ">
		<img src="./images/faculty.jpg" alt="faculty" />
	</div>
	<div class="container mt-5 position-relative ">
		<h1 class="mb-4 ">Add Faculty</h1>
		<form method="post" action="FacultyServlet"
			class="row g-3 w-50 justify-content-center">

			<div class="col-md-6">
				<label for="Fname" class="form-label">Enter First name:</label> <input
					type="text" class="form-control" name="fname" id="Fname" required>
			</div>

			<div class="col-md-6">
				<label for="Lname" class="form-label">Enter Last name:</label> <input
					type="text" class="form-control" name="lname" id="Lname" required>
			</div>

			<div class="col-md-6">
				<label for="Email" class="form-label">Enter email:</label> <input
					type="email" class="form-control" name="email" id="Email" required>
			</div>

			<div class="col-md-6">
				<label for="Address" class="form-label">Enter Address:</label> <input
					type="text" class="form-control" name="address" id="Address"
					required>
			</div>

			<div class="col-md-6">
				<label for="Qualification" class="form-label">Enter
					Qualification:</label> <input type="text" class="form-control"
					name="qualification" id="Qualification" required>
			</div>

			<div class="col-md-6">
				<label for="Department" class="form-label">Enter Department:</label>
				<input type="text" class="form-control" name="department"
					id="Department" required>
			</div>

			<div class="col-md-6">
				<label for="Position" class="form-label">Enter Position:</label> <input
					type="text" class="form-control" name="position" id="Position"
					required>
			</div>

			<div class="col-md-6">
				<label for="DOJ" class="form-label">Enter Date of joining:</label> <input
					type="date" class="form-control" name="doj" id="DOJ" required>
			</div>

			<div class="col-12 text-center">
				<button type="submit" class="btn btn-primary w-100">Submit</button>
			</div>
		</form>
	</div>
</body>
</html>
