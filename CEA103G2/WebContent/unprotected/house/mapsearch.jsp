<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>index</title>

<style type="text/css">

.breadcrumb_bg {
    background-image: url(/CEA103G2/index_img/search.jpg) !important;
    background-position: center;
    background-repeat: no-repeat;
    background-size: cover;
}

.section_padding {
    padding: 200px 0px !important;
}

/* content CSS start */
.subscribe_area div.container {
	padding: 100px 0;
}
/* content CSS end */

</style>

</head>
<body>
<%@include file="/front-end/header.file"%>

	<!-- subscribe_area part start-->
    <section class="breadcrumb breadcrumb_bg"  >
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="breadcrumb_iner">
                        <div class="breadcrumb_iner_item">
                            <h2>HowTrue</h2>
                            <h3 class='bg-5 text'> <span>-</span>Find the Right House</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
	
	 <section  style='padding-top:40px'>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                        <div class="breadcrumb_iner_item">
								<div class="form-inline">
								<input style='width:80%' type="text" class="form-control" placeholder="請輸入地址">
								<button type="submit" id='key' style='background-color:#EBEBFF;font-weight:bold' class="btn btn-default">地圖找房</button>
								</div>
								
                        </div>
                </div>
            </div>
        </div>
    </section> 
    <div id="map" style="width: 500px; height: 500px; margin:20px auto"></div>
<script type="text/javascript" src="javascripts/jquery.googlemap.js"></script>
<script src="<%=request.getContextPath()%>/template_front-end/js/jquery-1.12.1.min.js"></script>
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDJtdRDJrA8jHn3wA3iA_20Uh7rl8CCUbY"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script>
	let objArray = [];
	let initobj = {};
	
	function initMap(initobj) {
	    //設定中心點座標
	    var map = new google.maps.Map(document.getElementById('map'), {
	      zoom: 10,
	      center: {lat: initobj['lat'], lng: initobj['lng']},
	    });
	    let test = {
		    	  position: {lat: initobj['lat'], lng: initobj['lng']},
		    	  map: map,
		    	  animation: google.maps.Animation.BOUNCE
		 };
	    let markers = [];
	  	let markerObj = [];
	  	let info = [];
	  	let infowindow = [];
	    
	    for(let hos of objArray){
	    	let hosobj = objArray.pop()
    		markerObj.push(
    		{
	    	    position: {lat:hosobj['lat'],lng: hosobj['lng']},
	    	    map: map,
	    	    icon: {
	    	    	url:'<%=request.getContextPath()%>/index_img/home.png',
	    	        scaledSize: new google.maps.Size(30, 30)
	    	     }
    	    });
    	    let str = '<h5>物件編號'+hosobj['no']+'</h5>';
    	    str += '<p>'+hosobj['name']+'</p>';
    	    str+="<a href='<%=request.getContextPath()%>/house/house.do?houseno="+hosobj['no']+"&action=listHouPho_ByHouseA'>";
    	    str+="<img style='height:200px' src='<%=request.getContextPath()%>/house/houseImg.do?action=getOneImg&houseno="+hosobj['no']+"' ></a>";	
    	    info.push(str);
	    }
	    info.forEach(function(e,v){
	    	infowindow[v] = new google.maps.InfoWindow({
	    		  content: e
	    	});
	    })
		let count = 1;	    
	    markerObj.forEach(function(e,v){
	    	markers[v] = new google.maps.Marker(e);
	    	infowindow[v].open(map, markers[v]);
	    	setTimeout(function(){
	    		infowindow[v].close();
	    	},(count++)*400);
	    	markers[v].addListener('click', function() {
	    		 infowindow[v].open(map, markers[v]);
	    	});
	    	
	    	markers[v].setMap(map);
	    })
	    var marker = new google.maps.Marker(test);
	    
	}
	$("#key").click(function(){
		if(!!$(this).prev().val()){
			let address = $(this).prev().val();
			$.ajax({
				url:"<%=request.getContextPath()%>/HouseJsonServlet",
				type:'post',
				data:{
					action:'findhouse',
					keword:$(this).prev().val(),
				},
				success:function(e){
					
					 const KEY = "AIzaSyDJtdRDJrA8jHn3wA3iA_20Uh7rl8CCUbY";
					 let address_success = address;
					 let xhttp = new XMLHttpRequest();
				    xhttp.onreadystatechange = function(e) {
				    	let country="";
						let dist = "";
				        if (xhttp.readyState == 4 & xhttp.status == 200) {
				            let jsonobj = xhttp.responseText;
				            let key = JSON.parse(jsonobj);
				            initobj.center = key["results"][0]["formatted_address"];
				            initobj.lat = key["results"][0]["geometry"]["location"]["lat"];
				            initobj.lng = key["results"][0]["geometry"]["location"]["lng"];
							console.log(key["results"][0]['address_components']);
							let obj = key["results"][0]['address_components'];
							for(let k of obj){
								if(k['types'][0]=="administrative_area_level_1" ||k['types'][0]=="administrative_area_level_2"||k['types'][0]=="colloquial_area"){
									country=k['short_name'];
								}else if(k['types'][0]=="administrative_area_level_3"){
									dist = k['short_name'];
								}
							}
							addressSearch(country,dist);
							
				        }
				    }
				    xhttp.open("GET", "https://maps.googleapis.com/maps/api/geocode/json?address=" + address_success + "&key=" + KEY, true);
				    xhttp.send();
				}
			})
		
		}else{
			Swal.fire({
				  title: '請輸入地址',
			})
		}
	})
	function addressSearch(city,dist){
		$.ajax({
			url:'<%=request.getContextPath()%>/HouseJsonServlet',
			type:'post',
			data:{
				action:'mapsearch',
				hos_city:city,
				hos_dist:dist,
			},
			async:true,
			success:function(e1){
				objArray = [];
				for(let hos of e1){
					let hosobj ={};
					hosobj.lat=hos.hos_lat;
					hosobj.lng=hos.hos_lon;
					hosobj.name=hos.hos_name;
					hosobj.no=hos.hos_no;
					objArray.push(hosobj);
				}
				if(objArray.length===0){
					Swal.fire({
						  title: '這附近尚無案件',
					})
				}
				initMap(initobj);
			}
		})
	}
</script>    
    
<%@ include file="/front-end/footer.file"%>

</body>
</html>