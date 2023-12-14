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
 * Servlet implementation class ItemServlet
 */
@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StudentServlet() {
        super();
        try {
			connection = DBConnect.initializeDB();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    if (connection != null) {
	        String studentId = request.getParameter("student_id");
	        String fname = request.getParameter("fname");
	        String lname = request.getParameter("lname");
	        String email = request.getParameter("email");
	        String dob = request.getParameter("dob");
	        String pname = request.getParameter("pname");
	        String cname = request.getParameter("cname");
	        String ctype = request.getParameter("ctype");
	        String doe = request.getParameter("doe");
	        
	        StringBuilder sb = new StringBuilder();

	        if (studentId != null && studentId.trim().length() > 0) {
	            try {
	                PreparedStatement stmt = connection.prepareStatement("UPDATE student SET first_name=?, last_name=?, email=?, dob=?, program=?, course_name=?, course_type=?, date_of_enrolled=? WHERE student_id=?");
	                
	                stmt.setString(1, fname);
	                stmt.setString(2, lname);
	                stmt.setString(3, email);
	                stmt.setString(4, dob);
	                stmt.setString(5, pname);
	                stmt.setString(6, cname);
	                stmt.setString(7, ctype);
	                stmt.setString(8, doe);
	                stmt.setString(9, studentId);

	                int rowsAffected = stmt.executeUpdate();

	                if (rowsAffected > 0) {
	                    response.sendRedirect("home.jsp");
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
	                PreparedStatement stmt = connection.prepareStatement("INSERT INTO student(first_name, last_name, email, dob, program, course_name, course_type, date_of_enrolled) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
	                
	                stmt.setString(1, fname);
	                stmt.setString(2, lname);
	                stmt.setString(3, email);
	                stmt.setString(4, dob);
	                stmt.setString(5, pname);
	                stmt.setString(6, cname);
	                stmt.setString(7, ctype);
	                stmt.setString(8, doe);

	                int rowsAffected = stmt.executeUpdate();

	                if (rowsAffected > 0) {
	                    response.sendRedirect("home.jsp");
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
