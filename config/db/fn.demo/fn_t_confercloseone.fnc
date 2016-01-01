create or replace function FN_T_ConferCloseOne(
    p_CommodityID    varchar2,   --��Ʒ����
    p_Price          number,     --ƽ�ּ�
    p_BS_Flag        number,     --������־
    p_CustomerID     varchar2,   --���׿ͻ�ID
    p_OppCustomerID  varchar2,   --�Է����׿ͻ�ID
    p_HoldQty        number,     --ƽ�ֲֳ����������ǵֶ�����
    p_GageQty        number default 0,   --ƽ�ֵֶ�������ҵ���ϲ�֧�֣����ҪЭ��ƽ�ֵֶ���Ҫ�����ֶ�ת��ǰ����
    p_M_TradeNo      number,     --��ϳɽ���
    p_M_TradeNo_Opp  number      --�Է���ϳɽ���
) return number
/****
 * ����������Э��ƽ��
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1  ��ƽ�ֲֳ���������
 * -2  ��ƽ�ֵֶ���������
 * -3  ƽ�ֲֳ��������ڿ�ƽ�ֲֳ�����
 * -4  ƽ�ֵֶ��������ڿɵֶ�����
 * -100 ��������
****/
as
    v_version        varchar2(10):='1.0.2.1';
    v_CommodityID    varchar2(16);
    v_CustomerID     varchar2(40);
    v_FirmID         varchar2(32);
    v_OppFirmid      varchar2(32);     --���ֽ����̴���
    v_HoldQty        number;
    v_HoldSumQty     number(10);
    v_frozenQty      number(10);
    v_Margin         number(15,2):=0;
    v_Margin_one     number(15,2):=0;
    v_closeFL        number(15,2):=0;
    v_closeFL_one    number(15,2):=0;    --һ����¼�Ľ���ӯ��
    v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_Fee_one        number(15,2):=0;    --һ����¼�Ľ���������
    v_Assure         number(15,2):=0;
    v_Assure_one     number(15,2):=0;
    v_BS_Flag        number(2);
    v_Price          number(15,2);
    v_ContractFactor  number(12,2);
    v_MarginPriceType number(1);
    v_MarginPrice     number(15,2);  --����ɽ���֤��ļ۸�
    v_HoldFunds       number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��������ֶ���
    v_CustomerHoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ������ֶ���
    v_TradeDate            date;
    v_A_HoldNo       number(15);
    v_A_TradeNo      number(15);
    v_a_tradeno_closed     number(15);
    v_AddedTaxFactor T_Commodity.AddedTaxFactor%type;--��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
    v_GageQty        number(10);
          v_GageFrozenQty number(10);--add by zhaodc 20140804 �ֶ���������
    v_CloseAddedTax_one    number(15,2); --����ӯ����ֵ˰
    v_unCloseQty     number(10):=p_HoldQty; --δƽ�����������м����
    v_unCloseQtyGage       number(10):=p_GageQty; --δƽ�����������м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
    v_tradedAmountGage     number(10):=0;  --�ɽ�����
    v_CloseAlgr      number(2);
    v_Balance        number(15,2);
    v_F_FrozenFunds  number(15,2);
    v_AtClearDate    date;
    v_HoldTime       date;
    v_tmp_bs_flag    number(2);
    type c_HoldPosition is ref cursor;
      v_HoldPosition c_HoldPosition;
    v_sql varchar2(500);
    v_orderby  varchar2(100);
    v_closeTodayHis         number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
    v_YesterBalancePrice    number(15,2);
    v_GageMode       number(2);--�ֶ�ģʽ����0ȫ�ֶ���1��ֶ�����ֶ�ʱҪ���㸡����2009-10-14
    v_num            number(10);
    v_TaxInclusive     number(1);   --��Ʒ�Ƿ�˰ 0��˰  1����˰   xiefei 20150730
