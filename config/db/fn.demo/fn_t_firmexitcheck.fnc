CREATE OR REPLACE FUNCTION FN_T_FirmExitCheck
(
    p_FirmID in varchar2       --交易商ID
) RETURN NUMBER
/****
 * 交易商退市检查
 * 1、注意不要提交commit，因为别的函数要调用它；
 * 返回值
 * 1 成功
 * -1：此交易商存在持仓，不能退市！
****/
as
	v_version varchar2(10):='1.0.0.1';
    v_num   number(10);
begin
    --1、检查交易商是否存在持仓
    select nvl(sum(HoldQty+GageQty),0) into v_num from T_FirmHoldSum where FirmID=p_FirmID;
    if(v_num > 0) then
        return -1;
    end if;

    return 1;
end;
/

