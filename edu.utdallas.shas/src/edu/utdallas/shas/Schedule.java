package edu.utdallas.shas;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.PriorityQueue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Schedule {
	private Date currentTime;
	private HashMap<String, ArrayList<ScheduleEvent>> schedules;
	private PriorityQueue<DateCallbackPair> pendingEventsQueue = new PriorityQueue<DateCallbackPair>();
	class DateCallbackPair implements Comparable<DateCallbackPair> {
		public Date d;
		public EventCallback callback;
		
		public DateCallbackPair(Date d, EventCallback callback) {
			this.d = d;
			this.callback = callback;
		}
		@Override
		public int compareTo(DateCallbackPair o) {
			return d.compareTo(o.d);
		}
		
		public String toString() {
			return d.toString();
		}
	}
	public Schedule() {
		this(new Date());
	}
	
	public Schedule(Date currentTime) {
		schedules = new HashMap<String, ArrayList<ScheduleEvent>>();
		this.currentTime = currentTime;
	}

	public Date getCurrentTime() {
		return currentTime;
	}
	
	public void addEvent(String key, ScheduleEvent e) {
		ArrayList<ScheduleEvent> l = schedules.get(key);
		
		if (l == null) {
			l = new ArrayList<ScheduleEvent>();
			schedules.put(key, l);
		}
		l.add(e);
		pendingEventsQueue = new PriorityQueue<DateCallbackPair>();
	}
	
	public void removeEvent(String key, ScheduleEvent e) {
		ArrayList<ScheduleEvent> l = schedules.get(key);
		
		if (l == null) {
			throw new IllegalStateException();
		}
		l.remove(e);
		pendingEventsQueue = new PriorityQueue<DateCallbackPair>();
	}
	
	public void clearEvents(String key) {		
		schedules.remove(key);
		pendingEventsQueue = new PriorityQueue<DateCallbackPair>();
	}
	
	public void clearAllEvents() {
		schedules = new HashMap<String, ArrayList<ScheduleEvent>>();
		pendingEventsQueue = new PriorityQueue<DateCallbackPair>();
	}

	public ArrayList<ScheduleEvent> getSchedules(String key) {
		return schedules.get(key);
	}
	
	private PriorityQueue<DateCallbackPair> getNextEventsQueue() {
		PriorityQueue<DateCallbackPair> ret = new PriorityQueue<DateCallbackPair>();
		for (ArrayList<ScheduleEvent> l : schedules.values()) {
			for (ScheduleEvent e : l) {
				Date startDate = e.synthesizeFutureStartDate(currentTime);
				if (startDate != null)
					ret.add(new DateCallbackPair(startDate, e.getStartCallback()));
	
				Date endDate = e.synthesizeFutureEndDate(currentTime);
				if (endDate != null)
					ret.add(new DateCallbackPair(endDate, e.getEndCallback()));
			}
		}

		return ret;
	}
	public void next(HttpServletRequest request, HttpServletResponse response) {
		System.out.println(pendingEventsQueue);
		if (pendingEventsQueue.peek() != null) {
			Date d = pendingEventsQueue.peek().d;
			
			while (pendingEventsQueue.peek() != null &&
					d.equals(pendingEventsQueue.peek().d)) {
				DateCallbackPair dcp = pendingEventsQueue.poll();
				
				dcp.callback.run(request, response);
			}
			
			this.currentTime = d;
		}
		else {
			pendingEventsQueue = getNextEventsQueue();
			if (pendingEventsQueue.peek() != null)
				next(request, response);
		}
	}
}
