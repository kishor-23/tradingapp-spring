<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="com.chainsys.tradingapp.model.*" %>
	<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<%@ page import="java.util.*"%>
<%@ page import="com.chainsys.tradingapp.model.*"%>
<%@ page import="com.chainsys.tradingapp.dao.impl.*"%>
<%@ page import="com.chainsys.tradingapp.dao.*"%>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setHeader("Expires", "0"); 
    ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());
    User user = (User) session.getAttribute("user");
    StockDAO stockOperations = (StockDAO) context.getBean("stockImpl");

%>
<!DOCTYPE html>
<html lang="en" data-theme="light" data-pagefind-ignore="all">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

<title>Stocks Solution Demo (Light)</title>
<style>
*, *:before, *:after {
	box-sizing: border-box
}

* {
	margin: 0
}

body {
	line-height: 1.5;
	-webkit-font-smoothing: antialiased
}

img, picture, video, canvas, svg {
	display: block;
	max-width: 100%
}

input, button, textarea, select {
	font: inherit
}

p, h1, h2, h3, h4, h5, h6 {
	overflow-wrap: break-word
}

#root, #__next {
	isolation: isolate
}

a {
	text-decoration: none
}

header[data-astro-cid-rafkve5z] {
	display: flex;
	width: 100%;
	align-items: center;
	border-bottom: 1px solid #e0e3eb;
	justify-content: space-between;
	padding: 8px var(--gap-size);
	flex-direction: row;
	z-index: 1
}

:root[data-theme=dark] header[data-astro-cid-rafkve5z] {
	border-bottom: 1px solid #2a2e39
}

:root {
	--gap-size: 32px;
	box-sizing: border-box;
	font-family: -apple-system, BlinkMacSystemFont, Trebuchet MS, Roboto,
		Ubuntu, sans-serif;
	color: #000
}

:root[data-theme=dark] {
	color: #fff
}

* {
	box-sizing: border-box
}

body {
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
	background: #fff
}

:root[data-theme=dark] body {
	background: #000
}

#powered-by-tv p {
	margin: 0;
	font-size: 12px;
	color: rgba(0 0 0 60%)
}

:root[data-theme=dark] #powered-by-tv p {
	color: rgba(255 255 255 60%)
}

main {
	display: grid;
	width: 100%;
	padding: 0 calc(var(--gap-size)*.5);
	max-width: 960px;
	grid-template-columns: 1fr 1fr;
	grid-gap: var(--gap-size);
	margin-bottom: 24px
}

.span-full-grid, #symbol-info, #advanced-chart, #company-profile,
	#fundamental-data {
	grid-column: span 2
}

.span-one-column, #technical-analysis, #top-stories, #powered-by-tv {
	grid-column: span 1
}

#advanced-chart {
	height: 500px
}

#company-profile {
	height: 390px
}

#fundamental-data {
	height: 775px
}

#technical-analysis {
	height: 425px
}

#top-stories {
	height: 600px
}

#powered-by-tv {
	display: flex;
	background: #f8f9fd;
	border: solid 1px #e0e3eb;
	text-align: justify;
	flex-direction: column;
	gap: 8px;
	font-size: 14px;
	padding: 16px;
	border-radius: 6px
}

:root[data-theme=dark] #powered-by-tv svg {
	filter: invert()
}

:root[data-theme=dark] #powered-by-tv {
	background: #0c0e15;
	border: solid 1px #1e222d
}

#powered-by-tv a, #powered-by-tv a:visited {
	color: #2962ff
}

@media ( max-width : 800px) {
	main>section, .span-full-grid, #technical-analysis, #top-stories,
		#powered-by-tv {
		grid-column: span 2
	}
}

:root .stvb-brand[data-astro-cid-xwynydrv] {
	--stvb-color: #2962ff;
	--stvb-color-hover: #1e53e5;
	--stvb-color-active: #1848cc;
	--stvb-color-text: #fff;
	--stvb-color-hover-text: #fff;
	--stvb-color-active-text: #fff
}

:root .stvb-black[data-astro-cid-xwynydrv] {
	--stvb-color: #131722;
	--stvb-color-hover: #2a2e39;
	--stvb-color-active: #434651;
	--stvb-color-text: #fff;
	--stvb-color-hover-text: #fff;
	--stvb-color-active-text: #fff
}

:root[data-theme=dark] .stvb-black[data-astro-cid-xwynydrv] {
	--stvb-color: #fff;
	--stvb-color-hover: #f0f3fa;
	--stvb-color-active: #d1d4dc;
	--stvb-color-text: #131722;
	--stvb-color-hover-text: #131722;
	--stvb-color-active-text: #131722
}

