<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/pages/plugins/back/back_header.jsp"/>
<%!
	public static final String EMP_EDIT_URL = "pages/back/admin/emp/edit.action" ;
%>
<script type="text/javascript" src="js/pages/back/admin/emp/emp_edit.js"></script>
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
					<strong><span class="glyphicon glyphicon-pencil"></span>&nbsp;雇员编辑</strong>
				</div>
				<div class="panel-body">
					<form class="form-horizontal" action="<%=EMP_EDIT_URL%>" id="myform" method="post" enctype="multipart/form-data">
						<fieldset>
							<!-- 定义输入表单样式，其中id主要用于设置颜色样式 -->
							<div class="form-group" id="eidDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="eid">登录ID：</label>
								<div class="col-md-5">
									<span class="h5">${emp.eid}</span>
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="eidMsg">${errors['eid']}</div>
							</div>
							<div class="form-group" id="passwordDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="password">登录密码：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="password" id="password" name="password" class="form-control"
										placeholder="如果不该密码可以不填写">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="passwordMsg">${errors['password']}</div>
							</div>
							<div class="form-group" id="enameDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="ename">雇员姓名：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="ename" name="ename" class="form-control"
										placeholder="请输入雇员真实姓名" value="${emp.ename}">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="enameMsg">${errors['ename']}</div>
							</div>
							<div class="form-group" id="salDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="sal">基本工资：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="sal" name="sal" class="form-control"
										placeholder="请输入雇员月薪" value="${emp.sal}">
								</div>
								<!-- 定义表单错误提示显示元素 --> 
								<div class="col-md-4" id="salMsg">${errors['sal']}</div>
							</div>
							<div class="form-group" id="phoneDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="phone">联系电话：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<input type="text" id="phone" name="phone" class="form-control"
										placeholder="请输入雇员联系电话" value="${emp.phone}">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="phoneMsg">${errors['phone']}</div>
							</div>
							<div class="form-group" id="didDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="did">所属部门：</label>
								<div class="col-md-5">
									<select id="did" name="did" class="form-control">
										<option value="">====== 请选择所在部门 ======</option>
										<c:forEach items="${allDepts}" var="dept">
											<option value="${dept.did}" ${emp.did==dept.did ? "selected" : ""}>${dept.dname}</option>
										</c:forEach>
									</select>
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="didMsg">${errors['did']}</div>
							</div>
							<div class="form-group" id="lidDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="lid">雇员级别：</label>
								<div class="col-md-5">
									<select id="lid" name="lid" class="form-control">
										<option value="">====== 请选择雇员职务 ======</option>
										<c:forEach items="${allLevels}" var="lev">
											<c:if test="${lev.level ge level}">
												<option value="${lev.lid}" ${emp.lid==lev.lid ? "selected" : ""}>${lev.title}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="lidMsg">${errors['lid']}</div>
							</div>
							<div class="form-group" id="picDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="pic">雇员照片：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<img src="upload/member/${emp.photo}">
									<input type="file" id="pic" name="pic" class="form-control"
										placeholder="请选择雇员照片">
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="picMsg">${errors['pic']}</div>
							</div>
							<!-- 定义输入表单样式，其中id主要用于设置颜色样式 -->
							<div class="form-group" id="noteDiv">
								<!-- 定义表单提示文字 -->
								<label class="col-md-3 control-label" for="note">备注信息：</label>
								<div class="col-md-5">
									<!-- 定义表单输入组件 -->
									<textarea id="note" name="note"
										class="form-control" placeholder="请输入雇员的面试情况" rows="10">${emp.note}</textarea>
								</div>
								<!-- 定义表单错误提示显示元素 -->
								<div class="col-md-4" id="noteMsg">${errors['note']}</div>
							</div> 
							<div class="form-group">
								<div class="col-md-5 col-md-offset-3">
									<input type="hidden" name="eid" id="eid" value="${emp.eid}">
									<input type="hidden" name="photo" id="photo" value="${emp.photo}">
									<button type="submit" class="btn btn-primary">编辑</button>
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
