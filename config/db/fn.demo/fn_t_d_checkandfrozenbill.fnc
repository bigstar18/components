create or replace function FN_T_D_CheckAndFrozenBill(
    p_FirmID     varchar2,   --������ID
    p_CommodityID varchar2 ,--��ƷID
    p_FrozenDelayQty       number --������������
) return number
/****
 * ��鲢����ֵ�
 * ����ֵ
 * 1  �ɹ�
 * -1  �ֲֲ���
****/
as
	v_version varchar2(10):='1.0.2.2';
    v_HoldSum        number(10);   --�ֲֺϼ�����
    v_WillFrozenQty    number(10);
    v_TempFrozenQty    number(10);
begin
/*
	--1������Ч�ֵ����ȡ����������¼
    select nvl(sum(Quantity-SettleDelayQty-FrozenDelayQty), 0) into v_HoldSum
    from T_ValidBill
    where FirmID_S = p_FirmID
      and CommodityID = p_CommodityID
      and BillType = 5
      and Status = 1;
    if(v_HoldSum < p_FrozenDelayQty) then
        rollback;
        return -1;  --�ֲֲ���
    end if;
    --2������ֵ�
    v_WillFrozenQty := p_FrozenDelayQty;
    for cur_ValidBill in (select rowid,(Quantity-SettleDelayQty-FrozenDelayQty) UsefulQty
                      from T_ValidBill
					  where FirmID_S = p_FirmID
					      and CommodityID = p_CommodityID
					      and BillType = 5
					      and Status = 1 order by CreateTime
					  )
    loop
        if(cur_ValidBill.UsefulQty <= v_WillFrozenQty) then
            v_TempFrozenQty := cur_ValidBill.UsefulQty ;
        else
        	v_TempFrozenQty := v_WillFrozenQty ;
        end if;
        update T_ValidBill
        set FrozenDelayQty=FrozenDelayQty+v_TempFrozenQty
        where rowid=cur_ValidBill.rowid;
        v_WillFrozenQty := v_WillFrozenQty - v_TempFrozenQty;
        exit when v_WillFrozenQty=0;
    end loop;
*/
    return 1;

end;
/

