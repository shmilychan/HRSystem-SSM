<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<script type="text/javascript" src="js/pages/back/admin/emp/emp_list.js"></script>
<%!
	public static final String EMP_EDIT_URL = "pages/back/admin/emp/edit_pre.action" ;
%>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="1"/>
			<jsp:param name="msi" value="13"/>
		</jsp:include>
		<div class="content-wrapper text-left">
		<div class="panel panel-success">
			<div class="panel-heading">
				<strong><span class="glyphicon glyphicon-list"></span>&nbsp;雇员信息列表</strong>
			</div>
			<div class="panel-body">
				<div>
					<jsp:include page="/WEB-INF/pages/plugins/split_plugin_search_bar.jsp"/>
				</div>
				<table class="table table-condensed">
					<thead>
						<tr>
							<th class="text-center"><input type="checkbox" id="selall"></th>
							<th class="text-center">照片</th> 
							<th class="text-center">登录ID</th>
							<th class="text-center">姓名</th>
							<th class="text-center">级别</th>
							<th class="text-center">所在部门</th>
							<th class="text-center">雇佣日期</th>
							<th class="text-center">基本工资</th>
							<th class="text-center">联系电话</th>
							<shiro:hasPermission name="emp:edit">
								<th class="text-center">操作</th>
							</shiro:hasPermission>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allEmps}" var="emp">
							<tr>
								<td class="text-center"><input type="checkbox" id="eid-${emp.eid}" value="${emp.eid}"></td>
								<td class="text-center">
									<img src="upload/member/${emp.photo}" style="width:20px;"/> 
								</td> 
								<td class="text-center">${emp.eid}</td>
								<td class="text-center">
									<span id="eid-${emp.eid}" style="cursor:pointer;">${emp.ename}</span>
								</td>
								<td class="text-center">${allLevels[emp.lid]}</td> 
								<td class="text-center">${allDepts[emp.did]}</td>
								<td class="text-center"><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"/></td>
								<td class="text-center">${emp.sal}</td>
								<td class="text-center">${emp.phone}</td>
								<shiro:hasPermission name="emp:edit">
									<td class="text-center">
										<c:if test="${emp.lid != 'chief'}">
											<a type="button" class="btn btn-warning btn-xs" href="<%=EMP_EDIT_URL%>?eid=${emp.eid}">
												<span class="glyphicon glyphicon-edit"></span>&nbsp;编辑</a>
										</c:if>
									</td>
								</shiro:hasPermission>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div>
					<shiro:hasPermission name="emp:remove">
						<button id="deleteBtn" class="btn btn-danger btn-lg">删除所选雇员信息</button>
					</shiro:hasPermission>
				</div> 
				<div id="splitBarDiv" style="float:right">
					<jsp:include page="/WEB-INF/pages/plugins/split_plugin_page_bar.jsp"/>
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
	<jsp:include page="/WEB-INF/pages/plugins/back/info/emp_info_modal.jsp"/>
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
