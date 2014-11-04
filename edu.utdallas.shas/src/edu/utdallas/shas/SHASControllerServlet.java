package edu.utdallas.shas;

import java.io.IOException;
import java.util.Date;

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
		sess.setAttribute("securityEnabled",
				req.getParameter("securityAlarmEnabled").equalsIgnoreCase("Yes"));
		String securityAlarm = req.getParameter("securityAlarm");
		if (securityAlarm != null && securityAlarm.equalsIgnoreCase("Yes")) {
			Boolean b = (Boolean)sess.getAttribute("securityBreached");
			if (b == null || b == false) {
				sess.setAttribute("securityBreached", true);
				sess.setAttribute("securityBreachStart", new Date());
			}
		}
		else {
			sess.setAttribute("securityBreached", false);
		}
		String smokeDetected = req.getParameter("smokeDetected");
		if (smokeDetected != null && smokeDetected.equalsIgnoreCase("Yes")) {
			Boolean b = (Boolean)sess.getAttribute("smokeDetectedB");
			if (b == null || b == false) {
				sess.setAttribute("smokeDetectedB", true);
			}
		}
		else {
			sess.setAttribute("smokeDetectedB", false);
		}String coDetected = req.getParameter("coDetected");
		if (coDetected != null && coDetected.equalsIgnoreCase("Yes")) {
			Boolean b = (Boolean)sess.getAttribute("coDetectedB");
			if (b == null || b == false) {
				sess.setAttribute("coDetectedB", true);
			}
		}
		else {
			sess.setAttribute("coDetectedB", false);
		}String naturalGasDetected = req.getParameter("naturalGasDetected");
		if (naturalGasDetected != null && naturalGasDetected.equalsIgnoreCase("Yes")) {
			Boolean b = (Boolean)sess.getAttribute("naturalGasDetectedB");
			if (b == null || b == false) {
				sess.setAttribute("naturalGasDetectedB", true);
			}
		}
		else {
			sess.setAttribute("naturalGasDetectedB", false);
		}
		setSessionVariable(sess, req, "sprinklerzone1select");
		setSessionVariable(sess, req, "sprinklerzone2select");
		setSessionVariable(sess, req, "sprinklerzone3select");
		setSessionVariable(sess, req, "sprinklerzone4select");
		setSessionVariable(sess, req, "hvac");
		setSessionVariable(sess, req, "hvacTemperature");
		RequestDispatcher rd = req.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(req, resp);
	}
	@Override
	public void destroy() {
	}
}
