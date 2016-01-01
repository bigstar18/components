package gnnt.MEBS.espot.mgr.action.preordermanage;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.mgr.action.EcsideAction;
import gnnt.MEBS.common.mgr.common.Page;
import gnnt.MEBS.common.mgr.common.PageRequest;
import gnnt.MEBS.common.mgr.common.QueryConditions;
import gnnt.MEBS.common.mgr.statictools.Tools;
import gnnt.MEBS.espot.mgr.model.commoditymanage.PropertyType;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsResource;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsResourcePic;
import gnnt.MEBS.espot.mgr.model.preordermanage.GoodsResourceProperty;

@Controller("goodsResourceAction")
@Scope("request")
public class GoodsResourceAction extends EcsideAction {
	private static final long serialVersionUID = 8940802390578628251L;
	@Resource(name = "deliveryDayTypeMap")
	protected Map<String, String> deliveryDayTypeMap;
	@Resource(name = "deliveryTypeMap")
	protected Map<String, String> deliveryTypeMap;

	public Map<String, String> getDeliveryDayTypeMap() {
		return this.deliveryDayTypeMap;
	}

	public Map<String, String> getDeliveryTypeMap() {
		return this.deliveryTypeMap;
	}

	public String updateForwardGoodsResource() {
		this.entity = ((GoodsResource) getService().get(this.entity));
		GoodsResource localGoodsResource = (GoodsResource) this.entity;
		putResourcePropertys(localGoodsResource.getGoodsResourceProperties());
		PageRequest localPageRequest = new PageRequest(" and primary.resourceId=" + localGoodsResource.getResourceId());
		Page localPage = getQueryService().getPage(localPageRequest, new GoodsResourcePic());
		this.request.setAttribute("imageList", localPage.getResult());
		return "success";
	}

	public String showImages() throws IOException {
		this.logger.debug("enter showImages");
		HttpServletResponse localHttpServletResponse = ServletActionContext.getResponse();
		ServletOutputStream localServletOutputStream = null;
		byte[] arrayOfByte = null;
		GoodsResourcePic localGoodsResourcePic = new GoodsResourcePic();
		localGoodsResourcePic.setId(Long.valueOf(Tools.strToLong(this.request.getParameter("id"), -1000L)));
		localGoodsResourcePic = (GoodsResourcePic) getService().get(localGoodsResourcePic);
		arrayOfByte = localGoodsResourcePic.getPicture();
		if (arrayOfByte != null) {
			try {
				localHttpServletResponse.setContentType("text/html");
				localServletOutputStream = localHttpServletResponse.getOutputStream();
				localServletOutputStream.write(arrayOfByte);
				localServletOutputStream.flush();
				localServletOutputStream.close();
				localServletOutputStream = null;
			} catch (Exception localException) {
				localException.printStackTrace();
			} finally {
				if (localServletOutputStream != null) {
					localServletOutputStream.close();
					localServletOutputStream = null;
				}
			}
		}
		return null;
	}

	private void putResourcePropertys(Set<GoodsResourceProperty> paramSet) {
		if ((paramSet != null) && (paramSet.size() > 0)) {
			LinkedHashMap localLinkedHashMap = new LinkedHashMap();
			QueryConditions localQueryConditions = new QueryConditions();
			localQueryConditions.addCondition("status", "=", Integer.valueOf(0));
			PageRequest localPageRequest = new PageRequest(1, 100, localQueryConditions, " order by sortNo ");
			Page localPage = getService().getPage(localPageRequest, new PropertyType());
			if ((localPage != null) && (localPage.getResult() != null)) {
				for (int i = 0; i < localPage.getResult().size(); i++) {
					PropertyType localObject1 = (PropertyType) localPage.getResult().get(i);
					localLinkedHashMap.put(localObject1, new ArrayList());
				}
			}
			ArrayList localArrayList = new ArrayList();
			Object localObject1 = paramSet.iterator();
			Object localObject3;
			while (((Iterator) localObject1).hasNext()) {
				GoodsResourceProperty localObject2 = (GoodsResourceProperty) ((Iterator) localObject1).next();
				localObject3 = null;
				Iterator localIterator = localLinkedHashMap.keySet().iterator();
				while (localIterator.hasNext()) {
					PropertyType localPropertyType = (PropertyType) localIterator.next();
					if ((((GoodsResourceProperty) localObject2).getPropertyTypeID() != null)
							&& (((GoodsResourceProperty) localObject2).getPropertyTypeID().equals(localPropertyType.getPropertyTypeID()))) {
						localObject3 = (List) localLinkedHashMap.get(localPropertyType);
					}
				}
				if (localObject3 == null) {
					localObject3 = localArrayList;
				}
				((List) localObject3).add(localObject2);
			}
			localObject1 = new LinkedHashMap();
			Object localObject2 = localLinkedHashMap.keySet().iterator();
			while (((Iterator) localObject2).hasNext()) {
				localObject3 = (PropertyType) ((Iterator) localObject2).next();
				if (((List) localLinkedHashMap.get(localObject3)).size() > 0) {
					((Map) localObject1).put(localObject3, localLinkedHashMap.get(localObject3));
				}
			}
			if (localArrayList.size() > 0) {
				localObject2 = new PropertyType();
				((PropertyType) localObject2).setName("其它属性");
				((PropertyType) localObject2).setPropertyTypeID(Long.valueOf(-1L));
				((Map) localObject1).put(localObject2, localArrayList);
			}
			this.request.setAttribute("tpmap", localObject1);
		}
	}
}
