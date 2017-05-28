did = 1 ;

function deleteEmpFun(eid,tid) {
	// console.log(eid + " = " + tid) ;
	$.post("pages/back/admin/travel/delete_emp.action",{"tid":tid,"eid":eid},function(data){
		$("#travel-" + eid).remove() ;
		operateAlert(data.status,"出差人员信息移除成功！","出差人员信息移除失败！") ;
	},"json") ;
}

$(function(){
	$("button[id^=remove-]").each(function(){
		eid = this.id.substring(this.id.indexOf("-") + 1,this.id.lastIndexOf("-")) ;
		tid = this.id.substring(this.id.lastIndexOf("-") + 1) ;
		$(this).on("click",function(){
			deleteEmpFun(eid,tid) ;
		})
	}) ;
	$("#did").on("change",function(){
		did = $(this).val() ;
		loadData() ;
	}) ;
	$(addBtn).on("click",function(){
		// Ajax异步读取用户信息
		// 将异步加载信息填充到模态窗口的组件之中
		loadData() ;
		$("#userInfo").modal("toggle") ;	// 显示模态窗口
	}) ;
})

function loadData() {	// 该函数名称一定要固定，不许修改
	// 如果要想进行分页的处理列表前首先查询出部门编号
	did = $("#did").val() ;	// 取得指定组件的value
	tid = $("#tid").val() ;
	console.log("部门编号：" + did) ;
	$.post("pages/back/admin/travel/emp_dept.action", {
		"did" : did,
		"cp" : jsCommonCp, 
		"ls" : jsCommonLs,
		"tid" : tid
	}, function(data) {
		console.log(data);
		$("#empTable tr:gt(0)").remove() ;
		for (var x = 0 ; x < data.allEmps.length ; x ++) {
			addTableRow(data.allEmps[x].photo,data.allEmps[x].eid,data.allEmps[x].ename,data.allEmps[x].sal,data.allEmps[x].lid) ;
		}
		createSplitBar(data.allRecorders) ;	// 创建分页控制项
	}, "json");
}
function addTableRow(photo,eid,ename,sal,lid) {
	level = "普通员工" ;
	if (lid == "manager") {
		level = "部门经理" ;
	} else if (lid == "chief") {
		level = "总监" ;
	}
	row = 	"	<tr id='travelEmp-"+eid+"'>" + 
			"		<td class='text-center'>" +
			"			<img src='upload/member/"+photo+"' style='width:20px;'/> " +
			"		</td>" +
			"		<td class='text-center'>"+eid+"</td>" +
			"		<td class='text-center'>"+ename+"</td>" +
			"		<td class='text-center'>￥"+sal+"</td>" +
			"		<td class='text-center'>"+level+"</td>" +
			"		<td class='text-center'>" +
			"			<button class='btn btn-danger btn-xs' id='addEmp-"+eid+"'>" +
			"				<span class='glyphicon glyphicon-plus-sign'></span>&nbsp;增加</button>" +
			"		</td>" + 
			"	</tr> " ;
	$(empTable).append(row) ;
	$("#addEmp-" + eid).on("click",function(){
		tid = $("#tid").val() ;
		$.post("pages/back/admin/travel/add_emp.action",{"eid":eid,"tid":tid},function(data){
			if (data.status == true) {	// 待出发用户添加完成
				$("#travelEmp-" + eid).remove() ;
				rowInfo = 	"<tr id='travel-"+eid+"'>" + 
							"	<td class='text-center'>" +
							"		<img src='upload/member/"+data.emp.photo+"' style='width:20px;'/> " +
							"	</td>" +
							"	<td class='text-center'>"+data.emp.eid+"</td>" +
							"	<td class='text-center'>"+data.emp.ename+"</td>" +
							"	<td class='text-center'>￥"+data.emp.sal+"</td>" +
							"	<td class='text-center'>"+data.level.title+"</td>" +
							"	<td class='text-center'>"+data.dept.dname+"</td>" +
							"	<td class='text-center'>" +
							"		<button class='btn btn-danger btn-xs' id='remove-"+data.emp.eid+"-"+tid+"'>" +
							"			<span class='glyphicon glyphicon-remove'></span>&nbsp;移除</button>" +
							"	</td>" +
							"</tr> " ;
				$("#travelEmpTable").append(rowInfo) ;
				$("#remove-"+data.emp.eid+"-"+tid).on("click",function(){
					deleteEmpFun(eid,tid) ;
				}) ;
			} else {
				$("#userInfo").modal("toggle") ;
				operateAlert(false,"","该雇员已经有了项目安排无法添加到本次出差人员之内！") ;
			}
		},"json") ;
	}) ;
}

