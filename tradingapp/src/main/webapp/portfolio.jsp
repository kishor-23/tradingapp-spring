<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>

<%@ page import="java.util.*"%>

<%@ page import="com.chainsys.tradingapp.model.*"%>
<%@ page import="com.chainsys.tradingapp.dao.impl.*"%>
<%@ page import="com.chainsys.tradingapp.dao.*"%>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Portfolio</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
    html, body, .intro {
        height: 100%;
    }
    .card {
        display: flex;
        flex-direction: column;
        background-color: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        width: 80%;
        max-width: 600px;
        padding: 20px;
        text-align: center;
        font-family: Arial, sans-serif;
        margin: 20px auto;
    }
    .portfolio-container {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-top: 20px;
    }
    .portfolio {
        flex: 1;
        padding-right: 20px;
        margin-top:60px;
    }
    .chart-container {
        flex: 1;
        max-width: 400px;
        height: 400px;
        padding: 20px;
        margin-right:20px;
        background-color: #fff;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .chart-container canvas {
        width: 100% !important;
        height: 90% !important;
    }
    .row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 10px;
    }
    .label {
        color: #8e8e8e;
        font-size: 16px;
    }
    .value {
        color: #000;
        font-size: 28px;
        font-weight: bold;
    }
    .separator {
        border-top: 1px solid #e0e0e0;
        margin: 20px 0;
    }
    .pnl, .percentage {
        display: inline-block;
        margin-top: 10px;
    }
    .pnl {
        font-size: 28px;
        font-weight: bold;
    }
    .r1 {
        position: relative;
        left: -184px;
        top: 40px;
    }
    .r2 {
        position: relative;
        top: -25px;
        left: 174px;
    }
    .percentage {
        font-size: 18px;
        font-weight: bold;
        border-radius: 10px;
        padding: 5px 10px;
        margin-left: 10px;
    }
    .pnl.positive, .percentage.positive {
        color: #388e3c; /* green color for profit */
        background-color: #e8f5e9; /* light green background for profit */
    }
    .pnl.negative, .percentage.negative {
        color: #d32f2f; /* red color for loss */
        background-color: #fbeaea; /* light red background for loss */
    }
    ::-webkit-scrollbar {
        width: 0;
    }
    .gradient-custom-1 {
        background: #4758eb;
    }
    table {
        border-collapse: collapse;
        width: 100%;
    }
    table td, table th {
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }
    tbody td {
        font-weight: 500;
        color: #999999;
    }
    .fa-caret-up {
        color: green;
        font-size: 17px;
    }
    .fa-caret-down {
        color: red;
        font-size: 17px;
    }
    .header-fixed {
        position: sticky;
        top: 0;
        background-color: white;
        z-index: 1;
    }
    .scrollable-table {
        max-height: 400px; /* Adjust the height as needed */
        overflow-y: auto;
    }
    header[data-astro-cid-rafkve5z] {
        display: flex;
        width: 100%;
        align-items: center;
        border-bottom: 1px solid #e0e3eb;
        justify-content: space-between;
        padding: 10px;
        flex-direction: row;
        z-index: 1;
    }
</style>
</head>
<%
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
User user = (User) session.getAttribute("user");
ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());

PortfolioDAO portfolioOperations = (PortfolioDAO) context.getBean("portfolioImpl");
StockDAO stockOperations = (StockDAO) context.getBean("stockImpl");

List<Portfolio> portfoliolist = portfolioOperations.getPortfoliosByUserId(user.getId());

double totalInvested = 0.0;
double totalCurrent = 0.0;

for (Portfolio portfolio : portfoliolist) {
    totalInvested += portfolio.getBuyedPrice() * portfolio.getQuantity();
    double currentPrice = stockOperations.stockPriceById(portfolio.getStockId());
    totalCurrent += currentPrice * portfolio.getQuantity();
}

double pnlValue = totalCurrent - totalInvested;
double pnlPercentage = (totalInvested > 0) ? (pnlValue / totalInvested) * 100 : 0;

String pnlClass = (pnlValue >= 0) ? "positive" : "negative";

List<Category> categoryQuantities = portfolioOperations.getCategoryQuantities(user.getId());

int smallCapPercentage = 0;
int mediumCapPercentage = 0;
int largeCapPercentage = 0;

