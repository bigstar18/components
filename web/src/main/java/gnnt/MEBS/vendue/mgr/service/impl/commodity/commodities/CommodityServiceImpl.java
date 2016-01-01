package gnnt.MEBS.vendue.mgr.service.impl.commodity.commodities;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import gnnt.MEBS.common.mgr.model.StandardModel;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.Arith;
import gnnt.MEBS.vendue.mgr.model.commodity.commext.VCommext;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VCommodity;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VCurcommodity;
import gnnt.MEBS.vendue.mgr.model.commodity.commodities.VFundfrozen;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFee;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialFeeId;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMargin;
import gnnt.MEBS.vendue.mgr.model.firmSet.specialSet.SpecialMarginId;
import gnnt.MEBS.vendue.mgr.model.firmSet.tradeUser.TradeUserModel;
import gnnt.MEBS.vendue.mgr.model.system.sysPartition.VSyspartition;
import gnnt.MEBS.vendue.mgr.service.commodity.commdities.CommodityService;

@Service("commodityService")
@Transactional(propagation = Propagation.REQUIRED, readOnly = false)
public class CommodityServiceImpl extends StandardService implements CommodityService {
	public int deleteList(String[] paramArrayOfString) {
		int i = 1;
		for (String str : paramArrayOfString) {
			VCommodity localVCommodity = new VCommodity();
			localVCommodity.setCode(Integer.valueOf(Integer.parseInt(str)));
			localVCommodity = (VCommodity) get(localVCommodity);
			VCurcommodity localVCurcommodity = new VCurcommodity();
			localVCurcommodity.setCode(str);
			localVCurcommodity = (VCurcommodity) get(localVCurcommodity);
			if (localVCommodity != null) {
				if (localVCurcommodity == null) {
					localVCommodity.setStatus(Short.valueOf((short) 5));
					update(localVCommodity);
				} else {
					i = -1;
				}
			}
		}
		return i;
	}

