package grocery_utilities;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBGroceryConfig {

    // Database details
    private static final String DB_NAME = "grocery_store";
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME;
    private static final String USER = "root";
<<<<<<< HEAD
    private static final String PASSWORD = "";
=======
    private static final String PASSWORD = "root";
    private static final String URL =
            "jdbc:mysql://localhost:3306/" + DB_NAME;
>>>>>>> 193d2ac00bc3f144559673f9199c17a21a1482d0

    // Private constructor (prevents object creation)
    private DBGroceryConfig() {
    }

    // Get database connection
    public static Connection getConnection() throws SQLException {

        try {
            // Load MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found!", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
