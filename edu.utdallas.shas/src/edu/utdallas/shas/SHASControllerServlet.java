package edu.utdallas.shas;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SHASControllerServlet extends HttpServlet{
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		super.init();
	}
	
	private void setSessionVariable(HttpSession sess, HttpServletRequest req, String param) {
		String val = req.getParameter(param);
		if (val != null)
			sess.setAttribute(param, val);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
     //String sprinklerzone1 = req.getParameter("sprinklerzone1");
		HttpSession sess = req.getSession();
		if (req.getParameter("securityAlarm").equalsIgnoreCase("Yes")) {
			sess.setAttribute("securityBreached", true);
		}
		else {
			sess.setAttribute("securityBreached", false);
		}
		setSessionVariable(sess, req, "sprinklerzone1select");
		setSessionVariable(sess, req, "sprinklerzone2select");
		setSessionVariable(sess, req, "sprinklerzone3select");
		setSessionVariable(sess, req, "sprinklerzone4select");
		RequestDispatcher rd = req.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(req, resp);
	}
	@Override
	public void destroy() {
	}
}
