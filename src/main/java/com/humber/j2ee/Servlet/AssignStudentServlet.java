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
 * Servlet implementation class AssignStudentServlet
 */
@WebServlet("/AssignStudentServlet")
public class AssignStudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;
    
    /**
     * @throws SQLException 
     * @see HttpServlet#HttpServlet()
     */
    public AssignStudentServlet() throws SQLException {
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
	        String[] studentIds = request.getParameterValues("studentId");
	        int facultyId = Integer.parseInt(request.getParameter("facultyId"));

	        StringBuilder sb = new StringBuilder();
	        
            try {
            	PreparedStatement stmt = connection.prepareStatement("INSERT INTO assign_students(student_id, faculty_id) VALUES (?, ?)");
            	int rowsAffected = 0;
                for (String studentId : studentIds) {
                    int studentIdInt = Integer.parseInt(studentId);
                	stmt.setInt(1, studentIdInt);
                	stmt.setInt(2, facultyId);
                	rowsAffected = stmt.executeUpdate();
                }

                if (rowsAffected > 0) {
                    response.sendRedirect("viewAssignedStudents.jsp");
                } else {
                    sb.append("Insertion failed.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (IOException e) {
                e.printStackTrace();
            }
            response.getWriter().append(sb.toString());	        
	    } else {
	        response.getWriter().append("Database connection is not available.");
	    }
	    doGet(request, response);
	}

}
