CREATE OR REPLACE FUNCTION FN_T_UpdateQuotation
(
    p_CommodityID varchar2,   --商品代码
    p_YesterBalancePrice number, --昨结算价
    p_ClosePrice number,               --昨收盘价
    p_OpenPrice number,               --今开市价
    p_HighPrice number,               --最高价
    p_LowPrice number,               --最低价
    p_CurPrice number,               --最新价
    p_CurAmount number,               --现量(最新价所对应的成交量)
    p_OpenAmount number,               --开仓
	p_BuyOpenAmount number,               --买开仓
	p_SellOpenAmount number,               --卖开仓
    p_CloseAmount number,               --平仓
    p_BuyCloseAmount number,               --买平仓
    p_SellCloseAmount number,               --卖平仓
    p_ReserveCount number,               --订货量
    p_ReserveChange number,               --仓差
    p_Price number,                --结算价
    p_TotalMoney number,                --总成交额
    p_TotalAmount number,                --总成交量
    p_Spread number,                --涨跌
    p_BuyPrice1 number,                --买入价1
    p_SellPrice1 number,                --卖出价1
    p_BuyAmount1 number,                --申买量1
    p_SellAmount1 number,                --申卖量1
    p_BuyPrice2 number,                --买入价2
    p_SellPrice2 number ,               --卖出价2
    p_BuyAmount2 number ,               --申买量2
    p_SellAmount2 number,                --申卖量2
    p_BuyPrice3 number,                --买入价3
    p_SellPrice3 number,                --卖出价3
    p_BuyAmount3 number,                --申买量3
    p_SellAmount3 number ,               --申卖量3
    p_BuyPrice4 number ,               --买入价4
    p_SellPrice4 number,                --卖出价4
    p_BuyAmount4 number,                --申买量4
    p_SellAmount4 number,                --申卖量4
    p_BuyPrice5 number,                --买入价5
    p_SellPrice5 number,                --卖出价5
    p_BuyAmount5 number,                --申买量5
    p_SellAmount5 number,                --申卖量5
    p_OutAmount number,                --外盘
    p_InAmount number,                --内盘
    p_TradeCue number,                --交易提示
    p_NO number,                --计数字段
    p_CreateTime timestamp      --2009-09-21 增加更新时间，为null则取systimestamp(3)，将集合竞价行情时间更新成开市时间
) RETURN NUMBER
/****
 * 更新行情
 * 返回值
 * 1 成功
 * -100 失败
****/
as
	v_version varchar2(10):='1.0.0.9';
    v_num   number(10);
    v_errorcode number;
    v_errormsg  varchar2(200);
begin
    select count(*) into v_num from T_Quotation where CommodityID = p_CommodityID;
    if(v_num >0) then
        update T_Quotation set YesterBalancePrice=p_YesterBalancePrice,ClosePrice=p_ClosePrice,OpenPrice=p_OpenPrice,HighPrice=p_HighPrice,
        LowPrice=p_LowPrice,CurPrice=p_CurPrice,CurAmount=p_CurAmount,OpenAmount=p_OpenAmount,BuyOpenAmount=p_BuyOpenAmount,SellOpenAmount=p_SellOpenAmount,CloseAmount=p_CloseAmount,BuyCloseAmount=p_BuyCloseAmount,SellCloseAmount=p_SellCloseAmount,
        ReserveCount=p_ReserveCount,ReserveChange=p_ReserveChange,Price=p_Price,TotalMoney=p_TotalMoney,TotalAmount=p_TotalAmount,Spread=p_Spread,BuyPrice1=p_BuyPrice1,SellPrice1=p_SellPrice1
        ,BuyAmount1=p_BuyAmount1,SellAmount1=p_SellAmount1,BuyPrice2=p_BuyPrice2,SellPrice2=p_SellPrice2,BuyAmount2=p_BuyAmount2,SellAmount2=p_SellAmount2,BuyPrice3=p_BuyPrice3,SellPrice3=p_SellPrice3,BuyAmount3=p_BuyAmount3,SellAmount3=p_SellAmount3
        ,BuyPrice4=p_BuyPrice4,SellPrice4=p_SellPrice4,BuyAmount4=p_BuyAmount4,SellAmount4=p_SellAmount4,BuyPrice5=p_BuyPrice5,SellPrice5=p_SellPrice5,BuyAmount5=p_BuyAmount5,SellAmount5=p_SellAmount5,OutAmount=p_OutAmount,InAmount=p_InAmount
        ,TradeCue=p_TradeCue,NO=p_NO,CreateTime=decode(p_CreateTime,null,systimestamp(3),p_CreateTime)
        where CommodityID = p_CommodityID;
    else
        insert into T_Quotation(CommodityID,YesterBalancePrice,ClosePrice,OpenPrice,HighPrice,
        LowPrice,CurPrice,CurAmount,OpenAmount,BuyOpenAmount,SellOpenAmount,CloseAmount,BuyCloseAmount,SellCloseAmount,ReserveCount,ReserveChange,Price,TotalMoney,TotalAmount,Spread,
        BuyPrice1,SellPrice1,BuyAmount1,SellAmount1,BuyPrice2,SellPrice2,BuyAmount2,SellAmount2,BuyPrice3,SellPrice3,
        BuyAmount3,SellAmount3,BuyPrice4,SellPrice4,BuyAmount4,SellAmount4,BuyPrice5,SellPrice5,BuyAmount5,SellAmount5,
        OutAmount,InAmount,TradeCue,NO,CreateTime)
        values(p_CommodityID,p_YesterBalancePrice,p_ClosePrice,p_OpenPrice,p_HighPrice,p_LowPrice,p_CurPrice,p_CurAmount,p_OpenAmount,p_BuyOpenAmount,p_SellOpenAmount,p_CloseAmount,p_BuyCloseAmount,p_SellCloseAmount,p_ReserveCount,p_ReserveChange,p_Price,p_TotalMoney,p_TotalAmount,p_Spread,p_BuyPrice1,
        p_SellPrice1,p_BuyAmount1,p_SellAmount1,p_BuyPrice2,p_SellPrice2,p_BuyAmount2,p_SellAmount2,p_BuyPrice3,p_SellPrice3,p_BuyAmount3,
        p_SellAmount3,p_BuyPrice4,p_SellPrice4,p_BuyAmount4,p_SellAmount4,p_BuyPrice5,p_SellPrice5,p_BuyAmount5,p_SellAmount5,
        p_OutAmount,p_InAmount,p_TradeCue,p_NO,decode(p_CreateTime,null,systimestamp(3),p_CreateTime));
    end if;
    commit;
    return 1;
exception
    when OTHERS then
    v_errorcode:=sqlcode;
    v_errormsg :=sqlerrm;
    rollback;
    insert into T_DBLog(err_date,name_proc,err_code,err_msg)
    values(sysdate,'FN_T_UpdateQuotation',v_errorcode,v_errormsg);
    commit;
    return -100;
end;
/

