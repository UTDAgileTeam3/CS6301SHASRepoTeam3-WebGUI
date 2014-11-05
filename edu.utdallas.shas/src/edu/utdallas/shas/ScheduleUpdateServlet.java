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
    
    private ScheduleEventType mapType(String type) {
    	if (type.equalsIgnoreCase("one-shot"))
    		return ScheduleEventType.Oneshot;
    	else if (type.equalsIgnoreCase("weekly"))
    		return ScheduleEventType.Weekly;
    	else if (type.equalsIgnoreCase("monthly"))
    		return ScheduleEventType.Monthly;
    	else
    		throw new IllegalArgumentException();
    }
	/**
	 * @throws IOException 
	 * @throws ServletException 
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(final HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String calendarjson = request.getParameter("calendarjson");
		request.getSession().setAttribute("calendarjson", calendarjson);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss'.'SSS'Z'").create();
		ScheduleJSONValue schedArray[] = gson.fromJson(calendarjson, ScheduleJSONValue[].class);
		
		Schedule sched = (Schedule)request.getSession().getAttribute("schedule");
		sched.clearAllEvents();
		
		for (ScheduleJSONValue v : schedArray) {
			ScheduleEvent e = new ScheduleEvent(mapType(v.type), v.start, v.end, applianceStartCallback(v.title), applianceEndCallback(v.title));
			sched.addEvent(v.title, e);
		}
		RequestDispatcher rd = request.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(request, response);
	}
	private EventCallback applianceStartCallback(String title) {
		if (title.equalsIgnoreCase("Security Alarm")) {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					request.getSession().setAttribute("securityEnabled", true);
				}
			};
		}
		else if (title.equalsIgnoreCase("Sprinkler")) {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					request.getSession().setAttribute("sprinklerzone1select", "on");
					request.getSession().setAttribute("sprinklerzone2select", "on");
					request.getSession().setAttribute("sprinklerzone3select", "on");
					request.getSession().setAttribute("sprinklerzone4select", "on");
				}
			};
		}
		else if (title.equalsIgnoreCase("HVAC")) {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					request.getSession().setAttribute("hvac", "hvacOff");
				}
			};
		}
		else {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					// Do nothing.
				}
			};
		}
	}
	
	private EventCallback applianceEndCallback(String title) {
		if (title.equalsIgnoreCase("Security Alarm")) {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					request.getSession().setAttribute("securityEnabled", false);
				}
			};
		}
		else if (title.equalsIgnoreCase("Sprinkler")) {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					request.getSession().setAttribute("sprinklerzone1select", "off");
					request.getSession().setAttribute("sprinklerzone2select", "off");
					request.getSession().setAttribute("sprinklerzone3select", "off");
					request.getSession().setAttribute("sprinklerzone4select", "off");
				}
			};
		}
		else if (title.equalsIgnoreCase("HVAC")) {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					request.getSession().setAttribute("hvac", "acOn");
				}
			};
		}
		else {
			return new EventCallback() {
				@Override
				public void run(HttpServletRequest request,
						HttpServletResponse response) {
					// Do nothing.
				}
			};
		}
	}
}
