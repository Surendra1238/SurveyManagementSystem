<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Response Analysis</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="style3.css">
</head>
<body>
    <div class="container">
        <% 
            String formTitle = (String) request.getAttribute("formTitle");
            Map<String, Map<String, Integer>> analysisResults = 
                (Map<String, Map<String, Integer>>) request.getAttribute("analysisResults");
        %>
        <h3 style="text-align:center;"><%= formTitle %> Form analysis</h3>
        <% 
            int chartIndex = 0;
            for (Map.Entry<String, Map<String, Integer>> entry : analysisResults.entrySet()) {
                String questionLabel = entry.getKey();
                Map<String, Integer> optionCounts = entry.getValue();
                String options = "";
                String counts = "";
                for (Map.Entry<String, Integer> optionEntry : optionCounts.entrySet()) {
                    options += "'" + optionEntry.getKey() + "',";
                    counts += optionEntry.getValue() + ",";
                }
        %>
        <h4><%= questionLabel %></h4>
        <div class="chart-container">
            <canvas id="barChart<%= chartIndex %>"></canvas>
        </div>
        <script>
            var ctx = document.getElementById('barChart<%= chartIndex %>').getContext('2d');
            var barChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: [<%= options %>],
                    datasets: [{
                        label: 'Number of Responses',
                        data: [<%= counts %>],
                        backgroundColor: 'blue',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1,
                        barThickness: 20
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        </script>
        <% 
                chartIndex++;
            } 
        %>
    </div>
    <br><br>
    <a href="response.jsp" class="btn btn-back mb-3">Back to Response Selection</a>
</body>
</html>