create or replace function FN_T_CloseTrade(
    p_A_OrderNo     number,  --ί�е���
    p_M_TradeNo     number,  --��ϳɽ���
    p_Price         number,  --�ɽ���
    p_Quantity      number,   --�ɽ�����
    p_M_TradeNo_Opp     number,  --�Է���ϳɽ���
    p_CommodityID varchar2,
    p_FirmID     varchar2,
    p_TraderID       varchar2,
    p_bs_flag        number,
    p_status         number,
    p_orderQty       number,--ί������
    p_orderTradeQty       number,--ί���ѳɽ�����
    p_CustomerID        varchar2,
    p_OrderType      number,
    p_closeMode      number,
    p_specPrice      number,
    p_timeFlag       number,
    p_CloseFlag      number,
    p_contractFactor number,
    p_MarginPriceType         number,     --����ɽ���֤���������� 0:ʵʱ�ͱ���ʱ�������ּۣ�1:ʵʱ�������ۣ����а����ս����;2:���а������ۣ����н���ʱ�����ս����;
    p_marginAlgr         number,
    p_marginRate_b         number,
    p_marginRate_s         number,
    p_marginAssure_b         number,
    p_marginAssure_s         number,
    p_feeAlgr       number,
    p_feeRate_b         number,
    p_feeRate_s         number,
    p_TodayCloseFeeRate_B         number,
    p_TodayCloseFeeRate_S         number,
    p_HistoryCloseFeeRate_B         number,
    p_HistoryCloseFeeRate_S         number,
    p_ForceCloseFeeAlgr       number,
    p_ForceCloseFeeRate_B         number,
    p_ForceCloseFeeRate_S         number,
    p_YesterBalancePrice    number,
    p_AddedTaxFactor          number,  --��ֵ˰��ϵ��=AddedTax/(1+AddedTax)
    p_GageMode    number,
    p_CloseAlgr    number,
    p_TradeDate date,
    p_FirmID_opp     varchar2   --���ֽ�����ID
) return number
/****
 * ƽ�ֳɽ��ر�
 * 1��ע�ⲻҪ�ύcommit����Ϊ��ĺ���Ҫ��������
 * ����ֵ
 * 1 �ɹ�
 * -1 �ɽ���������δ�ɽ�����
 * -2 �ɽ��������ڶ�������
 * -3 ƽ�ֳɽ��������ڳֲ�����
 * -100 ��������
****/
as
    v_version varchar2(10):='1.0.2.2';
    v_price          number(15,2);
    v_frozenQty      number(10);
    v_holdQty        number(10);
    v_a_tradeno_closed number(15);
    v_Margin         number(15,2):=0;   --Ӧ�ձ�֤��
    v_Assure         number(15,2):=0;   --Ӧ�յ�����
    v_Fee            number(15,2):=0;   --Ӧ�շ���
    v_Fee_one            number(15,2);   --Ӧ�շ���
    v_A_TradeNo      number(15);
    v_A_HoldNo       number(15);
    v_id             number(15);
    v_tmp_bs_flag    number(2);
    v_TradeType      number(1);
    v_AtClearDate          date;
    v_HoldTime          date;
    v_MarginPrice    number(15,2);  --����ɽ���֤��ļ۸�
    v_HoldFunds    number(15,2):=0;  --ƽ��ʱӦ�˳ֲֽ��
    v_unCloseQty     number(10):=p_quantity; --δƽ�����������м����
    v_closeFL    number(15,2):=0;
    v_closeFL_one    number(15,2);   --����ƽ��ӯ���������м����
    v_CloseAddedTax_one    number(15,2);   --����ƽ����ֵ˰
    v_margin_one     number(15,2);   --�����м����
    v_Assure_one     number(15,2);   --�����м����
    v_tradedAmount   number(10):=0;  --�ɽ�����
    v_GageQty       number(10);
    v_GageQty_fsum       number(10);
    v_F_FrozenFunds   number(15,2);
    type c_T_HoldPosition is ref cursor;
    v_T_HoldPosition c_T_HoldPosition;
    v_sql varchar2(500);
    v_str  varchar2(200);
    v_orderby  varchar2(100);
    v_closeTodayHis        number(2);    --ƽ��ֻ�����ʷ��(0ƽ��֣�1ƽ��ʷ��)
    v_num            number(10);
    v_holddaysLimit number(1):=0;
