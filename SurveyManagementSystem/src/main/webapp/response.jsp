<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="survey.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Response Analysis</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f1f1f1;
            margin: 0;
            padding: 20px;
        }
        h2 {
            font-size: 2rem;
            color: #333;
            margin-bottom: 20px;
        }
        .container {
            background: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        .btn-back {
            background-color: #6c757d;
            border-color: #6c757d;
        }
        .btn-back:hover {
            background-color: #5a6268;
            border-color: #545b62;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Select a Form to View Analysis</h2>
        <form action="AnalyzeResponsesServlet" method="get">
            <div class="mb-3">
                <label for="formId" class="form-label">Choose a form:</label>
                <select id="formId" name="formId" class="form-select">
                    <%
                        // Fetch the list of forms from the database
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;
                        try {
                            conn = DatabaseConnection.getConnection();
                            String query = "SELECT ID, FORM_TITLE FROM Forms";
                            stmt = conn.prepareStatement(query);
                            rs = stmt.executeQuery();
                            while (rs.next()) {
                                int id = rs.getInt("ID");
                                String title = rs.getString("FORM_TITLE");
                    %>
                        <option value="<%= id %>"><%= title %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) {}
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) {}
                            if (conn != null) try { conn.close(); } catch (SQLException e) {}
                        }
                    %>
                </select>
            </div>
            <div class="row">
                <div class="col text-start">
                    <button type="submit" class="btn btn-primary">View Analysis</button>
                </div>
                <div class="col text-end">
                    <a href="AdminDashboard.html" class="btn btn-back">Back to Dashboard</a>
                </div>
            </div>
        </form>
    </div>
</body>
</html>
