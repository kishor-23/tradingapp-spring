<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.chainsys.model.*" %>
<!DOCTYPE html
<html lang="en">
<head>
    <title>Transactions</title>
    <link href="https://stackpath.bootstrapcdn.com/bootswatch/4.3.1/cosmo/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.datatables.net/v/dt/dt-1.11.5/datatables.min.css" rel="stylesheet">
    <title>Transactions</title>
</head>
<body>
<% 
if (session == null || session.getAttribute("user") == null) {
    response.sendRedirect("login.jsp");
    return;
}
User user = (User) session.getAttribute("user");
%>
    <div class="container">
        <h1>Transactions by <%= user.getName() %></h1>
        <table id="transactionTable" class="table table-hover">
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
                                <td><%= transaction.getPrice() %></td>
                                <td><%= transaction.getTransactionType() %></td>
                                <td><%= transaction.getTimestamp() %></td>
                                <td><%= transaction.getStockSymbol() %></td>
                                <td><%= transaction.getCompanyName() %></td>
                                 <td><%= transaction.getProfitOrLoss() %></td>
                            </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>

    <!-- Bootstrap JS (optional if you are not using any Bootstrap JavaScript features) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- DataTables JS -->
    <script src="https://cdn.datatables.net/v/dt/dt-1.11.5/datatables.min.js"></script>
    <!-- DataTables Buttons JS -->
    <script src="https://cdn.datatables.net/buttons/2.0.0/js/dataTables.buttons.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.0.0/js/buttons.html5.min.js"></script>
    <script src="https://cdn.datatables.net/buttons/2.0.0/js/buttons.print.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/pdfmake.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.70/vfs_fonts.js"></script>

     <script>
        $(document).ready(function() {
            $('#transactionTable').DataTable({
                responsive: true,
                dom: 'Blfrtip',
                buttons: [
                    { extend: 'copy', className: 'btn btn-primary my-3' },
                    { extend: 'csv', className: 'btn btn-primary' },
                    { extend: 'excel', className: 'btn btn-primary' },
                    { extend: 'pdf', className: 'btn btn-primary' },
                    { extend: 'print', className: 'btn btn-primary' }
                ],
                lengthMenu: [10, 25, 50, 100], // Display dropdown for rows per page
                "language": {
                    "paginate": {
                        "previous": "Previous",
                        "next": "Next"
                    }
                },
                "pagingType": "simple" // Change default pagination style to simple
            });
        });
    </script>
</body>
</html>
