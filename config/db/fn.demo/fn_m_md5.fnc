CREATE OR REPLACE FUNCTION FN_M_MD5 (p_str IN VARCHAR2)
RETURN VARCHAR2
/****
 * MD5加密算法
 * 返回MD5加密后的字符串
 ****/
IS
  raw_input RAW (128):=UTL_RAW.cast_to_raw (p_str);
  decrypted_raw RAW (2048);
BEGIN
  DBMS_OBFUSCATION_TOOLKIT.md5 (input => raw_input,checksum => decrypted_raw);
  RETURN LOWER (RAWTOHEX (decrypted_raw));
END;
/

