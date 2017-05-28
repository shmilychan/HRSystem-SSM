<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<%!
	public static final String TRAVEL_AUDIT_URL = "pages/back/admin/travel/travel_audit.jsp" ;
%>
<script type="text/javascript" src="js/pages/back/admin/travelaudit/travel_list.js"></script>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="3"/>
			<jsp:param name="msi" value="32"/>
		</jsp:include>
		<div class="content-wrapper text-left">
			<div class="panel panel-success">
				<div class="panel-heading">
					<strong><span class="glyphicon glyphicon-list"></span>&nbsp;出差信息列表</strong>
				</div>
				<div class="panel-body">
					<div>
						<jsp:include page="/WEB-INF/pages/plugins/split_plugin_search_bar.jsp"/>
					</div>
					<table class="table table-condensed">
						<thead>
							<tr>
								<th class="text-center"><strong>状态</strong></th>
								<th class="text-center"><strong>申请标题</strong></th>
								<th class="text-center"><strong>申请人</strong></th>
								<th class="text-center"><strong>申请部门</strong></th>
								<th class="text-center"><strong>申请日期</strong></th>
								<th class="text-center"><strong>开始日期</strong></th>
								<th class="text-center"><strong>结束日期</strong></th>
								<th class="text-center"><strong>出差人数</strong></th>
								<th class="text-center"><strong>差旅费用</strong></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${allTravels}" var="trv">
								<tr id="travel-${trv.tid}">
									<td class="text-center">
										<c:if test="${trv.audit==1}">
											<span class="text-success"><span class="glyphicon glyphicon-flag"></span>&nbsp;进行中</span>
										</c:if>
										<c:if test="${trv.audit==3}">
											<span class="text-danger"><span class="glyphicon glyphicon-flag"></span>&nbsp;已完成</span>
										</c:if>
									</td>
									<td class="text-center">
										<span id="showBtn-${trv.tid}" onmouseover="this.style.cursor='hand'">${trv.title }</span>
									</td>
									<td class="text-center"><span id="eid-${trv.seid}" style="cursor:pointer;">${allEmps[trv.seid].ename}</span></td>
									<td class="text-center">${allDepts[allEmps[trv.seid].did]}</td>
									<td class="text-center"><fmt:formatDate value="${trv.subdate}" pattern="yyyy-MM-dd"/></td>
									<td class="text-center"><fmt:formatDate value="${trv.sdate}" pattern="yyyy-MM-dd"/></td>
									<td class="text-center"><fmt:formatDate value="${trv.edate}" pattern="yyyy-MM-dd"/></td>
									<td class="text-center">${trv.ecount}人</td>
									<td class="text-center">￥${trv.total}</td>
								</tr> 
							</c:forEach>
						</tbody>
					</table>
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
	<jsp:include page="/WEB-INF/pages/plugins/back/info/travel_info_modal.jsp"/>
	<jsp:include page="/WEB-INF/pages/plugins/back/info/emp_info_modal.jsp"/>
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
