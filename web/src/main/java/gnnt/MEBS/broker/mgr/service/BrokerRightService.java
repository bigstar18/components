package gnnt.MEBS.broker.mgr.service;

import java.util.HashSet;
import java.util.Iterator;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import gnnt.MEBS.broker.mgr.dao.BrokerDAO;
import gnnt.MEBS.broker.mgr.model.brokerManagement.Broker;
import gnnt.MEBS.broker.mgr.model.brokerManagement.BrokerMenu;
import gnnt.MEBS.common.mgr.dao.StandardDao;
import gnnt.MEBS.common.mgr.service.StandardService;
import gnnt.MEBS.common.mgr.statictools.Tools;

@Service("com_brokerRightService")
@Transactional(propagation = Propagation.REQUIRED, readOnly = false, rollbackFor = { Exception.class })
public class BrokerRightService extends StandardService {
	@Autowired
	@Qualifier("brokerDAO")
	private BrokerDAO brokerDAO;

	public StandardDao getDao() {
		return this.brokerDAO;
	}

	public Broker getBrokerById(String paramString, boolean paramBoolean) {
		Broker localBroker = this.brokerDAO.getBrokerById(paramString);
		if (paramBoolean) {
			localBroker.getRightSet().size();
		}
		return localBroker;
	}

	public void saveBrokerRight(Broker broker, String as[], String as1[]) {
		if (as1 != null && as1.length > 0) {
			String s = "";
			String as2[] = as1;
			int i = as2.length;
			for (int k = 0; k < i; k++) {
				String s1 = as2[k];
				if (s.trim().length() > 0)
					s = (new StringBuilder()).append(s).append(",").toString();
				s = (new StringBuilder()).append(s).append(s1).toString();
			}

			HashSet hashset = new HashSet();
			Iterator iterator = broker.getRightSet().iterator();
			do {
				if (!iterator.hasNext())
					break;
				BrokerMenu brokermenu = (BrokerMenu) iterator.next();
				boolean flag = true;
				int l = 0;
				do {
					if (l >= as1.length)
						break;
					if ((long) brokermenu.getModuleId().intValue() == Tools.strToLong(as1[l])) {
						flag = false;
						break;
					}
					l++;
				} while (true);
				if (flag)
					hashset.add(brokermenu);
			} while (true);
			if (as != null && as.length > 0) {
				for (int j = 0; j < as.length; j++) {
					BrokerMenu brokermenu1 = new BrokerMenu();
					brokermenu1.setId(Long.valueOf(Long.parseLong(as[j])));
					brokermenu1 = (BrokerMenu) get(brokermenu1);
					if (brokermenu1 != null)
						hashset.add(brokermenu1);
				}

			}
			broker.setRightSet(hashset);
			update(broker);
		}
	}
}
