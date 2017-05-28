<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<%!
	public static final String INDEX_URL = "pages/back/index.jsp" ;	

	public static final String DEPT_LIST_URL = "pages/back/admin/dept/list.action" ;
	public static final String EMP_ADD_URL = "pages/back/admin/emp/add_pre.action" ;
	public static final String EMP_LIST_URL = "pages/back/admin/emp/list.action" ;
	
	public static final String TRAVEL_ADD_URL = "pages/back/admin/travel/add_pre.action" ;
	public static final String TRAVEL_LIST_SELF_URL = "pages/back/admin/travel/list_self.action" ;
	public static final String TRAVEL_LIST_EMP_URL = "pages/back/admin/travel/list_emp.action" ;
	
	public static final String TRAVEL_AUDIT_URL = "pages/back/admin/travelaudit/prepare.action" ;
	public static final String TRAVEL_LIST_URL = "pages/back/admin/travelaudit/list.action" ;
%>
<aside class="main-sidebar"> 
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="upload/member/nophoto.png" class="img-circle"
					alt="User Image">
			</div>
			<div class="pull-left info">
				<p>${ename}</p>
			</div> 
		</div>
		<!-- /.search form -->
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu">
			<li class="header"><i class="fa fa-university"></i> 差旅管理系统</li>
				<shiro:hasRole name="emp">
					<li class="treeview ${param.mi==1 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i
							class="fa fa-sitemap"></i> <span>雇员管理</span> <i
							class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<shiro:hasPermission name="dept:list">
							<li class="${param.msi==11 ? 'active' : ''}"><a href="<%=DEPT_LIST_URL%>"><i class="fa fa-object-group"></i>
								部门列表</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="emp:add">
							<li class="${param.msi==12 ? 'active' : ''}"><a href="<%=EMP_ADD_URL%>"><i class="fa fa-user-plus"></i>
								增加雇员</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="emp:list">
							<li class="${param.msi==13 ? 'active' : ''}"><a href="<%=EMP_LIST_URL%>"><i class="fa fa-users"></i>
								雇员列表</a></li>
						</shiro:hasPermission>
					</ul></li>
				</shiro:hasRole>
				<shiro:hasRole name="empshow">
					<li class="treeview ${param.mi==1 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i
							class="fa fa-sitemap"></i> <span>雇员管理</span> <i
							class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<shiro:hasPermission name="deptshow:list">
							<li class="${param.msi==11 ? 'active' : ''}"><a href="<%=DEPT_LIST_URL%>"><i class="fa fa-object-group"></i>
								部门列表</a></li>
						</shiro:hasPermission>
						<shiro:hasPermission name="empshow:list">
							<li class="${param.msi==13 ? 'active' : ''}"><a href="<%=EMP_LIST_URL%>"><i class="fa fa-users"></i>
								雇员列表</a></li>
						</shiro:hasPermission>
					</ul></li>
				</shiro:hasRole>
			<shiro:hasRole name="travel">
					<li class="treeview ${param.mi==2 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa  fa-car"></i>
						<span>差旅安排</span> <i class="fa fa-angle-left pull-right"></i>
					</a>
					<ul class="treeview-menu">
						<c:if test="${level == 2 || level == 1}">
							<shiro:hasPermission name="travel:add">
								<li class="${param.msi==21 ? 'active' : ''}"><a href="<%=TRAVEL_ADD_URL%>"><i
									class="fa fa-train"></i> 出差申请</a></li>
							</shiro:hasPermission>
							<shiro:hasPermission name="travel:self">
								<li class="${param.msi==22 ? 'active' : ''}"><a href="<%=TRAVEL_LIST_SELF_URL%>"><i
									class="fa fa-history"></i> 我的申请</a></li>
							</shiro:hasPermission>
						</c:if>
							<li class="${param.msi==23 ? 'active' : ''}"><a href="<%=TRAVEL_LIST_EMP_URL%>"><i
									class="fa fa-train"></i> 我的出差</a></li>
					</ul></li>
			</shiro:hasRole>
			<shiro:hasRole name="travelaudit">
				<li class="treeview  ${param.mi==3 ? 'active' : ''}"><a href="${basePath}<%=INDEX_URL%>"> <i class="fa fa-bitbucket-square"></i>
					<span>差旅审核</span> <i class="fa fa-angle-left pull-right"></i>
				</a>
				<ul class="treeview-menu">
					<shiro:hasPermission name="travelaudit:prepare">
						<li class="${param.msi==31 ? 'active' : ''}"><a href="<%=TRAVEL_AUDIT_URL%>"><i
							class="fa fa-plane"></i> 待审核申请</a></li>
					</shiro:hasPermission>
					<shiro:hasPermission name="travelaudit:list">
						<li class="${param.msi==32 ? 'active' : ''}"><a href="<%=TRAVEL_LIST_URL%>"><i
							class="fa fa-tasks"></i> 申请列表</a></li>
					</shiro:hasPermission>
				</ul></li>
			</shiro:hasRole>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>