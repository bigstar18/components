package gnnt.MEBS.vendue.front.model;

import java.sql.Timestamp;

public class BargainVO
{
  public int tradePartition;
  public long submitID;
  public String code;
  public String commodityID;
  public long contractID;
  public double price;
  public double amount;
  public String userID;
  public Timestamp tradeTime;
  public int section;
  public double s_bail;
  public double b_bail;
  public double s_poundage;
  public double b_poundage;
  public int status;
  public String contractContent;
  public double actualAmount;
  public double fellBackAmount;
  public int patchStatus;
  public int result;
  public double s_lastBail;
  public double b_lastBail;
  public double lastAmount;
  public String note;
  public double b_payments;
  public double s_payments;
  public double b_referPayment;
  public double s_referPayment;
  public double b_dedit;
  public double s_dedit;
  public Timestamp processingTime;
  public String remark;
  
  public String toString()
  {
    String str = "\n";
    StringBuffer localStringBuffer = new StringBuffer();
    localStringBuffer.append("**" + getClass().getName() + "**" + str);
    localStringBuffer.append("tradePartition:" + this.tradePartition + str);
    localStringBuffer.append("submitID:" + this.submitID + str);
    localStringBuffer.append("code:" + this.code + str);
    localStringBuffer.append("commodityID:" + this.commodityID + str);
    localStringBuffer.append("contractID:" + this.contractID + str);
    localStringBuffer.append("price:" + this.price + str);
    localStringBuffer.append("amount:" + this.amount + str);
    localStringBuffer.append("userID:" + this.userID + str);
    localStringBuffer.append("tradeTime:" + this.tradeTime + str);
    localStringBuffer.append("section:" + this.section + str);
    localStringBuffer.append("s_bail:" + this.s_bail + str);
    localStringBuffer.append("b_bail:" + this.b_bail + str);
    localStringBuffer.append("s_poundage:" + this.s_poundage + str);
    localStringBuffer.append("b_poundage:" + this.b_poundage + str);
    localStringBuffer.append("status:" + this.status + str);
    localStringBuffer.append("contractContent:" + this.contractContent + str);
    localStringBuffer.append("b_payments:" + this.b_payments + str);
    localStringBuffer.append("s_payments:" + this.s_payments + str);
    localStringBuffer.append("b_referPayment:" + this.b_referPayment + str);
    localStringBuffer.append("s_referPayment:" + this.s_referPayment + str);
    localStringBuffer.append("b_dedit:" + this.b_dedit + str);
    localStringBuffer.append("s_dedit:" + this.s_dedit + str);
    localStringBuffer.append("processingTime:" + this.processingTime + str);
    localStringBuffer.append("remark:" + this.remark + str);
    localStringBuffer.append(str);
    return localStringBuffer.toString();
  }
}
