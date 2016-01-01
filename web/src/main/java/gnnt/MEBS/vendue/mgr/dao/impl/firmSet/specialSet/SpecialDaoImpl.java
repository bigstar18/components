package gnnt.MEBS.vendue.mgr.dao.impl.firmSet.specialSet;

import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.vendue.mgr.dao.firmSet.specialSet.SpecialSetDao;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import gnnt.MEBS.vendue.mgr.util.Arith;
import java.util.Date;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Repository;

@Repository("specialSetDao")
public class SpecialDaoImpl
  extends StandardDao
  implements SpecialSetDao
{
  public Integer addSpecialFee(SpecialFee paramSpecialFee)
  {
    this.logger.debug("enter Dao_addSpecialFee");
    try
    {
      if (paramSpecialFee.getFeeAlgr().byteValue() == 1) {
        paramSpecialFee.setFee(Double.valueOf(Arith.div(paramSpecialFee.getFee().doubleValue(), 100.0F)));
      }
      paramSpecialFee.setUpdateTime(new Date(System.currentTimeMillis()));
      add(paramSpecialFee);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public SpecialFee viewSpecialFeeById(SpecialFeeId paramSpecialFeeId)
  {
    SpecialFee localSpecialFee = new SpecialFee();
    try
    {
      localSpecialFee.setId(paramSpecialFeeId);
      localSpecialFee = (SpecialFee)get(localSpecialFee);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return null;
    }
    return localSpecialFee;
  }
  
  public Integer updateSpecialFee(SpecialFee paramSpecialFee)
  {
    this.logger.debug("enter Dao_updateSpecialFee");
    try
    {
      if (paramSpecialFee.getFeeAlgr().byteValue() == 1) {
        paramSpecialFee.setFee(Double.valueOf(Arith.div(paramSpecialFee.getFee().doubleValue(), 100.0F)));
      }
      paramSpecialFee.setUpdateTime(new Date(System.currentTimeMillis()));
      update(paramSpecialFee);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public Integer deleteSpecialFee(String[] paramArrayOfString)
  {
    this.logger.debug("enter Dao_deleteSpecialFee");
    try
    {
      if (paramArrayOfString.length != 0)
      {
        SpecialFeeId[] arrayOfSpecialFeeId = new SpecialFeeId[paramArrayOfString.length];
        for (int i = 0; i < paramArrayOfString.length; i++)
        {
          String[] arrayOfString = paramArrayOfString[i].split(",");
          SpecialFeeId localSpecialFeeId = new SpecialFeeId();
          localSpecialFeeId.setUserCode(arrayOfString[0]);
          localSpecialFeeId.setBreedId(new Integer(arrayOfString[1]));
          localSpecialFeeId.setBs_flag(new Byte(arrayOfString[2]));
          arrayOfSpecialFeeId[i] = localSpecialFeeId;
        }
        deleteBYBulk(new SpecialFee(), arrayOfSpecialFeeId);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public Integer addSpecialMargin(SpecialMargin paramSpecialMargin)
  {
    this.logger.debug("enter Dao_addSpecialFee");
    try
    {
      if (paramSpecialMargin.getMarginAlgr().byteValue() == 1) {
        paramSpecialMargin.setMargin(Double.valueOf(Arith.div(paramSpecialMargin.getMargin().doubleValue(), 100.0F)));
      }
      paramSpecialMargin.setUpdateTime(new Date(System.currentTimeMillis()));
      add(paramSpecialMargin);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public Integer deleteSpecialMargin(String[] paramArrayOfString)
  {
    this.logger.debug("enter Dao_deleteSpecialMargin");
    try
    {
      if (paramArrayOfString.length != 0)
      {
        SpecialMarginId[] arrayOfSpecialMarginId = new SpecialMarginId[paramArrayOfString.length];
        for (int i = 0; i < paramArrayOfString.length; i++)
        {
          String[] arrayOfString = paramArrayOfString[i].split(",");
          SpecialMarginId localSpecialMarginId = new SpecialMarginId();
          localSpecialMarginId.setUserCode(arrayOfString[0]);
          localSpecialMarginId.setBreedId(new Integer(arrayOfString[1]));
          localSpecialMarginId.setBs_flag(new Byte(arrayOfString[2]));
          arrayOfSpecialMarginId[i] = localSpecialMarginId;
        }
        deleteBYBulk(new SpecialMargin(), arrayOfSpecialMarginId);
      }
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public Integer updateSpecialMargin(SpecialMargin paramSpecialMargin)
  {
    try
    {
      this.logger.debug("enter Dao_updateSpecialMargin");
      if (paramSpecialMargin.getMarginAlgr().byteValue() == 1) {
        paramSpecialMargin.setMargin(Double.valueOf(Arith.div(paramSpecialMargin.getMargin().doubleValue(), 100.0F)));
      }
      paramSpecialMargin.setUpdateTime(new Date(System.currentTimeMillis()));
      update(paramSpecialMargin);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return Integer.valueOf(-1);
    }
    return Integer.valueOf(1);
  }
  
  public SpecialMargin viewSpecialMarginById(SpecialMarginId paramSpecialMarginId)
  {
    this.logger.debug("enter Dao_viewSpecialMarginById");
    SpecialMargin localSpecialMargin = new SpecialMargin();
    try
    {
      localSpecialMargin.setId(paramSpecialMarginId);
      localSpecialMargin = (SpecialMargin)get(localSpecialMargin);
    }
    catch (Exception localException)
    {
      localException.printStackTrace();
      return null;
    }
    return localSpecialMargin;
  }
}
