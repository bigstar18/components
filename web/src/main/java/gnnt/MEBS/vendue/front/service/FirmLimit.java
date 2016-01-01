package gnnt.MEBS.vendue.front.service;

import javax.servlet.http.HttpServletRequest;

public abstract interface FirmLimit
{
  public abstract int validateFirm(String paramString, HttpServletRequest paramHttpServletRequest, int paramInt, short paramShort);
}
