package edu.utdallas.shas;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface EventCallback {
	public void run(HttpServletRequest request, HttpServletResponse response);
}
