package survey;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SaveFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String formTitle = request.getParameter("formTitle");
        String formData = request.getParameter("formData");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO forms (form_title, form_content, created_at) VALUES (?, ?, CURRENT_TIMESTAMP)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, formTitle);
                stmt.setString(2, formData);
                stmt.executeUpdate();

                response.setContentType("text/plain");
                PrintWriter out = response.getWriter();
                out.print("Form saved successfully!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
