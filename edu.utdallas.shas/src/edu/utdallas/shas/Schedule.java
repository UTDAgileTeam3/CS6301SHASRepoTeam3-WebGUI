package edu.utdallas.shas;

import java.util.Date;

public class Schedule {
	private Date currentTime;
	
	public Schedule() {
		currentTime = new Date();
	}
	
	public Schedule(Date currentTime) {
		this.currentTime = currentTime;
	}

	public Date getCurrentTime() {
		return currentTime;
	}
}
