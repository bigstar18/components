package gnnt.MEBS.common.broker.service;

import gnnt.MEBS.common.broker.model.Broker;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service("com_brokerService")
@Transactional(propagation=Propagation.REQUIRED, readOnly=false, rollbackFor={Exception.class})
public class BrokerService
  extends StandardService
{
  public Broker getBrokerByID(String BrokerId)
  {
    return getBrokerByID(BrokerId, true);
  }
  
  public Broker getBrokerByID(String brokerId, boolean loadRight)
  {
    this.logger.debug("enter getBrokerByID");
    Broker entity = new Broker();
    entity.setBrokerId(brokerId);
    Broker broker = (Broker)super.get(entity);
    if (broker != null) {
      if (loadRight) {
        broker.getRightSet().size();
      }
    }
    return broker;
  }
}
