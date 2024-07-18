<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.chainsys.tradingapp.model.*" %>
<%
    if (session == null || session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
    response.setHeader("Pragma", "no-cache"); 
    response.setHeader("Expires", "0"); 
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Stock Table with Pagination</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');

.pagination {
    justify-content: center;
    margin-top: 15px;
}

.filter-buttons, .search-bar {
    margin-bottom: 15px;
}

.sortable:hover {
    cursor: pointer;
    text-decoration: underline;
}

.sort-icon {
    margin-left: 5px;
}

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
.bdr {
  border-radius: 6px;
  overflow: hidden;
}
header[data-astro-cid-rafkve5z] {
	display: flex;
	width: 100%;
	align-items: center;
	border-bottom: 1px solid #e0e3eb;
	justify-content: space-between;
	padding: 12px;
	flex-direction: row;
	z-index: 1
}

:root[data-theme=dark] header[data-astro-cid-rafkve5z] {
	border-bottom: 1px solid #2a2e39
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
<div class="row">
    
    <div class="container">
        <div class="row mb-3">
            <div class="col-md-8 filter-buttons text-left">
             <form method="get" action="/stocks" id="filterForm">
    <input type="hidden" name="page" value="1">
    <input type="hidden" name="itemsPerPage" value="${itemsPerPage}">
    <input type="hidden" name="searchQuery" value="${searchQuery}">
<input type="hidden" name="sortField" id="sortField" value="${sortField}">
<input type="hidden" name="sortOrder" id="sortOrder" value="${sortOrder}">

    
    <button type="submit" class="btn btn-primary" name="filterCategory" value="Small">Small Cap</button>
    <button type="submit" class="btn btn-warning" name="filterCategory" value="Medium">Medium Cap</button>
    <button type="submit" class="btn btn-success" name="filterCategory" value="Large">Large Cap</button>
    <button type="submit" class="btn btn-info" name="filterCategory" value="All">All</button>
</form>


            </div>
            <div class="col-md-4 search-bar">
          <form method="get" action="/stocks" id="searchForm">

    
    <input type="text" class="form-control" id="searchInput" name="searchQuery" value="${searchQuery}" placeholder="Search for stocks...">
</form>

                
            </div>
        </div>
        <div class="table-responsive rounded">
            <table class="table table-hover ">
                <thead>
                    <tr>
                        <th>Symbol</th>
                        <th>Company Name</th>
                     <th id="priceHeader" class="sortable" onclick="sortTable('currentStockPrice')">Current Stock Price
    <span id="priceSortIcon" class="sort-icon"></span>
</th>


                        <th>Cap Category</th>
                        <th colspan="2">stocks</th>
                    </tr>
                </thead>
                <tbody id="stockTable">
                    <%
                        List<Stock> listStocks = (List<Stock>) request.getAttribute("listStocks");
                        if (listStocks != null) {
                            for (Stock stock : listStocks) {
                    %>
                    
 
 <script>
 
 function redirectToStockDetail(stockid) {
	    window.location.href = '/stockDetail?stockid=' + stockid;
	}

 function sortTable(field) {
	    let sortOrder = '${sortOrder}';
	    // Toggle sort order
	    sortOrder = sortOrder === 'true' ? 'false' : 'true';
	    document.getElementById('sortField').value = field;
	    document.getElementById('sortOrder').value = sortOrder;
	    document.getElementById('filterForm').submit();
	}
</script>

    

<%-- The table row --%>
  <tr class="clickable" >
                <td onclick="redirectToStockDetail('<%= stock.getStockId() %>')"><%= stock.getSymbol() %></td>
                <td onclick="redirectToStockDetail('<%= stock.getStockId() %>')"><%= stock.getCompanyName() %></td>
                <td ><%= stock.getCurrentStockPrice() %></td>
                <td><%= stock.getCapCategory() %></td>
                <td>
                    <button class="btn btn-success" data-toggle="modal" data-target="#buyModal" 
                            data-symbol="<%= stock.getSymbol() %>" 
                            data-price="<%= stock.getCurrentStockPrice() %>"
                            data-stock-id="<%= stock.getStockId() %>">
                        Buy
                    </button>
                </td>
                <td>
                    <button class="btn btn-danger" data-toggle="modal" data-target="#sellModal" 
                            data-symbol="<%= stock.getSymbol() %>" 
                            data-price="<%= stock.getCurrentStockPrice() %>"
                            data-stock-id="<%= stock.getStockId() %>">
                        Sell
                    </button>
                </td>
            </tr>

                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
            <nav aria-label="Page navigation example">
                <ul class="pagination">
                    <%
                        int totalPages = (Integer) request.getAttribute("totalPages");
                        int currentPage = (Integer) request.getAttribute("currentPage");
                        for (int i = 1; i <= totalPages; i++) {
                    %>
                    <li class="page-item <%= i == currentPage ? "active" : "" %>">
                        <a class="page-link" href="?page=<%= i %>&itemsPerPage=<%= request.getAttribute("itemsPerPage") %>&filterCategory=<%= request.getAttribute("filterCategory") %>&searchQuery=<%= request.getAttribute("searchQuery") %>"><%= i %></a>
                    </li>
                    <%
                        }
                    %>
                </ul>
            </nav>
        </div>
    </div>
</div>
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
                        <input type="number" class="form-control" id="stockId" name="stockId" readonly>
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
let debounceTimer;
document.getElementById('searchInput').addEventListener('keyup', function() {
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(function() {
        document.getElementById('searchForm').submit();
    }, 1000);
});





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