	public List<Integer> addToCur(String[] paramArrayOfString) {
		ArrayList localArrayList = new ArrayList();
		for (String str1 : paramArrayOfString) {
			VCommodity localVCommodity = new VCommodity();
			localVCommodity.setCode(Integer.valueOf(Integer.parseInt(str1)));
			localVCommodity = (VCommodity) get(localVCommodity);
			VCurcommodity localVCurcommodity = new VCurcommodity();
			localVCurcommodity.setCode(str1);
			localVCurcommodity = (VCurcommodity) get(localVCurcommodity);
			if (localVCurcommodity != null) {
				localArrayList.add(localVCommodity.getCode());
			} else if (localVCommodity.getAuditstatus().byteValue() != 1) {
				localArrayList.add(localVCommodity.getCode());
			} else if ((localVCommodity.getStatus().shortValue() != 2) && (localVCommodity.getStatus().shortValue() != 8)) {
				localArrayList.add(localVCommodity.getCode());
			} else {
				byte b = localVCommodity.getBsFlag().byteValue();
				VSyspartition localVSyspartition = new VSyspartition();
				localVSyspartition.setPartitionid(localVCommodity.getTradepartition());
				localVSyspartition = (VSyspartition) get(localVSyspartition);
				double d3;
				if (b == 1) {
					d3 = localVCommodity.getBeginprice().doubleValue();
				} else {
					d3 = localVCommodity.getAlertprice().doubleValue();
				}
				SpecialMargin localSpecialMargin = new SpecialMargin();
				SpecialMarginId localSpecialMarginId = new SpecialMarginId();
				localSpecialMarginId.setBreedId(Integer.valueOf(Integer.parseInt(localVCommodity.getBreedid().toString())));
				localSpecialMarginId.setBs_flag(Byte.valueOf(b));
				localSpecialMarginId.setUserCode(localVCommodity.getUserid());
				localSpecialMargin.setId(localSpecialMarginId);
				localSpecialMargin = (SpecialMargin) get(localSpecialMargin);
				double d1;
				if (localSpecialMargin != null) {
					if (localSpecialMargin.getMarginAlgr().byteValue() == 1) {
						d1 = Arith.mul(Arith.mul(d3, localVCommodity.getAmount().doubleValue()), localSpecialMargin.getMargin().doubleValue());
					} else {
						d1 = Arith.mul(localSpecialMargin.getMargin().doubleValue(), localVCommodity.getAmount().doubleValue());
					}
				} else if (localVCommodity.getMarginalgr().byteValue() == 1) {
					if (b == 1) {
						d1 = Arith.mul(Arith.mul(d3, localVCommodity.getAmount().doubleValue()), localVCommodity.getBSecurity().doubleValue());
					} else {
						d1 = Arith.mul(Arith.mul(d3, localVCommodity.getAmount().doubleValue()), localVCommodity.getSSecurity().doubleValue());
					}
				} else if (b == 1) {
					d1 = Arith.mul(localVCommodity.getBSecurity().doubleValue(), localVCommodity.getAmount().doubleValue());
				} else {
					d1 = Arith.mul(localVCommodity.getSSecurity().doubleValue(), localVCommodity.getAmount().doubleValue());
				}
				SpecialFee localSpecialFee = new SpecialFee();
				SpecialFeeId localSpecialFeeId = new SpecialFeeId();
				localSpecialFeeId.setBreedId(Integer.valueOf(Integer.parseInt(localVCommodity.getBreedid().toString())));
				localSpecialFeeId.setBs_flag(Byte.valueOf(b));
				localSpecialFeeId.setUserCode(localVCommodity.getUserid());
				localSpecialFee.setId(localSpecialFeeId);
				localSpecialFee = (SpecialFee) get(localSpecialFee);
				double d2;
				if (localSpecialFee != null) {
					if (localSpecialFee.getFeeAlgr().byteValue() == 1) {
						d2 = Arith.mul(Arith.mul(d3, localVCommodity.getAmount().doubleValue()), localSpecialFee.getFee().doubleValue());
					} else {
						d2 = Arith.mul(localSpecialFee.getFee().doubleValue(), localVCommodity.getAmount().doubleValue());
					}
				} else if (localVCommodity.getFeealgr().byteValue() == 1) {
					if (b == 1) {
						d2 = Arith.mul(Arith.mul(d3, localVCommodity.getAmount().doubleValue()), localVCommodity.getBFee().doubleValue());
					} else {
						d2 = Arith.mul(Arith.mul(d3, localVCommodity.getAmount().doubleValue()), localVCommodity.getSFee().doubleValue());
					}
				} else if (b == 1) {
					d2 = Arith.mul(localVCommodity.getBFee().doubleValue(), localVCommodity.getAmount().doubleValue());
				} else {
					d2 = Arith.mul(localVCommodity.getSFee().doubleValue(), localVCommodity.getAmount().doubleValue());
				}
				String str2 = localVCommodity.getUserid();
				Object[] arrayOfObject = { str2, Integer.valueOf(1) };
				double d4 = 0.0D;
				try {
					Object localObject = executeProcedure("{?=call FN_F_GetRealFunds(?,?) }", arrayOfObject);
					d4 = Double.parseDouble(executeProcedure("{?=call FN_F_GetRealFunds(?,?) }", arrayOfObject).toString());
				} catch (Exception localException1) {
					localException1.printStackTrace();
				}
				TradeUserModel localTradeUserModel = new TradeUserModel();
				localTradeUserModel.setUserCode(str2);
				localTradeUserModel = (TradeUserModel) get(localTradeUserModel);
				Double localDouble = localTradeUserModel.getOverdraft();
				localDouble = Double.valueOf(localDouble == null ? 0.0D : localDouble.doubleValue());
				if (Arith.compareTo(Arith.add(d4, localDouble.doubleValue()), Arith.add(d1, d2)) == -1) {
					localArrayList.add(localVCommodity.getCode());
				} else {
					arrayOfObject = new Object[] { str2, Double.valueOf(Arith.add(d1, d2)), Integer.valueOf(21) };
					try {
						executeProcedure("{?=call FN_F_UpdateFrozenFunds(?,?,?) }", arrayOfObject);
					} catch (Exception localException2) {
						localException2.printStackTrace();
					}
					VFundfrozen localVFundfrozen = new VFundfrozen();
					localVFundfrozen.setCode(localVCommodity.getCode().toString());
					localVFundfrozen.setUserid(str2);
					localVFundfrozen.setFrozenmargin(Double.valueOf(d1));
					localVFundfrozen.setFrozenfee(Double.valueOf(d2));
					localVFundfrozen.setFrozentime(new Date());
					add(localVFundfrozen);
					localVCurcommodity = new VCurcommodity();
					localVCurcommodity.setCode(str1);
					localVCurcommodity.setCommodityid(localVCommodity.getCommodityid());
					localVCurcommodity.setTradepartition(localVCommodity.getTradepartition());
					localVCurcommodity.setBargaintype(Byte.valueOf((byte) 0));
					localVCurcommodity.setModifytime(new Date());
					add(localVCurcommodity);
					if (localVCommodity.getStatus().shortValue() == 8) {
						localVCommodity.setStatus(Short.valueOf((short) 2));
					}
					update(localVCommodity);
				}
			}
		}
		return localArrayList;
	}

	public int add(VCommodity paramVCommodity, List<VCommext> paramList) {
		int i = -1;
		add(paramVCommodity);
		Iterator localIterator = paramList.iterator();
		while (localIterator.hasNext()) {
			VCommext localVCommext = (VCommext) localIterator.next();
			localVCommext.setCode(paramVCommodity.getCode().toString());
			if ((localVCommext.getValue() != null) && (!localVCommext.getValue().equals(""))) {
				add(localVCommext);
			}
		}
		i = 1;
		return i;
	}

	public int update(VCommodity paramVCommodity, List<VCommext> paramList) {
		int i = -1;
		VCommodity localVCommodity = new VCommodity();
		localVCommodity.setCode(paramVCommodity.getCode());
		localVCommodity = (VCommodity) get(localVCommodity);
		paramVCommodity.setStatus(localVCommodity.getStatus());
		if (paramVCommodity.getStatus().shortValue() != 8) {
			if (paramVCommodity.getStatus().shortValue() == 2) {
				VCurcommodity localObject = new VCurcommodity();
				((VCurcommodity) localObject).setCode(paramVCommodity.getCode().toString());
				localObject = (VCurcommodity) get((StandardModel) localObject);
				if ((localObject != null) && (((VCurcommodity) localObject).getSection() != null)) {
					return i;
				}
			} else {
				return i;
			}
		}
		i = 1;
		update(paramVCommodity);
		executeUpdateBySql("delete from v_commext where code = '" + paramVCommodity.getCode() + "'");
		Object localObject = paramList.iterator();
		while (((Iterator) localObject).hasNext()) {
			VCommext localVCommext = (VCommext) ((Iterator) localObject).next();
			localVCommext.setCode(paramVCommodity.getCode().toString());
			if ((localVCommext.getValue() != null) && (!localVCommext.getValue().equals(""))) {
				add(localVCommext);
			}
		}
		return i;
	}
}
