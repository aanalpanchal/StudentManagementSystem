package com.humber.j2ee.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.humber.j2ee.config.DBConnect;

/**
 * Servlet implementation class DeleteFacultyServlet
 */
@WebServlet("/DeleteFacultyServlet")
public class DeleteFacultyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int studentId = Integer.parseInt(request.getParameter("faculty_id"));

		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = DBConnect.initializeDB();
			ps = conn.prepareStatement("DELETE FROM faculty WHERE faculty_id = ?");
			ps.setInt(1, studentId);
			ps.executeUpdate();

			response.sendRedirect("viewFaculties.jsp");
		} catch (SQLException e) {
			e.printStackTrace();

			response.sendRedirect("error.jsp");
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
