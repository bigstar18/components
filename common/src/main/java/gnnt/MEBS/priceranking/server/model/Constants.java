package gnnt.MEBS.priceranking.server.model;

public class Constants
{
  public static final int SYSTEM_STATUS_INIT = 1;
  public static final int SYSTEM_STATUS_SECTION_OPEN = 2;
  public static final int SYSTEM_STATUS_SECTION_PAUSE = 3;
  public static final int SYSTEM_STATUS_REST = 4;
  public static final int SYSTEM_STATUS_CLOSE = 5;
  public static final int SYSTEM_STATUS_UNIT_END = 6;
  public static final int SYSTEM_STATUS_MANUAL_START = 7;
  public static final int SYSTEM_STATUS_SECTION_RECOVERY = 8;
  public static final int SYSTEM_STATUS_MANUAL_WAIT = 9;
  public static final int SYSTEM_STATUS_SECTION_FORCED = 10;
  
  public static String getStatusName(int systemStatus)
  {
    if (systemStatus == 1) {
      return "准备开市";
    }
    if (systemStatus == 2) {
      return "交易中";
    }
    if (systemStatus == 3) {
      return "节间休息";
    }
    if (systemStatus == 4) {
      return "休市";
    }
    if (systemStatus == 5) {
      return "闭市";
    }
    if (systemStatus == 6) {
      return "流程结束状态";
    }
    if (systemStatus == 7) {
      return "手动开市状态";
    }
    if (systemStatus == 8) {
      return "恢复交易";
    }
    if (systemStatus == 9) {
      return "等待手动开始状态";
    }
    if (systemStatus == 10) {
      return "强制开市状态";
    }
    return null;
  }
}
