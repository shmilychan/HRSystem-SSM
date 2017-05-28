var myform ;

function calcTotal() {
	total = 0.0 ;
	$("span[id^=price-]").each(function(){
		total += parseFloat($(this).text()) ;
	}) ;
	$(allPrice).text(total) ;
}

function clearCostModal() {
	$(title).val("") ;
	$(price).val("") ;
	$("#tid option").each(function(){
		$(this).prop("selected",false) ;
	}) ;
	myform.resetForm() ; 
} 
function deleteCost(tcid) {
	$.post("pages/back/admin/travel/delete_cost.action",{"tcid":tcid},function(data){
		operateAlert(data.trim() == "true","支出项删除成功！" , "支出项删除失败！") ;
		if (data.trim() == "true") {
			$("#travel-" + tcid).remove() ;
			calcTotal() ;
		}
	},"text") ;
} 
$(function(){
	calcTotal() ;
	
	$("button[id^=remove-]").each(function(){
		tcid = this.id.split("-")[1];
		$(this).on("click",function(){ 
			deleteCost(tcid) ;
		}) ; 
	}) ;
	
	$(addBtn).on("click",function(){
		clearCostModal() ;
		// Ajax异步读取用户信息
		// 将异步加载信息填充到模态窗口的组件之中
		$("#costInfo").modal("toggle") ;	// 显示模态窗口
	}) ;
	myform = $("#myform").validate({
		debug : true, // 取消表单的提交操作
		submitHandler : function(form) {
			// form.submit(); // 提交表单
			// operateAlert(true,"支出项追加失败！" , "支出项追加成功！") ;
			// $("#costInfo").modal("toggle") ;	// 显示模态窗口
			tpid = $(tpid).val() ;
			title = $(title).val() ;
			price = $(price).val() ;
			tid = $(tid).val() ;
			$.post("pages/back/admin/travel/add_cost.action",
					{"tpid":tpid,"title":title,"price":price,"tid":tid},function(data){
						if (data.status) {
							$("#title").val("") ; 
							$("#price").val("") ;
							costInfo = 	"<tr id='travel-"+data.cost.tcid+"'>" +
										"	<td class='text-center'>"+data.type.title+"</td>" +
										"	<td class='text-center'>￥<span id='price-"+data.cost.tcid+"'>"+data.cost.price+"</span></td>" +
										"	<td class='text-center'>"+data.cost.title+"</td>" +
										"	<td class='text-center'>" +
										"		<button class='btn btn-danger btn-xs' id='remove-"+data.cost.tcid+"'>" +
										"			<span class='glyphicon glyphicon-remove'></span>&nbsp;移除</button>" +
										"	</td>" +
										"</tr>" ;
							$("#costTable").append(costInfo) ;
							$("#remove-" + data.cost.tcid).on("click",function(){
								deleteCost(data.cost.tcid) ;
							}) ;
							calcTotal() ;
						}
						$("#costInfo").modal("toggle") ;
						operateAlert(data.status,"支出项追加成功！" , "支出项追加失败！") ;
					},"json") ;
		},
		errorPlacement : function(error, element) {
			$("#" + $(element).attr("id").replace(".", "\\.") + "Msg").append(error);
		},
		highlight : function(element, errorClass) {
			$(element).fadeOut(1,function() {
				$(element).fadeIn(1, function() {
					$("#" + $(element).attr("id").replace(".","\\.") + "Div").attr("class","form-group has-error");
				});

			})
		},
		unhighlight : function(element, errorClass) {
			$(element).fadeOut(1,function() {
				$(element).fadeIn(1,function() {
						$("#" + $(element).attr("id").replace(".","\\.") + "Div").attr("class","form-group has-success");
				});
			})
		},
		errorClass : "text-danger",
		rules : {
			"title" : {
				required : true,
				//remote : {
//									url : "check.jsp", // 后台处理程序
//									type : "post", // 数据发送方式
//									dataType : "html", // 接受数据格式
//									data : { // 要传递的数据
//										code : function() {
//											return $("#code").val();
//										}
//									},
//									dataFilter : function(data, type) {
//										if (data.trim() == "true")
//											return true;
//										else
//											return false;
//									}
				//}
			},
			"tpid" : {
				required : true
			} ,
			"price" : {
				required : true ,
				number : true
			}
		}
	});
})