<%@ page pageEncoding="UTF-8"%>
<%--
<jsp:include page="/pages/plugins/split_plugin_page_bar.jsp"/>
--%> 
<%
	String basePath = request.getScheme() + "://" + 
		request.getServerName() + ":" + request.getServerPort() +  
		request.getContextPath()  ;
%>
<%
	request.setCharacterEncoding("UTF-8") ;
	String url = basePath + request.getAttribute("url") ;	// 提交路径
	long currentPage = 1 ;	// 当前所在的页面，默认是在第1页
	int lineSize = 1 ;	// 表示每页显示的数据行数
	long allRecorders = 0 ;	// 保存总记录的统计结果
	long pageSize = 1 ;	// 总页数
	String column = (String) request.getAttribute("column") ;
	String keyWord = (String) request.getAttribute("keyWord") ;
%>

<%
	try {
		currentPage = (Long) request.getAttribute("currentPage") ;
	} catch (Exception e) {}
	try {
		lineSize = (Integer) request.getAttribute("lineSize") ;
	} catch (Exception e) {}
	try {
		allRecorders = (Long) request.getAttribute("allRecorders") ;
	} catch (Exception e) {}
	if ("null".equals(column) || column == null || "".equals(column)) {
		column = "" ;
	}
	if ("null".equals(keyWord) || keyWord == null || "".equals(keyWord)) {
		keyWord = "" ;
	}
%>
<%
	int seed = 2 ;	// 定义一个种子数，用于判断是否会有“.”
	if (allRecorders > 0) {
		pageSize = (allRecorders + lineSize - 1) / lineSize ;
	}
%>
<div id="pageCtl">
	<ul class="pagination"> 
		<li class="<%=currentPage == 1? "active" : ""%>">
		<%
			if (currentPage == 1) {
		%>
				<span>1</span>
		<%
			} else {
		%>
			<a href="<%=url%>?cp=<%=1%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>&${paramName}=${paramValue}">1</a></li>
		<%
			}
		%>
<%
	if (pageSize > (seed - 1) * 2) {	// 数据量很大，需要进行省略号的出现
		if (currentPage <= seed * 2) {
			long startPage = 2 ;	// 从第2页开始显示
			long endPage = currentPage + seed * 2  ;	
			if (endPage >= pageSize)  {
				endPage = pageSize - 1 ;
			}
			for (long x = startPage ; x <= endPage ; x ++) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>&${paramName}=${paramValue}"><%=x%></a></li>
<%
			}
			if ((currentPage + seed * 2) < pageSize - 1) {
%> 
				<li class="disabled"><span>...</span></li>
<%
			}
		} else {	// 需要分两段显示了
%>
			<li class="disabled"><span>...</span></li>
<%
			long startPage = currentPage - seed ;	
			long endPage = currentPage + seed ;
			if (endPage >= pageSize) {
				endPage = pageSize - 1 ;
			}
			for (long x = startPage ; x <= endPage ; x ++) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>&${paramName}=${paramValue}"><%=x%></a></li>
<%
			}
			if ((currentPage + seed * 2) < pageSize) {	// 后面还有很多页
%>
			<li class="disabled"><span>...</span></li>
<%
			} else {	// 后续的页码需要出现
				for (long x = currentPage + seed + 1 ; x < pageSize ; x ++ ) {
%>
			<li class="<%=currentPage == x ? "active" : ""%>"><a href="<%=url%>?cp=<%=x%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>&${paramName}=${paramValue}"><%=x%></a></li>
<%
				}
			}
		}
	}
%>
<%
	if (pageSize != 1) {
%>
		<li class="<%=currentPage == pageSize ? "active" : ""%>">
		<%
			if (currentPage == pageSize) {
		%>
				<span><%=pageSize%></li>
		<%
			} else {
		%>
				<a href="<%=url%>?cp=<%=pageSize%>&ls=<%=lineSize%>&col=<%=column%>&kw=<%=keyWord%>&${paramName}=${paramValue}"><%=pageSize%></a>
		<%
			}
		%>
		</li>
<%
	}
%>
	</ul>
</div>