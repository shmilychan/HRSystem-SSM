function addTableRow(photo,eid,ename,sal,level,hiredate,dname,phone) {
	row = 	"	<tr id='travelEmp-"+eid+"'>" + 
			"		<td class='text-center'>" +
			"			<img src='upload/member/"+photo+"' style='width:20px;'/> " +
			"		</td>" +
			"		<td class='text-center'>"+ename+"</td>" +
			"		<td class='text-center'>"+phone+"</td>" +
			"		<td class='text-center'>￥"+sal+"</td>" +
			"		<td class='text-center'>"+level+"</td>" +
			"		<td class='text-center'>"+hiredate+"</td>" +
			"		<td class='text-center'>"+dname+"</td>" +
			"	</tr> " ;
	$("#travelEmpTable").append(row) ;
}

$(function(){
	$("span[id^=showBtn-]").each(function(){
		$(this).on("click",function(){
			tid = this.id.split("-")[1] ;
			console.log("差旅编号：" + tid) ;
			$("#travelEmpTable tr:gt(0)").remove() ;
			$("#travelCostTable tr:gt(0)").remove() ;
			$.post("pages/back/admin/travelaudit/show.action",{"tid":tid},
					function(data){
				$("#travel-title").text(data.travel.title) ;
				for (x = 0 ; x < data.allItems.length ; x ++) {
					if (data.allItems[x].iid == data.travel.iid) {
						$("#travel-item").text(data.allItems[x].title) ;
					}
				}
				$("#travel-total").text("￥" + data.travel.total) ;
				$("#travel-ecount").text(data.travel.ecount + "人") ;
				$("#travel-subdate").text(new Date(data.travel.subdate.time).format("yyyy-MM-dd")) ;
				$("#travel-sdate").text(new Date(data.travel.sdate.time).format("yyyy-MM-dd")) ;
				$("#travel-edate").text(new Date(data.travel.edate.time).format("yyyy-MM-dd")) ;
				$("#travel-dest").text(data.travel.dest) ;
				$("#travel-show_ecount").text(data.travel.ecount) ;
				$("#allPrice").text(data.travel.total) ;
				for (x = 0 ; x < data.allEmps.length ; x ++) {
					level = null ;
					for (y = 0 ; y < data.allLevels.length ; y ++) {
						if (data.allLevels[y].lid == data.allEmps[x].lid) {
							level = data.allLevels[y].title ;
						}
					}
					dname = null ;
					for (y = 0 ; y < data.allDepts.length ; y ++) {
						if (data.allDepts[y].did = data.allEmps[x].did) {
							dname = data.allDepts[y].dname ;
						}
					}
					addTableRow(
							data.allEmps[x].photo,
							data.allEmps[x].eid,
							data.allEmps[x].ename,
							data.allEmps[x].sal,
							level,
							new Date(
									data.allEmps[x].hiredate.time)
									.format("yyyy-MM-dd"),
							dname,
							data.allEmps[x].phone);
				}
				for (x = 0 ; x < data.allCosts.length ; x ++) {
					type = "" ;
					for (y = 0 ; y < data.allTypes.length ; y ++) {
						if (data.allTypes[y].tpid == data.allCosts[x].tpid) {
							type = data.allTypes[y].title ;
						}
					}
					costInfo = 	"<tr id='travel-"+data.allCosts[x].tcid+"'>" +
					"	<td class='text-center'>"+type+"</td>" +
					"	<td class='text-center'>￥<span id='price-"+data.allCosts[x].tcid+"'>"+data.allCosts[x].price+"</span></td>" +
					"	<td class='text-center'>"+data.allCosts[x].title+"</td>" +
					"</tr>" ;
					$("#travelCostTable").append(costInfo) ;
				}
			},"json") ;
			$("#travelInfo").modal("toggle") ;
		}) ;
	}) ;
	$("span[id^=eid-]").each(function(){
		$(this).on("click",function(){
			eid = this.id.split("-")[1] ;
			eid = this.id.substring(4) ;
			console.log("雇员编号：" + eid) ;
			$.post("pages/back/admin/emp/get.action",{"eid":eid},function(data){
				$("#info-photo").attr("src","upload/member/" + data.emp.photo);
				$("#info-ename").text(data.emp.ename);
				$("#info-level").text(data.level.title);
				$("#info-dept").text(data.dept.dname);
				$("#info-phone").text(data.emp.phone);
				$("#info-hiredate").text(new Date(data.emp.hiredate.time).format("yyyy-MM-dd"));
				$("#info-note").text(data.emp.note);
			},"json") ;
			$("#userInfo").modal("toggle") ;
		}) ;
	}) ;
})