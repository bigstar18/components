package gnnt.MEBS.vendue.mgr.dao.impl.bargainManager;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.vendue.mgr.dao.bargainManager.BargainManagerDao;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.transform.Transformers;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

@Repository("bargainManagerDao")
public class BargainManagerDaoImpl
  extends StandardDao
  implements BargainManagerDao
{
  public void unfounds(Object[] paramArrayOfObject)
  {
    try
    {
      executeProcedure("{? = call FN_F_UpdateFundsFull(?,?,?,?,?,?,?)}", paramArrayOfObject);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
    }
  }
  
  public void updateHisBargain(String paramString1, double paramDouble, String paramString2, long paramLong)
  {
    StringBuffer localStringBuffer1 = new StringBuffer();
    StringBuffer localStringBuffer2 = new StringBuffer();
    localStringBuffer1.append("select * from v_hisBargain vh where vh.contractID=").append(paramLong).append(" and trunc(vh.tradeDate,'MI')=trunc(to_date('").append(paramString2).append("','yyyy-MM-DD HH24:MI:SS'),'MI')");
    List localList = findAllBySQL(localStringBuffer1.toString(), null);
    if ((localList != null) && (localList.size() > 0))
    {
      Map localMap = (Map)localList.get(0);
      BigDecimal localBigDecimal1 = (BigDecimal)localMap.get("B_UNFROZENBAIL");
      BigDecimal localBigDecimal2 = (BigDecimal)localMap.get("S_UNFROZENBAIL");
      if ((paramString1.equals("buy")) && (localBigDecimal1 != null)) {
        localStringBuffer2.append("update v_hisBargain vh set vh.b_unFrozenBail = vh.b_unFrozenBail+").append(paramDouble).append(" where vh.contractID=").append(paramLong).append(" and trunc(vh.tradeDate,'MI')=trunc(to_date('").append(paramString2).append("','yyyy-MM-DD HH24:MI:SS'),'MI')");
      } else if ((paramString1.equals("sell")) && (localBigDecimal2 != null)) {
        localStringBuffer2.append("update v_hisBargain vh set vh.s_unFrozenBail = vh.s_unFrozenBail+").append(paramDouble).append(" where vh.contractID=").append(paramLong).append(" and trunc(vh.tradeDate,'MI')=trunc(to_date('").append(paramString2).append("','yyyy-MM-DD HH24:MI:SS'),'MI')");
      }
      updateBySQL(localStringBuffer2.toString(), null);
    }
  }
  
  private List<Map<Object, Object>> findAllBySQL(final String paramString, final Object[] paramArrayOfObject)
  {
    List localList = (List)getHibernateTemplate().execute(new HibernateCallback()
    {
      public Object doInHibernate(Session paramAnonymousSession)
        throws HibernateException, SQLException
      {
        BargainManagerDaoImpl.this.logger.debug(paramString);
        paramAnonymousSession.clear();
        Query localQuery = paramAnonymousSession.createSQLQuery(paramString).setResultTransformer(Transformers.ALIAS_TO_ENTITY_MAP);
        if ((paramArrayOfObject != null) && (paramArrayOfObject.length > 0)) {
          for (int i = 0; i < paramArrayOfObject.length; i++)
          {
            BargainManagerDaoImpl.this.logger.debug("   params[" + i + "]:" + paramArrayOfObject[i]);
            localQuery.setParameter(i, paramArrayOfObject[i]);
          }
        }
        List localList = localQuery.list();
        paramAnonymousSession.clear();
        return localList;
      }
    });
    return localList;
  }
  
  private void updateBySQL(final String paramString, final Object[] paramArrayOfObject)
  {
    getHibernateTemplate().execute(new HibernateCallback()
    {
      public Object doInHibernate(Session paramAnonymousSession)
        throws HibernateException, SQLException
      {
        BargainManagerDaoImpl.this.logger.debug(paramString);
        paramAnonymousSession.clear();
        SQLQuery localSQLQuery = paramAnonymousSession.createSQLQuery(paramString);
        if ((paramArrayOfObject != null) && (paramArrayOfObject.length > 0)) {
          for (int i = 0; i < paramArrayOfObject.length; i++)
          {
            BargainManagerDaoImpl.this.logger.debug("   params[" + i + "]:" + paramArrayOfObject[i]);
            localSQLQuery.setParameter(i, paramArrayOfObject[i]);
          }
        }
        return Integer.valueOf(localSQLQuery.executeUpdate());
      }
    });
  }
}
