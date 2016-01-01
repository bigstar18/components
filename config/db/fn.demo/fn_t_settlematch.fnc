create or replace function FN_T_SettleMatch
(
    p_commodityId varchar2, --��Ʒ����
    p_quantity number,  --��������
    p_status number, --״̬
    p_result number, --��Լ״̬
    p_firmID_B varchar2,  --�򷽽����̴���
    p_firmID_S varchar2,  --���������̴���
    p_settleDate varchar2, --��������
    p_matchId varchar2 ,--��Ա��
    p_operator varchar2 --������
) return number
/****
 *
 *  ��ѯ�ֲ�ʱ���˽������Ͳ�Ϊ��ǰ���ռ��ɣ���������Ʒ�����걨���������⣬���ճֲֲ������ͬʱ�������ں͵��ڽ��յ�����������������⣬��ʱ�ų��������
 *  ������ʱ��������ֻ����Ʒ���õĽ���������ֲֵĽ��������޹�
 * ����ֵ
 *  1 �ɹ�
 * -1 �򷽳ֲֲ���
 * -2 �����ֲֲ���
****/
as
 v_contractFactor number;  --��Լ����
 v_buypayout_ref number(15,2):=0;--�򷽲ο�����
 v_buyPayout number(15,2):=0;--�����򷽻���
 v_sellincom_ref number(15,2):=0;--�����ο�����
 v_buyMargin number(15,2):=0;--�򷽽��ձ�֤��
 v_sellMargin number(15,2):=0;--�������ձ�֤��
 v_everybuyPayout number(15,2):=0;--��ÿ�ʳֲ����ջ���
 v_everybuyMargin number(15,2):=0;--��ÿ�ʳֲֽ��ձ�֤��
 v_everysellMargin number(15,2):=0;--����ÿ�ʳֲֽ��ձ�֤��
 v_price number;
 v_settleprice_b number:=0;
 v_settleprice_s number:=0;
 v_weight number(15,4);
 v_amountQty_s number(10);
 v_amountQty_b number(10);
 v_quantity number(10);
 v_settlePriceType number(2); --���ڽ��ռ۸���� 0,1,3 ͳһ�� 2������
 v_delaySettlePriceType number(2);--���ڽ����걨���ռ۸����� 0ͳһ�� 1������
 v_settleType number(2);--��Ա�Ľ��շ�ʽ 1���� 3����
 v_settleDate varchar2(20);--�������� �����ڽ���ȡ�ֲ���ϸ�Ľ��մ������ڣ�����Ϊp_settleDate��
 v_settleWay number(2);--��Ʒ���շ�ʽ0��Զ�ڣ����ڣ� 1�����ֻ������ڣ� 2ר������ �����ڣ�
 v_count number;
 v_taxIncluesive number(1);--��Ʒ�۸����Ƿ�˰  1 ����˰ 0 ��˰
 v_addedtax number(10,4):=0;--��Ʒ��ֵ˰��
 v_buytax number(15,2):=0;--����˰
 v_everytax number(15,2):=0;--ÿ��˰��
 v_fundsflow number;--û�õ���ˮ����ֵ
begin
    --����ʷ��Ʒ���ѯ��Ʒ���� �����ʷ�鲻���鵱ǰ��Ʒ����Ϊ���׽���ʱ��Ʒ����ʷ�������ڽ��׽���ǰ������������걨���ʱֻ�ܲ鵱ǰ��Ʒ��
    select count(*) into v_count from t_h_commodity where commodityid=p_commodityId and trunc(cleardate)=to_date(p_settleDate,'yyyy-MM-dd');
    if v_count=0 then
       select settlepricetype,delaySettlePriceType,contractFactor,settleWay,TAXINCLUSIVE,addedtax into v_settlePriceType,v_delaySettlePriceType,v_contractFactor,v_settleWay,v_taxIncluesive,v_addedtax from t_commodity where commodityid=p_commodityId;
    else
       select settlepricetype,delaySettlePriceType,contractFactor,settleWay,TAXINCLUSIVE,addedtax into v_settlePriceType,v_delaySettlePriceType,v_contractFactor,v_settleWay,v_taxIncluesive,v_addedtax from t_h_commodity where commodityid=p_commodityId and trunc(cleardate)=to_date(p_settleDate,'yyyy-MM-dd');
    end if;
