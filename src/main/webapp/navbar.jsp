<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String username = (String) session.getAttribute("username");
%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
	crossorigin="anonymous"></script>
</head>
<style>
.custom-width {
	width: 70px !important;
	
}
.minus-margin{

	margin-left:-50px;
}
</style>

<body>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid px-5">
			<a class="navbar-brand" href="index.jsp"><img
				src="./images/logo.png" width=70 height=50></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div
				class="collapse navbar-collapse d-flex align-items-center justify-content-between"
				id="navbarNavDropdown">
				<ul class="navbar-nav d-flex gap-3">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="home.jsp">Home</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Student
							Services </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="addStudent.jsp">Add
									Student</a></li>

						</ul></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> Faculty
							Services </a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="addFaculty.jsp">Add
									Faculty</a></li>
							<li><a class="dropdown-item" href="viewFaculties.jsp">View
									Faculties</a></li>
							<li><hr class="dropdown-divider"></li>
							<li><a class="dropdown-item" href="assignStudents.jsp">Assign
									Students</a></li>

							<li><a class="dropdown-item" href="viewAssignedStudents.jsp">View
									Assigned Students</a></li>
						</ul></li>
				</ul>
				<div>
					<div class="nav-item dropdown text-white custom-width ">
						<a class="nav-link dropdown-toggle" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> <%=username%>
						</a>
						<ul class="dropdown-menu minus-margin">
							<li><a class="dropdown-item "
								href="LogoutServlet">Logout</a></li>

						</ul>
					</div>
				</div>

			</div>
		</div>
	</nav>
</body>
</html>
