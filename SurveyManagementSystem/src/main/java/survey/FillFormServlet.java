package survey;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class FillFormServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int formId = Integer.parseInt(request.getParameter("formId"));

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT form_title,form_content FROM forms WHERE id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, formId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String formContent = rs.getString("form_content");
                    String formTitle=rs.getString("form_title");
                    request.setAttribute("formContent", formContent);
                    request.setAttribute("formTitle", formTitle);
                    request.getRequestDispatcher("fillForm.jsp").forward(request, response);
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Form not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}
