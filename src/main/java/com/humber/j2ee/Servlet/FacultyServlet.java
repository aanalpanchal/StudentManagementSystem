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
 * Servlet implementation class FacultyServlet
 */
@WebServlet("/FacultyServlet")
public class FacultyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;
       
    /**
     * @throws SQLException 
     * @see HttpServlet#HttpServlet()
     */
    public FacultyServlet() throws SQLException {
        super();
        connection = DBConnect.initializeDB();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (connection != null) {
            String facultyId = request.getParameter("faculty_id");
            String fname = request.getParameter("fname");
            String lname = request.getParameter("lname");
            String email = request.getParameter("email");
            String address = request.getParameter("address");
            String qualification = request.getParameter("qualification");
            String department = request.getParameter("department");
            String position = request.getParameter("position");
            String doj = request.getParameter("doj");

            StringBuilder sb = new StringBuilder();

            if (facultyId != null && !facultyId.trim().isEmpty()) {
                try {
                    PreparedStatement stmt = connection.prepareStatement("UPDATE faculty SET first_name=?, last_name=?, email=?, address=?, qualification=?, department=?, position=?, date_of_join=? WHERE faculty_id=?");

                    stmt.setString(1, fname);
                    stmt.setString(2, lname);
                    stmt.setString(3, email);
                    stmt.setString(4, address);
                    stmt.setString(5, qualification);
                    stmt.setString(6, department);
                    stmt.setString(7, position);
                    stmt.setString(8, doj);
                    stmt.setString(9, facultyId);

                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        response.sendRedirect("viewFaculties.jsp");
                    } else {
                        sb.append("Update failed.");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    PreparedStatement stmt = connection.prepareStatement("INSERT INTO faculty(first_name, last_name, email, address, qualification, department, position, date_of_join) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");

                    stmt.setString(1, fname);
                    stmt.setString(2, lname);
                    stmt.setString(3, email);
                    stmt.setString(4, address);
                    stmt.setString(5, qualification);
                    stmt.setString(6, department);
                    stmt.setString(7, position);
                    stmt.setString(8, doj);

                    int rowsAffected = stmt.executeUpdate();

                    if (rowsAffected > 0) {
                        response.sendRedirect("viewFaculties.jsp");
                    } else {
                        sb.append("Insertion failed.");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            response.getWriter().append(sb.toString());
        } else {
            response.getWriter().append("Database connection is not available.");
        }
    }
}
