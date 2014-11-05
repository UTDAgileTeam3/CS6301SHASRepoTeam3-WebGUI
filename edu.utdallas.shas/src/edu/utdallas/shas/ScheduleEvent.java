package edu.utdallas.shas;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class ScheduleEvent {
	private EventCallback startCallback;
	private EventCallback endCallback;
	private Date startTime;
	private Date endTime;
	private ScheduleEventType type;
	
	public ScheduleEvent(ScheduleEventType type, Date startTime, Date endTime, EventCallback startCallback, EventCallback endCallback) {
		if (!startTime.before(endTime))
			throw new IllegalArgumentException();

		this.startCallback = startCallback;
		this.endCallback = endCallback;
		this.startTime = startTime;
		this.endTime = endTime;
		this.type = type;
	}
	
	public EventCallback getStartCallback() {
		return startCallback;
	}

	public EventCallback getEndCallback() {
		return endCallback;
	}
	
	private Date getNewDate(Date currentTime, Date time, int unit, int unitcount) {
		Calendar currcal = Calendar.getInstance();
		currcal.setTime(currentTime);
		Calendar newcal = Calendar.getInstance();
		newcal.setTime(time);

		while (!newcal.after(currcal)) {
			newcal.add(unit, unitcount);
		}

		return newcal.getTime();
	}
	
	private Date synthesizeFutureDate(Date currentTime, Date time) {
		switch (type) {
		case Oneshot:
			if (time.after(currentTime)) {
				return time;
			}
			return null;
		case Weekly:
			return getNewDate(currentTime, time, Calendar.DAY_OF_MONTH, 7);
		case Monthly:
			return getNewDate(currentTime, time, Calendar.MONTH, 1);
		default:
			return null;
		}
	}
	
	public Date synthesizeFutureStartDate(Date currentTime) {
		return synthesizeFutureDate(currentTime, startTime);
	}
	
	public Date synthesizeFutureEndDate(Date currentTime) {
		return synthesizeFutureDate(currentTime, endTime);
	}
	
	public Date getStartTime() {
		return startTime;
	}
	
	public Date getEndTime() {
		return endTime;
	}
}