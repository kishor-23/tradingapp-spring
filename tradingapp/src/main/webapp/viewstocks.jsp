<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
            <p class="mb-0 ms-2">ChainTrade</p>
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
	String symbol = (String) request.getAttribute("symbol");
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
</body>
</html>