:root .stvb-gray[data-astro-cid-xwynydrv] {
	--stvb-color: #f0f3fa;
	--stvb-color-hover: #e0e3eb;
	--stvb-color-active: #d1d4dc;
	--stvb-color-text: #131722;
	--stvb-color-hover-text: #131722;
	--stvb-color-active-text: #131722
}

:root .stvb-gray[data-astro-cid-xwynydrv].stvb-secondary {
	--stvb-color: #e0e3eb;
	--stvb-color-hover: #f0f3fa;
	--stvb-color-active: #e0e3eb
}

:root[data-theme=dark] .stvb-gray[data-astro-cid-xwynydrv] {
	--stvb-color: #2a2e39;
	--stvb-color-hover: #363a45;
	--stvb-color-active: #434651;
	--stvb-color-text: #fff;
	--stvb-color-hover-text: #fff;
	--stvb-color-active-text: #fff
}

:root[data-theme=dark] .stvb-gray[data-astro-cid-xwynydrv].stvb-secondary
	{
	--stvb-color: #434651;
	--stvb-color-hover: #2a2e39;
	--stvb-color-active: #363a45;
	--stvb-color-text: #d1d4dc
}

.stvb-base[data-astro-cid-xwynydrv] {
	display: inline-flex;
	flex-direction: row;
	align-items: center;
	font-style: normal;
	font-size: 16px;
	line-height: 24px
}

.stvb-base[data-astro-cid-xwynydrv]:focus-visible {
	outline-color: var(--tv-blue-500);
	outline-width: 2px;
	outline-offset: 4px
}

button[data-astro-cid-xwynydrv].stvb-base {
	border: none
}

.stvb-icon[data-astro-cid-xwynydrv] {
	--arrow-fill-color: var(--stvb-color-text)
}

.stvb-icon-force-color[data-astro-cid-xwynydrv] {
	color: var(--stvb-color-text) !important
}

.stvb-force-no-border[data-astro-cid-xwynydrv] {
	border: none !important
}

.stvb-small[data-astro-cid-xwynydrv] {
	height: 34px;
	border-radius: 6px;
	padding-inline: 12px;
	font-weight: 400;
	letter-spacing: -.317px
}

.stvb-medium[data-astro-cid-xwynydrv] {
	height: 40px;
	border-radius: 8px;
	padding-inline: 16px;
	font-weight: 510;
	letter-spacing: -.32px
}

.stvb-primary[data-astro-cid-xwynydrv] {
	background-color: var(--stvb-color);
	color: var(--stvb-color-text)
}

.stvb-secondary[data-astro-cid-xwynydrv] {
	background-color: transparent;
	color: var(--stvb-color)
}

button[data-astro-cid-xwynydrv].stvb-base.stvb-secondary,
	.stvb-secondary[data-astro-cid-xwynydrv] {
	border-style: solid;
	border-width: 1px;
	border-color: var(--stvb-color)
}

@media ( any-hover :hover) {
	.stvb-primary[data-astro-cid-xwynydrv]:hover, .stvb-secondary[data-astro-cid-xwynydrv]:hover
		{
		color: var(--stvb-color-hover-text);
		background-color: var(--stvb-color-hover)
	}
}

.stvb-primary[data-astro-cid-xwynydrv]:active, .stvb-secondary[data-astro-cid-xwynydrv]:active
	{
	color: var(--stvb-color-active-text);
	background-color: var(--stvb-color-active)
}

.stvb-base[data-astro-cid-xwynydrv].stvb-icon.stvb-medium {
	padding: 6px
}

.stvb-base[data-astro-cid-xwynydrv].stvb-icon.stvb-small {
	padding: 3px
}

.stvb-pointer[data-astro-cid-xwynydrv] {
	cursor: pointer
}
</style>
</head>
<body>
	<header data-astro-cid-rafkve5z>
		<div class="d-flex justify-content-start">
            <button onclick="window.history.back()" class="btn ">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>
		
          <div class="logo d-flex align-items-center">
            <img src="assets/favicon.svg" width="32" height="32" alt="Chaintrade logo">
            <a class="mb-0 ms-2" href="/profile" style="color: black; text-decoration: none !important;">ChainTrade</a>
          </div>
          
        
     
    
	</header>
	<br>
	<style>
.span-full-grid, #symbol-info, #advanced-chart, #company-profile,
	#fundamental-data {
	grid-column: span 2;
}

.span-one-column, #technical-analysis, #top-stories {
	grid-column: span 1;
}

#advanced-chart {
	height: 500px;
}

#company-profile {
	height: 390px;
}

#fundamental-data {
	height: 775px;
}

#technical-analysis {
	height: 425px;
}

#top-stories {
	height: 600px;
}

