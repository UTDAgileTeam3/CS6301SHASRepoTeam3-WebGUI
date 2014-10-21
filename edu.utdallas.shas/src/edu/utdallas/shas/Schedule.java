package edu.utdallas.shas;

import java.util.Date;
import java.util.HashMap;
import java.util.PriorityQueue;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Schedule {
	private Date currentTime;
	private HashMap<String, ScheduleEvent> schedules;
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
		schedules = new HashMap<String, ScheduleEvent>();
		this.currentTime = currentTime;
	}

	public Date getCurrentTime() {
		return currentTime;
	}
	
	public void addEvent(String key, ScheduleEvent e) {
		schedules.put(key, e);
	}
	
	public void removeEvent(String key) {
		schedules.remove(key);
	}
	
	private PriorityQueue<DateCallbackPair> getNextEventsQueue() {
		PriorityQueue<DateCallbackPair> ret = new PriorityQueue<DateCallbackPair>();
		for (ScheduleEvent e : schedules.values()) {
			for (Date d : e.synthesizeFutureStartDates(currentTime)) {
				ret.add(new DateCallbackPair(d, e.getStartCallback()));
			}
			
			for (Date d : e.synthesizeFutureEndDates(currentTime)) {
				ret.add(new DateCallbackPair(d, e.getEndCallback()));
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
			next(request, response);;
		}
	}
}