--���ڽ��ջ��ǵ��ڽ��գ�settleType =1Ϊ���ڶ����۽������Ϊ���ڽ���
    if v_settleWay=1 then
       v_settleType:=3;
       if v_delaySettlePriceType=1 then
          v_settlePriceType:=2;
       end if;
    else
        v_settleType:=1;
    end if;
    --��ѯ����˫���Ŀ��������
    select  nvl(sum(HoldQty+GageQty-happenMATCHQTY),0)  into v_amountQty_b from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=1 and FirmID=p_firmID_B and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') ;
    select  nvl(sum(HoldQty+GageQty-happenMATCHQTY),0) into v_amountQty_s from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=2 and FirmID=p_firmID_S and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') ;
    if(v_amountQty_b<p_quantity)then
        return -1;--�򷽳ֲֲ���
    end if;
    if(v_amountQty_s<p_quantity)then
        return -2;--�����ֲֲ���
    end if;

   --��
   v_weight:=p_quantity;--�������
   for debit in (select * from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=1 and FirmID=p_firmID_B and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') order by a_holdno asc)
    loop
       v_settleDate:=p_settleDate;
       v_quantity:=debit.HoldQty+debit.GageQty-debit.happenmatchqty;
       if(v_settlePriceType=2)then
          v_price:=debit.price;
       else
          v_price:=debit.settlePrice;
       end if;
      v_settleprice_b:=debit.settlePrice;
      --�������
      if v_quantity > v_weight  then
        --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
         --˰��
         v_everytax:=(v_price*v_weight*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --��׼���� = ���� - ˰��
          v_buypayout_ref:=v_buypayout_ref+(v_price*v_weight*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
           --˰��
           v_everytax:=(v_price*v_weight*v_contractFactor)*v_addedtax;
          --��׼�����
          v_buypayout_ref:=v_buypayout_ref+v_price*v_weight*v_contractFactor;
         end if;
         --ÿ�ʽ��ջ���
          v_everybuyPayout:=debit.Payout/(debit.HoldQty+debit.GageQty)*v_weight;
          --��֤��
          v_everybuyMargin:=debit.SettleMargin/(debit.HoldQty+debit.GageQty)*v_weight;
          v_buyPayout:=v_buyPayout+v_everybuyPayout;
          v_buyMargin:=v_buyMargin+v_everybuyMargin;
          --˰��
          v_buytax:=v_buytax + v_everytax;
          --�޸Ľ��ճֲ���ϸ���״̬=������ԣ����������������Ի������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=1,happenmatchqty = happenmatchqty + v_weight,happenMatchPayout=happenMatchPayout+v_everybuyPayout ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everybuyMargin,SETTLEADDEDTAX=debit.SETTLEADDEDTAX+v_everytax where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_weight, v_price, v_everybuyPayout, v_everybuyMargin);
          v_weight:=0;
      else
        --ȫ����Ե����
         if v_quantity > 0 then
         --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
         --˰��
         v_everytax:=(v_price*v_quantity*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --��׼���� = ���� - ˰��
          v_buypayout_ref:=v_buypayout_ref+(v_price*v_quantity*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
           --˰��
           v_everytax:=(v_price*v_quantity*v_contractFactor)*v_addedtax;
          --��׼�����
          v_buypayout_ref:=v_buypayout_ref+v_price*v_quantity*v_contractFactor;
         end if;
          v_weight:=v_weight - v_quantity;
          --���һ�ʳֲ��ü�����������Ի���ͱ�֤��
          v_everybuyPayout:=debit.Payout-debit.happenMatchPayout;
          v_everybuyMargin:=debit.SettleMargin-debit.happenMatchSettleMargin;
          v_buyPayout:=v_buyPayout+v_everybuyPayout;
          v_buyMargin:=v_buyMargin+v_everybuyMargin;
           --˰��
          v_buytax:=v_buytax + v_everytax;
          --�޸Ľ��ճֲ���ϸ���״̬=ȫ����ԣ����������������Ի������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=2,happenmatchqty = debit.HoldQty+debit.GageQty ,happenMatchPayout=happenMatchPayout+v_everybuyPayout ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everybuyMargin,SETTLEADDEDTAX=debit.SETTLEADDEDTAX+v_everytax  where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_quantity, v_price, v_everybuyPayout, v_everybuyMargin);
        end if;
      end if;
      exit when v_weight=0;
    end loop;

    --����
    v_weight:=p_quantity;--�������
    for debit in (select * from t_settleholdposition t where CommodityID=p_commodityId and BS_Flag=2 and FirmID=p_firmID_S and settletype<>2 and trunc(SettleProcessDate)=to_date(p_settleDate,'yyyy-MM-dd') order by a_holdno asc)
     loop
      v_settleDate:=p_settleDate;
      v_quantity:=debit.HoldQty+debit.GageQty-debit.happenmatchqty;
      if(v_settlePriceType=2)then
          v_price:=debit.price;
      else
          v_price:=debit.settlePrice;
      end if;
      v_settleprice_s:=debit.settlePrice;
      if v_quantity > v_weight  then
         --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
         --˰��
          v_everytax:=(v_price*v_weight*v_contractFactor)*(v_addedtax /(1+v_addedtax));
        --��׼���� = ���� - ˰��
           v_sellincom_ref:=v_sellincom_ref+(v_price*v_weight*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
          --��׼�����
            v_sellincom_ref:=v_sellincom_ref+v_price*v_weight*v_contractFactor;
         end if;
          v_everysellMargin:=debit.SettleMargin/(debit.HoldQty+debit.GageQty)*v_weight;
          v_sellMargin:=v_sellMargin+v_everysellMargin;
          --�޸Ľ��ճֲ���ϸ���״̬=������ԣ����������������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=1,happenmatchqty = happenmatchqty + v_weight,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everysellMargin where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_weight, v_price, 0, v_everysellMargin);
          v_weight:=0;
      else
         if v_quantity > 0 then
            --�����Ʒ�����к�˰
         if(v_taxIncluesive=0) then
          v_everytax:=(v_price*v_quantity*v_contractFactor)*(v_addedtax/(1+v_addedtax));
        --��׼���� = ���� - ˰��
          v_sellincom_ref:=v_sellincom_ref+(v_price*v_quantity*v_contractFactor-v_everytax);
          --�����Ʒ�����в���˰
         else
           --˰��
           --v_everytax:=(v_price*v_quantity*v_contractFactor)*v_addedtax;
          --��׼�����
          v_sellincom_ref:=v_sellincom_ref+v_price*v_quantity*v_contractFactor;
         end if;
          v_everysellMargin:=debit.SettleMargin-debit.happenMatchSettleMargin;
          v_sellMargin:=v_sellMargin+v_everysellMargin;
          v_weight:=v_weight - v_quantity;
          --�޸Ľ��ճֲ���ϸ���״̬=ȫ����ԣ����������������Ա�֤��
          update T_SettleHoldPosition set MATCHStatus=2,happenmatchqty = debit.HoldQty+debit.GageQty ,
                 happenMatchSettleMargin=happenMatchSettleMargin+v_everysellMargin where id=debit.id;
          --���뽻����Թ�����
          insert into T_MatchSettleholdRelevance (MatchID, SettleID, Quantity, Price, SettlePayOut, Settlemargin) values (p_matchId, debit.id, v_quantity, v_price, 0, v_everysellMargin);
        end if;
      end if;
      exit when v_weight=0;
    end loop;
    --���뽻����Ա�
    insert into T_SettleMatch (MatchID,  CommodityID,  ContractFactor,  Quantity,Status,Result,SettleType, FirmID_B,  BuyPrice,  BuyPayout_Ref,  BuyPayout,  BuyMargin,
                               FirmID_S,SellPrice,SellIncome_Ref,SellIncome,SellMargin,CreateTime,ModifyTime,SettleDate, Modifier,buytax,taxIncluesive)
                         values(p_matchId,p_commodityId,v_contractFactor,p_quantity,p_status,p_result,v_settleType,p_firmID_B,v_settleprice_b,v_buypayout_ref,v_buyPayout,v_buyMargin,
                               p_firmID_S,v_settleprice_s,v_sellincom_ref,0,v_sellMargin,sysdate, sysdate,to_date(v_settleDate,'yyyy-MM-dd'),p_operator,v_buytax,v_taxIncluesive);
    --���뽻�������־��
    insert into T_SettleMatchLog(id,Matchid,operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,p_operator,'��ӽ�����ԣ��������'||p_quantity||',�򷽣�'||p_firmID_B||',�۸�'||v_settleprice_b||',����:'||p_firmID_S||'�۸�'||v_settleprice_s,sysdate);
     --��Գɹ������Ƚ�˰�ո��� ,������Ʒ�Ƿ�˰�����շ� ,����˰��,���������Լ��������˰����ȡ
     if(p_result =1) then
       v_fundsflow:=fn_f_updatefundsfull(p_firmID_B,'15100',v_buytax,p_matchId,p_commodityId,null,null);
      insert into T_SettleMatchFundManage(Id,Matchid,Firmid,Summaryno,Amount,Operatedate,Commodityid) values(seq_t_settlematchfundmanage.nextval,p_matchId,p_firmID_B,'15100',v_buytax,sysdate,p_commodityId);
      --д�����־
      insert into t_Settlematchlog(id,Matchid,Operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,'ϵͳ','������ֵ˰,���ID:'||p_matchId||' ���:'||v_buytax,sysdate);
      --������˰����ˮ
       v_fundsflow:=fn_f_updatefundsfull(p_firmID_S,'15101',v_buytax,p_matchId,p_commodityId,null,null);
      insert into T_SettleMatchFundManage(Id,Matchid,Firmid,Summaryno,Amount,Operatedate,Commodityid) values(seq_t_settlematchfundmanage.nextval,p_matchId,p_firmID_S,'15101',v_buytax,sysdate,p_commodityId);
      insert into t_Settlematchlog(id,Matchid,Operator,Operatelog,Updatetime) values(seq_t_settlematchlog.nextval,p_matchId,'ϵͳ','��������ֵ˰,���ID:'||p_matchId||' ���:'||v_buytax,sysdate);
      end if;
return 1;
end;
/

