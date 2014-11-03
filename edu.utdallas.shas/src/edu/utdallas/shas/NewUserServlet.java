package edu.utdallas.shas;

import java.sql.Statement;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewUserServlet extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String name = req.getParameter("new_name");
		String newusername = req.getParameter("new_uname");
		String newpassword = req.getParameter("new_password");
		String confirmpassword = req.getParameter("confirm_new_password");
		String email = req.getParameter("new_email");
		String phonenumber = req.getParameter("new_phonenumber");
		
		Properties properties = new Properties();
		properties.load(getServletContext().getResourceAsStream("/WEB-INF/database.properties"));
		System.out.println(properties);
		String url = properties.getProperty("jdbc.url");
		String driver = properties.getProperty("jdbc.driver");
		String username = properties.getProperty("jdbc.username");
		String password = properties.getProperty("jdbc.password");

		try {
			Class.forName(driver);
			Connection myConn=DriverManager.getConnection(url, username, password);
			Statement statement = myConn.createStatement() ;
			String query = "insert into shasuser (username, password, name, phonenumber, address, accesslevel) "
					+ "values('"+newusername+"', '"+newpassword+"', '"+name+"', "+ phonenumber+", '"+email+"', 1)";
			System.out.println("*****************************Query:  "+query);
			statement.execute(query) ;
			statement.close();
			myConn.close();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		System.out.println("User info::: ");
		System.out.println("Name: "+name+"\nUname: "+newusername+"\npwd: "+newpassword+"\n confirm: "+confirmpassword+"\n email: "+email+"\n phone: "+phonenumber);
		RequestDispatcher rd = req.getRequestDispatcher("./newUser.jsp");
		rd.forward(req, resp);
		
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		super.doGet(req, resp);
	}

}
