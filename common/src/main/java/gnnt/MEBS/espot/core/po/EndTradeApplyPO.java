package gnnt.MEBS.espot.core.po;

import gnnt.MEBS.espot.core.util.Tool;

import java.io.Serializable;
import java.util.Date;
/**
 * [E_endTradeApply]
 * 结束合同申请表
 * @author liuzx
 */
public class EndTradeApplyPO extends Clone implements Serializable {
	private static final long serialVersionUID = 6852916402545302618L;
	/**申请编号*/
	private long applyID;
	/**合同号*/
	private long tradeNo;
	/**申请方交易商代码*/
	private String firmID;
	/**
	 * 状态
	 * 0：未处理 1：已撤销 2：已处理
	 */
	private int status;
	/**申请时间*/
	private Date applyTime;
	/**处理时间*/
	private Date processTime;
	/**
	 * 申请编号
	 * @return long
	 */
	public long getApplyID() {
		return applyID;
	}
	/**
	 * 申请编号
	 * @param applyID
	 */
	public void setApplyID(long applyID) {
		this.applyID = applyID;
	}
	/**
	 * 合同号
	 * @return long
	 */
	public long getTradeNo() {
		return tradeNo;
	}
	/**
	 * 合同号
	 * @param tradeNo
	 */
	public void setTradeNo(long tradeNo) {
		this.tradeNo = tradeNo;
	}
	/**
	 * 申请方交易商代码
	 * @return String
	 */
	public String getFirmID() {
		return firmID;
	}
	/**
	 * 申请方交易商代码
	 * @param firmID
	 */
	public void setFirmID(String firmID) {
		this.firmID = firmID;
	}
	/**
	 * 状态
	 * 0：未处理 1：已撤销 2：已处理
	 * @return int
	 */
	public int getStatus() {
		return status;
	}
	/**
	 * 根据数字状态转换中文意思用于提示信息的展示
	 * @return
	 */
	public String getStatusMeaning(){
		String sta="";
		 if(this.getStatus()==0){
			sta="未处理";
		}else if(this.getStatus()==1){
			sta="已撤销";
		}else if(this.getStatus()==2){
			sta="已处理";
		}
		 switch (Tool.strToInt(this.getStatus()+"")) {
			case 0:
				sta="未处理";
				break;
			case 1:
				sta="已撤销";
				break;
			case 2:
				sta="已处理";
				break;
			default:
				break;
			}
		return sta;
	}
	/**
	 * 状态
	 * 0：未处理 1：已撤销 2：已处理
	 * @param status
	 */
	public void setStatus(int status) {
		this.status = status;
	}
	/**
	 * 申请时间
	 * @return Date
	 */
	public Date getApplyTime() {
		return applyTime;
	}
	/**
	 * 申请时间
	 * @param applyTime
	 */
	public void setApplyTime(Date applyTime) {
		this.applyTime = applyTime;
	}
	/**
	 * 处理时间
	 * @return Date
	 */
	public Date getProcessTime() {
		return processTime;
	}
	/**
	 * 处理时间
	 * @param processTime
	 */
	public void setProcessTime(Date processTime) {
		this.processTime = processTime;
	}
}
