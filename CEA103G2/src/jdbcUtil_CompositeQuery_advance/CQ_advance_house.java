package jdbcUtil_CompositeQuery_advance;

import java.util.Map;

public class CQ_advance_house {
//	�o�Ӥ�k�ekey-value�i�ӡA
//	1.key�n�h������A�w�藍�P���O�A�n�Τ��P���ҽk�d�ߡC
//	2.value �ҽk�d�߹�Hvalue
//	�A��Ҧ��ҽk�d�ߥ�aCondition�°_�ӸU�άd��
	public static String get_aCondition_For_myDB(String columnName, String value) {		
		String aCondition = null;
		if ("hos_type".equals(columnName)) {
			if(value.equals("0")) {
				aCondition = "hos_type >= 0";
			}else {
				aCondition = columnName + "=" + value;
			}
		}
		// �Ω�varchar		
		else if ("hos_city".equals(columnName) || "hos_dist".equals(columnName)) 
			aCondition = columnName + " like '%" + value + "%'";
		else if ("keyword".equals(columnName)) {
			aCondition = "HOS_NAME  like '%" + value + "%' or ";
			aCondition +="HOS_CITY  like '%" + value + "%' or ";
			aCondition +="HOS_DIST  like '%" + value + "%' or ";
			aCondition +="HOS_ADDRESS  like '%" + value + "%' or ";
			aCondition +="HOS_INFO  like '%" + value + "%'";
		}
			
		// �Ω�date
		else if ("hiredate".equals(columnName)) //�S�Ψ�A�d�۰Ѧ�                         
			aCondition = columnName + "=" + "'"+ value +"'";                          //for �䥦DB  �� date
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
//****Oracle����	aCondition = "to_char(" + columnName + ",'yyyy-mm-dd')='" + value + "'";  //for Oracle �� date	
		return aCondition + " ";
	}
//�ڭ̪��D���n��~�ɯŪ������ƦX�d��  
//�i�H�w�擄�����order �n�Τ����k�Ƨ�(asc�Bdesc)
/*	�`�N
 * �e��Parameter��key-value�A�䤤��key�����n��orderCol�MorderType�A
 * 						   ������value����Ʈw���Masc�Ϊ�desc
 */
	public static String get_WhereCondition(Map<String, String[]> map) {
		StringBuffer whereCondition = new StringBuffer();
		int count = 0;
		String your_Init_Order_Col = "hos_no";
		String orderCol = null;
		String orderType = null;
//		m{(s1,s1[1]),(s2,s2[1]),(s3,s3[1]),...} 
		//�����Xkey�As1�Bs2�B...
//		�A�qmap ���Xs1[]�Bs2[]�Bs3[]�u�O�o�ǳ����ץu��1
//		�Ʋ�:�o�̬�������ץu��1�T�n��s[]�A�]����checkbox�o�ǡBselect
		String value = null;
		for (String key : map.keySet()) {
			value = map.get(key)[0];
			if(value == null || value.trim().length() == 0)  continue;//���S�Ѽƶi�A�N�O�d�ߥ����A���Φh�[SQL���O
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
