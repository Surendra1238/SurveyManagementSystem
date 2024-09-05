package survey;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");

        try (Connection conn = DatabaseConnection.getConnection()) {
            // Validate token
            String validateTokenSql = "SELECT email FROM password_reset_tokens WHERE token = ?";
            String email = null;
            try (PreparedStatement stmt = conn.prepareStatement(validateTokenSql)) {
                stmt.setString(1, token);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        email = rs.getString("email");
                    }
                }
            }

            if (email != null) {
                // Update password
                String updatePasswordSql = "UPDATE users SET password = ? WHERE email = ?";
                try (PreparedStatement stmt = conn.prepareStatement(updatePasswordSql)) {
                    stmt.setString(1, newPassword);
                    stmt.setString(2, email);
                    stmt.executeUpdate();
                }

                // Remove the token
                String deleteTokenSql = "DELETE FROM password_reset_tokens WHERE token = ?";
                try (PreparedStatement deleteStmt = conn.prepareStatement(deleteTokenSql)) {
                    deleteStmt.setString(1, token);
                    deleteStmt.executeUpdate();
                }

                response.sendRedirect("SurveyLogin.jsp?message=Password reset successful. Please log in.");
            } else {
                response.sendRedirect("ResetPassword.jsp?token=" + token + "&error=Invalid or expired token.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("ResetPassword.jsp?token=" + token + "&error=An error occurred. Please try again.");
        }
    }
}
