package survey;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;


public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO users (email, password, role) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, email);
                stmt.setString(2, password);
                stmt.setString(3, role);
                int rowsInserted = stmt.executeUpdate();
                if (rowsInserted > 0) {
                    response.sendRedirect("SurveyLogin.jsp?message=Registration successful. Please log in.");
                } else {
                    response.sendRedirect("Register.jsp?error=Registration failed. Please try again.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("jsp/Register.jsp?error=An error occurred. Please try again.");
        }
    }
}