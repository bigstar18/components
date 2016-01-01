package gnnt.MEBS.espot.front.action.display;

import java.net.URLDecoder;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import gnnt.MEBS.common.front.action.JDBCStandardAction;
import gnnt.MEBS.common.front.statictools.Tools;
import gnnt.MEBS.espot.front.common.XTradeFrontGlobal;
import gnnt.MEBS.espot.front.model.commodity.Breed;
import gnnt.MEBS.espot.front.model.commodity.BreedProps;
import gnnt.MEBS.espot.front.model.commodity.Category;
import gnnt.MEBS.espot.front.model.commodity.Property;

@Controller("commodityPropertyAction")
@Scope("request")
public class CommodityPropertyAction extends JDBCStandardAction {
	private static final long serialVersionUID = -2209189455788678665L;

	public String getBreedListAndPropertys() throws Exception {
		List list = XTradeFrontGlobal.getCategoryPage().getResult();
		logger.debug((new StringBuilder()).append("来了来了").append(request.getParameter("bsFlag")).toString());
		boolean flag = request.getParameter("tbln") != null && !"".equals(request.getParameter("tbln"));
		if (list == null || list.size() < 1) {
			logger.debug((new StringBuilder()).append("isTrade? 'trade':SUCCESS=====").append(flag ? "trade" : "success").toString());
			return flag ? "trade" : "success";
		}
		if (request.getParameter("propertySearch") != null) {
			String s = request.getParameter("propertySearch");
			request.setAttribute("shopSearch", s);
		}
		Object obj = new TreeSet();
		Object obj1 = new HashMap();
		long l = -1000L;
		long l1 = -1000L;
		if (request.getParameter("cat") != null)
			l = Tools.strToLong(request.getParameter("cat"), -1000L);
		if (request.getParameter("brd") != null)
			l1 = Tools.strToLong(request.getParameter("brd"), -1000L);
		HashMap hashmap = new HashMap();
		String as[] = request.getParameterValues("pvl");
		if (as != null && as.length > 0) {
			String as1[] = as;
			int i = as1.length;
			for (int j = 0; j < i; j++) {
				String s2 = as1[j];
				s2 = s2.replaceAll("%", "%25");
				s2 = Tools.getEncoding(s2, "UTF-8");
				s2 = URLDecoder.decode(s2, "UTF-8");
				logger.debug(s2);
				if (s2.indexOf(":") > 0) {
					String s3 = s2.substring(0, s2.indexOf(":"));
					String s4 = s2.substring(s2.indexOf(":") + 1, s2.length());
					hashmap.put(s3, s4);
				}
			}

		}
		request.setAttribute("commodityProperty", hashmap);
		Category category = null;
		Object obj2 = list.iterator();
		do {
			if (!((Iterator) (obj2)).hasNext())
				break;
			Category category1 = (Category) ((Iterator) (obj2)).next();
			if (category1.getCategoryID().longValue() == l)
				category = category1;
		} while (true);
		obj2 = (String) request.getAttribute("accessShop");
		if (category != null) {
			if (obj2 != null)
				request.setAttribute("breedSet", category.getContainBreed());
			obj = getBreedSet(category, l1);
			obj1 = getPropMapByBreedSet(((Set) (obj)), category);
			request.setAttribute("category", category);
		}
		if (l1 > 0L && obj != null && ((Set) (obj)).size() > 0)
			request.setAttribute("breed", ((Set) (obj)).iterator().next());
		if (obj2 == null)
			request.setAttribute("breedSet", obj);
		request.setAttribute("propMap", obj1);
		String s1 = request.getParameter("showModel");
		if (s1 == null)
			s1 = "0";
		logger.debug((new StringBuilder()).append("showModel=====").append(s1).toString());
		request.setAttribute("showModel", s1);
		return flag ? "trade" : "success";
	}

	private Map getPropMapByBreedSet(Set set, Category category) {
		if (set == null)
			return new HashMap();
		TreeSet treeset = new TreeSet(new Comparator() {
			public int compare(BreedProps breedprops1, BreedProps breedprops2) {
				byte byte0 = 0;
				if (breedprops1.getSortNo() != null && breedprops2.getSortNo() != null) {
					if (breedprops1.getSortNo().longValue() > breedprops2.getSortNo().longValue())
						byte0 = 1;
					else
						byte0 = -1;
				} else if (breedprops1.getBelongtoProperty().getSortNo().longValue() > breedprops2.getBelongtoProperty().getSortNo().longValue())
					byte0 = 1;
				else
					byte0 = -1;
				return byte0;
			}

			public int compare(Object obj1, Object obj2) {
				return compare((BreedProps) obj1, (BreedProps) obj2);
			}
		});
		Breed breed;
		for (Iterator iterator = set.iterator(); iterator.hasNext(); treeset.addAll(breed.getContainBreedProps()))
			breed = (Breed) iterator.next();

		TreeSet treeset1 = new TreeSet(new Comparator() {

			public int compare(Property property2, Property property3) {
				return property2.getSortNo().longValue() <= property3.getSortNo().longValue() ? -1 : 1;
			}

			public int compare(Object obj1, Object obj2) {
				return compare((Property) obj1, (Property) obj2);
			}
		});
		Object obj = category.getContainProperty().iterator();
		do {
			if (!((Iterator) (obj)).hasNext())
				break;
			Property property = (Property) ((Iterator) (obj)).next();
			if (property.getSearchable().equals("Y"))
				treeset1.add(property);
		} while (true);
		obj = new LinkedHashMap();
		Property property1;
		for (Iterator iterator1 = treeset1.iterator(); iterator1.hasNext(); ((Map) (obj)).put(property1.getPropertyName(), new LinkedHashSet()))
			property1 = (Property) iterator1.next();

		Iterator iterator2 = treeset.iterator();
		do {
			if (!iterator2.hasNext())
				break;
			BreedProps breedprops = (BreedProps) iterator2.next();
			if (!breedprops.getBelongtoProperty().getHasValueDict().equals("N") && !breedprops.getBelongtoProperty().getSearchable().equals("N")) {
				String s = breedprops.getBelongtoProperty().getPropertyName();
				if (((Map) (obj)).containsKey(s)) {
					Set set1 = (Set) ((Map) (obj)).get(s);
					set1.add(breedprops.getPropertyValue());
				}
			}
		} while (true);
		return ((Map) (obj));
	}

	private Set<Breed> getBreedSet(Category paramCategory, long paramLong) {
		if (paramLong < 0L) {
			return paramCategory.getContainBreed();
		}
		Set localSet = paramCategory.getContainBreed();
		Iterator localIterator = localSet.iterator();
		while (localIterator.hasNext()) {
			Breed localBreed = (Breed) localIterator.next();
			if (localBreed.getBreedID().longValue() == paramLong) {
				TreeSet localTreeSet = new TreeSet();
				localTreeSet.add(localBreed);
				return localTreeSet;
			}
		}
		return new TreeSet();
	}
}
