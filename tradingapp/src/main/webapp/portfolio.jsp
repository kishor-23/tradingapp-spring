<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@ page import="java.util.List"%>
<%@ page import="com.chainsys.model.*"%>
<%@ page import="com.chainsys.impl.*"%>
<%@ page import="com.chainsys.dao.*"%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Portfolio</title>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
<link
    href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    rel="stylesheet">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
<style>
html, body, .intro {
    height: 100%;
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
    z-index: 1
}
</style>
</head>
<%
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
User user = (User) session.getAttribute("user");
PortfolioDAO portfolioOperations = new PortfolioImpl();
StockImpl stock = new StockImpl();
List<Portfolio> portfoliolist = portfolioOperations.getPortfoliosByUserId(user.getId());
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
        <a class="mb-0 ms-2" href="NomineeServlet?action=list" style="color: black; text-decoration: none !important;">ChainTrade</a>
    </div>
</header>

<section class="intro">
    <div class="gradient-custom-1 h-100">
        <div class="mask d-flex align-items-center h-100">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-12">
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
                                        double currentPrice = stock.stockPriceById(portfolio.getStockId());
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
<script
    src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
<script
    src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
