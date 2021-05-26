package jdbcUtil_CompositeQuery_advance;

/*
 *  1. 用於後台查詢物件
 *  2. empno=0 表示還沒指派
 *  3. hos_status(0)表示未處理(1)修改過(2)成功(3)失敗
 *  4. hos_state(0)表示還沒刊登 (1)刊登中
 *     
 * */

import java.util.*;

public class CQ_house_back {
//可以metaData
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
					&&!"orderType".equals(key)//之後排序可以用
					&&!"orderCol".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_myDB(key, value.trim());

				if (count == 1)
					whereCondition.append(" where " + aCondition);
				else
					whereCondition.append(" and " + aCondition);

				System.out.println("有送出查詢資料的欄位數count = " + count);
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
