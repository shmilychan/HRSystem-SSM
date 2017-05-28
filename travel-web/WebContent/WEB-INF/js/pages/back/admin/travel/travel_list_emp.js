function addTableRow(photo,eid,ename,level,dname,phone) {
	row = 	"	<tr id='travelEmp-"+eid+"'>" + 
			"		<td class='text-center'>" +
			"			<img src='upload/member/"+photo+"' style='width:20px;'/> " +
			"		</td>" +
			"		<td class='text-center'>"+ename+"</td>" +
			"		<td class='text-center'>"+phone+"</td>" +
			"		<td class='text-center'>"+level+"</td>" +
			"		<td class='text-center'>"+dname+"</td>" +
			"	</tr> " ;
	$("#travelEmpTable").append(row) ;
} 
$(function(){
	$("span[id^=showBtn-]").each(function(){
		$(this).on("click",function(){
			tid = this.id.split("-")[1] ;
			$.post("pages/back/admin/travel/show_emp.action",{"tid":tid},
					function(data){
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
							level,
							dname,
							data.allEmps[x].phone);
				}
			},"json") ;
			
			$("#travelEmpInfo").modal("toggle") ;
		}) ;
	}) ;
})