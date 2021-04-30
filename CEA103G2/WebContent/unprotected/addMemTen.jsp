<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memTen.model.*"%>

<%
  MemTenVO memTenVO = (MemTenVO) request.getAttribute("memTenVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>會員資料新增 - addMemTen.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  img {
  	width: 200px;
  	height: auto;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>會員資料新增 - addMemTen.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath()%>/select_page.jsp"><img src="<%=request.getContextPath()%>/images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>請填寫會員資料:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" enctype="multipart/form-data" ACTION="<%=request.getContextPath()%>/memTen/memTen.do" name="form1">
<table>
	<tr>
		<td>帳號:</td>
		<td><input type="TEXT" name="mem_username" size="45" 
			 value="<%= (memTenVO==null)? "peter1" : memTenVO.getMem_username()%>" /></td>
	</tr>
	<tr>
		<td>密碼:</td>
		<td><input type="TEXT" name="mem_password" size="45"
			 value="<%= (memTenVO==null)? "peter0101" : memTenVO.getMem_password()%>" /></td>
	</tr>
	<tr>
		<td>照片:</td>
		<td><div id="preview"></div><input type="file" name="mem_pic" id="mem_pic" size="45" /></td>
	</tr>
	<tr>
		<td>姓名:</td>
		<td><input type="TEXT" name="mem_name" size="45"
			 value="<%= (memTenVO==null)? "吳永志" : memTenVO.getMem_name()%>" /></td>
	</tr>
	<tr>
		<td>性別:</td>
		<td>
			<select name="mem_gender" size="1"> 
				<option value="0"<%= ((memTenVO == null) ? "" : (memTenVO.getMem_gender() == 0 ? "selected" : ""))%>>男</option>
				<option value="1"<%= ((memTenVO == null) ? "" : (memTenVO.getMem_gender() == 1 ? "selected" : ""))%>>女</option>		
			</select>
		</td>
	</tr>
	<tr>
		<td>身分證字號:</td>
		<td><input type="TEXT" name="mem_id" size="45"
			 value="<%= (memTenVO==null)? "A192685483" : memTenVO.getMem_id()%>" /></td>
	</tr>
	<tr>
		<td>出生年月日:</td>
		<td><input name="mem_birthday" id="birthday_date" type="text"></td>
	</tr>
	<tr>
		<td>連絡電話:</td>
		<td><input type="TEXT" name="mem_phone" size="45"
			 value="<%= (memTenVO==null)? "0225024654" : memTenVO.getMem_phone()%>" /></td>
	</tr>
	<tr>
		<td>行動電話:</td>
		<td><input type="TEXT" name="mem_mobile" size="45"
			 value="<%= (memTenVO==null)? "0955162239" : memTenVO.getMem_mobile()%>" /></td>
	</tr>
	<tr>
		<td>電子信箱:</td>
		<td><input type="TEXT" name="mem_email" size="45"
			 value="<%= (memTenVO==null)? "peterwu1@gmail.com" : memTenVO.getMem_email()%>" /></td>
	</tr>
	<tr>
		<td>地址:</td>
		<td><input type="TEXT" name="mem_addr" size="45"
			 value="<%= (memTenVO==null)? "台北市中山區民生東路三段67號" : memTenVO.getMem_addr()%>" /></td>
	</tr>
	

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增"></FORM>

<!-- 上傳圖片可預覽 -->
<script>
function init() {

    let myFile = document.getElementById("mem_pic");
    let preview = document.getElementById("preview");

    myFile.addEventListener('change', function(e) {
        // 取得檔案物件的兩種方式
        // 1. 直接從myFile物件上取得檔案物件 (因為非同步，一樣，多個classname註冊時會有問題)
        // 2. 從event物件中取得他的soure target，也就是myFile物件，再取得檔案物件 
        // 檔案的基本資訊，包括：檔案的名稱、大小與文件型態
        let files = e.target.files;
        // 判斷files物件是否存在
        if (files !== null) {
            // 取出files物件的第一個
            let file = files[0];
            // 判斷file.type的型別是否包含'image'
            if (file.type.indexOf('image') > -1) {
                // new a FileReader
                let reader = new FileReader();
                // 在FileReader物件上註冊load事件 - 載入檔案的意思
                reader.addEventListener('load', function(e) {
                    // 取得結果 提示：從e.target.result取得讀取到結果
                    let result = e.target.result;
                    // console.log(result) 確認讀取到結果
                    // 新增img元素
                    let img = document.createElement('img');
                    // 賦予src屬性
                    img.src = result;
                    // 放到div裡面
                    preview.append(img);
                });
                // 使用FileReader物件上的 readAsDataURL(file) 的方法，傳入要讀取的檔案，並開始進行讀取
                reader.readAsDataURL(file); // trigger!!!!
            } else {
                // 彈出警告視窗 alert('請上傳圖片！');
                alert('請上傳圖片！');
            }
        }
    });
}

window.onload = init;
</script>

</body>


<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
	java.sql.Date mem_birthday = null;
	try {
		mem_birthday = memTenVO.getMem_birthday();
 	} catch (Exception e) {
		mem_birthday = new java.sql.Date(System.currentTimeMillis());
 	}
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#birthday_date').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=mem_birthday%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
        //      var somedate1 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});

        
        //      2.以下為某一天之後的日期無法選擇
        //      var somedate2 = new Date('2017-06-15');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});
        
</script>
</html>