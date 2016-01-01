package gnnt.MEBS.common.front.statictools.filetools;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

public class XMLWork
{
  private static final String encoding = "GBK";
  
  public static Object reader(Class cl, String xml)
  {
    Object result = null;
    try
    {
      result = Class.forName(cl.getName()).newInstance();
      JAXBContext context = JAXBContext.newInstance(new Class[] { result.getClass() });
      InputStream is = null;
      try
      {
        is = new ByteArrayInputStream(xml.getBytes("GBK"));
      }
      catch (UnsupportedEncodingException e)
      {
        e.printStackTrace();
      }
      Unmarshaller ums = context.createUnmarshaller();
      result = ums.unmarshal(is);
    }
    catch (JAXBException e)
    {
      e.printStackTrace();
    }
    catch (InstantiationException e)
    {
      e.printStackTrace();
    }
    catch (IllegalAccessException e)
    {
      e.printStackTrace();
    }
    catch (ClassNotFoundException e)
    {
      e.printStackTrace();
    }
    return result;
  }
  
  public static String writer(Object obj)
  {
    String result = null;
    JAXBContext context = null;
    try
    {
      context = JAXBContext.newInstance(new Class[] { obj.getClass() });
      Marshaller ms = context.createMarshaller();
      ms.setProperty("jaxb.encoding", "GBK");
      Writer writer = new StringWriter();
      ms.marshal(obj, writer);
      result = writer.toString();
    }
    catch (JAXBException e)
    {
      e.printStackTrace();
    }
    return result;
  }
  
  public static String readXMLFile(String fileURI)
  {
    StringBuilder sb = new StringBuilder();
    BufferedReader reader = null;
    try
    {
      reader = new BufferedReader(new InputStreamReader(new FileInputStream(fileURI)));
    }
    catch (FileNotFoundException e)
    {
      e.printStackTrace();
    }
    if (reader != null) {
      try
      {
        String line = reader.readLine();
        while (line != null)
        {
          sb.append(line.trim());
          
          line = reader.readLine();
        }
        return sb.toString();
      }
      catch (Exception e)
      {
        return "";
      }
    }
    return "";
  }
}
