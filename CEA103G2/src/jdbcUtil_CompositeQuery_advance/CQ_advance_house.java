package jdbcUtil_CompositeQuery_advance;

import java.util.Map;

public class CQ_advance_house {
//	硂よ猭癳key-value秈ㄓ
//	1.key璶ゑ癸逆皐癸ぃ璶ノぃ家絢琩高
//	2.value 家絢琩高癸禜value
//	р┮Τ家絢琩高ノaCondition奥癬ㄓ窾ノ琩高
	public static String get_aCondition_For_myDB(String columnName, String value) {		
		String aCondition = null;
		if ("hos_type".equals(columnName)) {
			if(value.equals("0")) {
				aCondition = "hos_type >= 0";
			}else {
				aCondition = columnName + "=" + value;
			}
		}
		// ノvarchar		
		else if ("hos_city".equals(columnName) || "hos_dist".equals(columnName)) 
			aCondition = columnName + " like '%" + value + "%'";
		else if ("keyword".equals(columnName)) {
			aCondition = "HOS_NAME  like '%" + value + "%' or ";
			aCondition +="HOS_CITY  like '%" + value + "%' or ";
			aCondition +="HOS_DIST  like '%" + value + "%' or ";
			aCondition +="HOS_ADDRESS  like '%" + value + "%' or ";
			aCondition +="HOS_INFO  like '%" + value + "%'";
		}
			
		// ノdate
		else if ("hiredate".equals(columnName)) //⊿ノ痙帝把σ                         
			aCondition = columnName + "=" + "'"+ value +"'";                          //for ㄤウDB   date
		else if ("price".equals(columnName)) {
			switch(value) {
			case "0" : aCondition="hos_rent >= 0"; break;
			case "1" : aCondition="hos_rent <= 5000"; break;
			case "2" : aCondition="hos_rent > 5000 and hos_rent <= 10000"; break;
			case "3" : aCondition="hos_rent > 10000 and hos_rent <= 20000"; break;
			case "4" : aCondition="hos_rent > 20000 and hos_rent <= 30000"; break;
			case "5" : aCondition="hos_rent > 30000 and hos_rent <= 40000"; break;
			case "6" : aCondition="hos_rent > 40000"; break;
			}
		}
		else if ("area".equals(columnName)) {
			switch(value) {
			case "0" : aCondition="hos_squares >= 0"; break;
			case "1" : aCondition="hos_squares <= 10"; break;
			case "2" : aCondition="hos_squares > 10 and hos_squares <= 20"; break;
			case "3" : aCondition="hos_squares > 20 and hos_squares <= 30"; break;
			case "4" : aCondition="hos_squares > 30 and hos_squares <= 40"; break;
			case "5" : aCondition="hos_squares > 40 and hos_squares <= 50"; break;
			case "6" : aCondition="hos_squares > 50"; break;
			}
		}
//****Oracleセ	aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";  //for Oracle  date	
		return aCondition + " ";
	}
//иà祅初~どセ狡琩高  
//皐癸ぐ或逆order 璶ノぐ或よ猭逼(ascdesc)
/*	猔種
 * 玡Parameterkey-valueㄤいkeyゲ斗璶ΤorderCol㎝orderType
 * 						   癸莱value戈畐逆㎝asc┪desc
 */
	public static String get_WhereCondition(Map<String, String[]> map) {
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		String your_Init_Order_Col = "hos_no";
		String orderCol = null;
		String orderType = null;
//		m{(s1,s1[1]),(s2,s2[1]),(s3,s3[1]),...} 
		//keys1s2...
//		眖map s1[]s2[]s3[]琌硂ㄇ常Τ1
//		狡策:硂柑ぐ或Τ1絋璶倒s[]Τcheckbox硂ㄇselect
		String value = null;
		for (String key : map.keySet()) {
			value = map.get(key)[0];
			if(value == null || value.trim().length() == 0)  continue;//常⊿把计秈碞琌琩高场ぃノSQL
			if (!"action".equals(key) 
					&&!"orderType".equals(key)
					&&!"orderCol".equals(key)
					&&!"hos_rent".equals(key)
					&&!"hos_squares".equals(key)) {
				count++;
				String aCondition = get_aCondition_For_myDB(key, value.trim());
				if (count == 1)
					whereCondition.append(" where hos_state=1 and " + aCondition);
				else
					whereCondition.append(" and " + aCondition);
			}else if ("orderCol".equals(key)){
				orderCol = value;
			}else if ("orderType".equals(key)){
				orderType = value;
			}	
		}
		if(count==0) whereCondition.append(" where hos_state=1 ");
		if(orderCol!=null && orderType!=null) {
			whereCondition.append(" order by "+orderCol+" "+orderType);
		}else {
			whereCondition.append(" order by "+your_Init_Order_Col);
		}
		return whereCondition.toString();
	}
	
}
