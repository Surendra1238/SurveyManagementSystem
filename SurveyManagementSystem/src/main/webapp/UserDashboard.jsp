<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="survey.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>USER Dashboard</title>
    <style>
        body {
            background-color: skyblue;
        }
        h3{
           color:brown;
        }
        
        .container {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .form-label {
            font-weight: bold;
        }
        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }
        h1 {
            font-size: 2.5rem;
            color: #333;
        }
    </style>
</head>
<body>
    <h3><marquee direction="right">WELCOME TO USER DASHBOARD</marquee></h3>
    <div class="container p-4">
        <h1 class="mb-4 text-center">Select a Form to Fill Out</h1>
        <form action="FillFormServlet" method="post">
            <div class="mb-3">
                <label for="formId" class="form-label">Form:</label>
                <select id="formId" name="formId" class="form-select" required>
                    <%
                        // Fetch available forms from the database
                        Connection conn = DatabaseConnection.getConnection();
                        String sql = "SELECT id, form_title FROM forms";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            int formId = rs.getInt("id");
                            String formTitle = rs.getString("form_title");
                    %>
                        <option value="<%= formId %>"><%= formTitle %></option>
                    <%
                        }
                    %>
                </select>
            </div>
            <div class="text-center">
                <button type="submit" class="btn btn-primary">Fill Form</button>
            </div>
        </form>
    </div>
</body>
</html>
