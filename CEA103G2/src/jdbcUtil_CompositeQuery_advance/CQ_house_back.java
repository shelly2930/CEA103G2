package jdbcUtil_CompositeQuery_advance;

/*
 *  1. �Ω��x�d�ߪ���
 *  2. empno=0 ����٨S����
 *  3. hos_status(0)��ܥ��B�z(1)�ק�L(2)���\(3)����
 *  4. hos_state(0)����٨S�Z�n (1)�Z�n��
 *     
 * */

import java.util.*;

public class CQ_house_back {
//�i�HmetaData
	public static String get_aCondition_For_myDB(String columnName, String value) {

		String aCondition = null;

		if ("emp_no".equals(columnName) || "hos_status".equals(columnName) || "hos_state".equals(columnName)) {
			aCondition = columnName + "=" + value;
		}
		return aCondition + " ";
	}

	public static String get_WhereCondition(Map<String, String[]> map) {
		Set<String> keys = map.keySet();
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		String your_Init_Order_Col = "HOS_APPTIME";
		String orderCol = null;
		String orderType = null;
		String value = null;
		for (String key : keys) {
			value = map.get(key)[0];
			if(value == null || value.trim().length() == 0) continue;
			if (!"action".equals(key)
					&&!"orderType".equals(key)//����Ƨǥi�H��
					&&!"orderCol".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_myDB(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("���e�X�d�߸�ƪ�����count = " + count);
			}else if ("orderCol".equals(key)){
				orderCol = value;
			}else if ("orderType".equals(key)){
				orderType = value;
			}
		}if(orderCol!=null && orderType!=null) {
			whereCondition.append(" order by "+orderCol+" "+orderType);
		}else {
			whereCondition.append(" order by "+your_Init_Order_Col +" DESC");
		}
		return whereCondition.toString();
	}

	
}
