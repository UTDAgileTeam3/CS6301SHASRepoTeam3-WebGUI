package edu.utdallas.shas;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * Servlet implementation class SchedulerServlet
 */
@WebServlet("/SchedulerServlet")
public class ScheduleUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScheduleUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    class ScheduleJSONValue {
    	public String title;
    	public Date start;
    	public Date end;
    	public String type;
    	boolean allDay;
    	
    	public String toString() {
    		return "(" + title + ", " + start.toString() + ", " + end.toString() + ", " + type + ", " + (allDay ? "true" : "false") + ")";
    	}
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(final HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String calendarjson = request.getParameter("calendarjson");
		request.getSession().setAttribute("calendarjson", calendarjson);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'").create();
		ScheduleJSONValue schedArray[] = gson.fromJson(calendarjson, ScheduleJSONValue[].class);
		for (int i = 0; i < schedArray.length; i++)
			System.out.println(schedArray[i]);
		RequestDispatcher rd = request.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(request, response);
	}
}
