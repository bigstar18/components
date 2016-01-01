package gnnt.MEBS.timebargain.mgr.service.systemMana;

public class LogonManager
{
  /* Error */
  public static java.util.Map<String, Object> getRMIConfig(String moduleId, javax.sql.DataSource ds)
  {
    // Byte code:
    //   0: aconst_null
    //   1: astore_2
    //   2: aconst_null
    //   3: astore_3
    //   4: aconst_null
    //   5: astore 4
    //   7: aconst_null
    //   8: astore 5
    //   10: ldc 1
    //   12: invokestatic 18	org/apache/commons/logging/LogFactory:getLog	(Ljava/lang/Class;)Lorg/apache/commons/logging/Log;
    //   15: astore 6
    //   17: ldc 24
    //   19: astore 7
    //   21: aload_1
    //   22: invokeinterface 26 1 0
    //   27: astore 5
    //   29: new 32	java/lang/StringBuilder
    //   32: dup
    //   33: ldc 34
    //   35: invokespecial 36	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   38: aload_0
    //   39: invokevirtual 39	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   42: ldc 43
    //   44: invokevirtual 39	java/lang/StringBuilder:append	(Ljava/lang/String;)Ljava/lang/StringBuilder;
    //   47: invokevirtual 45	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   50: astore 7
    //   52: aload 6
    //   54: aload 7
    //   56: invokeinterface 49 2 0
    //   61: aload 5
    //   63: aload 7
    //   65: invokeinterface 55 2 0
    //   70: astore_3
    //   71: aload_3
    //   72: invokeinterface 61 1 0
    //   77: astore 4
    //   79: aload 4
    //   81: invokeinterface 67 1 0
    //   86: ifeq +108 -> 194
    //   89: new 73	java/util/HashMap
    //   92: dup
    //   93: invokespecial 75	java/util/HashMap:<init>	()V
    //   96: astore_2
    //   97: aload_2
    //   98: ldc 76
    //   100: aload 4
    //   102: iconst_1
    //   103: invokeinterface 78 2 0
    //   108: invokeinterface 82 3 0
    //   113: pop
    //   114: aload 6
    //   116: new 32	java/lang/StringBuilder
    //   119: dup
    //   120: ldc 88
    //   122: invokespecial 36	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   125: aload_2
    //   126: ldc 76
    //   128: invokeinterface 90 2 0
    //   133: invokevirtual 94	java/lang/StringBuilder:append	(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   136: invokevirtual 45	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   139: invokeinterface 49 2 0
    //   144: aload_2
    //   145: ldc 97
    //   147: aload 4
    //   149: iconst_2
    //   150: invokeinterface 99 2 0
    //   155: invokestatic 103	java/lang/Integer:valueOf	(I)Ljava/lang/Integer;
    //   158: invokeinterface 82 3 0
    //   163: pop
    //   164: aload 6
    //   166: new 32	java/lang/StringBuilder
    //   169: dup
    //   170: ldc 109
    //   172: invokespecial 36	java/lang/StringBuilder:<init>	(Ljava/lang/String;)V
    //   175: aload_2
    //   176: ldc 97
    //   178: invokeinterface 90 2 0
    //   183: invokevirtual 94	java/lang/StringBuilder:append	(Ljava/lang/Object;)Ljava/lang/StringBuilder;
    //   186: invokevirtual 45	java/lang/StringBuilder:toString	()Ljava/lang/String;
    //   189: invokeinterface 49 2 0
    //   194: aload 4
    //   196: invokeinterface 111 1 0
    //   201: aconst_null
    //   202: astore 4
    //   204: aload_3
    //   205: invokeinterface 114 1 0
    //   210: aconst_null
    //   211: astore_3
    //   212: goto +86 -> 298
    //   215: astore 7
    //   217: aload 6
    //   219: ldc 115
    //   221: aload 7
    //   223: invokeinterface 117 3 0
    //   228: aload 5
    //   230: ifnull +99 -> 329
    //   233: aload 5
    //   235: invokeinterface 121 1 0
    //   240: goto +89 -> 329
    //   243: astore 9
    //   245: aload 9
    //   247: invokevirtual 122	java/sql/SQLException:printStackTrace	()V
    //   250: aload 6
    //   252: aload 9
    //   254: invokeinterface 127 2 0
    //   259: goto +70 -> 329
    //   262: astore 8
    //   264: aload 5
    //   266: ifnull +29 -> 295
    //   269: aload 5
    //   271: invokeinterface 121 1 0
    //   276: goto +19 -> 295
    //   279: astore 9
    //   281: aload 9
    //   283: invokevirtual 122	java/sql/SQLException:printStackTrace	()V
    //   286: aload 6
    //   288: aload 9
    //   290: invokeinterface 127 2 0
    //   295: aload 8
    //   297: athrow
    //   298: aload 5
    //   300: ifnull +29 -> 329
    //   303: aload 5
    //   305: invokeinterface 121 1 0
    //   310: goto +19 -> 329
    //   313: astore 9
    //   315: aload 9
    //   317: invokevirtual 122	java/sql/SQLException:printStackTrace	()V
    //   320: aload 6
    //   322: aload 9
    //   324: invokeinterface 127 2 0
    //   329: aload_2
    //   330: areturn
    // Line number table:
    //   Java source line #30	-> byte code offset #0
    //   Java source line #31	-> byte code offset #2
    //   Java source line #32	-> byte code offset #4
    //   Java source line #33	-> byte code offset #7
    //   Java source line #34	-> byte code offset #10
    //   Java source line #36	-> byte code offset #17
    //   Java source line #37	-> byte code offset #21
    //   Java source line #38	-> byte code offset #29
    //   Java source line #39	-> byte code offset #52
    //   Java source line #40	-> byte code offset #61
    //   Java source line #42	-> byte code offset #71
    //   Java source line #43	-> byte code offset #79
    //   Java source line #45	-> byte code offset #89
    //   Java source line #46	-> byte code offset #97
    //   Java source line #47	-> byte code offset #114
    //   Java source line #48	-> byte code offset #144
    //   Java source line #49	-> byte code offset #164
    //   Java source line #51	-> byte code offset #194
    //   Java source line #52	-> byte code offset #201
    //   Java source line #53	-> byte code offset #204
    //   Java source line #54	-> byte code offset #210
    //   Java source line #55	-> byte code offset #212
    //   Java source line #56	-> byte code offset #217
    //   Java source line #61	-> byte code offset #228
    //   Java source line #62	-> byte code offset #233
    //   Java source line #63	-> byte code offset #240
    //   Java source line #64	-> byte code offset #245
    //   Java source line #65	-> byte code offset #250
    //   Java source line #59	-> byte code offset #262
    //   Java source line #61	-> byte code offset #264
    //   Java source line #62	-> byte code offset #269
    //   Java source line #63	-> byte code offset #276
    //   Java source line #64	-> byte code offset #281
    //   Java source line #65	-> byte code offset #286
    //   Java source line #67	-> byte code offset #295
    //   Java source line #61	-> byte code offset #298
    //   Java source line #62	-> byte code offset #303
    //   Java source line #63	-> byte code offset #310
    //   Java source line #64	-> byte code offset #315
    //   Java source line #65	-> byte code offset #320
    //   Java source line #68	-> byte code offset #329
    // Local variable table:
    //   start	length	slot	name	signature
    //   0	331	0	moduleId	String
    //   0	331	1	ds	javax.sql.DataSource
    //   1	329	2	map	java.util.Map<String, Object>
    //   3	209	3	state	java.sql.PreparedStatement
    //   5	198	4	rs	java.sql.ResultSet
    //   8	296	5	conn	java.sql.Connection
    //   15	306	6	logger	org.apache.commons.logging.Log
    //   19	45	7	sql	String
    //   215	7	7	e	Exception
    //   262	34	8	localObject	Object
    //   243	10	9	ex	java.sql.SQLException
    //   279	10	9	ex	java.sql.SQLException
    //   313	10	9	ex	java.sql.SQLException
    // Exception table:
    //   from	to	target	type
    //   17	212	215	java/lang/Exception
    //   228	240	243	java/sql/SQLException
    //   17	228	262	finally
    //   264	276	279	java/sql/SQLException
    //   298	310	313	java/sql/SQLException
  }
}
