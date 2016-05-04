<%-- 
    Document   : Buyer Bid
    Created on : Apr 28, 2016,02:35:45 PM
    Author     : Murtala Aliyu
--%>

<%@ page language="java" contentType="text/html; charset=US-ASCII"
	pageEncoding="US-ASCII"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"%>
<%@ page import="java.sql.*" import = "java.Math.*"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<title>Buyer Bid</title>
</head>

<a href="AllAuction.jsp"><button type="button">Back</button></a>
<a href="Home.jsp"><button type="button">Home</button></a>



<body>
	<!-- jsp code start -->
	<%
	int item_id=0;

	try{
		item_id=Integer.parseInt(request.getParameter("item_id"));
	   }
	catch (Exception e){
	      response.sendRedirect("RequiredContent.html"); 
	   }
	
	int bid_price=0;

	try{
		bid_price=Integer.parseInt(request.getParameter("bid_price"));
	   }
	catch (Exception e){
	      response.sendRedirect("RequiredContent.html");
	   }
	
	
	if(bid_price ==0 || bid_price <0){
		response.sendRedirect("RequiredContent.html");
	}else{
		
		
		
		Connection conn;
		try {
		Class.forName("com.mysql.jdbc.Driver").newInstance();
	
		} catch (InstantiationException e) {
		e.printStackTrace();
	
		} catch( IllegalAccessException e) {
		e.printStackTrace();	
	
		} catch(ClassNotFoundException e) {
		e.printStackTrace();
	
		}
		
		try {
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/proj2016?autoReconnect=true", "root", "WeHearKK290");
		
		} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		conn = null;
		}
		
		Statement stmt3 = conn.createStatement();
		ResultSet set = stmt3.executeQuery("SELECT * FROM active_auction WHERE item_id = " + item_id);
		set.next();
		int auction_id = set.getInt("auction_id");
		
		Statement stmt = conn.createStatement();
		
		ResultSet rs=stmt.executeQuery("select * from active_auction where item_id=" + item_id);
		rs.next();
		int book_price = rs.getInt("current_price");
		if (bid_price > book_price ) {
			book_price = bid_price;
		}
		
		Statement stmt2 = conn.createStatement();
		stmt2.executeUpdate("UPDATE active_auction SET current_price =" + book_price + " WHERE active_auction.item_id=" + item_id);
  		
		Statement stmt_bid = conn.createStatement();
		int i = 2;
		stmt_bid.executeUpdate("INSERT INTO bid VALUES(" + i + ", " + book_price + "'2016-05-04 06:00:00', 5, " + auction_id);
		
		Statement stmt1 = conn.createStatement(); 

		/*	The resulting set of the bids of this auction. */
		ResultSet bids = stmt1.executeQuery( "SELECT * FROM bid WHERE bid.auction_id=" + auction_id );	
	
		while(bids.next()) {
		/* For each bid, print the username, price, and time. */

		int bidder_id = bids.getInt("bidder_id");
		Statement stmt900 = conn.createStatement();
		ResultSet users = stmt900.executeQuery( "SELECT * FROM users WHERE account_id=" + bidder_id );
		users.next();

		String username = users.getString("username");

		Double bid_price2 = bids.getDouble("bid_price");

		String time = bids.getString("time");
	    %>
		<p> <% out.println( "User: " + username + " Price: " + bid_price + " Time: " + time); %>
		</p>
	
	<%}
	}%>

		

	<p> Thanks for bidding </p>
</body>
</html>