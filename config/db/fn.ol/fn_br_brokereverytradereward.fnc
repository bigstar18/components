create or replace function FN_BR_BrokerEveryTradeReward(
    p_CommodityID    varchar2 ,--��ƷID
    p_Quantity       number ,--����
    p_FeeMoney       number ,--һ�ʳɽ��յ�������
    p_BarginMoney    number, --�ɽ�����
    p_AtClearDate       date,--����������������
    p_TradeAtClearDate  date,--�ɽ�������������
    p_BS_Flag        number,--������־
    p_OrderType      number,--ί������
    p_TradeType      number,--�ɽ�����
    p_type           number--����ֵ����  0 ����Ӷ��  1  �̶�������
)return number
  /**
  * ����ÿ�ʳɽ�Ӧ����Ա�ļ���Ӷ����Ա�ֳɵĹ̶�������
  * 2012-8-14 by jingwh
  **/
as
  v_brokerReward               number(15,2) default 0;
  v_feealgr                    number(1);
  v_feeRate_b                  number(15, 9);
  v_feeRate_s                  number(15, 9);
  v_todayclosefeerate_b        number(15, 9);
  v_todayclosefeerate_s        number(15, 9);
  v_historyclosefeerate_b      number(15, 9);
  v_historyclosefeerate_s      number(15, 9);
  v_forceclosefeerate_b        number(15, 9);
  v_forceclosefeerate_s        number(15, 9);
  v_rate                       number(15, 9);
  v_marketFee                  number(15,2);
  v_factmarketFee              number(15,2)  default 0;
begin
 --��ȡ��Ʒ��Ϣ���������㷨����
    select t.feealgr,t.FeeRate_b,t.feerate_s,t.todayclosefeerate_b,t.todayclosefeerate_s,t.historyclosefeerate_b,t.historyclosefeerate_s,t.forceclosefeerate_b,t.forceclosefeerate_s
     into    v_feealgr,v_feeRate_b,v_feeRate_s,v_todayclosefeerate_b,v_todayclosefeerate_s,v_historyclosefeerate_b,v_historyclosefeerate_s,v_forceclosefeerate_b,v_forceclosefeerate_s from t_commodity t where t.commodityid=p_CommodityID;
    --�Ƚ϶���ʱ��ͳɽ�ʱ��
    if(p_OrderType=1)then--����
          if(p_BS_Flag=1)then--����
                v_rate:=v_feeRate_b;
          elsif(p_BS_Flag=2)then--������
                v_rate:=v_feeRate_s;
          end if;
    elsif(p_OrderType=2)then--ƽ��
       -- �ж��Ƿ�ǿƽ  2013-12-18 by zhaodc
      if(p_TradeType=3)then
              if(p_BS_Flag=1)then--��ת��
                  v_rate:=v_forceclosefeerate_b;
              elsif(p_BS_Flag=2)then--��ת��
                  v_rate:=v_forceclosefeerate_s;
              end if;
      else
          if(trunc(p_TradeAtClearDate)=trunc(p_AtClearDate))then--�񿪽�ƽ
              if(p_BS_Flag=1)then--��ת��
                  v_rate:=v_todayclosefeerate_b;
              elsif(p_BS_Flag=2)then--��ת��
                  v_rate:=v_todayclosefeerate_s;
              end if;
          elsif(trunc(p_TradeAtClearDate)>trunc(p_AtClearDate))then  --ƽ��ʷ
              if(p_BS_Flag=1)then--��ת��
                  v_rate:=v_historyclosefeerate_b;
              elsif(p_BS_Flag=2)then--��ת��
                  v_rate:=v_historyclosefeerate_s;
              end if;
          end if;
      end if;
    end if;
    --�㷵�г�������
    if(v_feealgr=1)then
       v_marketFee:=v_rate*p_BarginMoney;
    elsif(v_feealgr=2)then
       v_marketFee:=v_rate*p_Quantity;
    end if;
    --�㷵��Ա�ļ���Ӷ�� ����г��������������ѣ��գ�>�г�Ӧ�������ѣ��̶���  ����Ӷ��=��-�̶� ��
    --����г��������������ѣ��գ�<=�г�Ӧ�������ѣ��̶���  ������ȫ�������г� ����Ӷ��=0
    --�����Ա�ֳ��õ��Ĺ̶�������  �����>�̶� ��Ա�ֳ�=�̶�*���� �����<�̶� ��Ա�ֳ�=��*������������10  �̶�100  ���� 30% �ù̶���ֳɵĻ��г��ͻ��Ǯ20  ��
    if(p_FeeMoney>v_marketFee)then
      v_brokerReward:=p_FeeMoney-v_marketFee;
      v_factmarketFee:=v_marketFee;
    elsif(p_FeeMoney<=v_marketFee)then
      v_brokerReward:=0;
      v_factmarketFee:=p_FeeMoney;
    end if;
    if(p_type=0)then
      return v_brokerReward;
    elsif(p_type=1)then
      return v_factmarketFee;
    end if;

end;
/

