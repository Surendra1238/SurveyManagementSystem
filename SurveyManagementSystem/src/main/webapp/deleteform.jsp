<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Deleting Form...</title>
</head>
<body>
<%
    // Get the form ID from the request
    int formId = Integer.parseInt(request.getParameter("formId"));

    try {
        // Establish database connection
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "SYSTEM", "Harsha21");

        // Delete responses associated with the form
        String deleteResponsesQuery = "DELETE FROM responses WHERE form_id = ?";
        PreparedStatement deleteResponsesStmt = con.prepareStatement(deleteResponsesQuery);
        deleteResponsesStmt.setInt(1, formId);
        deleteResponsesStmt.executeUpdate();

        // Delete the form from the forms table
        String deleteFormQuery = "DELETE FROM forms WHERE id = ?";
        PreparedStatement deleteFormStmt = con.prepareStatement(deleteFormQuery);
        deleteFormStmt.setInt(1, formId);
        deleteFormStmt.executeUpdate();

        // Close connections
        deleteResponsesStmt.close();
        deleteFormStmt.close();
        con.close();

        // Redirect back to viewforms.jsp after deletion
        response.sendRedirect("viewforms.jsp");
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<h2>Error occurred while deleting the form.</h2>");
    }
%>
</body>
</html>
