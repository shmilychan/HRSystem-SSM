package cn.mldn.travel.service.back;

import java.util.Map;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;

import cn.mldn.travel.vo.Dept;
import cn.mldn.travel.vo.Emp;

public interface IDeptServiceBack {
	/**
	 * 进行部门领导的降级处理操作，降级的领导具备的级别是“staff”，在进行降级处理的时候一定要考虑到当前用户的级别
	 * 只有人事部经理具备有降级的处理操作（使用的注解就表示是人事部门），但是当前人员的级别需要根据ineid（编辑者）查询
	 * 需要调用IEmpDAO.findById()方法查询当前编辑者的详细信息（判断级别）
	 * 级别如果符合于修改者要求，则进行部门的领导的删除以及雇员的级别的变更。
	 * 本处只需要根据部门编号就可以找到部门的原始的领导编号，原始的领导编号确定之后就可以修改雇员信息
	 * @param did 要修改的部门信息，里面包含有部门的编号信息
	 * @param ineid 修改者的雇员编号
	 * @return 修改成功返回true
	 */
	@RequiresRoles(value = {"emp"}, logical = Logical.OR)
	@RequiresPermissions(value = {"dept:edit","emp:edit"}, logical = Logical.AND)
	public boolean editLevel(Long did,String ineid);
	
	@RequiresRoles(value = {"emp"}, logical = Logical.OR)
	@RequiresPermissions(value = {"dept:edit"}, logical = Logical.OR)
	public boolean edit(Dept vo);
	/**
	 * 列出全部的部门的完整信息
	 * @return 返回的集合包含有如下数据：<br>
	 *         1、key = allDepts、value = 所有的部门信息集合；<br>
	 *         2、key = allEmps、value = 部门的所有领导信息集合。<br>
	 */
	@RequiresRoles(value = {"emp", "empshow"}, logical = Logical.OR)
	@RequiresPermissions(value = {"dept:list",
			"deptshow:list"}, logical = Logical.OR)
	public Map<String, Object> list();
}
