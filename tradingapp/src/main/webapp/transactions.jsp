<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.chainsys.tradingapp.model.*" %>
<%@ page import="org.springframework.context.ApplicationContext"%>
<%@ page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ page import="jakarta.servlet.http.HttpSession"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Transactions</title>
    <link href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/cosmo/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/dt/dt-1.11.5/datatables.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <title>Transactions</title>
</head>
<style>
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
<body>

<% 
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
ApplicationContext context = WebApplicationContextUtils.getWebApplicationContext(getServletContext());

User user = (User) session.getAttribute("user");
%>
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
<div class="container">
    <h1>Transactions Details</h1>
    <div class="row">
        <div class="col-md-4">
            <label for="minDate">From:</label>
            <input type="date" id="minDate" name="minDate" class="form-control">
        </div>
        <div class="col-md-4">
            <label for="maxDate">To:</label>
            <input type="date" id="maxDate" name="maxDate" class="form-control">
        </div>
    </div>
    <table id="transactionTable" class="table table-hover mt-3">
        <thead>
            <tr>
                <th>Transaction ID</th>
                <th>User ID</th>
                <th>Stock ID</th>
                <th>Shares</th>
                <th>Price</th>
                <th>Type</th>
                <th>Time stamp</th>
                <th>Stock Symbol</th>
                <th>Company Name</th>
                <th>profit/loss</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Transaction> transactions = (List<Transaction>) request.getAttribute("transactions");
                if (transactions != null) {
                    for (Transaction transaction : transactions) {
            %>
                        <tr>
                            <td><%= transaction.getTransactionId() %></td>
                            <td><%= transaction.getUserId() %></td>
                            <td><%= transaction.getStockId() %></td>
                            <td><%= transaction.getShares() %></td>
                            <td>₹<%= transaction.getPrice() %></td>
                            <td><%= transaction.getTransactionType() %></td>
                            <td><%= transaction.getTimestamp() %></td>
                            <td><%= transaction.getStockSymbol() %></td>
                            <td><%= transaction.getCompanyName() %></td>
                            <td>₹<%= transaction.getProfitOrLoss() %></td>
                        </tr>
            <%
                    }
                }
            %>
        </tbody>
    </table>
    <br>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/v/dt/dt-1.11.5/datatables.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.0.0/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.0.0/js/buttons.html5.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.0.0/js/buttons.print.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/vfs_fonts.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Initialize DataTable
        var table = new DataTable('#transactionTable', {
            responsive: true,
            dom: 'Blfrtip',
            buttons: [
                { extend: 'copy', className: 'btn btn-primary my-3' },
                { extend: 'csv', className: 'btn btn-primary' },
                { extend: 'excel', className: 'btn btn-primary' },
                { extend: 'pdf', className: 'btn btn-primary' },
                { extend: 'print', className: 'btn btn-primary' }
            ],
            lengthMenu: [10, 25, 50, 100],
            language: {
                paginate: {
                    previous: "Previous",
                    next: "Next"
                }
            },
            pagingType: "full_numbers"
        });

        // Custom filtering function which will search data in column seven between two values
        function filterByDate(settings, data, dataIndex) {
            var min = document.getElementById('minDate').value;
            var max = document.getElementById('maxDate').value;
            var date = data[6]; // Use data for the date column

            if ((min === "" && max === "") || 
                (min === "" && date <= max) ||
                (min <= date && max === "") ||
                (min <= date && date <= max)) {
                return true;
            }
            return false;
        }

        // Event listener to the two range filtering inputs to redraw on input
        document.getElementById('minDate').addEventListener('change', function() {
            table.draw();
        });
        document.getElementById('maxDate').addEventListener('change', function() {
            table.draw();
        });

        // Register the filter
        DataTable.ext.search.push(filterByDate);
    });
</script>
</body>
</html>