begin
      v_CustomerID := p_CustomerID;
      v_CommodityID := p_CommodityID;
      v_BS_Flag := p_BS_Flag;

      --��ȡ���ֽ�����ID
      select firmid into v_OppFirmid from t_customer where customerid = p_OppCustomerID;

      if(v_BS_Flag=1) then  --�ֲֵ�������־
          v_tmp_bs_flag:=2; --�൱��ί��ƽ�ֵ�������־
      else
          v_tmp_bs_flag:=1;
      end if;
      --��ס���׿ͻ��ֲֺϼƣ��Է�ֹ��������
      begin
        select HoldQty,FrozenQty,GageQty,GageFrozenQty
        into v_HoldSumQty, v_frozenQty,v_GageQty,v_GageFrozenQty
        from T_CustomerHoldSum
        where CustomerID = v_CustomerID
          and CommodityID = v_CommodityID
          and bs_flag = v_BS_Flag for update;
      exception
          when NO_DATA_FOUND then
          return -15;--û���ҵ���Ӧ�ĳֲּ�¼
      end;

      /*--��ƽ�ֲֳ���������
      if(p_HoldQty > v_HoldSumQty-v_frozenQty) then
          rollback;
          return -1;
      end if;

      --��ƽ�ֵֶ���������
      if(p_GageQty > v_GageQty) then
          rollback;
          return -2;
      end if;*/

      --��ƽ�ֲֳ���������
      if(p_HoldQty > v_frozenQty) then
          rollback;
          return -1;
      end if;

      --��ƽ�ֵֶ���������
      if(p_GageQty > v_GageFrozenQty) then
          rollback;
          return -2;
      end if;

      --��ȡƽ���㷨,�ֶ�ģʽ
      select CloseAlgr,GageMode into v_CloseAlgr,v_GageMode from T_A_Market;

