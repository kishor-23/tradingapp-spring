<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home</title>
        <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
        <link rel="icon" href="assets/favicon.svg" type="image/x-icon">
  <link rel="stylesheet" href="style/navbar.css"> 
      <link rel="stylesheet" href="style/home.css">
    
    <script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
    <style>
        html, body {
    height: 100%; 
 margin: 0;
    padding: 0;
}
    </style>
    <header>
        <div style="display: flex; justify-content: center; font-size:3px">
           <a href="/profile" style="color: black;"><div class="logo"><img src="assets/favicon.svg" width="32" height="32" alt="logo"><p> ChainTrade </p></div>
       
           </a>  </div>
        <div class="hamburger">
            <div class="line"></div>
            <div class="line"></div>
            <div class="line"></div>
        </div>
        <nav class="nav-bar">
            <ul>
                <li><a href="#home" class="active">Home</a></li>
                <li><a href="LiveMarket.jsp" >Live</a></li>
                <li><a href="learn_to_trade.jsp" >Learn to trade</a></li>
                <%
        
    if (session == null || session.getAttribute("user") == null) {
    %>
                <li><a href="register.jsp" style="background-color: blue; color: white;" >Register</a></li>
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
    
    
   
<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
    <div class="tradingview-widget-container__widget"></div>
    <!-- <div class="tradingview-widget-copyright"><a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Track all markets on TradingView</span></a></div> -->
    <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-ticker-tape.js" async>
    {
    "symbols": [
      {
        "proName": "FOREXCOM:SPXUSD",
        "title": "S&P 500 Index"
      },
      {
        "proName": "FOREXCOM:NSXUSD",
        "title": "US 100 Cash CFD"
      },
      {
        "proName": "FX_IDC:EURUSD",
        "title": "EUR to USD"
      },
      {
        "proName": "BITSTAMP:BTCUSD",
        "title": "Bitcoin"
      },
      {
        "proName": "BITSTAMP:ETHUSD",
        "title": "Ethereum"
      }
    ],
    "showSymbolLogo": true,
    "isTransparent": false,
    "displayMode": "adaptive",
    "colorTheme": "light",
    "locale": "en"
  }
    </script>
  </div>
  <!-- TradingView Widget END -->


    <div class="tradingview-widget-container">
        <div id="symbol-overview" class="tradingview-widget-container__widget"></div>
       
        <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-overview.js" async>
        {
            "symbols": [
                ["Apple", "AAPL|1D"],
                ["Google", "GOOGL|1D"],
                ["Bitcoin", "COINBASE:BTCUSD|1D"],
                ["Netflix", "NASDAQ:NFLX"],
                ["Facebook", "NASDAQ:FB"],
                ["Amazon", "NASDAQ:AMZN"],
                ["Tesla", "NASDAQ:TSLA"],
                ["tcs", "BSE:TCS"],
                ["infosys", "BSE:INFY"],
                ["reliance", "BSE:RELIANCE"],
                ["wipro", "BSE:WIPRO"],
                ["l&t", "BSE:LT"],
                ["Sensex","BSE:SENSEX"],
                ["Gold","GOLDBEES|1Y"],
                ["NIDTYBEES","NIFTYBEES|1Y"]
            ],
            "chartOnly": false,
            "width": "100%",
            "height": "100%",
            "locale": "en",
            "colorTheme": "light",
            "autosize": true,
            "showVolume": false,
            "showMA": false,
            "hideDateRanges": false,
            "hideMarketStatus": false,
            "hideSymbolLogo": false,
            "scalePosition": "right",
            "scaleMode": "flexible",
            "fontFamily": "-apple-system, BlinkMacSystemFont, Trebuchet MS, Roboto, Ubuntu, sans-serif",
            "fontSize": "10",
            "noTimeScale": false,
            "valuesTracking": "1",
            "changeMode": "price-and-percent",
            "chartType": "area",
            "maLineColor": "#2962FF",
            "maLineWidth": 1,
            "maLength": 12,
            "lineWidth": 2,
            "lineType": 0,
            "dateRanges": [
                "1d|1",
                "1m|30",
                "3m|60",
                "12m|1D",
                "60m|1W",
                "all|1M"
            ]
        }
        </script>
    </div>
    
    <h3 style="text-align: center; padding: 15px;">Stock Market news</h3>

  <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container" style="margin: auto;">
    <div class="tradingview-widget-container__widget"></div>
    <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js" async>
    {
    "feedMode": "all_symbols",
    "isTransparent": false,
    "displayMode": "regular",
    "width": "95%",
    "height": "550",
    "colorTheme": "light",
    "locale": "en"
  }
    </script>
  </div>
  <!-- TradingView Widget END -->
  
  

<div class="footer-top active " data-section="">
  <div class="container">
      <div class="footer-brand">
          <a href="#" class="logo">
              <img src="https://codewithsadee.github.io/cryptex/assets/images/logo.svg" width="50" height="50" alt="logo"> ChainTrade </a>
          <h2 class="footer-title">Let's talk! <i class="fa-solid fa-thumbs-up"></i> </h2>
          <a href="tel:+123456789101" class="footer-contact-link">+12 345 678 9101</a>
          <a href="mailto:hello.cryptex@gmail.com" class="footer-contact-link">hello.chaintrade@gmail.com</a>
          <address class="footer-contact-link"> ELCOT - Vadapalanji, Plot No 2, opposite MKU , Madurai</address>
      </div>
      <ul class="footer-list">
          <li>
              <p class="footer-list-title">Products</p>
          </li>
        
          <li>
              <a href="#" class="footer-link">Inverse Perpetual</a>
          </li>
        
          <li>
              <a href="#" class="footer-link">Exchange</a>
          </li>
          <li>
              <a href="#" class="footer-link">Launchpad</a>
          </li>
          <li>
              <a href="#" class="footer-link">Binance Pay</a>
          </li>
      </ul>
      <ul class="footer-list">
          <li>
              <p class="footer-list-title">Services</p>
          </li>
          <li>
              <a href="#" class="footer-link">Buy Crypto</a>
          </li>
          <li>
              <a href="#" class="footer-link">Markets</a>
          </li>
          <li>
              <a href="#" class="footer-link">Tranding Fee</a>
          </li>
     
          <li>
              <a href="#" class="footer-link">API</a>
          </li>
      </ul>
      <ul class="footer-list">
          <li>
              <p class="footer-list-title">Support</p>
          </li>
        
          <li>
              <a href="#" class="footer-link">Help Center</a>
          </li>
          <li>
              <a href="#" class="footer-link">User Feedback</a>
          </li>

          <li>
              <a href="#" class="footer-link">API Documentation</a>
          </li>
          <li>
              <a href="#" class="footer-link">Trading Rules</a>
          </li>
      </ul>
      <ul class="footer-list">
          <li>
              <p class="footer-list-title">About Us</p>
          </li>
          <li>
              <a href="#" class="footer-link">About Bybit</a>
          </li>
          <li>
              <a href="#" class="footer-link">Authenticity Check</a>
          </li>
          <li>
              <a href="#" class="footer-link">Careers</a>
          </li>
      
          <li>
              <a href="#" class="footer-link">Blog</a>
          </li>
      </ul>
  </div>
  
</div>
</body>
</html>