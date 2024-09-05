<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Forms</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="style1.css">
</head>
<body>
    <div class="container">
        <a href="AdminDashboard.html" class="back-button">Back to Admin Dashboard</a>
        <h1 style="text-align:center;">Manage Survey Forms</h1>
        <table>
            <tr>
                <th>Form Title</th>
                <th>Date Created</th>
                <th>Actions</th>
            </tr>
            <%
                try {
                    // Database connection
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "SYSTEM", "Harsha21");
                    Statement stmt = con.createStatement();

                    // Fetch forms from the database
                    String query = "SELECT id, form_title, created_at FROM forms ORDER BY created_at DESC";
                    ResultSet rs = stmt.executeQuery(query);

                    while (rs.next()) {
                        int formId = rs.getInt("id");
                        String formTitle = rs.getString("form_title");
                        Timestamp createdAt = rs.getTimestamp("created_at");
            %>
                        <tr>
                            <td><%= formTitle %></td>
                            <td><%= createdAt %></td>
                            <td class="actions">
                                <a href="editform.jsp?id=<%= formId %>" title="Edit"><i class="fas fa-pen"></i></a>
                                <i class="fas fa-trash" onclick="confirmDeletion(<%= formId %>)" title="Delete"></i>
                                <a href="ViewFormServlet?id=<%= formId %>" title="View form"><i class="fas fa-eye"></i></a>
                            </td>
                        </tr>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
    </div>

    <!-- Overlay for the dialog -->
    <div class="overlay" id="overlay"></div>

    <!-- Confirmation dialog -->
    <div class="confirmation-dialog" id="confirmationDialog">
        <h3>Are you sure you want to delete this form?</h3>
        <form action="deleteform.jsp" method="post" id="deleteForm">
            <input type="hidden" name="formId" id="formId">
            <button type="submit">Confirm</button>
            <button type="button" onclick="cancelDeletion()">Cancel</button>
        </form>
    </div>
    <script>
        // Show the confirmation dialog
        function confirmDeletion(formId) {
            document.getElementById('formId').value = formId;
            document.getElementById('confirmationDialog').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
        }

        // Cancel the deletion and hide the dialog
        function cancelDeletion() {
            document.getElementById('confirmationDialog').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }
    </script>
</body>
</html>
