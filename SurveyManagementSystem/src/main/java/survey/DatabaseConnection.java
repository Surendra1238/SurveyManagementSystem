package survey;

import java.sql.*;

public class DatabaseConnection {
	private static final String URL = "jdbc:oracle:thin:@localhost:1521/orcl";
    private static final String USER = "SYSTEM";
    private static final String PASSWORD = "Harsha21";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
