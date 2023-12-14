<%@ page
	import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException, com.humber.j2ee.config.DBConnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
if (session == null || session.getAttribute("username") == null) {
	response.sendRedirect("index.html");
}
%>
<%!private String generateFilterOptions(String columnName) {
		StringBuilder options = new StringBuilder();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;

		try {
			conn = DBConnect.initializeDB();
			ps = conn.prepareStatement("SELECT DISTINCT " + columnName + " FROM student");
			rs = ps.executeQuery();

			while (rs.next()) {
				String value = rs.getString(columnName);
				options.append("<option value=\"").append(value).append("\">").append(value).append("</option>");
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

		return options.toString();
	}%>

<div class="row">
	<div class="col-4">
		<label for="courseTypeFilter" class="form-label">Course Type:</label>
		<select class="form-select" id="courseTypeFilter" name="courseType">
			<option value="">All</option>
			<%=generateFilterOptions("course_type")%>
		</select>
	</div>
	<div class="col-4">
		<label for="courseNameFilter" class="form-label">Course Name:</label>
		<select class="form-select" id="courseTypeFilter" name="courseName">
			<option value="">All</option>
			<%=generateFilterOptions("course_name")%>
		</select>
	</div>
	<div class="col-4">

		<label for="programNameFilter" class="form-label">Program
			Name:</label> <select class="form-select" id="programNameFilter"
			name="programName">
			<option value="">All</option>
			<%=generateFilterOptions("program")%>
		</select>
	</div>
	<div class="col-4 mt-2">
		<label for="firstNameFilter" class="form-label">Program
			Name:</label> <select class="form-select" id="firstNameFilter"
			name="firstName">
			<option value="">All</option>
			<%=generateFilterOptions("first_name")%>
		</select>
	</div>
<div class="col-4 mt-2">
		<label for="lastNameFilter" class="form-label">Program
			Name:</label> <select class="form-select" id="lastNameFilter"
			name="lastName">
			<option value="">All</option>
			<%=generateFilterOptions("last_name")%>
		</select>
	</div>
</div>
