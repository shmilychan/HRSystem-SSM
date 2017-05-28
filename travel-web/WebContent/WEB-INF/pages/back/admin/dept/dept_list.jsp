<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<script type="text/javascript" src="js/pages/back/admin/dept/dept_list.js"></script>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="1"/>
			<jsp:param name="msi" value="11"/>
		</jsp:include>
		<div class="content-wrapper text-left">
		<div class="panel panel-success">
			<div class="panel-heading">
				<strong><span class="glyphicon glyphicon-list"></span>&nbsp;雇员信息列表</strong>
			</div>
			<div class="panel-body">
				<table class="table table-condensed">
					<thead>
						<tr>
							<th class="text-center">部门名称</th> 
							<th class="text-center">领导姓名</th>
							<shiro:hasPermission name="dept:edit">
								<th class="text-center">操作</th>
							</shiro:hasPermission>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${allDepts}" var="dept">
							<tr>
								<td class="text-center">
									<shiro:hasPermission name="dept:edit">
										<input type="text" id="dname-${dept.did}" class="form-control" value="${dept.dname}">
									</shiro:hasPermission>
									<shiro:lacksPermission name="dept:edit">
										${dept.dname}
									</shiro:lacksPermission>
								</td>
								<td class="text-center" id="mgr-${dept.did}">
									<span id="eid-${dept.eid}" style="cursor:pointer;" alt="${dept.did}">${empMap[dept.eid]}</span>
								</td>
								<shiro:hasPermission name="dept:edit">
									<td class="text-center">
										<button id="edit-${dept.did}" class="btn btn-warning">
												<span class="glyphicon glyphicon-edit"></span>&nbsp;编辑</button>
									</td>
								</shiro:hasPermission>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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
