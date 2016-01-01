create or replace function FN_T_SettleProcess(
    p_CommodityID varchar2,
    p_SettleType number   --0���Զ����գ�1���ֶ����գ�
) return number
/****
 * ���մ���
 * 1��ע�ⲻҪ�ύcommit����Ϊ���д�����Ҫ��������
 * 2�����׽���֮ǰ����������
 * 3���˺��������˽�������ʱ��������Ϊ�Զ�����ʱ���н�������㣬�ֹ�������ͨ���ⲿ�������㸡���߳�������
 * ����ֵ
 * 1 �ɹ�
 * -1 ����ʱ�������ݲ�ȫ
 * -100 ��������
****/
as
  v_version varchar2(10):='1.0.2.1';
    v_CommodityID varchar2(16):=p_CommodityID;
    v_BreedID number(10);  --FN_T_SettleProcessƷ��id, add by tangzy 2010-06-21
    v_FirmID varchar2(32);
    v_CustomerID        varchar2(40);
    v_HoldQty  number(10);
    v_Payout         number(15,2):=0;
    v_Payout_one         number(15,2):=0;
    v_Margin         number(15,2):=0;
    v_Margin_one         number(15,2):=0;
    v_Margin_b         number(15,2):=0;
    v_Margin_b_one         number(15,2):=0;
    v_Margin_s         number(15,2):=0;
    v_Margin_s_one         number(15,2):=0;
    v_closeFL_one         number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_CloseFL         number(15,2):=0;        --����ӯ���ۼ�
    v_Fee_one         number(15,2):=0;    --һ����¼�Ľ���������
    v_Fee         number(15,2):=0;        --�����������ۼ�
    v_BS_Flag           number(2);
    v_Price         number(15,2);
    v_ContractFactor    number(12,2);
    v_LastFirmID varchar2(32) default null;
    v_TradeDate date;--������ʷ��ʱ�Դ���״̬���е����ڲ��룬�����õ�������ڣ���Ϊ���ڽ�����������
  v_SettlePriceType number(2);
  v_A_HoldNo number(15); --��ǰ�ɽ���
  v_Last_A_HoldNo number(15); --��һ�ʳɽ���
  v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
  v_GageQty     number(10);
  v_SettlePrice         number(15,2);
  v_CloseAddedTax_one   number(15,2); --����ӯ����ֵ˰
  v_CloseAddedTax         number(15,2):=0;        --����ӯ����ֵ˰�ۼ�
  v_num            number(10);
  v_Balance    number(15,2);
  v_F_FrozenFunds   number(15,2);
  v_redoCal           number(2):=0;    --�Ƿ����������㣬0�������������㣻1�����������㣻
  v_sql  varchar2(1000);
  v_str  varchar2(100);
  v_EvenPrice         number(16,6);
    v_LowestSettleFee             number(15,2) default 0;
    v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   xiefei 20150730
    --���ճֲ���ϸ���м��㽻���ʽ��α�
    type c_T_SettleHoldPosition is ref cursor;
  v_T_SettleHoldPosition c_T_SettleHoldPosition;
    --�����α���¶����ʽ��ͷŸ��˲��ֵı�֤��
    cursor cur_T_FirmHoldSum is
        select FirmID,HoldMargin-HoldAssure
        from T_FirmHoldSum
        where CommodityID=p_CommodityID;
    --���ճֲ���ϸ�����˽������ʽ��αֻ꣬�����ֶ����Զ�����
    cursor cur_BackFunds(c_TradeDate date,c_CommodityID varchar2) is
        select FirmID,sum(SettleMargin),sum(Payout),sum(SettleFee),sum(Settle_PL),sum(SettleAddedTax)
      from T_SettleHoldPosition
      where SettleProcessDate=c_TradeDate and CommodityID=c_CommodityID and SettleType in(0,1)
      group by FirmID;
    --���ճֲ���ϸ���и��³ֲ־����αֻ꣬�����ֶ����Զ�����
    cursor cur_EvenPrice(c_TradeDate date,c_CommodityID varchar2) is
        select FirmID,BS_Flag,decode(nvl(sum(HoldQty+GageQty),0),0,0,nvl(sum(Price*(HoldQty+GageQty)),0)/sum(HoldQty+GageQty)) EvenPrice
        from T_SettleHoldPosition
        where SettleProcessDate=c_TradeDate and CommodityID=c_CommodityID and SettleType in(0,1)
        group by FirmID,BS_Flag;

    v_SettleType  number(10):= 1; --�������ڲ����ֶ����Զ����գ����ڽ������������ݿ���Ϊ1,���������͵���1��
    v_billNum            number(10);
