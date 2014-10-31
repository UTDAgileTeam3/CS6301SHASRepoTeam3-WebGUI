package edu.utdallas.shas;

import java.io.IOException;

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
		String email = req.getParameter("new_phonenumber");
		String phonenumber = req.getParameter("new_email");
		
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
