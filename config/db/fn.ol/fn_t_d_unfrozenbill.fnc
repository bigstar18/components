create or replace function FN_T_D_UnFrozenBill(
    p_FirmID     varchar2,   --交易商ID
    p_CommodityID varchar2 ,--商品ID
    p_UnFrozenDelayQty       number --解冻延期数量
) return number
/****
 * 解冻仓单数量
 * 返回值
 * 1  成功
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_WillFrozenQty    number(10);
    v_TempFrozenQty    number(10);
begin
/*
    --1、解冻仓单
    v_WillFrozenQty := p_UnFrozenDelayQty;
    for cur_ValidBill in (select rowid,FrozenDelayQty
                      from T_ValidBill
					  where FirmID_S = p_FirmID
					      and CommodityID = p_CommodityID
					      and BillType = 5
					      and Status = 1 order by CreateTime desc
					  )
    loop
        if(cur_ValidBill.FrozenDelayQty <= v_WillFrozenQty) then
            v_TempFrozenQty := cur_ValidBill.FrozenDelayQty ;
        else
        	v_TempFrozenQty := v_WillFrozenQty ;
        end if;
        update T_ValidBill
        set FrozenDelayQty=FrozenDelayQty-v_TempFrozenQty
        where rowid=cur_ValidBill.rowid;
        v_WillFrozenQty := v_WillFrozenQty - v_TempFrozenQty;
        exit when v_WillFrozenQty=0;
    end loop;
	*/
    return 1;

end;
/

