package edu.utdallas.shas;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.websocket.Session;


public class LoginServlet extends HttpServlet{
	PrintWriter out = null;
	@Override
	public void init() throws ServletException {
		System.out.println("inside init !!!!!!!!!!!!");
	}
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		String id = null;
		id = req.getParameter("id");
		try {
			out = resp.getWriter();
			out.println("<b>Hello User id="+id+"</b>");
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		HttpSession sess = req.getSession();
		int loginAttempt;
		 if (sess.getAttribute("loginCount") == null)
         {
             sess.setAttribute("loginCount", 0);
             loginAttempt = 0;
         }
		 else
         {
              loginAttempt = (Integer) sess.getAttribute("loginCount");
         }
		 if (loginAttempt >= 2 )
         {
			// Recipient's email ID needs to be mentioned.
		      String to = "ngdebusk@gmail.com";

		      // Sender's email ID needs to be mentioned
		      String from = "shassystemalerts@gmail.com";
		      
		      // Assuming you are sending email from localhost
		      String host = "smtp.gmail.com";

		      // Get system properties
		      Properties properties = System.getProperties();

		      // Setup mail server
		      properties.put("mail.smtp.auth", "true");
		      properties.put("mail.smtp.starttls.enable", "true");
		      properties.setProperty("mail.smtp.host", host);
		      properties.setProperty("mail.smtp.port", "587");

		      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties,
		    		  new javax.mail.Authenticator(){
		    	protected PasswordAuthentication getPasswordAuthentication(){
		    		return new PasswordAuthentication("shassystemalerts", "shas2014");
		    	}
		      });

		      try{
		         // Create a default MimeMessage object.
		         MimeMessage message = new MimeMessage(session);

		         // Set From: header field of the header.
		         message.setFrom(new InternetAddress(from));

		         // Set To: header field of the header.
		         message.addRecipient(Message.RecipientType.TO,
		                                  new InternetAddress(to));

		         // Set Subject: header field
		         message.setSubject("Alert for 3 failed login attempts into SHAS!");

		         // Now set the actual message
		         message.setText("We have detected three failed login attempts into SHAS system. Please take necessary actions!!");

		         // Send message
		         Transport.send(message);
		         System.out.println("Sent message successfully....");
		         sess.invalidate();
		      }catch (MessagingException mex) {
		         mex.printStackTrace();
		      }
         }
		 else
		 {
			String uname = null;
			String pwd = null;
			uname = req.getParameter("uname");
			pwd= req.getParameter("password");
			
			Properties properties = new Properties();
			properties.load(getServletContext().getResourceAsStream("/WEB-INF/database.properties"));
			System.out.println(properties);
			String url = properties.getProperty("jdbc.url");
			String driver = properties.getProperty("jdbc.driver");
			String username = properties.getProperty("jdbc.username");
			String password = properties.getProperty("jdbc.password");
			
			try 
			{
				Class.forName(driver); 
				Connection myConn=DriverManager.getConnection(url, username, password);
				Statement statement = myConn.createStatement() ;
				ResultSet resultset = statement.executeQuery("select username, password from shasuser") ;
				
				boolean isCredCorrect =false;
				while (resultset.next()) {              
				    if( uname.equals(resultset.getString(1)) && pwd.equals(resultset.getString(2)))
				    {
				    	isCredCorrect = true;
				    	break;
				    }
				    
				}
				statement.close();
				myConn.close();
				if(isCredCorrect)
				{
					
					sess.setAttribute("uname", uname);
					sess.setAttribute("securityBreached", false);
					sess.setAttribute("securityEnabled", true);
					sess.setAttribute("schedule", new Schedule());
					RequestDispatcher rd = req.getRequestDispatcher("./SHASHome.jsp");
					rd.forward(req, resp);
				}
				else
				{
					loginAttempt++;
					sess.setAttribute("loginCount",loginAttempt);
					String errorMessage = "Attempt: "+(loginAttempt)+" Wrong username or password. Please Try again.";
					req.setAttribute("errorMessage", errorMessage);
					RequestDispatcher rd = req.getRequestDispatcher("./login.jsp");
					rd.forward(req, resp);
				}
			//	resp.sendRedirect("./FirstJSP.jsp?id="+id);
			} catch (Exception e) {
				e.printStackTrace();
			}
		 }
	}
	
	@Override
	public void destroy() {
		System.out.println("*******************inside destroy ***********************");
		if(out!=null)
			out.close();
	
	}

}