begin
    --1����ȡ��������
    select TradeDate into v_TradeDate from T_SystemStatus;
      --�ж��Ƿ���������
      select count(*) into v_num from T_SettleHoldPosition where SettleProcessDate = v_TradeDate and CommodityID=v_CommodityID and SettleType in(0,1);
      if(v_num > 0) then
          v_redoCal := 1;
      end if;

/*
    select AddedTaxFactor,ContractFactor,SettlePriceType,LowestSettleFee
    into   v_AddedTaxFactor,v_ContractFactor,v_SettlePriceType,v_LowestSettleFee    20150730  xief */

    -----�����Ƿ�˰�ֶ� xief  20150730
    select AddedTaxFactor,ContractFactor,SettlePriceType,LowestSettleFee,TaxInclusive
    into   v_AddedTaxFactor,v_ContractFactor,v_SettlePriceType,v_LowestSettleFee,v_TaxInclusive
      from T_Commodity
      where CommodityID=v_CommodityID;
      --2���˴���Ʒ��ȫ��ʵʱ�ı�֤��͵����𣬲���ȥ���㱣֤��͵�����ֱ��ȡ
    update T_Firm a
      set RuntimeMargin = RuntimeMargin-
      nvl((
          select sum(HoldMargin)
          from T_FirmHoldSum
          where CommodityID=v_CommodityID and FirmID=a.FirmID
          group by FirmID
      ),0), RuntimeAssure = RuntimeAssure-
      nvl((
          select sum(HoldAssure)
          from T_FirmHoldSum
          where CommodityID=v_CommodityID and FirmID=a.FirmID
          group by FirmID
      ),0)
      where a.FirmID in (select distinct FirmID from T_FirmHoldSum where CommodityID=v_CommodityID);
      -- 2.5�������α���¶����ʽ��ͷŸ��˲��ֵı�֤��
      open cur_T_FirmHoldSum;
      loop
        fetch cur_T_FirmHoldSum into v_FirmID,v_Margin;
        exit when cur_T_FirmHoldSum%notfound;
          --���¶����ʽ��ͷŸ��˲��ֵı�֤��
      v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-v_Margin,'15');
    end loop;
      close cur_T_FirmHoldSum;

    --���ֶ������뽻�ճֲ���ϸ��
    insert into t_settleholdposition
      (id, settleprocessdate, a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss, settlemargin, payout, settlefee, settle_pl, settleaddedtax, settleprice, settletype, holdtype, atcleardate,MATCHStatus)
      select SEQ_T_SettleHoldPosition.nextval,v_TradeDate,a_holdno, a_tradeno, customerid, commodityid, bs_flag, price, holdqty, openqty, holdtime, holdmargin, firmid, gageqty, holdassure, floatingloss,0,0,0,0,0,0,v_SettleType , holdtype, atcleardate , 0
      from t_holdposition
      where CommodityID=v_CommodityID and (HoldQty+GageQty) > 0;

    --���պ�����Ч�ֵ��ֶ�������������  add by tangzy 2010-06-18
    select BREEDID into v_BreedID from T_Commodity where COMMODITYID=v_CommodityID;
    update t_validgagebill t
      set quantity = quantity +
                     nvl((select gageqty from t_firmholdsum a
                                  where a.commodityid = v_CommodityID
                                    and a.firmid = t.firmid
                                    and a.bs_flag = 2),
                         0)
      where t.commodityId=v_CommodityID;

      --7��ɾ������Ʒ�Ľ��׿ͻ��ֲ���ϸ,���׿ͻ��ֲֺϼƱ������ֲֺ̳ϼƱ�
    delete from T_HoldPosition where CommodityID=v_CommodityID;
      delete from T_CustomerHoldSum where CommodityID=v_CommodityID;
      delete from T_FirmHoldSum where CommodityID=v_CommodityID;

      --�������������Ļ���Ҫ���˽����ʽ�д��ˮ���൱�ں��,�����ֶ����Զ�����
    if(v_redoCal = 1) then
        open cur_BackFunds(v_TradeDate,v_CommodityID);
        loop
          fetch cur_BackFunds into v_FirmID,v_Margin,v_Payout,v_Fee,v_CloseFL,v_CloseAddedTax;
          exit when cur_BackFunds%notfound;
          --�˽��ջ�����������ѣ�������ӯ�����ս��տ��� ����д��ˮ
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15008',-v_Payout,null,v_CommodityID,null,null);
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15010',-v_Fee,null,v_CommodityID,null,null);
          --��ӯ��Ҳ�÷�����
          if(v_CloseFL >= 0) then
            v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15011',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
          else
            v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15012',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
          end if;
            --�˽��ձ�֤�𣬲�д��ˮ
        update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin-v_Margin where FirmID=v_FirmID;
          v_Balance := FN_F_UpdateFundsFull(v_FirmID,'15013',-v_Margin,null,v_CommodityID,null,null);
      end loop;
        close cur_BackFunds;
          --������0
          v_Margin := 0;
          v_Payout := 0;
        v_Fee := 0;
        v_CloseFL := 0;
        v_CloseAddedTax := 0;

        v_str := ' and SettleType in(0,1) ';
    else
        v_str := ' and SettleType =' || v_SettleType;
      end if;

      --4��������ǰ����ּ�������㷨���㽻�ռ�
    if(v_SettlePriceType <> 2) then
        v_SettlePrice := FN_T_ComputeSettlePrice(v_CommodityID,v_SettlePriceType);
      end if;
    v_sql := 'select A_HoldNo,FirmID,BS_Flag,HoldQty,Price,GageQty,CustomerID ' ||
               'from T_SettleHoldPosition ' ||
               'where to_char(SettleProcessDate,''yyyy-MM-dd'')=''' || to_char(v_TradeDate,'yyyy-MM-dd') || ''' and CommodityID=''' || v_CommodityID || '''' ||
               v_str ||
               'order by FirmID ';
      --5�������α���ݽ��ռ����۳����ջ�����������ѣ�����ӯ������д�ʽ���ˮ�������ֶ���
      --6��ͬʱ���ֲ���ϸ��ת�뽻�ճֲ���ϸ����ɾ���ֲ���ϸ������Ӧ��¼
      open v_T_SettleHoldPosition for v_sql;
      loop
          fetch v_T_SettleHoldPosition into v_A_HoldNo,v_FirmID,v_BS_Flag,v_HoldQty,v_Price,v_GageQty,v_CustomerID;
          exit when v_T_SettleHoldPosition%notfound;
            --�ж��Ƿ���ͬһ������
            if(v_LastFirmID is not null and v_LastFirmID <> v_FirmID) then
            --�۳����ջ�����������ѣ�������ӯ�����ս��տ��� ����д��ˮ
          v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15008',v_Payout,null,v_CommodityID,null,null);
          --��������ѵ�����ͽ��������ѣ�����ͽ�����������ȡ�����ҽ��˽��������һ����ϸ�������Ѹ��³ɼ��ϲ���������
          if(v_Fee >= v_LowestSettleFee) then
              v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_Fee,null,v_CommodityID,null,null);
        else
            v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
              update T_SettleHoldPosition
              set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
              where SettleProcessDate=v_TradeDate and A_HoldNo=v_Last_A_HoldNo and SettleType in(0,1); -- 2010-07-30 ����SettleType in(0,1)
          end if;

          if(v_CloseFL >= 0) then
            v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
          else
            v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
          end if;

            --�۳����ձ�֤�𣬲�д��ˮ
        update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_Margin_b+v_Margin_s where FirmID=v_LastFirmID;
          v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15013',v_Margin_b+v_Margin_s,null,v_CommodityID,null,null);

            --��һ��ͬ��������������0
                v_Margin_b := 0;
                v_Margin_s := 0;
                v_Payout := 0;
            v_Fee := 0;
            v_CloseFL := 0;
            v_CloseAddedTax := 0;
            end if;
            --��������ּۼ��㽻�ռ�����ǿ��ּ�
            if(v_SettlePriceType = 2) then
              v_SettlePrice := v_Price;
            end if;
      --���㽻�ձ�֤��
          v_Margin_one := FN_T_ComputeSettleMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_HoldQty+v_GageQty,v_SettlePrice);
            if(v_Margin_one < 0) then
                Raise_application_error(-20042, 'ComputeSettleMargin error');
            end if;
          if(v_BS_Flag = 1) then
            v_Margin_b_one := v_Margin_one;
            --������ҽ��ջ���
            v_Payout_one := FN_T_ComputePayout(v_FirmID,v_CommodityID,v_BS_Flag,v_HoldQty+v_GageQty,v_SettlePrice);
            if(v_Payout_one < 0) then
                  Raise_application_error(-20043, 'computePayout error');
              end if;
          else
            v_Margin_s_one := v_Margin_one;
            end if;
          --���㽻��������
      v_Fee_one := FN_T_ComputeSettleFee(v_FirmID,v_CommodityID,v_bs_flag,v_HoldQty+v_GageQty,v_SettlePrice);
            if(v_Fee_one < 0) then
              Raise_application_error(-20031, 'computeFee error');
            end if;
       --����˰ǰ����ӯ��
            if(v_BS_Flag = 1) then
                v_closeFL_one := (v_HoldQty+v_GageQty)*(v_SettlePrice-v_price)*v_contractFactor; --˰ǰӯ��
            else
                v_closeFL_one := (v_HoldQty+v_GageQty)*(v_price-v_SettlePrice)*v_contractFactor; --˰ǰӯ��
            end if;
            --���㽻����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax) xief 20150811
          --  v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
             v_CloseAddedTax_one := 0;
             --����˰��Ľ���ӯ�� xief 20150730  xief 20150811
           /*   if(v_TaxInclusive=1) then
                     --����˰ �۳���ֵ˰
                     v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
              end if;
              */
               /*
            --����˰����ӯ��
            v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��   xief 20150730*/

          --����ǰ�ֲּ�¼�ͽ��շ��ò��뽻�ճֲ���ϸ��
          update T_SettleHoldPosition
          set SettleMargin=v_Margin_one,Payout=v_Payout_one,SettleFee=v_Fee_one,Settle_PL=v_closeFL_one,SettleAddedTax=v_CloseAddedTax_one,SettlePrice=v_SettlePrice
          where SettleProcessDate=v_TradeDate and A_HoldNo=v_A_HoldNo and SettleType in(0,1); -- 2010-07-30 ����SettleType in(0,1)


      --�ۼƽ��
          v_Margin_b := v_Margin_b + v_Margin_b_one;
          v_Margin_s := v_Margin_s + v_Margin_s_one;
          v_Payout := v_Payout + v_Payout_one;
          v_Fee := v_Fee + v_Fee_one;
          v_CloseFL := v_CloseFL + v_closeFL_one;  --˰��ӯ���ϼ�
      v_CloseAddedTax:=v_CloseAddedTax + v_CloseAddedTax_one;  --������ֵ˰�ϼ�
      --������0
          v_Margin_b_one := 0;
          v_Margin_s_one := 0;
      v_Payout_one := 0;
      --���˽�����ID�����ϸ�������ID�������жϴ˽������Ƿ�������
            v_LastFirmID := v_FirmID;
            v_Last_A_HoldNo := v_A_HoldNo; --���ڸ�����������ѵĲ��
      end loop;
      close v_T_SettleHoldPosition;
      --�۳����һ�������̵Ľ��ջ�����������ѣ�������ӯ�����ս��տ��� ����д��ˮ
    if(v_LastFirmID is not null) then
    v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15008',v_Payout,null,v_CommodityID,null,null);
    --��������ѵ�����ͽ��������ѣ�����ͽ�����������ȡ�����ҽ��˽��������һ����ϸ�������Ѹ��³ɼ��ϲ���������
      if(v_Fee >= v_LowestSettleFee) then
          v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_Fee,null,v_CommodityID,null,null);
    else
        v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15010',v_LowestSettleFee,null,v_CommodityID,null,null);
          update T_SettleHoldPosition
          set SettleFee=SettleFee+(v_LowestSettleFee-v_Fee)
          where SettleProcessDate=v_TradeDate and A_HoldNo=v_Last_A_HoldNo and SettleType in(0,1); -- 2010-07-30 ����SettleType in(0,1)
      end if;
      --��Ʒ������˰�������۳�����ӯ���ͽ��տ���
    /*if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15011',v_CloseFL,null,v_CommodityID,v_CloseAddedTax,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15012',-v_CloseFL,null,v_CommodityID,-v_CloseAddedTax,null);
    end if;*/
    ---xief  20150811
    if(v_CloseFL >= 0) then
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15011',v_CloseFL,null,v_CommodityID,null,null);
    else
      v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15012',-v_CloseFL,null,v_CommodityID,null,null);
    end if;


        --�۳����һ�������̽��ձ�֤�𣬲�д��ˮ
    update T_Firm set RuntimeSettleMargin=RuntimeSettleMargin+v_Margin_b+v_Margin_s where FirmID=v_LastFirmID;
    v_Balance := FN_F_UpdateFundsFull(v_LastFirmID,'15013',v_Margin_b+v_Margin_s,null,v_CommodityID,null,null);
    end if;
        --����ǰ����ּ��������Ʒ�ϵĽ��ս����Ϊ-1��ͬʱ���½��ճֲ���ϸ���еĽ��ռ�Ϊ����Ʒ�������̣������ĳֲ־��ۣ���Ϊ���շ������ʱҪ��
      if(v_SettlePriceType = 2) then
            v_SettlePrice := -1;

          open cur_EvenPrice(v_TradeDate,v_CommodityID);
          loop
            fetch cur_EvenPrice into v_FirmID,v_BS_Flag,v_EvenPrice;
            exit when cur_EvenPrice%notfound;
          --  update T_SettleHoldPosition--ȥ�����½��ճֲ���ϸ�Ľ��ռ۸�
           -- set SettlePrice=v_EvenPrice
          --  where SettleProcessDate=v_TradeDate and CommodityID=v_CommodityID and SettleType in(0,1)
             --     and FirmID=v_FirmID and BS_Flag=v_BS_Flag;
        end loop;
          close cur_EvenPrice;
        end if;
    --���½��ռ۵���Ʒ���еĽ��ս�����У������뽻����Ʒ��
    update T_Commodity set SpecSettlePrice=v_SettlePrice where CommodityID=v_CommodityID;
    -- ɾ��������Ʒʱȥ�����մ����������������������Ʒ��������ʱ����ͬ����Ʒ��������Ʒ�У���Ϊ֮ǰ�����걨�ɽ�ʱ�����  by 2013-11-18 zdaodc
    -- delete from T_SettleCommodity where SettleProcessDate=v_TradeDate and CommodityID=v_CommodityID;
    delete from T_SettleCommodity where  CommodityID=v_CommodityID;
        insert into T_SettleCommodity select v_TradeDate,a.* from T_Commodity a where a.CommodityID=v_CommodityID;

      --�ͷŸ����Ķ����ʽ�����ֻ�ͷ�û�гֲֶ�����ʱ������Ϊ0�ģ��������ͨ��JAVA���ø�������洢���ͷţ��������ɾ���ֲִ���ĺ�����
        for fz in (select FirmID,RuntimeFL from T_Firm where FirmID not in(select distinct FirmID from T_FirmHoldSum) and RuntimeFL <> 0)
        loop
            update T_Firm set RuntimeFL = 0 where FirmID = fz.FirmID;
            --���¶����ʽ��ͷŻ�۳��仯�ĸ���0
        v_F_FrozenFunds := FN_F_UpdateFrozenFunds(fz.FirmID,-fz.RuntimeFL,'15');
        end loop;

      -- �ⶳ�ֵ�
      v_billNum := FN_T_UnfrozenBill(v_CommodityID);

      --ɾ���ֵ�������С��ֵ��ֶ������Ч�ֵ��ֶ����е�����
      delete from t_billfrozen where operation in (select to_char(id) from t_e_gagebill where commodityid = v_CommodityID);
      insert into t_e_hisgagebill
       select v_TradeDate,t.* from t_e_gagebill t where commodityid = v_CommodityID;
      delete from t_e_gagebill where commodityid = v_CommodityID;
      delete from t_validgagebill  where commodityid = v_CommodityID;

    return 1;

end;
/

