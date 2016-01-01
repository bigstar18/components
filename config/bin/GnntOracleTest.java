import java.io.PrintStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GnntOracleTest
{
  public static void main(String[] args)
  {
    int port = 1521;
    String SID = "gnnt";
    if (args.length == 0)
    {
      System.out.println("Error! Please input IP , Port and SID.");
      System.out.println("Example:GnntOracleTest 172.16.1.1:1521:gnnt");
      System.out.println("Example:GnntOracleTest -debug 172.16.1.1:1521:gnnt");
      return;
    }
    String URL = "";
    if ((args[0].equals("-debug")) && (args.length == 2))
    {
      URL = "jdbc:oracle:thin:@" + args[1];
      System.out.println("[DEBUG] URL=" + URL);
    }
    else
    {
      URL = "jdbc:oracle:thin:@" + args[0];
    }
    try
    {
      Class.forName("oracle.jdbc.driver.OracleDriver");
      Connection conn = DriverManager.getConnection(URL, "NotExistedUser", "Password");
      if (conn != null) {
        conn.close();
      }
    }
    catch (SQLException se)
    {
      if (se.getErrorCode() == 1017) {
        System.out.println("succeed");
      } else {
        System.out.println("failed");
      }
    }
    catch (Exception e)
    {
      e.printStackTrace();
    }
  }
}