begin
      if(p_TraderID is not null) then
          v_TradeType := 1;  --�н���ԱΪ�������ף�����ƽ�֣�
      else
        if(p_CloseFlag = 2) then
          v_TradeType := 3;  --����ԱΪ����ƽ�ֱ�־Ϊ2��ʾ�г�ǿƽ
        else
          v_TradeType := 4;  --�����н���Ա�ı�ʾί�н��ף�����ƽ�֣�
        end if;
      end if;

        if(p_bs_flag=1) then  --ί��ƽ�ֵ�������־
            v_tmp_bs_flag:=2; --�൱�ڱ�ƽ�ֵ�������־
        else
            v_tmp_bs_flag:=1;
        end if;
        select frozenqty
        into v_frozenQty
        from T_CustomerHoldSum
        where CustomerID = p_CustomerID
          and CommodityID = p_CommodityID
          and bs_flag = v_tmp_bs_flag for update;
        if(v_frozenqty <p_quantity) then
            rollback;
            return -2;
        end if;

		--ָ��ƽ�ֲ�ѯ����
        if(p_closeMode = 2) then  --ָ��ʱ��ƽ��
            if(p_timeFlag = 1) then  --ƽ���
		            --�ӳֲ���ϸ���øý��׿ͻ����ո���Ʒ�ֲֺϼ�
		            v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')=''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
	        elsif(p_timeFlag = 2) then  --ƽ��ʷ��
	                --�ӳֲ���ϸ���øý��׿ͻ��ǵ��ո���Ʒ�ֲֺϼ�
	                v_str := ' and to_char(AtClearDate,''yyyy-MM-dd'')<>''' || to_char(p_TradeDate,'yyyy-MM-dd') || ''' ';
	        end if;
        elsif(p_closeMode = 3) then  --ָ���۸�ƽ��
            v_str := ' and Price =' || p_specPrice || ' ';
        end if;
        --����ƽ���㷨(0�ȿ���ƽ��1����ƽ��2�ֲ־���ƽ��(������)ѡ����������
		--2009-08-04����ǿƽʱ������ƽ˳��
		if(p_TraderID is null and p_CloseFlag = 2) then
			--v_orderby := ' order by a.A_HoldNo desc ';
             select holddayslimit into v_holddaysLimit from t_commodity where commodityid=p_CommodityID;
             if(v_holddaysLimit=0) then   --�޳ֲ���������
               v_orderby := ' order by a.A_HoldNo desc ';
             else
               v_orderby := ' order by a.A_HoldNo asc ';
             end if;
        else
	        if(p_CloseAlgr = 0) then
		        v_orderby := ' order by a.A_HoldNo ';
		    elsif(p_CloseAlgr = 1) then
		        v_orderby := ' order by a.A_HoldNo desc ';
		    end if;
	    end if;
	    v_str := v_str || v_orderby;

          if(p_Quantity = p_orderQty - p_orderTradeQty) then
            --����ί��
            update T_Orders
            set tradeqty=tradeqty + p_Quantity,
                Status=3,UpdateTime=systimestamp(3)
            where A_orderNo = p_A_OrderNo;
          elsif(p_Quantity < p_orderQty - p_orderTradeQty) then
            --����ί��
			if(p_status = 6) then  --״̬Ϊ���ֳɽ��󳷵���������ֳɽ��ر��ڳ����ر�֮�󣬲����ٸ���״̬��
	            update T_Orders
	            set tradeqty=tradeqty + p_Quantity,UpdateTime=systimestamp(3)
	            where A_orderNo = p_A_OrderNo;
			else
	            update T_Orders
	            set tradeqty=tradeqty + p_Quantity,Status=2,UpdateTime=systimestamp(3)
	            where A_orderNo = p_A_OrderNo;
			end if;
          else
            rollback;
            return -1;
          end if;

            --��ָ��ƽ��ƽ�ֲּ�¼ʱ�Գֲ���ϸ��Ϊ������ָ��ƽ��ʱ�Ե���ָ��ƽ�ֶ����Ϊ��
            if(p_closeMode = 1) then --��ָ��ƽ��
	            --�����ֲ���ϸ�����������˵�ָ��ƽ�ֶ��������,��ƽ��û�õ�b.ID����Ϊb��û������������0�滻
	            v_sql := 'select a.a_holdno,a_tradeno,price,(a.HoldQty-nvl(b.FrozenQty,0)),GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),0 from T_holdposition a,(select A_HoldNo,nvl(sum(FrozenQty),0) FrozenQty from T_SpecFrozenHold group by A_HoldNo) b ' ||
	                     ' where (a.HoldQty+a.GageQty) > 0 and a.A_HoldNo=b.A_HoldNo(+) and nvl(b.FrozenQty,0)<a.HoldQty and CustomerID=''' || p_CustomerID ||
	                     ''' and CommodityID =''' || p_CommodityID || ''' and bs_flag = ' || v_tmp_bs_flag || v_str;
			else  --ָ��ƽ��
	            v_sql := 'select a.a_holdno,a_tradeno,price,HoldQty,GageQty,HoldTime,AtClearDate,nvl(b.FrozenQty,0),b.ID from T_holdposition a,T_SpecFrozenHold b ' ||
	                     ' where (a.HoldQty+a.GageQty) > 0 and b.A_HoldNo=a.A_HoldNo(+) and b.A_OrderNo= ' || p_A_OrderNo || v_str;
			end if;
            open v_T_HoldPosition for v_sql;
            loop
                fetch v_T_HoldPosition into v_a_holdno, v_a_tradeno_closed, v_price, v_holdqty,v_GageQty,v_HoldTime,v_AtClearDate,v_frozenQty,v_id;
                exit when v_T_HoldPosition%NOTFOUND;
                if(p_closeMode = 1) then --��ָ��ƽ��
	                if(v_holdqty<=v_unCloseQty) then
	                    v_tradedAmount:=v_holdqty;
	                else
	                    v_tradedAmount:=v_unCloseQty;
	                end if;
                else  --ָ��ƽ��
	                if(v_frozenQty<=v_unCloseQty) then
	                    v_tradedAmount:=v_frozenQty;
	                    delete from T_SpecFrozenHold where id=v_id;
	                else
	                    v_tradedAmount:=v_unCloseQty;
	                    update T_SpecFrozenHold set FrozenQty=FrozenQty-v_tradedAmount where id=v_id;
	                end if;
				end if;
				--�ж���ƽ��ֻ���ƽ��ʷ��
			    if(trunc(p_TradeDate) = trunc(v_AtClearDate)) then
			        v_closeTodayHis := 0;
			    else
			    	v_closeTodayHis := 1;
			    end if;
		        --����ɽ���Ӧ�۳���������
				if(v_TradeType = 3) then  --ǿƽ
					v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_ForceCloseFeeAlgr,p_ForceCloseFeeRate_B,p_ForceCloseFeeRate_S);
				else  --���������ƽ���ǽ��쿪�Ĳ��򰴽񿪽�ƽ�����Ѽ���
					if(v_closeTodayHis = 0) then  --ƽ���
						v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_TodayCloseFeeRate_B,p_TodayCloseFeeRate_S);
					else  --ƽ��ʷ��
				        v_Fee_one := FN_T_ComputeFeeByArgs(p_bs_flag,v_tradedAmount,p_Price,p_contractFactor,p_feeAlgr,p_HistoryCloseFeeRate_B,p_HistoryCloseFeeRate_S);
				    end if;
			    end if;
                if(v_Fee_one < 0) then
                  Raise_application_error(-20030, 'computeFee error');
                end if;
                --����Ӧ�˱�֤�𣬸�������ѡ�񿪲ּۻ�������������
				if(p_MarginPriceType = 1) then
			        v_MarginPrice := p_YesterBalancePrice;
			    elsif(p_MarginPriceType = 2) then
					if(v_closeTodayHis = 0) then  --ƽ���
						v_MarginPrice := v_price;
					else  --ƽ��ʷ��
				        v_MarginPrice := p_YesterBalancePrice;
				    end if;
				else  -- default type is 0
					v_MarginPrice := v_price;
				end if;
                v_Margin_one := FN_T_ComputeMarginByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginRate_b,p_marginRate_s);
                if(v_Margin_one < 0) then
                    Raise_application_error(-20040, 'computeMargin error');
                end if;
		        --���㵣����
		        v_Assure_one := FN_T_ComputeAssureByArgs(v_tmp_bs_flag,v_tradedAmount,v_MarginPrice,p_contractFactor,p_marginAlgr,p_marginAssure_b,p_marginAssure_s);
		        if(v_Assure_one < 0) then
		            Raise_application_error(-20040, 'computeAssure error');
		        end if;
		        --��֤��Ӧ���ϵ�����
		        v_Margin_one := v_Margin_one + v_Assure_one;

	            --����Ӧ�˳ֲֽ��
	            v_HoldFunds := v_HoldFunds + v_tradedAmount*v_price*p_contractFactor;
                --����ƽ��ӯ��
                if(v_tmp_bs_flag=1) then  --v_tmp_bs_flag�ǳֲֵ�������־
                    v_closeFL_one := v_tradedAmount*(p_price-v_price)*p_contractFactor; --˰ǰӯ��
                else
                    v_closeFL_one := v_tradedAmount*(v_price-p_price)*p_contractFactor; --˰ǰӯ��
                end if;
	            --����ƽ����ֵ˰,v_AddedTaxFactor��ֵ˰ϵ��=AddedTax/(1+AddedTax)
	            v_CloseAddedTax_one := round(v_closeFL_one*p_AddedTaxFactor,2);
                v_closeFL_one := v_closeFL_one - v_CloseAddedTax_one; --˰��ӯ��
				--���ü��㺯���޸ĳɽ����� 2011-2-15 by feijl
                select FN_T_ComputeTradeNo(SEQ_T_Trade.nextval) into v_A_TradeNo from dual;
                 insert into T_Trade
                  (a_tradeno, m_tradeno, a_orderno, a_tradeno_closed,tradetime, Firmid, CommodityID, bs_flag, ordertype, price, quantity, close_pl, tradefee,TradeType,HoldPrice,HoldTime,CustomerID,CloseAddedTax,M_TradeNo_Opp,AtClearDate,TradeAtClearDate,oppFirmid)
                values
                  (v_A_TradeNo, p_M_TradeNo, p_A_OrderNo, v_a_tradeno_closed, sysdate, p_Firmid, p_CommodityID,p_bs_flag, p_ordertype, p_price, v_tradedAmount, v_closeFL_one, v_Fee_one,v_TradeType,v_price,v_HoldTime,p_CustomerID,v_CloseAddedTax_one,p_M_TradeNo_Opp,v_AtClearDate,p_TradeDate,p_FirmID_opp);

                --���³ֲּ�¼
                update T_holdposition
                set holdqty = holdqty - v_tradedAmount,HoldMargin=HoldMargin-v_Margin_one,HoldAssure=HoldAssure-v_Assure_one
                where a_holdno = v_a_holdno;
                v_unCloseQty:=v_unCloseQty - v_tradedAmount;

                v_Margin:=v_Margin + v_Margin_one;
                v_Assure:=v_Assure + v_Assure_one;
                v_Fee:=v_Fee + v_Fee_one;
                v_closeFL:=v_closeFL + v_closeFL_one;

                exit when v_unCloseQty=0;
            end loop;
            close v_T_HoldPosition;
            if(v_unCloseQty>0) then --�ɽ��������ڳֲ�����������
                rollback;
                return -3;
            end if;

        --���ٽ��׿ͻ��������̵ĳֲֺϼ���Ϣ2009-10-15
        v_num := FN_T_SubHoldSum(p_quantity,0,v_Margin,v_Assure,p_CommodityID,p_contractFactor,v_tmp_bs_flag,p_FirmID,v_HoldFunds,p_CustomerID,v_HoldFunds,p_GageMode,p_quantity);

        --������ʱ��֤�����ʱ������
        update T_Firm
        set runtimemargin = runtimemargin - v_Margin,
		    RuntimeAssure = RuntimeAssure - v_Assure
        where Firmid = p_FirmID;
        --���¶����ʽ��ͷŸ��˲��ֵı�֤��
		v_F_FrozenFunds := FN_F_UpdateFrozenFunds(p_FirmID,-(v_Margin-v_Assure)+v_Fee-v_closeFL,'15');
    return 1;

end;
/

