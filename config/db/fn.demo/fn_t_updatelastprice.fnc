CREATE OR REPLACE FUNCTION FN_T_UpdateLastPrice
(
  p_CommodityID varchar2,   --商品代码
  p_Price number     --价格
)  return number
/***
 * 修改开盘指导价
 *
 * 返回值：成功返回1；
 ****/
as
  v_version varchar2(10):='1.0.4.4';
begin
	update T_Commodity set LastPrice=p_Price where CommodityID=p_CommodityID;
	update T_Quotation set Price=p_Price,YesterBalancePrice=p_Price,CreateTime=sysdate where CommodityID=p_CommodityID;
    return 1;
end;
/