/*
   select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice   xief 20150730*/

        ----�����Ƿ�˰
   select Contractfactor,MarginPriceType,AddedTaxFactor,LastPrice,TaxInclusive
        into v_ContractFactor,v_MarginPriceType,v_AddedTaxFactor,v_YesterBalancePrice,v_TaxInclusive

        from T_Commodity where CommodityID=v_CommodityID;
      select TradeDate into v_TradeDate from T_SystemStatus;

      --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
      if(v_CloseAlgr = 0) then
          v_orderby := ' order by a.A_HoldNo ';
      elsif(v_CloseAlgr = 1) then
          v_orderby := ' order by a.A_HoldNo desc ';
      end if;

      v_sql := 'select a.a_holdno,FirmID,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,a_tradeno,nvl(b.FrozenQty,0) from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
                 ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and CustomerID=''' || v_CustomerID ||
                 ''' and CommodityID =''' || v_CommodityID || ''' and bs_flag = ' || v_BS_Flag || v_orderby;
      --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������
      open v_HoldPosition for v_sql;
          loop
              fetch v_HoldPosition into v_a_holdno, v_FirmID, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_a_tradeno_closed,v_frozenQty;
                exit when v_HoldPosition%NOTFOUND;
                --����˱ʳֲ�ȫ����ָ��ƽ�ֶ�����û�еֶ���ָ����һ����¼
                if(v_holdqty <> 0 or v_GageQty <> 0) then
                    v_tradedAmount:=0;
                    v_tradedAmountGage:=0;
                    v_Margin_one:=0;
                    v_Assure_one:=0;
                    --�ж���ƽ��ֻ���ƽ��ʷ��
                    if(trunc(v_TradeDate) = trunc(v_AtClearDate)) then
                        v_closeTodayHis := 0;
                    else
                        v_closeTodayHis := 1;
                    end if;

                    --1������Ӧ�˿���
                    if(v_holdqty > 0) then
                        if(v_holdqty<=v_unCloseQty) then
                            v_tradedAmount:=v_holdqty;
                        else
                            v_tradedAmount:=v_unCloseQty;
                        end if;
                        --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
                        if(v_MarginPriceType = 1) then
                            v_MarginPrice := v_YesterBalancePrice;
                        elsif(v_MarginPriceType = 2) then
                            --�ж���ƽ��ֻ���ƽ��ʷ��
                            if(v_closeTodayHis = 0) then  --ƽ���
                                v_MarginPrice := v_price;
                            else  --ƽ��ʷ��
                                v_MarginPrice := v_YesterBalancePrice;
                            end if;
                        else  -- default type is 0
                            v_MarginPrice := v_price;
                        end if;

                        v_Margin_one := FN_T_ComputeMargin(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                        if(v_Margin_one < 0) then
                            Raise_application_error(-20040, 'computeMargin error');
                        end if;
                        --���㵣����
                        v_Assure_one := FN_T_ComputeAssure(v_FirmID,v_CommodityID,v_BS_Flag,v_tradedAmount,v_MarginPrice);
                        if(v_Assure_one < 0) then
                            Raise_application_error(-20041, 'computeAssure error');
                        end if;
                        --��֤��Ӧ���ϵ�����
                        v_Margin_one := v_Margin_one + v_Assure_one;
                        v_Margin:=v_Margin + v_Margin_one;
                        v_Assure:=v_Assure + v_Assure_one;
                        --����Ӧ�˳ֲֽ��������ֶ���
                        v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*v_ContractFactor;
                    end if;

                    --2������ֲ���ϸ��ƽ�ֵĵֶ�����
                    if(v_GageQty > 0) then
                        if(v_GageQty<=v_unCloseQtyGage) then
                            v_tradedAmountGage:=v_GageQty;
                        else
                            v_tradedAmountGage:=v_unCloseQtyGage;
                        end if;
                    end if;
                    --����ǰ�ֶ�ģʽ�����ֲֽ̳��Ҫ�˵ֶ���
                    if(v_GageMode=1) then
                        v_HoldFunds := v_HoldFunds + v_tradedAmountGage*v_price*v_ContractFactor;
                    end if;
                    --�����ͻ��ϼƽ������ֶ���
                    v_CustomerHoldFunds := v_CustomerHoldFunds + (v_tradedAmount+v_tradedAmountGage)*v_price*v_ContractFactor;

                    --3������ƽ�ֿ���
                    --����ƽ��������
                    if(v_closeTodayHis = 0) then  --ƽ���
                        v_Fee_one := FN_T_ComputeTodayCloseFee(v_FirmID,v_CommodityID,v_tmp_bs_flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                    else  --ƽ��ʷ��
                        v_Fee_one := FN_T_ComputeHistoryCloseFee(v_FirmID,v_CommodityID,v_tmp_bs_flag,v_tradedAmount+v_tradedAmountGage,p_Price);
                    end if;
                    if(v_Fee_one < 0) then
                        Raise_application_error(-20030, 'computeFee error');
                    end if;
                    --����˰ǰƽ��ӯ��
                    if(v_BS_Flag = 1) then
                        v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(p_Price-v_price)*v_contractFactor; --˰ǰӯ��
                    else
                        v_closeFL_one := (v_tradedAmount+v_tradedAmountGage)*(v_price-p_Price)*v_contractFactor; --˰ǰӯ��
                    end if;

                   --����ƽ����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)  xief 20158011
                   -- v_CloseAddedTax_one := round(v_closeFL_one*v_AddedTaxFactor,2);
                      v_CloseAddedTax_one := 0;


                   --����˰���ƽ��ӯ�� xief 20150730   xief 20150811
                 /*   if(v_TaxInclusive=1) then
                           --����˰ �۳���ֵ˰
                           v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
                    end if;
                   */
                   /* --����˰��ƽ��ӯ��
                    v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��  xief   20150730*/

                    --���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
                    select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                    insert into T_Trade
                      (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID,         bs_flag,       ordertype, price, quantity,                             close_pl,     tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,OppFirmID)
                    values
                      (v_A_TradeNo,p_M_TradeNo, null, v_a_tradeno_closed, sysdate, v_Firmid, v_CommodityID,v_tmp_bs_flag, 2,    p_Price, v_tradedAmount+v_tradedAmountGage, v_closeFL_one,v_Fee_one,    6,     v_price,v_HoldTime,v_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,v_TradeDate,v_OppFirmid);

                    --���³ֲּ�¼
                    update T_holdposition
                    set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one,GageQty = GageQty - v_tradedAmountGage
                    where a_holdno = v_a_holdno;

                    v_unCloseQty:=v_unCloseQty - v_tradedAmount;
                    v_unCloseQtyGage:=v_unCloseQtyGage - v_tradedAmountGage;

                    v_Fee:=v_Fee + v_Fee_one;
                     v_closeFL:=v_closeFL + v_closeFL_one;

                  exit when v_unCloseQty=0 and v_unCloseQtyGage=0;
                end if;
            end loop;
            close v_HoldPosition;
            if(v_unCloseQty>0) then --ƽ�ֲֳ��������ڿ�ƽ�ֲֳ�����
                rollback;
                return -3;
            end if;
            if(v_unCloseQtyGage>0) then --ƽ�ֵֶ��������ڿɵֶ�����
                rollback;
                return -4;
            end if;

            --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ2009-10-15
            v_num := FN_T_SubHoldSum(p_HoldQty,p_GageQty,v_Margin,v_Assure,v_CommodityID,v_ContractFactor,v_BS_Flag,v_FirmID,v_HoldFunds,v_CustomerID,v_CustomerHoldFunds,v_GageMode,p_HoldQty);

            --������ʱ��֤�����ʱ������
            update T_Firm
               set runtimemargin = runtimemargin - v_Margin,
                   RuntimeAssure = RuntimeAssure - v_Assure
             where Firmid = v_FirmID;
            --���¶����ʽ��ͷŸ��˲��ֵı�֤��
            v_F_FrozenFunds := FN_F_UpdateFrozenFunds(v_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    return 1;

end;
/

