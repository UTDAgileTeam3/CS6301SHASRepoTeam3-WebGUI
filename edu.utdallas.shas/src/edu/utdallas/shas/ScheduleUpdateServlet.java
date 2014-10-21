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

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(final HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] alarmDays = request.getParameterValues("alarm");
		String[] sprinklerDays = request.getParameterValues("sprinkler");
		String alarmDayStartTime = request.getParameter("alarmstart");
		String alarmDayEndTime = request.getParameter("alarmend");
		String sprinklerDayStartTime = request.getParameter("sprinklerstart");
		String sprinklerDayEndTime = request.getParameter("sprinklerend");
		Schedule sched = (Schedule)request.getSession().getAttribute("schedule");
		EventCallback alarmStart = new EventCallback() {
			public void run(HttpServletRequest request, HttpServletResponse response) {
				System.out.println("Alarm start");
				request.getSession().setAttribute("securityEnabled", true);
			}
		};
		
		EventCallback alarmEnd = new EventCallback() {
			public void run(HttpServletRequest request, HttpServletResponse response) {
				System.out.println("Alarm end");
				request.getSession().setAttribute("securityEnabled", false);
			}
		};
		
		EventCallback sprinklerStart = new EventCallback() {
			public void run(HttpServletRequest request, HttpServletResponse response) {
				
			}
		};
		
		EventCallback sprinklerEnd = new EventCallback() {
			public void run(HttpServletRequest request, HttpServletResponse response) {
				
			}
		};
		
		try {
			updateSchedule(sched, "alarm", alarmDays, alarmDayStartTime, alarmDayEndTime, alarmStart, alarmEnd);
			updateSchedule(sched, "sprinkler", sprinklerDays, sprinklerDayStartTime, sprinklerDayEndTime, sprinklerStart, sprinklerEnd);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		RequestDispatcher rd = request.getRequestDispatcher("./SHASHome.jsp");
		rd.forward(request, response);
	}

	private int[] parseDays(String[] dayStr) throws Exception {
		int[] ret = new int[dayStr.length];
		
		for (int i = 0; i < dayStr.length; i++) {
			String s = dayStr[i];
			
			if (s.equals("SU"))
				ret[i] = Calendar.SUNDAY;
			else if (s.equals("M"))
				ret[i] = Calendar.MONDAY;
			else if (s.equals("T"))
				ret[i] = Calendar.TUESDAY;
			else if (s.equals("W"))
				ret[i] = Calendar.WEDNESDAY;
			else if (s.equals("TR"))
				ret[i] = Calendar.THURSDAY;
			else if (s.equals("F"))
				ret[i] = Calendar.FRIDAY;
			else if (s.equals("S"))
				ret[i] = Calendar.SATURDAY;
			else
				throw new Exception();
		}
		
		return ret;
	}
	private void updateSchedule(Schedule sched, String name,
			String[] days, String startTime, String endTime, EventCallback startCallback, EventCallback endCallback) throws Exception {
		if (days == null) {
			sched.removeEvent(name);
		}
		else {
			ScheduleEvent e = new ScheduleEvent(parseDays(days), parseTime(startTime), parseTime(endTime), startCallback, endCallback);
			sched.addEvent(name, e);
		}
	}

	private Date parseTime(String startTime) throws ParseException {
		SimpleDateFormat fmt = new SimpleDateFormat("HH:mm:ss");
		return fmt.parse(startTime);
	}

}
