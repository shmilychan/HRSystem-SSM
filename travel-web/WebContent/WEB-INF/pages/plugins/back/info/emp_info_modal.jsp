<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="modal fade" id="userInfo"  tabindex="-1" aria-labelledby="modalTitle" aria-hidden="true" data-keyboard="true">
	<div class="modal-dialog" style="width: 1000px">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" aria-hidden="true">&times;</button>
				<div class="form-group" id="didDiv">
					<strong><span class="glyphicon glyphicon-eye-open"></span>&nbsp;查看雇员详细信息</strong></h3>
				</div>
			</div>
			<div class="modal-body">
				<div id="costBasicInfo">
					<div class="row">
						<div class="col-xs-3">
							<div><img src="upload/member/nophoto.png" style="width:200px;" id="info-photo"></div>
							<shiro:hasPermission name="dept:edit">
								<c:if test="${level==2}">
									<div class="height:50px;">&nbsp;</div>
									<div><button id="levelBtn" class="btn btn-danger btn-lg">
										<span class="glyphicon glyphicon-pencil"></span>&nbsp;部门领导降级</button></div>
								</c:if> 
							</shiro:hasPermission>
						</div> 
						<div class="col-xs-8">
							<table class="table table-condensed" style="width:700px;">
								<tr>
									<td style="width:30%;"><strong>雇员姓名：</strong></td>
									<td id="info-ename"></td>
								</tr>
								<tr>
									<td><strong>雇员职务：</strong></td>
									<td id="info-level"></td>
								</tr>
								<tr>
									<td><strong>所属部门：</strong></td>
									<td id="info-dept"></td>
								</tr>
								<tr>
									<td><strong>联系电话：</strong></td>
									<td id="info-phone"></td>
								</tr>
								<tr>
									<td><strong>雇佣日期：</strong></td>
									<td id="info-hiredate"></td>
								</tr>
								<tr>
									<td><strong>备注信息：</strong></td>
									<td><pre class="pre-scrollable" style="width:400px;height:210px;" id="info-note"></pre></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭窗口</button>
			</div>
		</div>
	</div>
</div>
