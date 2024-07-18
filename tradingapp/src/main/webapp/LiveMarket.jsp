<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live</title>
    <!-- favicon -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <link rel="icon" href="assets/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="style/home.css">
        <link rel="stylesheet" href="style/navbar.css">
    
    <script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
    <style>
    
          * { 
    margin: 0; 
    padding: 0; 
    list-style: none; 
    text-decoration: none; 
    box-sizing: border-box; 
    font-family: 'Poppins', sans-serif;
}
a { 
  text-decoration: none; 
  color: inherit;
} 

a { 
  display: block;
} 
.container{
  display: flex;
  justify-content: center;
  align-items: center;
  height: 98vh;
  background-color: #f9f9f9;
}

.widget-container {
    width: 100%;
    height: 100vh; /* Set a fixed height for the widget */
    align-items: center;
}

  
    </style>
   <header>
        <div style="display: flex; justify-content: center; font-size:2px">
           <a href="/profile" style="color: black;"><div class="logo"><img src="assets/favicon.svg" width="32" height="32" alt="logo"><p style="padding-top:14px"> ChainTrade </p></div>
       
           </a>  </div>
        <div class="hamburger">
            <div class="line"></div>
            <div class="line"></div>
            <div class="line"></div>
        </div>
        <nav class="nav-bar">
            <ul>
                <li><a href="home.jsp" >Home</a></li>
                <li><a href="LiveMarket.jsp" class="active" >Live</a></li>
                <li><a href="learn_to_trade.jsp" >Learn to trade</a></li>
                <%
        
    if (session == null || session.getAttribute("user") == null) {
    %>
                <li><a href="register.jsp" style="background-color: blue; color: white;" >register</a></li>
                <% } else{
                
                
                %>
                 <li><a href="/profile" style="background-color: blue; color: white;" >profile</a></li>
                 <%} %>
            </ul>
        </nav>
    </header>
    <script>
        hamburger=document.querySelector(".hamburger");
        hamburger.onclick =function(){
            navBar=document.querySelector(".nav-bar");
            navBar.classList.toggle("active");
        }
    </script>
    

  <!-- TradingView Widget END -->
   <div class="container " >
     <!-- TradingView Widget BEGIN -->
    <div class="widget-container">
        <div class="tradingview-widget-container" style="height:100%;width:100%">
            <div class="tradingview-widget-container__widget" style="height:calc(100% - 32px);width:100%"></div>
            <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
            {
            "autosize": true,
            "symbol": "BSE:TCS",
            "interval": "1D",
            "timezone": "Etc/UTC",
            "theme": "light",
            "style": "1",
            "locale": "en",
            "withdateranges": true,
            "hide_side_toolbar": false,
            "allow_symbol_change": true,
            "details": true,
            "hotlist": true,
            "calendar": false,
            "show_popup_button": true,
            "popup_width": "1000",
            "popup_height": "650",
            "support_host": "https://www.tradingview.com"
          }
            </script>
          </div>
        </div>
          <!-- TradingView Widget END -->
   </div>
 <div class="my-2 mx-2 p-3 ">
    <a href="/stocks" class="btn btn-primary p-10 w-100 ">View All Stocks</a>
 </div>
  <div class=" mx-2 p-3 ">
    <a href="realtimestockdata.html" class="btn btn-success p-10 w-100 ">View sample live Stock</a>
 </div>
</body>
</html>