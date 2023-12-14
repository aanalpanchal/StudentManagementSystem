package com.humber.j2ee.Servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.humber.j2ee.config.DBConnect;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Connection connection;

	/**
	 * @throws SQLException 
	 * @see HttpServlet#HttpServlet()
	 */
	public LoginServlet() throws SQLException {
		super();
		connection = DBConnect.initializeDB();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
//		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		if (connection != null) {
			String username = request.getParameter("email");
	        String password = request.getParameter("password");
	        StringBuilder sb = new StringBuilder();
	
	        if ((username != null && username.trim().length() > 0) && (password != null && password.trim().length() > 0)) {
			    try {
			        PreparedStatement stmt = connection.prepareStatement("SELECT * FROM user where email = ? and password = ?");
			        stmt.setString(1, username);
			        stmt.setString(2, password);

			        ResultSet rs = stmt.executeQuery();
			        boolean result = false;			        
			        
		        	while (rs.next()) {
		        		result = true;
		        	}
		        	
		        	if(result) {
		        	    HttpSession session = request.getSession();
		        	    session.setAttribute("username", username);

		        	    response.sendRedirect("home.jsp");
	        		} else {
	        			String errorMessage = "Enter correct email and password";
	        			request.setAttribute("error", errorMessage);
	        		}

			        rs.close();
			        stmt.close();
			    } catch (SQLException e) {
			        e.printStackTrace();
			    }	
			    response.getWriter().append(sb.toString());
			} else {
				response.getWriter().append("Please enter correct data.");				
			}
		} else {
		    response.getWriter().append("Database connection is not available.");
		}
		doGet(request, response);
	}
}