@media ( max-width : 800px) {
	main>section, .span-full-grid, #technical-analysis, #top-stories {
		grid-column: span 2;
	}
}
</style>
	<%
	int stockid = (int) request.getAttribute("stockid");
	Stock stock= stockOperations.getStockDetailsById(stockid);
	String symbol=stock.getSymbol();
	
	%>
	<main>
		<section id="symbol-info">
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
				<div class="tradingview-widget-container__widget"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-info.js"
					async>
                    {
                    "symbol": " <%=symbol%>",
                    "width": "100%",
                    "locale": "en",
                    "colorTheme": "light",
                    "isTransparent": true
                     }
                </script>
			</div>
			 <div class="d-flex justify-content-end p-2">
    <div  class="mr-2">
        <button class="btn btn-success" data-toggle="modal" data-target="#buyModal" 
                data-symbol="<%= symbol %>" 
                data-price="<%= stock.getCurrentStockPrice() %>"
                data-stock-id="<%= stock.getStockId() %>">
            Buy
        </button>
    </div>
    <div>
        <button class="btn btn-danger" data-toggle="modal" data-target="#sellModal" 
                data-symbol="<%= stock.getSymbol() %>" 
                data-price="<%= stock.getCurrentStockPrice() %>"
                data-stock-id="<%= stock.getStockId() %>">
            Sell
        </button>
    </div>
