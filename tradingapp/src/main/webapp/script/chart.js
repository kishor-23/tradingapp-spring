/**
 * 
 */
google.charts.load('current', { packages: ['corechart'] });
        google.charts.setOnLoadCallback(initializeChart);

        let chartData = [['Time', 'Price']];
        let chart;
        let options;
        let profitLoss = 0;

        function initializeChart() {
            chartData = [['Time', 'Price'], ...generateInitialData()];

            options = getChartOptions();

            chart = new google.visualization.AreaChart(document.getElementById('myChart'));
            chart.draw(google.visualization.arrayToDataTable(chartData), options);

            setInterval(() => addRandomData(), 5000);
        }

        function getChartOptions() {
            const isDarkMode = document.body.classList.contains('dark-mode');
            return {
                title: 'Practice Trading ',
                hAxis: { title: 'Time', textStyle: { color: isDarkMode ? '#fff' : '#333' } },
                vAxis: { title: 'Price', textStyle: { color: isDarkMode ? '#fff' : '#333' } },
                legend: { position: 'bottom', textStyle: { color: isDarkMode ? '#fff' : '#333' } },
                backgroundColor: isDarkMode ? '#333' : '#fff',
                titleTextStyle: { color: isDarkMode ? '#fff' : '#333' }
            };
        }

        function generateInitialData() {
            const data = [];
            const basePrice = 100 + Math.random() * 100;

            for (let i = 600; i > 0; i -= 10) {
                const time = new Date();
                time.setSeconds(time.getSeconds() - i);

                const price = basePrice + (Math.random() - 0.5) * 20;

                data.push([time, price]);
            }

            return data;
        }

        function generateRandomDataPoint() {
            const time = new Date();
            const price = 100 + Math.random() * 100;
            return [time, price];
        }

        function addRandomData() {
            const newDataPoint = generateRandomDataPoint();
            chartData.push(newDataPoint);

            const previousPrice = chartData[chartData.length - 2][1];
            const currentPrice = newDataPoint[1];
            const difference = currentPrice - previousPrice;

            document.getElementById('latestPrice').textContent = `Latest Price: ${currentPrice.toFixed(2)}`;

            const differenceElement = document.getElementById('difference');
            differenceElement.textContent = `Difference: rs. ${difference.toFixed(2)}`;
            if (difference >= 0) {
                differenceElement.style.color = 'green';
            } else {
                differenceElement.style.color = 'red';
            }

            // Calculate and display profit/loss
            profitLoss += difference;
            const profitLossElement = document.getElementById('profitLoss');
            profitLossElement.textContent = `Profit/Loss: rs. ${profitLoss.toFixed(2)}`;
            profitLossElement.style.color = profitLoss >= 0 ? 'green' : 'red';

            chart.draw(google.visualization.arrayToDataTable(chartData), options);
        }

        function toggleMode() {
            const body = document.body;
            const button = document.querySelector('button.toggle-mode');
            if (body.classList.contains('light-mode')) {
                body.classList.remove('light-mode');
                body.classList.add('dark-mode');
                button.textContent = '☀️';
            } else {
                body.classList.remove('dark-mode');
                body.classList.add('light-mode');
                button.textContent = '🌙';
            }

            options = getChartOptions();
            chart.draw(google.visualization.arrayToDataTable(chartData), options);
        }

        function setPriceAndSubmit(action) {
            const currentPrice = chartData[chartData.length - 1][1];
            document.getElementById('currentPrice').value = currentPrice;
        }