for (Category cq : categoryQuantities) {
    int totalQuantity = cq.getTotalQuantity();
    int userTotalQuantity = cq.getUserTotalQuantity();
    int percentage = Math.round((float) totalQuantity / userTotalQuantity * 100);

    switch (cq.getCapCategory()) {
        case "Small" :
            smallCapPercentage = percentage;
            break;
        case "Medium" :
            mediumCapPercentage = percentage;
            break;
        case "Large" :
            largeCapPercentage = percentage;
            break;
    }
}
%>
<body>
<header data-astro-cid-rafkve5z>
    <div class="d-flex justify-content-start">
        <button onclick="window.history.back()" class="btn">
            <i class="fas fa-arrow-left"></i> Back
        </button>
    </div>
    
    <div class="logo d-flex align-items-center">
        <img src="assets/favicon.svg" width="32" height="32" alt="Chaintrade logo">
        <a class="mb-0 ms-2" href="/profile" style="color: black; text-decoration: none !important;">ChainTrade</a>
    </div>
</header>

<div class="portfolio-container">

    <div class="portfolio card">
        <div class="row">
            <div class="r1">
                <div class="label">Invested</div>
                <div class="value"><%=String.format("%.2f", totalInvested)%></div>
            </div>
            <div class="r2">
                <div class="label">Current</div>
                <div class="value"><%=String.format("%.2f", totalCurrent)%></div>
            </div>
        </div>
        <div class="separator"></div>
        <div>
            <div class="pnl ">P&L   :<%=String.format("%.2f", pnlValue)%></div>
            <div class="percentage <%=pnlClass%>"><%=String.format("%.2f", pnlPercentage)%> %</div>
        </div>
    </div>
    <div class="chart-container">
    <p>Investment details in each cap</p>
        <canvas id="capChart"></canvas>
    </div>
</div>

<section class="intro">

    <div class="h-100">
    
        <div class="mask d-flex align-items-center h-100">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
                    <h2>Portfolio</h2>
                        <div class="table-responsive bg-white rounded-3 scrollable-table">
                            <table class="table mb-0">
                                <thead class="header-fixed">
                                    <tr scope="row" style="color: #666666;">
                                        <th scope="col">Symbol</th>
                                        <th scope="col">Company</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Invested Price</th>
                                        <th scope="col">Current Price</th>
                                        <th scope="col">Total Invested Price</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                    for (Portfolio portfolio : portfoliolist) {
                                        double currentPrice = stockOperations.stockPriceById(portfolio.getStockId());
                                        double investedPrice = portfolio.getBuyedPrice();
                                        boolean isPriceUp = currentPrice > investedPrice;
                                    %>
                                    <tr>
                                        <td><%=portfolio.getSymbol()%></td>
                                        <td><%=portfolio.getCompany()%></td>
                                        <td><%=portfolio.getQuantity()%></td>
                                        <td><%=portfolio.getBuyedPrice()%></td>
                                        <td><%=currentPrice%> <%
                                         if (isPriceUp) {
                                         %> <i class="fas fa-caret-up"></i> <%
                                         } else {
                                         %> <i class="fas fa-caret-down"></i> <%
                                         }
                                         %></td>
                                        <td><%=portfolio.getTotal()%></td>
                                    </tr>
                                    <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>


<script>
window.onload = function() {
    const smallCapPercentage =<%=smallCapPercentage%>; 
    const mediumCapPercentage = <%=mediumCapPercentage%>;
    const largeCapPercentage =<%=largeCapPercentage%>;

    const ctx = document.getElementById('capChart').getContext('2d');
    new Chart(ctx, {
        type: 'doughnut',
        data: {
            labels: ['Small Cap', 'Medium Cap', 'Large Cap'],
            datasets: [{
                label: 'Cap Category Percentages',
                data: [smallCapPercentage, mediumCapPercentage, largeCapPercentage],
                backgroundColor: ['#FF6384', '#36A2EB', '#FFCE56'],
                hoverBackgroundColor: ['#FF6384', '#36A2EB', '#FFCE56']
            }]
        },
        options: {
            responsive: true,
            plugins: {
                legend: {
                    position: 'top',
                },
                tooltip: {
                    enabled: true,
                }
            }
        }
    });
};

</script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
