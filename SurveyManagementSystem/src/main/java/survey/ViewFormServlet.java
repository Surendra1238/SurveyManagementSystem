package survey;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ViewFormServlet extends HttpServlet {
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String formId = request.getParameter("id");

        // Database connection details
        String jdbcURL = "jdbc:oracle:thin:@localhost:1521:orcl";
        String dbUser = "SYSTEM";
        String dbPassword = "Harsha21";

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

            // Prepare and execute the query
            String query = "SELECT form_title, form_content FROM forms WHERE id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, Integer.parseInt(formId));
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String formTitle = rs.getString("form_title");
                String formContent = rs.getString("form_content");
                request.setAttribute("formContent", formContent);
                request.setAttribute("formTitle", formTitle);
                request.getRequestDispatcher("formdetails.jsp").forward(request, response);
            } else {
                out.println("Form not found.");
            }

            rs.close();
            pstmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("An error occurred while fetching the form.");
        }
    }
}
