package gnnt.MEBS.common.broker.service;

import gnnt.MEBS.common.broker.model.Broker;
import gnnt.MEBS.common.broker.model.BrokerAge;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_brokerAgeService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class BrokerAgeService
  extends StandardService
{
  public BrokerAge getBrokerAgeByID(String BrokerAgeId)
  {
    return getBrokerAgeByID(BrokerAgeId, true);
  }
  
  public BrokerAge getBrokerAgeByID(String brokerAgeId, boolean loadRight)
  {
    this.logger.debug("enter getBrokerByID");
    BrokerAge entity = new BrokerAge();
    entity.setBrokerAgeId(brokerAgeId);
    BrokerAge brokerAge = (BrokerAge)super.get(entity);
    if (brokerAge != null) {
      if (loadRight) {
        brokerAge.getBroker().getRightSet().size();
      }
    }
    return brokerAge;
  }
}
