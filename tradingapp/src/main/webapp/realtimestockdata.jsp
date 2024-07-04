<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Live Stock Price Chart</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chartjs-adapter-date-fns@3"></script>
    <style>
        .modal-content {
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
        }

        input[readonly] {
            background-color: #e9ecef;
        }

        .stock-details {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
            gap: 20px;
        }
    </style>
</head>

<body>
    


    <div class="col">
        <nav aria-label="breadcrumb" class="bg-body-tertiary rounded-3 p-3 mb-4">
          <ol class="breadcrumb mb-0 d-flex justify-content-between align-items-center w-100">
            <div class="breadcrumb-items d-flex align-items-center">
              <li class="breadcrumb-item"><a href="home.jsp">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">Chart</li>
              <li class="breadcrumb-item active" aria-current="page">Apple</li>
            </div>
            <div class="logo d-flex align-items-center">
              <img src="assets/favicon.svg" width="32" height="32" alt="logo">
              <p class="mb-0 ms-2">ChainTrade</p>
            </div>
          </ol>
        </nav>
      </div>
    
    <div class="container mt-3">
        <div class="d-flex justify-content-start">
            <button onclick="window.history.back()" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back
            </button>
        </div>
        <h1 class="text-center">Live Stock Price for Apple</h1>
        <div class="stock-details">
            <p class="text-center">Symbol: AAPL</p>
            <p class="text-center">Current Price: <span id="currentPrice">Loading...</span></p>
            <p class="text-center">Open: <span id="openPrice">Loading...</span></p>
            <p class="text-center">High: <span id="highPrice">Loading...</span></p>
            <p class="text-center">Low: <span id="lowPrice">Loading...</span></p>
        </div>
        
        <div class="text-center mb-4">
            <button id="buyButton" class="btn btn-primary">Buy</button>
        </div>
        <div class="row justify-content-center">
            <div class="col-md-8">
                <canvas id="stockChart" width="1000" height="400"></canvas>
            </div>
        </div>
    </div>

    <div id="buyModal" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Buy Stock</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">�</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="buyForm">
                        <div class="form-group">
                            <label for="price">Price:</label>
                            <input type="text" id="price" name="price" class="form-control" readonly>
                        </div>
                        <div class="form-group">
                            <label for="quantity">Quantity:</label>
                            <input type="number" id="quantity" name="quantity" min="1" class="form-control">
                        </div>
                        <div class="form-group">
                            <label for="total">Total Price:</label>
                            <input type="text" id="total" name="total" class="form-control" readonly>
                        </div>
                        <button type="submit" class="btn btn-primary">Buy</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>
        const apiKey = 'JAID6NXIGQ4YRGLG';
        //const apiKey = 'L4XUJTOGC60BL9C8';
        const symbol = 'AAPL';
        const apiUrl = `https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=${symbol}&interval=1min&apikey=${apiKey}`;

        const ctx = document.getElementById('stockChart').getContext('2d');
        let stockChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [],
                datasets: [{
                    label: `Stock Price of ${symbol}`,
                    data: [],
                    borderColor: 'rgba(75, 192, 192, 1)',
                    borderWidth: 2,
                    fill: true,
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                }]
            },
            options: {
                scales: {
                    x: {
                        type: 'time',
                        time: {
                            unit: 'minute'
                        }
                    },
                    y: {
                        beginAtZero: false
                    }
                }
            }
        });

        async function fetchStockData() {
            console.log('Fetching stock data from API...');
            try {
                const response = await fetch(apiUrl);
                console.log('API Response:', response);
                const data = await response.json();
                console.log('API Data:', data);

                if (data['Time Series (1min)']) {
                    const timeSeries = data['Time Series (1min)'];
                    const times = Object.keys(timeSeries).reverse();
                    const prices = times.map(time => ({
                        x: new Date(time),
                        y: parseFloat(timeSeries[time]['1. open'])
                    }));

                    console.log('Parsed Times:', times);
                    console.log('Parsed Prices:', prices);

                    stockChart.data.labels = times.map(time => new Date(time));
                    stockChart.data.datasets[0].data = prices;
                    stockChart.update();

                    const latestData = timeSeries[times[0]];
                    const latestStockPrice = parseFloat(latestData['1. open']);
                    document.getElementById('currentPrice').innerText = latestStockPrice.toFixed(2);
                    document.getElementById('openPrice').innerText = latestData['1. open'];
                    document.getElementById('highPrice').innerText = latestData['2. high'];
                    document.getElementById('lowPrice').innerText = latestData['3. low'];
                    document.getElementById('price').value = latestStockPrice.toFixed(2);
                } else {
                    console.error('Time Series data not available:', data);
                    document.getElementById('currentPrice').innerText = 'API rate limit reached. Please try again later.';
                }
            } catch (error) {
                console.error('Failed to fetch stock data:', error);
                document.getElementById('currentPrice').innerText = 'Error fetching data';
            }
        }

        fetchStockData();
        setInterval(fetchStockData, 60000);

        const modal = document.getElementById('buyModal');
        const btn = document.getElementById('buyButton');
        const span = document.getElementsByClassName('close')[0];
        const quantityInput = document.getElementById('quantity');
        const totalInput = document.getElementById('total');

        btn.onclick = function () {
            $('#buyModal').modal('show');
        }

        span.onclick = function () {
            $('#buyModal').modal('hide');
        }

        quantityInput.oninput = function () {
            const price = parseFloat(document.getElementById('price').value);
            const quantity = parseInt(quantityInput.value);
            const total = price * quantity;
            totalInput.value = total.toFixed(2);
        }

        $('#buyForm').on('submit', function (e) {
            e.preventDefault();
            const price = parseFloat(document.getElementById('price').value);
            const quantity = parseInt(quantityInput.value);
            const total = price * quantity;

            alert(`You have bought ${quantity} shares at $${price.toFixed(2)} each for a total of $${total.toFixed(2)}.`);
            $('#buyModal').modal('hide');
        });
    </script>
</body>

</html>
