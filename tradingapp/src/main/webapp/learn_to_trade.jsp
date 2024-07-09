<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>simulator</title>
    <!-- favicon -->
    <link rel="icon" href="assets/favicon.svg" type="image/x-icon">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

   
    <!-- for chart -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css">

    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style/navbar.css">
    <style>
   * {
            box-sizing: border-box;
        }
        :root {
            --color-blue: #1669C9;
            --color-dark: #222;
        }
        section {
            margin-bottom: 120px;
        }
        .intro-icons {
            margin-bottom: 100px;
        }
        h2 {
            font-weight: 600;
            color: var(--color-dark);
            letter-spacing: 0;
            margin-top: 5px;
            font-size: 1.6rem;
            line-height: 2rem;
        }
        .intro-icons .item {
            display: block;
            position: relative;
            border-radius: 10px;
            padding: 20px 15px 0;
            transition: ease-in-out 200ms;
            font-size: 1.2rem;
            min-width: 190px;
            text-decoration: none;
            color: #fff;
        }
        .intro-icons .item:hover {
            transform: translate(0, -10px);
        }
        .intro-icons span {
            display: block;
            min-height: 60px;
            vertical-align: bottom;
        }
        .intro-icons strong {
            font-weight: 600;
            margin: 20px -15px -15px;
            display: block;
            /* background: #fff; */
            padding: 10px;
            /* box-shadow: 2px 4px 8px #ddd; */
            border-radius: 0 0 10px 10px;
            color: var(--color-dark);
        }
        .intro-icons img {
            position: absolute;
            bottom: 72px;
        }
      body {
        background-color: #f8f9fa;
      }
     

    </style>
</head>
<body>
   <header>
     <div style="display: flex; justify-content: center; font-size:2px">
           <a href="NomineeServlet?action=list" style="color: black;"><div class="logo"><img src="assets/favicon.svg" width="32" height="32" alt="logo"><p style="padding-top:14px"> ChainTrade </p></div>
       
           </a>  </div>
        <div class="hamburger">
            <div class="line"></div>
            <div class="line"></div>
            <div class="line"></div>
        </div>
        <nav class="nav-bar">
            <ul>
                <li><a href="home.jsp" >Home</a></li>
                <li><a href="LiveMarket.jsp" >Live</a></li>
                <li><a href="#" class="active">Learn to trade</a></li>
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

  <!-- Bootstrap and jQuery scripts -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

   <br>
   <section class="container mt-5">
    <div class="row">
        <div class="col-lg-7 ">
            <h1 class="display-4">Free and open <span>stock market and financial education</span></h1>
          
        <p class="lead">ChainTrade offers free and open stock market and financial education. Learn at your own pace, with interactive and engaging content. Available in multiple languages.</p>
            <a href="#invest" class="btn btn-primary btn-lg">Start Learning</a>
          </div>
        <div class="col-lg-5">
            <img src="https://zerodha.com/varsity/wp-content/themes/varsity2//images/landing.png" class="img-fluid" alt="Financial Education" height="300">
        </div>
    </div>
</section>
<section class="container intro-icons my-5">
  <h2 class="mb-4">Explore </h2>
  <div class="row">
      <div class="col-lg-2 col-md-2 col-sm-6 mb-4 mx-2">
          <a class="item" href="/varsity/modules" style="background-color: #77B4F2">
              <span><img src="assets/ico-modules.svg" alt="Modules" class=""></span>
              <strong>Modules</strong>
          </a>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-6 mb-4 mx-2">
          <a class="item" href="https://varsitylive.zerodha.com" style="background-color: #F2C8CA">
              <span><img src="assets/ico-blog.svg" alt="Live"></span>
              <strong>Blog</strong>
          </a>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-6 mb-4 mx-2">
          <a class="item" href="/varsity/video-modules" style="background-color: #F0B32A">
              <span><img src="assets/ico-videos.svg" alt="Videos"></span>
              <strong>Videos</strong>
          </a>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-6 mb-4 mx-2">
          <a class="item" href="#" style="background-color: #B6ADF4">
              <span><img src="assets/ico-certified.svg" alt="Certified"></span>
              <strong>Certified</strong>
          </a>
      </div>
      <div class="col-lg-2 col-md-3 col-sm-6 mb-4 mx-2">
          <a class="item" href="#" style="background-color: #A5CC65">
              <span><img src="assets/ico-junior.svg" alt="Junior"></span>
              <strong>Quiz</strong>
          </a>
      </div>
  </div>
</section>

   <div class="container">
    <h1 id="invest">Things to note before investing</h1>
    <p class="lead">Investing is an integral part of financial planning, but before you start your investment journey, it is good to be aware of the following </p>


    <ol type="1" style="line-height: 2;">
      <li> Risk and Return go hand in hand. Higher the risk, the higher the return. The lower the risk, the lower the return.</li>

      <li> Investment in fixed income is a good option if you want to protect your principal amount. It is relatively less risky. However, you have the risk of losing money when you adjust the inflation return. Example – A fixed deposit that gives you 9% when the inflation is 10% means you lose a net of 1% per annum. Alternatively, the risk increases if you invest in a corporate fixed-income instrument.</li>

      <li> Investment in Equities is a great option. It is known to beat inflation over a long period. Historically equity investment has generated returns close to 14-15%. However, equity investments can be risky.</li>

      <li> Real Estate investment requires a significant outlay of cash and cannot be done with smaller amounts. Liquidity is another issue with real estate investment – you cannot buy or sell whenever you want.</li>

      <li> Gold and silver are relatively safer, but the historical return on such investment has not been very encouraging.</li>
    </ol>

  <p>  <p>You can download the <a href="https://zerodha.com/varsity/wp-content/uploads/2022/11/Module-1_Chapter-1_savings-comparision.xlsx">excel sheet</a> </p>
    </div>


    
    <div class="container">
        <h1>What Is a Paper Trade?</h1>
        <p class="lead"> A paper trade is a simulated trade that allows&nbsp;an investor to&nbsp;practice buying and selling without risking real money. The term paper trade dates back to a time when aspiring traders practiced trading on paper before risking money in live markets—well before online <a href="https://www.investopedia.com/terms/t/trading-platform.asp" data-component="link" data-source="inlineLink" data-type="internalLink" data-ordinal="1">trading platforms</a> became the norm. While learning, a paper trader records all trades by hand to keep track of hypothetical trading positions, portfolios, and <a href="https://www.investopedia.com/terms/p/plstatement.asp" data-component="link" data-source="inlineLink" data-type="internalLink" data-ordinal="2">profits or losses</a>. Most practice trading now involves the use of an electronic stock market simulator, which looks and feels like an actual trading platform. </p>

    </div>
     <!-- chart with random values -->
     <div id="myChart" style="max-width: 1000px; height: 400px; margin: auto;"></div>
    <div id="latestPrice" style="font-size: 24px; margin-top: 5px; text-align: center;">Latest Price: </div>
    <div id="difference" style="text-align: center; ">Difference: </div>
    <div id="profitLoss" style="text-align: center;">Profit/Loss: rs.0.00</div>
    <script src="script/chart.js"></script> 
 <br>

</body>
</html>