package survey;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
public class SubmitFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int formId = Integer.parseInt(request.getParameter("formId"));
        String formData = request.getParameter("formData");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO responses (form_id, response_data, submitted_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, formId);
                stmt.setString(2, formData);
                stmt.executeUpdate();
                response.setContentType("text/plain");
                PrintWriter out = response.getWriter();
                out.print("Response submitted successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}