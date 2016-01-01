create or replace function FN_T_ReComputeFloatLoss
return number
/****
 * ������ʱ���������������½����̶����ʽ�
 * ע�ⲻҪ�ύcommit����Ϊ���д�����Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -100 ��������
****/
as
	v_version varchar2(10):='1.0.0.10';
	v_FloatingLossComputeType number(2);
	v_FloatingProfitSubTax number(1);
	v_F_FrozenFunds number(15,2);
	v_GageMode number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
begin
	    --��ȡ�����������ͣ�ӯ���Ƿ��˰
	    select FloatingLossComputeType,FloatingProfitSubTax,GageMode into v_FloatingLossComputeType,v_FloatingProfitSubTax,v_GageMode from T_A_Market;
		--���³ֲ���ϸ�ϵĸ���ӯ��
        update
        (select /*+ BYPASS_UJVC */a.Price HoldPrice,HoldQty,GageQty,bs_flag,floatingloss,b.AddedTax,b.ContractFactor,b.price from T_HoldPosition a,
            (select c.AddedTax,c.ContractFactor,c.commodityid,q.price from T_Commodity c,T_Quotation q where c.CommodityID=q.CommodityID) b
        where a.commodityid=b.commodityid)
        --set floatingloss = decode(bs_flag,1,(Price-HoldPrice),(HoldPrice-Price))*HoldQty*ContractFactor;
        set floatingloss = FN_T_ComputeFPSubTax(HoldPrice,Price,HoldQty+decode(v_GageMode,1,GageQty,0),ContractFactor,bs_flag,AddedTax,v_FloatingProfitSubTax);

		--����������Ʒ�ֲ���ϸ�ϵĸ���ӯ��
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_Commodity b
         where a.bs_flag=1 and a.commodityid=b.commodityid
         and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
        )
        set floatingloss = 0;
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_Commodity b
         where a.bs_flag=2 and a.commodityid=b.commodityid
         and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
        )
        set floatingloss = 0;

		--�������⽻���ֲ̳���ϸ�ϵĸ���ӯ��
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_A_FirmMargin b
         where a.bs_flag=1 and a.commodityid=b.commodityid and a.firmid=b.firmid
         and (b.marginrate_b=-1 or (b.MarginAlgr=1 and b.MarginRate_B >= 1))
        )
        set floatingloss = 0;
        update
        (
         select /*+ BYPASS_UJVC */floatingloss
         from T_HoldPosition a,T_A_FirmMargin b
         where a.bs_flag=2 and a.commodityid=b.commodityid and a.firmid=b.firmid
         and (b.marginrate_s=-1 or (b.MarginAlgr=1 and b.MarginRate_S >= 1))
        )
        set floatingloss = 0;

      --���½��׿ͻ��ֲֺϼ��еĸ���ӯ��
	  update T_CustomerHoldSum a
      set FloatingLoss=
      (
          select sum(x.FloatingLoss)
          from T_HoldPosition x
          where x.CustomerID = a.CustomerID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.CustomerID,x.CommodityID,x.BS_Flag
      );
      --���½����ֲֺ̳ϼ��еĸ���ӯ��
	  update T_FirmHoldSum a
      set FloatingLoss=
      (
          select sum(x.FloatingLoss)
          from T_CustomerHoldSum x
          where x.FirmID = a.FirmID and x.CommodityID = a.CommodityID and x.BS_Flag = a.BS_Flag
          group by x.FirmID,x.CommodityID,x.BS_Flag
      );

      --���½�������ʱ����
	  if(v_FloatingLossComputeType = 0) then     --����Ʒ������
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                 from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                       T_FirmHoldSum group by firmid) a,
                       t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 1) then  --����Ʒ��������
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                   from (select firmid,sum(case when FloatingLoss>0 then 0 else -FloatingLoss end) FloatingLoss from
                          (select firmid,sum(FloatingLoss) FloatingLoss from T_FirmHoldSum
                           group by firmid,commodityID) group by firmid
                        ) a,t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 2) then  --������Ʒ
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,case when sum(FloatingLoss)>0 then 0 else -sum(FloatingLoss) end FloatingLoss
                              from T_FirmHoldSum group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  elsif(v_FloatingLossComputeType = 3 or v_FloatingLossComputeType = 4) then  --������ӯ������ӯ��
            for fz in (select a.firmid,a.FloatingLoss-b.runtimefl diff
                       from ( select firmid,-sum(FloatingLoss) FloatingLoss
                              from T_FirmHoldSum group by firmid) a,
                         t_firm b where a.firmid=b.firmid)
            loop
                if(fz.diff <> 0) then
                    update T_Firm
                    set RuntimeFL = RuntimeFL + fz.diff
                    where FirmID = fz.firmid;
                    --���¶����ʽ��ͷŻ�۳��仯�ĸ���
      			    v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.firmid,fz.diff,'15');
                end if;
            end loop;
	  end if;

      return 1;

end;
/

