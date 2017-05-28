<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<script type="text/javascript" src="js/pages/back/admin/travel/travel_list_emp.js"></script>
<body class="hold-transition skin-blue sidebar-mini">
	<div class="wrapper">
		<!-- 导入头部标题栏内容 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_title_head.jsp" />
		<!-- 导入左边菜单项 -->
		<jsp:include page="/WEB-INF/pages/plugins/back/include_menu_item.jsp">
			<jsp:param name="mi" value="2"/>
			<jsp:param name="msi" value="23"/>
		</jsp:include>
		<div class="content-wrapper text-left">
			<div class="panel panel-success">
				<div class="panel-heading">
					<strong><span class="glyphicon glyphicon-list"></span>&nbsp;我的出差安排列表</strong>
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
								<th class="text-center"><strong>开始日期</strong></th>
								<th class="text-center"><strong>结束日期</strong></th>
								<th class="text-center"><strong>出差目的地</strong></th>
								<th class="text-center"><strong>差旅人数</strong></th>
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
										<span id="showBtn-${trv.tid}" onmouseover="this.style.cursor='hand'">${trv.title}</span>
									</td>
									<td class="text-center"><fmt:formatDate value="${trv.sdate}" pattern="yyyy-MM-dd"/></td>
									<td class="text-center"><fmt:formatDate value="${trv.edate}" pattern="yyyy-MM-dd"/></td>
									<td class="text-center">${trv.dest}</td>
									<td class="text-center">${trv.ecount}人</td>
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
	<jsp:include page="/WEB-INF/pages/plugins/back/info/travel_emp_modal.jsp"/>
	<jsp:include page="/WEB-INF/pages/plugins/back/include_javascript_foot.jsp" />
<jsp:include page="/WEB-INF/pages/plugins/back/back_footer.jsp"/>
