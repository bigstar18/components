CREATE OR REPLACE FUNCTION FN_T_InitTrade
(
    p_ClearDate Date  --结算日期
)
RETURN NUMBER
/****
 * 初始化交易系统
 * 返回值 1 成功;-100 其它错误
****/
as
	v_version varchar2(10):='1.0.2.2';
	v_CommodityID varchar2(16);
	v_Price         number(15,2);
	v_ReserveCount   number(10);
	v_num            number(10);
        v_ret            number(10);
	v_quotationTwoSide  number(10);
    v_errorcode number;
    v_errormsg  varchar2(200);
    --当日行情游标,用来更新商品的昨结算价
    cursor cur_T_Quotation is select CommodityID,Price from T_Quotation;
    --商品交收游标
    cursor cur_T_Commodity is
        select CommodityID
        from T_Commodity
        where SettleDate<trunc(p_ClearDate);
begin
    --1、利用游标更新交收商品，只有交收日期小于当天日期并且持仓表中没有此商品的持仓，则可以从商品表中删除此商品
  	open cur_T_Commodity;
    loop
    	fetch cur_T_Commodity into v_CommodityID;
    	exit when cur_T_Commodity%notfound;
        select count(*) into v_num from T_FirmHoldSum where CommodityID = v_CommodityID and (HoldQty+GageQty)>0;
        if(v_num <= 0) then
		    delete from T_Commodity where CommodityID=v_CommodityID;
		    --2009-11-27 增加删除特殊设置的表
		    delete from T_A_FirmMargin where CommodityID=v_CommodityID;
		    delete from T_A_FirmFee where CommodityID=v_CommodityID;
		    delete from T_A_FirmMaxHoldQty where CommodityID=v_CommodityID;
        else
           update T_Commodity set status=1 where CommodityID=v_CommodityID;
        end if;
 	end loop;
    close cur_T_Commodity;
    --2、删除交易客户持仓明细表的持仓数量和抵顶数量都等于0的记录
    delete from T_HoldPosition where HoldQty=0 and GageQty=0;
    --3、删除交易客户持仓合计表的持仓数量和抵顶数量都等于0的记录
    delete from T_CustomerHoldSum where HoldQty=0 and GageQty=0;
    --4、删除交易商持仓合计表的持仓数量和抵顶数量都等于0的记录
    delete from T_FirmHoldSum where HoldQty=0 and GageQty=0;
    --5、利用游标更新商品昨结算价和订货量，by cxc 2009-08-17订货量改在从持仓量上汇总，这里只更新昨结算价
  	open cur_T_Quotation;
    loop
    	fetch cur_T_Quotation into v_CommodityID,v_Price;
    	exit when cur_T_Quotation%notfound;
    	update T_Commodity set LastPrice=v_Price where CommodityID=v_CommodityID;
 	end loop;
    close cur_T_Quotation;
    --6、更新商品上的订货量，且是双边的， 重新和持仓上的对一次，保证每天都正确，因为协议平仓，提前交收中没有更新行情上的订货量
    --add 2010-09-07 增加行情单双边判断
	select quotationTwoSide into v_quotationTwoSide from T_A_MARKET;
	update T_Commodity a
    set ReserveCount =
    nvl((
          select decode(v_quotationTwoSide,2,sum(HoldQty+GageQty),sum(HoldQty+GageQty)/2)
      	  from T_FirmHoldSum
      	  where CommodityID=a.CommodityID
          group by CommodityID
    ),0);
    --7、清空当日行情表
    delete from T_Quotation;
    --8、根据商品插入初始行情
    insert into T_Quotation(CommodityID,Price,YesterBalancePrice,ReserveCount,CreateTime)
                 select     CommodityID,LastPrice,LastPrice,      ReserveCount,sysdate
                 from T_Commodity where Status<>1;
    --8.5 更新行情的昨收盘价
    update T_Quotation a
    set (ClosePrice) =nvl(
    (
      select nvl(CurPrice,0)
      from T_H_Quotation
      where ClearDate =(select max(ClearDate) from T_H_Quotation) and CommodityID=a.CommodityID
    ),0);

    --9、清空当日延期行情表
    delete from T_DelayQuotation;
    --10、根据商品插入初始延期行情
    insert into T_DelayQuotation(CommodityID,BuySettleQty,SellSettleQty,BuyNeutralQty,SellNeutralQty,CreateTime,NeutralSide)
                 select          CommodityID,       0,           0,            0,             0,       sysdate ,     0
                 from T_Commodity where Status<>1 and SettleWay=1;

    --11、初始化当日最小序号表  2011-2-15 by feijl
    select count(*) into v_num from T_CurMinNo where TradeDate = TO_NUMBER(TO_CHAR(p_ClearDate,'yyMMdd'));
    if(v_num <= 0) then
		update T_CurMinNo set TradeDate = TO_NUMBER(TO_CHAR(p_ClearDate,'yyMMdd')),A_OrderNo=SEQ_T_Orders.nextval,A_TradeNo=SEQ_T_Trade.nextval,A_HoldNo=SEQ_T_HoldPosition.nextval;
    end if;
    --调用财务系统初始化存储 liuchao 20130411
    SP_F_StatusInit();

    --更新持仓的到期日期 add by zhaodc 2013-12-25
    select count(*) into v_ret from  t_commodity c where c.maxholdpositionday is not null;
    if ( v_ret > 0) then
      v_ret := fn_t_addTradeDays();
      for cmd in (select commodityid from t_commodity c where c.maxholdpositionday is not null)
      loop
        v_ret := fn_t_updateholddays(cmd.commodityid);
      end loop;
    end if;
    --将没有设置最大持仓天数（也叫做：到期日期）的订货明细的到期日期和到期天数清空
    update t_holdposition
       set deadline = null,remainday=null
     where commodityid in ( select commodityid from t_commodity where maxholdpositionday is null );

    commit;
    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_InitTrade',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

