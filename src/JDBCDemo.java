import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class JDBCDemo {

    public static void main(String[] args) {
        Connection conn;
        Statement stmt;
        try {
            // load the JDBC driver
            Class.forName("org.postgresql.Driver");

            // establish connection
            String url = "jdbc:postgresql://localhost:5432/disastermngt";
            conn = DriverManager.getConnection(url, "postgres", "postgres");

            // query the database
            String sql =
                    "SELECT " +
                            "person.id," +
                            "first_name," +
                            "resource_type," +
                            "report_type," +
                            "disaster_type," +
                            "time_stamp," +
                            "ST_AsText(geom) as geom \n" +
                            "from person \n" +
                            "join report on person.id = report.id \n" +
                            "join donation_report on report.id = donation_report.report_id";
                    //sql = "select id, report_type, disaster_type, time_stamp, " +
                   // "ST_AsText(geom) as geom from report";
            stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);

            // print the result
            if (res != null) {
                while (res.next()) {
                    System.out.println("id: " + res.getString("id"));
                    System.out.println("first_name: " + res.getString("first_name"));
                    System.out.println("resource_type: " + res.getString("resource_type"));
                    System.out.println("report_type: " + res.getString("report_type"));
                    System.out.println("disaster_type: " + res.getString("disaster_type"));
                    System.out.println("time_stamp: " + res.getString("time_stamp"));
                    System.out.println("geom: " + res.getString("geom"));
                }
            }

            // clean up
            stmt.close();
            conn.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }



}
