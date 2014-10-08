package edu.utdallas.shas;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SHASControllerServlet extends HttpServlet{
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
     //String sprinklerzone1 = req.getParameter("sprinklerzone1");
		req.setAttribute("sprinklerzone1select", req.getParameter("sprinklerzone1select"));
		req.setAttribute("sprinklerzone2select", req.getParameter("sprinklerzone2select"));
		req.setAttribute("sprinklerzone3select", req.getParameter("sprinklerzone3select"));
		req.setAttribute("sprinklerzone4select", req.getParameter("sprinklerzone4select"));
		RequestDispatcher rd = req.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(req, resp);

	}
	@Override
	public void destroy() {
	}
}
