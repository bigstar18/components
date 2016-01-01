create or replace function FN_T_ComputePayout(
    p_FirmID varchar2,
    p_CommodityID varchar2,
    p_bs_flag        number,
    p_quantity number,
    p_price number
) return number
/****
 * 计算交收货款
 * 返回值 成功返回交收货款;-1 计算所需数据不全;-100 其它错误
 *
 * 新添加在计算比例货款时，如果商品含税，扣除其税费   by 张天骥  2015/09/11
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_marginRate_b         number(10,4);
    v_marginAlgr_b         number(2);
    v_contractFactor     number(12,2);
    v_margin             number(15,2) default 0;
    v_taxinclusive      number(1);                              --商品是否含税 1为不含税 0为含税
    v_addedtax         number(10,4);                          --商品税率
    
begin
    --获取商品信息：合约因子，交收货款系数，交收货款算法 , 商品是否含税，商品税率
    select PayoutRate,PayoutAlgr,contractfactor,taxinclusive,addedtax
    into v_marginRate_b,v_marginAlgr_b,v_contractFactor,v_taxinclusive,v_addedtax
    from T_Commodity where CommodityID=p_CommodityID;

    begin
        --获取特殊的交收货款系数，交收货款算法
        select PayoutRate,PayoutAlgr
    	into v_marginRate_b,v_marginAlgr_b
        from T_A_FirmSettleMargin
        where FirmID=p_FirmID and CommodityID=p_CommodityID;
    exception
        when NO_DATA_FOUND then
            null;
    end;
  
	if(v_marginAlgr_b = 1) then  
             --如果商品不含税
            if(v_taxinclusive = 1 ) then --应收交收货款 =数量 * 合约因子 * 价格 * 交收货款系数 按照百分比算
            v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b;
            else -- 商品含税 应收交收货款 =数量 * 合约因子 * 价格 * 交收货款系数 * 商品含税系数  按照百分比算
             v_margin:=p_quantity*v_contractFactor*p_price*v_marginRate_b*(1/(1+v_addedtax));
             end if;
    elsif(v_marginAlgr_b = 2) then  --应收交收货款 =数量 * 交收货款系数 按绝对值算
		v_margin:=p_quantity*v_marginRate_b;
    end if;

    if(v_margin is null) then
    	rollback;
        return -1;
    end if;
    return v_margin;
exception
    when no_data_found then
    	rollback;
        return -1;
    when others then
    	rollback;
    	return -100;
end;
/

