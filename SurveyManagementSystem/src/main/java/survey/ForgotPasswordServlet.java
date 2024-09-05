package survey;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        // Generate a reset token
        String token = UUID.randomUUID().toString();

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Store token in database (for simplicity, assuming a table for tokens exists)
            String sql = "INSERT INTO password_reset_tokens (email, token) VALUES (?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, token);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ForgotPassword.jsp?error=An error occurred. Please try again.");
            return;
        }

        // Redirect to the reset password page with token
        response.sendRedirect("ResetPassword.jsp?token=" + token);
    }
}