</div>

			<!-- TradingView Widget END -->
		</section>
		<section id="advanced-chart">
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container"
				style="height: 100%; width: 100%">
				<div id="tradingview_ae7da"
					style="height: calc(100% - 32px); width: 100%"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/tv.js"></script>
				<script type="text/javascript">
                    new TradingView.widget({
                        autosize: true,
                        symbol: ' <%=symbol%>',
                        interval: 'D',
                        timezone: 'Etc/UTC',
                        theme: 'light',
                        style: '1',
                        locale: 'en',
                        hide_side_toolbar: false,
                        allow_symbol_change: true,
                        studies: ['STD;MACD'],
                        container_id: 'tradingview_ae7da',
                    });
                </script>
			</div>
			<!-- TradingView Widget END -->
		</section>
		<section id="company-profile">
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
				<div class="tradingview-widget-container__widget"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-profile.js"
					async>
                      {
                      "width": "100%",
                      "height": "100%",
                      "colorTheme": "light",
                      "isTransparent": true,
                      "symbol": " <%=symbol%>",
                      "locale": "en"
                    }
                </script>
			</div>
			<!-- TradingView Widget END -->
		</section>
		<!-- TradingView Widget BEGIN -->
				<section id="advanced-chart">
		
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-overview.js" async>
  {
  "symbols": [
    [
      " <%=symbol%>",
      " <%=symbol%>|1Y"
    ]
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
  "scaleMode": "Normal",
  "fontFamily": "-apple-system, BlinkMacSystemFont, Trebuchet MS, Roboto, Ubuntu, sans-serif",
  "fontSize": "10",
  "noTimeScale": false,
  "valuesTracking": "1",
  "changeMode": "price-and-percent",
  "chartType": "area",
  "maLineColor": "#2962FF",
  "maLineWidth": 1,
  "maLength": 9,
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
<!-- TradingView Widget END -->
</section>
		<section id="fundamental-data">
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
				<div class="tradingview-widget-container__widget"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/external-embedding/embed-widget-financials.js"
					async>
                      {
                      "colorTheme": "light",
                      "isTransparent": true,
                      "largeChartUrl": "",
                      "displayMode": "regular",
                      "width": "100%",
                      "height": 775,
                      "symbol": " <%=symbol%>",
                      "locale": "en"
                    }
                </script>
			</div>
			<!-- TradingView Widget END -->
		</section>
		<section id="technical-analysis">
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
				<div class="tradingview-widget-container__widget"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/external-embedding/embed-widget-technical-analysis.js"
					async>
                    {
                    "interval": "15m",
                    "width": "100%",
                    "isTransparent": true,
                    "height": "100%",
                    "symbol": " <%=symbol%>",
                    "showIntervalTabs": true,
                    "displayMode": "single",
                    "locale": "en",
                    "colorTheme": "light"
                     }
                </script>
			</div>
			<!-- TradingView Widget END -->
		</section>
		<section id="top-stories">
			<!-- TradingView Widget BEGIN -->
			<div class="tradingview-widget-container">
				<div class="tradingview-widget-container__widget"></div>
				<script type="text/javascript"
					src="https://s3.tradingview.com/external-embedding/embed-widget-timeline.js"
					async>
                      {
                      "feedMode": "symbol",
                      "symbol": " <%=symbol%>",
                      "colorTheme": "light",
                      "isTransparent": true,
                      "displayMode": "regular",
                      "width": "100%",
                      "height": 600,
                      "locale": "en"
                    }
                </script>
			</div>
			<!-- TradingView Widget END -->
		</section>
		<section id="powered-by-tv">
			<svg xmlns="http://www.w3.org/2000/svg" width="157" height="21">
                <use
					href="/widget-docs/tradingview-logo.svg#tradingview-logo"></use>
            </svg>
			<p>
				Charts and financial information provided by TradingView, a popular
				charting & trading platform. Check out even more <a
					href="https://www.tradingview.com/features/">advanced features</a>
				or <a href="https://www.tradingview.com/widget/">grab charts</a> for
				your website.
			</p>
		</section>
	</main>
	
	
	
	<!-- Buy Modal -->
<div class="modal fade" id="buyModal" tabindex="-1" role="dialog" aria-labelledby="buyModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="StockTransaction" method="post">
              <input type="hidden" name="transactionType" value="buy">
                <div class="modal-header bg-primary text-white">
                    <h5 class="modal-title" id="buyModalLabel">Buy Stock</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <label for="stockSymbol" class="font-weight-bold">Stock Symbol</label>
                        <input type="text" class="form-control" id="stockSymbol" name="symbol" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <input type="hidden" class="form-control" id="stockId" name="stockId" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <label for="userid" class="font-weight-bold">User ID</label>
                        <input type="number" class="form-control" id="userid" value="<%= user.getId() %>" name="userid" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <label for="stockPrice" class="font-weight-bold">Current Price</label>
                        <input type="text" class="form-control" id="stockPrice" name="price" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <label for="quantity" class="font-weight-bold">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min="1" max="10" value="1" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="totalPrice" class="font-weight-bold">Total Price</label>
                        <input type="text" class="form-control" id="totalPrice" name="totalPrice" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-primary">Buy</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Sell Modal -->
<div class="modal fade" id="sellModal" tabindex="-1" role="dialog" aria-labelledby="sellModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <form action="StockTransaction" method="post">
            <input type="hidden" name="transactionType" value="sell">
            
                <div class="modal-header bg-danger text-white">
                    <h5 class="modal-title" id="sellModalLabel">Sell Stock</h5>
                    <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group mb-3">
                        <label for="sellStockSymbol" class="font-weight-bold">Stock Symbol</label>
                        <input type="text" class="form-control" id="sellStockSymbol" name="symbol" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <input type="hidden" class="form-control" id="sellStockId" name="stockId" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <label for="sellUserId" class="font-weight-bold">User ID</label>
                        <input type="number" class="form-control" id="sellUserId" value="<%= user.getId() %>" name="userid" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <label for="sellStockPrice" class="font-weight-bold">Current Price</label>
                        <input type="text" class="form-control" id="sellStockPrice" name="price" readonly>
                    </div>
                    <div class="form-group mb-3">
                        <label for="sellQuantity" class="font-weight-bold">Quantity</label>
                        <input type="number" class="form-control" id="sellQuantity" name="quantity" min="1" max="10" value="1" required>
                    </div>
                    <div class="form-group mb-3">
                        <label for="sellTotalPrice" class="font-weight-bold">Total Price</label>
                        <input type="text" class="form-control" id="sellTotalPrice" name="totalPrice" readonly>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="submit" class="btn btn-danger">Sell</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>




// Handle Buy Button Click
$('#buyModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget);
    let symbol = button.data('symbol');
    let price = button.data('price');
    let stockId = button.data('stock-id');
    let modal = $(this);
    modal.find('.modal-body #stockSymbol').val(symbol);
    modal.find('.modal-body #stockPrice').val(price);
    modal.find('.modal-body #quantity').val(1);
    modal.find('.modal-body #totalPrice').val(price);
    modal.find('.modal-body #stockId').val(stockId);
});
// Handle Sell Button Click
$('#sellModal').on('show.bs.modal', function (event) {
    let button = $(event.relatedTarget);
    let symbol = button.data('symbol');
    let price = button.data('price');
    let stockId = button.data('stock-id');
    let modal = $(this);
    modal.find('.modal-body #sellStockSymbol').val(symbol);
    modal.find('.modal-body #sellStockPrice').val(price);
    modal.find('.modal-body #sellQuantity').val(1);
    modal.find('.modal-body #sellTotalPrice').val(price);
    modal.find('.modal-body #sellStockId').val(stockId);
});

// Update Total Price when Buy Quantity Changes
document.getElementById('quantity').addEventListener('input', function() {
    let price = parseFloat(document.getElementById('stockPrice').value) || 0;
    let quantity = parseInt(this.value) || 1;
    document.getElementById('totalPrice').value = (price * quantity).toFixed(2);
});

// Update Total Price when Sell Quantity Changes
document.getElementById('sellQuantity').addEventListener('input', function() {
    let price = parseFloat(document.getElementById('sellStockPrice').value) || 0;
    let quantity = parseInt(this.value) || 1;
    document.getElementById('sellTotalPrice').value = (price * quantity).toFixed(2);
});
</script>
</body>
</html>