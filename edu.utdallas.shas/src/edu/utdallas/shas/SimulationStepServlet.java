package edu.utdallas.shas;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SimulationStepServlet
 */
@WebServlet("/SimulationStepServlet")
public class SimulationStepServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SimulationStepServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Schedule sched = (Schedule)request.getSession().getAttribute("schedule");
		
		sched.next(request, response);
		RequestDispatcher rd = request.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(request, response);
	}

}
