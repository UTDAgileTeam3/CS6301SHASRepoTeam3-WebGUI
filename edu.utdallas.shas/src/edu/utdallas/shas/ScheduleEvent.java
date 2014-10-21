package edu.utdallas.shas;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

public class ScheduleEvent {
	private EventCallback startCallback;
	private EventCallback endCallback;
	int[] daysOfWeek;
	private Date startTime;
	private Date endTime;
	
	private Date normalizeDate(Date d)
	{
		Calendar cal = Calendar.getInstance();
		cal.setTime(d);
		cal.set(1970, 0, 1);
		return cal.getTime();
	}
	public ScheduleEvent(int[] daysOfWeek, Date startTime, Date endTime, EventCallback startCallback, EventCallback endCallback) {
		Date normalizedStartTime = normalizeDate(startTime);
		Date normalizedEndTime = normalizeDate(endTime);
		
		if (startTime.after(endTime))
			throw new IllegalArgumentException();
		this.startCallback = startCallback;
		this.endCallback = endCallback;
		this.daysOfWeek = daysOfWeek;
		this.startTime = normalizedStartTime;
		this.endTime = normalizedEndTime;
	}
	
	public EventCallback getStartCallback() {
		return startCallback;
	}

	public EventCallback getEndCallback() {
		return endCallback;
	}
	
	private Date getNewDate(Date currentTime, Calendar cal, int dayOfWeek) {
		Calendar currcal = Calendar.getInstance();
		currcal.setTime(currentTime);
		Calendar newcal = Calendar.getInstance();
		
		newcal.setTime(currentTime);
		newcal.set(Calendar.HOUR_OF_DAY, cal.get(Calendar.HOUR_OF_DAY));
		newcal.set(Calendar.MINUTE, cal.get(Calendar.MINUTE));
		newcal.set(Calendar.SECOND, cal.get(Calendar.SECOND));

		int diff = dayOfWeek - newcal.get(Calendar.DAY_OF_WEEK);
        if (!(diff >= 0) || !newcal.after(currcal)) {
            diff += 7;
        }
        newcal.add(Calendar.DAY_OF_MONTH, diff);
		return newcal.getTime();
	}
	
	private ArrayList<Date> synthesizeFutureDates(Date currentTime, Date time) {
		ArrayList<Date> ret = new ArrayList<Date>();
		Calendar timeCal = Calendar.getInstance();
		timeCal.setTime(time);
		
		for (int i : daysOfWeek) {
			ret.add(getNewDate(currentTime, timeCal, i));
		}
		
		return ret;
	}
	
	public ArrayList<Date> synthesizeFutureStartDates(Date currentTime) {
		return synthesizeFutureDates(currentTime, startTime);
	}
	
	public ArrayList<Date> synthesizeFutureEndDates(Date currentTime) {
		return synthesizeFutureDates(currentTime, endTime);
	}
}