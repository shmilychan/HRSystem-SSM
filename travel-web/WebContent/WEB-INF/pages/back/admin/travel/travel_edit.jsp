<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<%!
	public static final String TRAVEL_EDIT_URL = "pages/back/admin/travel/edit.action" ;
%>
<script type="text/javascript" src="${basePath}js/my97date/WdatePicker.js"></script> 
<script type="text/javascript" src="js/pages/back/admin/travel/travel_edit.js"></script>
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
					<strong><span class="glyphicon glyphicon-pencil"></span>&nbsp;出差申请单</strong>
				</div>
				<div class="panel-body">
					<form class="form-horizontal" action="<%=TRAVEL_EDIT_URL%>" id="myform" method="post">
						<fieldset>
							<!-- 定义输入表单样式，其中id主要用于设置颜色样式 -->
							<div class="form-group" id="titleDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="title">申请标题：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="title" name="title" class="form-control"
										placeholder="请输入出差申请标题" value="${travel.title}">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="titleMsg"></div>
							</div>
							<div class="form-group" id="destDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="dest">出差目的地：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="dest" name="dest" class="form-control"
										placeholder="请输入出差目的地" value="${travel.dest}">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="destMsg"></div>
							</div>
							<div class="form-group" id="iidDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="iid">出差类型：</label>
								<div class="col-md-5">
									<select id="iid" name="iid" class="form-control">
										<option value="">====== 请选择外出类型 ======</option>
										<c:forEach items="${allItems}" var="item">
											<option value="${item.iid}" ${item.iid==travel.iid ? "selected" :""}>${item.title}</option>
										</c:forEach>
									</select>
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="iidMsg"></div>
							</div>
							<div class="form-group" id="sdateDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="sdate">出差开始日期：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="sdate" name="sdate" class="form-control"
										placeholder="请选择出差开始时间" value="<fmt:formatDate value="${travel.sdate}" pattern="yyyy-MM-dd"/>"> 
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="sdateMsg"></div>
							</div>
							<div class="form-group" id="edateDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="edate">出差结束日期：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="edate" name="edate" class="form-control"
										placeholder="请选择出差结束时间" value="<fmt:formatDate value="${travel.edate}" pattern="yyyy-MM-dd"/>">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="edateMsg"></div>
							</div>
							<!-- 定义输入表单样式，其中id主要用于设置颜色样式 -->
							<div class="form-group" id="noteDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="note">出差事由：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<textarea id="note" name="note"
										class="form-control" placeholder="请输入本次出差要处理的业务详情" rows="10">${travel.note}</textarea>
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="noteMsg"></div>
							</div> 
							<div class="form-group">
								<div class="col-md-5 col-md-offset-3">
									<input type="hidden" name="tid" id="tid" value="${travel.tid}">
									<button type="submit" class="btn btn-primary">修改</button>
									<button type="reset" class="btn btn-warning">重置</button>
								</div>
							</div>
						</fieldset>
					</form>
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
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
