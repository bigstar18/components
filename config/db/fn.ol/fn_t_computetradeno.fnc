create or replace function FN_T_ComputeTradeNo(
    p_TradeSeq number --�ɽ�seq
) return number
/****
 * ����ɽ�����
 * ����ֵ �ɹ����سɽ�����(yyMMdd+��Ź��ɣ���101122000001)
****/
as
	v_version varchar2(10):='1.0.4.3';
    v_TradeDate number(10) ;
    v_A_TradeNo number(15) ;
    v_No number(15) ;
begin
	select TradeDate,A_TradeNo into v_TradeDate,v_A_TradeNo from T_CurMinNo;
	v_No := p_TradeSeq-v_A_TradeNo;
    --return v_TradeDate * power(10,length(v_No)) + v_No;
	if (length(v_No) < 7) then
		return v_TradeDate * power(10,6) + v_No;
	else
		return v_TradeDate * power(10,length(v_No)) + v_No;
	end if;

end;
/

