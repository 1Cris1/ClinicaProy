import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class TestDB {
    public static void main(String[] args) {
        String url = "jdbc:sqlserver://localhost\\SQLEXPRESS;databaseName=bd_clinica;integratedSecurity=true;encrypt=true;trustServerCertificate=true;";
        try (Connection conn = DriverManager.getConnection(url);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT nombres, apellidos, horario_lv, horario_sabado, duracion_cita FROM medicos WHERE nombres LIKE '%MARIANA%'")) {
            while (rs.next()) {
                System.out.println("Dr: " + rs.getString("nombres") + " " + rs.getString("apellidos"));
                System.out.println("LV: " + rs.getString("horario_lv"));
                System.out.println("Sab: " + rs.getString("horario_sabado"));
                System.out.println("Duracion: " + rs.getInt("duracion_cita"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
