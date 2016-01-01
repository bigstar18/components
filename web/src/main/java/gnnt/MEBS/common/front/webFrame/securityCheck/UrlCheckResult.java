package gnnt.MEBS.common.front.webFrame.securityCheck;

import java.io.PrintStream;

public enum UrlCheckResult
{
  SUCCESS(0),  NEEDLESSCHECK(0),  USERISNULL(-1),  AUOVERTIME(-2),  AUUSERKICK(-3),  NOPURVIEW(-4),  NEEDLESSCHECKRIGHT(-5),  NOMODULEPURVIEW(-6);
  
  private final int value;
  
  public int getValue()
  {
    return this.value;
  }
  
  private UrlCheckResult(int value)
  {
    this.value = value;
  }
  
  public static void main(String[] args)
  {
    System.out.println(NOPURVIEW);
  }
}
