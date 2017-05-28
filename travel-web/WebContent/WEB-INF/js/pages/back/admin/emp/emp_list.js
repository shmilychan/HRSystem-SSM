$(function(){
	$("span[id^=eid-]").each(function(){
		$(this).on("click",function(){
			eid = this.id.substring(4) ;
			did = $(this).attr("alt") ;
			console.log("雇员编号：" + eid) ;
			$.post("pages/back/admin/emp/get.action",{"eid":eid},function(data){
				$("#info-photo").attr("src","upload/member/" + data.emp.photo);
				$("#info-ename").text(data.emp.ename);
				$("#info-level").text(data.level.title);
				$("#info-dept").text(data.dept.dname);
				$("#info-phone").text(data.emp.phone);
				$("#info-hiredate").text(new Date(data.emp.hiredate.time).format("yyyy-MM-dd"));
				$("#info-note").text(data.emp.note);
				$("#levelBtn").attr("alt",did) ;	// 保存部门的编号信息
			},"json") ;
			$("#userInfo").modal("toggle") ;
		}) ;
	}) ;
	$(selall).on("click",function(){
		$("input[id^=eid-]").each(function(){
			$(this).prop("checked",$(selall).prop("checked")) ;
		}) ;
	}) ;
	$(deleteBtn).on("click",function(){
		ids = "" ;
		$("input[id^=eid-]").each(function(){
			if ($(this).prop("checked")) {
				ids += $(this).val() + "," ;
			}
		}) ;
		if (ids == "") {
			operateAlert(false,"","您还未选择任何要删除的数据！") ;
		} else {
			if (window.confirm("您确定要删除这些雇员信息吗？")) {
				window.location = "pages/back/admin/emp/delete.action?ids=" + ids ;
			}
		}
	}) ;
}) 