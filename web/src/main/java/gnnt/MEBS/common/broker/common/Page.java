package gnnt.MEBS.common.broker.common;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Page<T>
  implements Serializable
{
  private static final long serialVersionUID = 2984068735031118368L;
  protected List<T> result;
  protected int pageSize;
  protected int pageNumber;
  protected int totalCount = 0;
  
  public Page(int pageNumber, int pageSize, int totalCount)
  {
    this(pageNumber, pageSize, totalCount, new ArrayList(0));
  }
  
  public Page(int pageNumber, int pageSize, int totalCount, List<T> result)
  {
    if (pageSize <= 0) {
      throw new IllegalArgumentException(
        "[pageSize] must great than zero");
    }
    this.pageSize = pageSize;
    this.pageNumber = pageNumber;
    this.totalCount = totalCount;
    setResult(result);
  }
  
  public void setResult(List<T> elements)
  {
    if (elements == null) {
      throw new IllegalArgumentException("'result' must be not null");
    }
    this.result = elements;
  }
  
  public List<T> getResult()
  {
    return this.result;
  }
  
  public int getTotalCount()
  {
    return this.totalCount;
  }
  
  public void setTotalCount(int totalCount)
  {
    this.totalCount = totalCount;
  }
  
  public int getPageSize()
  {
    return this.pageSize;
  }
  
  public void setPageSize(int pageSize)
  {
    this.pageSize = pageSize;
  }
  
  public int getPageNumber()
  {
    return this.pageNumber;
  }
  
  public void setPageNumber(int pageNumber)
  {
    this.pageNumber = pageNumber;
  }
  
  public int getTotalPage()
  {
    int totalPage = 1;
    if (this.totalCount % this.pageSize == 0) {
      totalPage = this.totalCount / this.pageSize;
    } else {
      totalPage = this.totalCount / this.pageSize + 1;
    }
    return totalPage;
  }
}
