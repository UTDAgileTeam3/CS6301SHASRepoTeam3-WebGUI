package edu.utdallas.shas;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet{
	PrintWriter out = null;
	@Override
	public void init() throws ServletException {
		System.out.println("inside init !!!!!!!!!!!!");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = null;
		id = req.getParameter("id");
		try {
			out = resp.getWriter();
			out.println("<b>Hello User id="+id+"</b>");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String uname = null;
		String pwd = null;
		uname = req.getParameter("uname");
		pwd= req.getParameter("password");
		
		
		try {
			if(uname.equals("admin") && pwd.equals("SHAS"))
			{
				req.getSession().setAttribute("uname", uname);

				RequestDispatcher rd = req.getRequestDispatcher("./SHASHome.jsp");
				rd.forward(req, resp);
			}
			else
			{
				String errorMessage = "Wrong username or password. Please Try again.";
				req.setAttribute("errorMessage", errorMessage);
				RequestDispatcher rd = req.getRequestDispatcher("./login.jsp");
				rd.forward(req, resp);
			}
		//	resp.sendRedirect("./FirstJSP.jsp?id="+id);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Override
	public void destroy() {
		System.out.println("*******************inside destroy ***********************");
		if(out!=null)
			out.close();
	
	}

}
