package gnnt.MEBS.vendue.front.model;

import java.sql.Timestamp;

public class CurSubmitVO
{
  public int tradePartition;
  public long iD;
  public String code;
  public double price;
  public double amount;
  public String userID;
  public String traderID;
  public Timestamp submitTime;
  public int orderType;
  public double validAmount;
  public Timestamp modifytime;
  public double frozenMargin;
  public double frozenFee;
  public double unFrozenMargin;
  public double unFrozenFee;
  public int withdrawType;
  
  public String toString()
  {
    String str = "\n";
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("**" + getClass().getName() + "**" + str);
    localStringBuffer.append("tradePartition:" + this.tradePartition + str);
    localStringBuffer.append("ID:" + this.iD + str);
    localStringBuffer.append("code:" + this.code + str);
    localStringBuffer.append("price:" + this.price + str);
    localStringBuffer.append("amount:" + this.amount + str);
    localStringBuffer.append("userID:" + this.userID + str);
    localStringBuffer.append("submitTime:" + this.submitTime + str);
    localStringBuffer.append("orderType:" + this.orderType + str);
    localStringBuffer.append("validAmount:" + this.validAmount + str);
    localStringBuffer.append("modifytime:" + this.modifytime + str);
    localStringBuffer.append("frozenMargin:" + this.frozenMargin + str);
    localStringBuffer.append("frozenFee:" + this.frozenFee + str);
    localStringBuffer.append("unFrozenMargin:" + this.unFrozenMargin + str);
    localStringBuffer.append("unFrozenFee:" + this.unFrozenFee + str);
    localStringBuffer.append("withdrawType:" + this.withdrawType + str);
    localStringBuffer.append(str);
    return localStringBuffer.toString();
  }
}
