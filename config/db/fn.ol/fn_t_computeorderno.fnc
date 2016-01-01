create or replace function FN_T_ComputeOrderNo(
    p_OrderSeq number --委托seq
) return number
/****
 * 计算委托单号
 * 返回值 成功返回委托单号(yyMMdd+序号构成，如101122000001)
****/
as
	v_version varchar2(10):='1.0.4.3';
    v_TradeDate number(10) ;
    v_A_OrderNo number(15) ;
    v_No number(15) ;
begin
	select TradeDate,A_OrderNo into v_TradeDate,v_A_OrderNo from T_CurMinNo;
	v_No := p_OrderSeq-v_A_OrderNo;
    --return v_TradeDate * power(10,length(v_No)) + v_No;
	if (length(v_No) < 7) then
		return v_TradeDate * power(10,6) + v_No;
	else
		return v_TradeDate * power(10,length(v_No)) + v_No;
	end if;

end;
/

