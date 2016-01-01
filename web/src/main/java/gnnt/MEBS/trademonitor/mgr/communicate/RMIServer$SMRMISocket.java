package gnnt.MEBS.trademonitor.mgr.communicate;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.rmi.server.RMISocketFactory;

class RMIServer$SMRMISocket
  extends RMISocketFactory
{
  private int port = 1099;
  
  public RMIServer$SMRMISocket(RMIServer paramRMIServer, int paramInt)
  {
    if (paramInt > 0) {
      this.port = paramInt;
    }
  }
  
  public ServerSocket createServerSocket(int paramInt)
    throws IOException
  {
    if (paramInt <= 0) {
      paramInt = this.port;
    }
    return new ServerSocket(paramInt);
  }
  
  public Socket createSocket(String paramString, int paramInt)
    throws IOException
  {
    return new Socket(paramString, paramInt);
  }
}
