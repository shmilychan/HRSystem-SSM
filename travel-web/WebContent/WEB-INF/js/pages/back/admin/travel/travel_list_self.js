$(function(){
	$("span[id^=showBtn-]").each(function(){
		$(this).on("click",function(){
			tid = this.id.split("-")[1] ;
			console.log("差旅编号：" + tid) ;
			$("#travelInfo").modal("toggle") ;
		}) ;
	}) ;
})