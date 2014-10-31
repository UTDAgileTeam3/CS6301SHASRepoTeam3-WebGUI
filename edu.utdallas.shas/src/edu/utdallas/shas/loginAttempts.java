package edu.utdallas.shas;

public class loginAttempts {
	// See if customer is a valid user
	String selectQuery = "Select firstName,lastName,email from customer where userName='"+userName+"' and password='"+password+"'";
	selectResult = statement.executeQuery(selectQuery);

	        if(selectResult.next())
	        {
	            // We got a valid user, let's log them in
	            Customer customer = new Customer();
	            customer.setFirstName(selectResult.getString("firstName"));
	            customer.setLastName(selectResult.getString("lastName"));
	            customer.setEmail(selectResult.getString("email"));
	            customer.setUserName(userName);
	            customer.setPassword(password);

	            // establish a user session
	            session.setAttribute("customer", customer);
	            session.setAttribute("firstName", customer.getFristName());
	            url = "/index.jsp";
	            selectResult.close();

	        }
	        else
	        {
	            int loginAttempt;
	            if (session.getAttribute("loginCount") == null)
	            {
	                session.setAttribute("loginCount", 0);
	                loginAttempt = 0;
	            }
	            else
	            {
	                 loginAttempt = (Integer) session.getAttribute("loginCount");
	            }

	            //this is 3 attempt counting from 0,1,2
	            if (loginAttempt >= 2 )
	            {        
	                long lastAccessedTime = session.getLastAccessedTime();
	                date = new Date();
	                long currentTime = date.getTime();
	                long timeDiff = currentTime - lastAccessedTime;
	                // 20 minutes in milliseconds  
	                if (timeDiff >= 1200000)
	                {
	                    //invalidate user session, so they can try again
	                    session.invalidate();
	                }
	                else
	                {
	                     // Error message 
	                     session.setAttribute("message","You have exceeded the 3 failed login attempt. Please try loggin in in 20 minutes, or call our customer service center at 1-800 555-1212.");
	                }  

	            }
	            else
	            {
	                 loginAttempt++;
	                 int allowLogin = 3-loginAttempt;
	                 session.setAttribute("message","loginAttempt= "+loginAttempt+". Invalid username or password. You have "+allowLogin+" attempts remaining. Please try again! <br>Not a registered cusomer? Please <a href=\"register.jsp\">register</a>!");
	            }
	            session.setAttribute("loginCount",loginAttempt);
	            url = "/login.jsp";

	        }

	        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(url);
	        dispatcher.forward(request, response);
}
