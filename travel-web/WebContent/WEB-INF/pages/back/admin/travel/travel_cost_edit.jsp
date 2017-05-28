<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<script type="text/javascript" src="js/pages/back/admin/travel/travel_cost_edit.js"></script>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="2"/>
			<jsp:param name="msi" value="22"/>
		</jsp:include>
		<div class="content-wrapper text-left">
			<div class="panel panel-success">
				<div class="panel-heading">
					<strong><span class="glyphicon glyphicon-list"></span>&nbsp;出差费用列表</strong>
				</div>
				<div class="panel-body">
					<button class="btn btn-danger btn-lg" id="addBtn">
						<span class="glyphicon glyphicon-plus-sign"></span>&nbsp;增加费用项</button>
					<table class="table table-condensed" id="costTable">
						<thead>
							<tr>
								<th class="text-center"><strong>支出类型</strong></th>
								<th class="text-center"><strong>费用</strong></th>
								<th class="text-center"><strong>用途</strong></th>
								<th class="text-center"><strong>操作</strong></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${allCosts}" var="cost">
								<tr id="travel-${cost.tcid}">
									<td class="text-center">${allTypes[cost.tpid]}</td>
									<td class="text-center">￥<span id="price-${cost.tcid}">${cost.price}</span></td>
									<td class="text-center">${cost.title}</td>
									<td class="text-center">
										<button class="btn btn-danger btn-xs" id="remove-${cost.tcid}">
											<span class="glyphicon glyphicon-remove"></span>&nbsp;移除</button>
									</td>
								</tr> 
							</c:forEach>
						</tbody>
					</table>
					<div id="splitBarDiv" style="float:right">
						<input type="hidden" name="tid" id="tid" value="${param.tid}">
						<span>总费用￥<span id="allPrice" class="text-danger h2"></span></span>
					</div>
				</div>
				<div class="panel-footer">
					<jsp:include page="/WEB-INF/pages/plugins/include_alert.jsp"/>
				</div>
			</div>
		</div>
		<!-- 导入公司尾部认证信息 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_foot.jsp" />
		<!-- 导入右边工具设置栏 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_sidebar.jsp" />
		<div class="control-sidebar-bg"></div>
	</div>
	
<div class="modal fade" id="costInfo"  tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true" data-keyboard="true">
	<div class="modal-dialog" style="width: 1000px">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
				<div class="form-group" id="didDiv">
					<strong><span class="glyphicon glyphicon-eye-open"></span>&nbsp;增加差旅支出申请项</strong></h3>
				</div>
			</div>
			<div class="modal-body">
				<div id="costBasicInfo">
					<form class="form-horizontal" id="myform" method="post">
						<div class="form-group" id="titleDiv">
							<!-- 定义表单提示文字 -->
							<label class="col-md-3 control-label" for="title">用途说明：</label>
							<div class="col-md-5">
								<!-- 定义表单输入组件 -->
								<input type="text" id="title" name="title" class="form-control"
									placeholder="请输入费用用途说明">
							</div>
							<!-- 定义表单错误提示显示元素 -->
							<div class="col-md-4" id="titleMsg"></div>
						</div>
						<div class="form-group" id="tpidDiv">
							<!-- 定义表单提示文字 -->
							<label class="col-md-3 control-label" for="tid">费用类型：</label>
							<div class="col-md-5">
								<select id="tpid" name="tpid" class="form-control">
									<option value="">====== 请选择费用类型 ======</option>
									<c:forEach items="${allTypes}" var="me">
										<option value="${me.key}">${me.value}</option>
									</c:forEach>
								</select>
							</div>
							<!-- 定义表单错误提示显示元素 -->
							<div class="col-md-4" id="tpidMsg"></div>
						</div>
						<div class="form-group" id="priceDiv">
							<!-- 定义表单提示文字 -->
							<label class="col-md-3 control-label" for="price">所需金额：</label>
							<div class="col-md-5">
								<!-- 定义表单输入组件 -->
								<input type="text" id="price" name="price" class="form-control"
									placeholder="请输入本费用所需金额">
							</div>
							<!-- 定义表单错误提示显示元素 -->
							<div class="col-md-4" id="priceMsg"></div>
						</div>
						<div class="form-group">
							<div class="col-md-5 col-md-offset-3">
								<button type="submit" class="btn btn-primary">增加</button>
								<button type="reset" class="btn btn-warning">重置</button>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
			</div>
		</div>
	</div>
</div>
	
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
