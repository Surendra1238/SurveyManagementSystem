package survey;

import java.io.IOException;
import java.sql.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateFormServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int formId = Integer.parseInt(request.getParameter("formId"));
        String formData = request.getParameter("formData");
        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:orcl", "SYSTEM", "Harsha21");
            ps = con.prepareStatement("UPDATE forms SET form_content = ? WHERE id = ?");
            ps.setString(1, formData);
            ps.setInt(2, formId);
            ps.executeUpdate();

            response.setContentType("text/html");
            response.getWriter().write("Success");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error");
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
