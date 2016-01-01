import java.io.PrintStream;
import java.net.Socket;

public class GnntPortTest
{
  public static String host;
  public static short port;
  
  public static void main(String[] args)
  {
    boolean loop = false;
    String hostAndPort = null;
    if ((args.length == 2) && (args[0].equals("-t")))
    {
      loop = true;
      hostAndPort = args[1];
    }
    else if (args.length == 1)
    {
      hostAndPort = args[0];
    }
    int ret = check(hostAndPort);
    if (ret < 0)
    {
      System.out.println("Usage: java -classpath .:x.jar GnntPortTest [-t] <ip>:<port>");
      System.exit(ret);
    }
    if (loop) {
      for (;;)
      {
        if (portTestBool(host, port)) {
          System.out.println("Y");
        } else {
          System.out.println("N");
        }
        try
        {
          Thread.sleep(3000L);
        }
        catch (InterruptedException localInterruptedException) {}
      }
    }
    if (portTestBool(host, port)) {
      System.exit(0);
    } else {
      System.exit(1);
    }
  }
  
  public static int check(String hostAndPort)
  {
    if (hostAndPort == null) {
      return -1;
    }
    int idx = -1;
    if ((idx = hostAndPort.indexOf(":")) < -1) {
      return -2;
    }
    host = hostAndPort.substring(0, idx);
    try
    {
      port = Short.parseShort(hostAndPort.substring(idx + 1));
    }
    catch (Exception e)
    {
      return -3;
    }
    return 0;
  }
  
  public static boolean portTestBool(String host, short port)
  {
    try
    {
      Socket sock = new Socket(host, port);
      return true;
    }
    catch (Exception e) {}
    return false;
  }
}
