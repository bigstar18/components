create or replace function FN_T_FirmDel
(
    p_FirmID m_firm.firmid%type --交易商代码
)return integer is
  /**
  * 订单系统删除交易商
  * 返回值： 1 成功
  注意不要提交commit，因为别的函数要调用它；
  **/
  v_cnt                number(5); --数字变量
begin
  /*---mengyu 2013.08.29  注销交易不能删除更改数据保留即可*/
  /*  --2、删除交易商特殊保证金表此交易商记录，历史记录更新交易商ID加上_
  update T_H_FirmMargin set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_A_FirmMargin where FirmID=p_FirmID;
    --3、删除交易商特殊手续费表此交易商记录，历史记录更新交易商ID加上_
    update T_H_FirmFee set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_A_FirmFee where FirmID=p_FirmID;
    --4、删除特殊持仓量表此交易商记录
    delete from T_A_FirmMaxHoldQty where FirmID=p_FirmID;
    --5、删除委托表此交易商记录，历史记录更新交易商ID加上_
    update T_H_Orders set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Orders where FirmID=p_FirmID;
    --6、删除成交表此交易商记录，历史记录更新交易商ID加上_
    update T_H_Trade set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Trade where FirmID=p_FirmID;
    --7、删除持仓明细表中此交易商记录，历史记录更新交易商ID加上_
    update T_H_HoldPosition set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_HoldPosition where FirmID=p_FirmID;
    --8、删除交易客户持仓合计表此交易商记录，历史记录更新交易商ID加上_
    update T_H_CustomerHoldSum set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_CustomerHoldSum where FirmID=p_FirmID;
    --9、删除交易商持仓合计表此交易商记录，历史记录更新交易商ID加上_
    update T_H_FirmHoldSum set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_FirmHoldSum where FirmID=p_FirmID;
    --11、更新交收交易客户持仓合计表此交易商记录，交易商ID加上_
    update T_SettleHoldPosition set FirmID=FirmID || '_' where FirmID=p_FirmID;
    --14、删除交易员表此交易商记录
    delete from T_Trader where TraderID in(select TraderID from M_Trader where FirmID=p_FirmID);
    --15、删除交易客户表此交易商记录
    delete from T_Customer where FirmID=p_FirmID;
    --16、删除交易商表此交易商，历史记录更新交易商ID加上_
    update T_H_Firm set FirmID=FirmID || '_' where FirmID=p_FirmID;
    delete from T_Firm where FirmID=p_FirmID;
    */
    return 1;

end;
/

