package cn.mldn.travel.service.back;

import java.util.Map;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;

import cn.mldn.travel.vo.Travel;
import cn.mldn.travel.vo.TravelCost;
import cn.mldn.travel.vo.TravelEmp;

public interface ITravelServiceBack {
	/**
	 * 进行定时调度更新
	 * @return 更新结果
	 */
	public boolean editTask() ;
	
	/**
	 * 要取得指定出差的所有雇员信息
	 * @param tid 出差编号
	 * @return 包含有如下数据返回：<br>
	 * 1、key = allEmps、value = 全部的出差员工信息；<br>
	 * 2、key = allDepts、value = 所有的部门信息；<br>
	 * 3、key = allLevels、value = 所有级别；<br>
 	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:self"}, logical = Logical.OR)
	public Map<String,Object> getTravelEmp(long tid) ;
	
	/**
	 * 取得指定雇员的所有出差信息 
	 * @param eid 雇员编号
	 * @param currentPage 页
	 * @param lineSize 行
	 * @param column 列
	 * @param keyWord 关键字
	 * @return 返回如下数据内容：<br>
	 * 1、key = allTravels、value = 出差项；<br>
	 * 2、key = allRecorders、value = 雇员的个数。
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:self"}, logical = Logical.OR)
	public Map<String,Object> listByEmp(String eid,long currentPage,int lineSize,String column,String keyWord) ;
	
	
	/**
	 * 查看一个出产申请的详情信息
	 * @param tid 出差编号
	 * @return 返回有如下的信息内容：<br>
	 * 1、key = allLevels、value = 所有的级别信息；<br>
	 * 2、key = allDepts、value = 所有的部门信息；<br>
	 * 3、key = allEmps、value = 所有的出差人员的信息；<br>
	 * 4、key = allCosts、value = 所有的出差费用信息；<br>
	 * 5、key = travel、value = 出差单信息。<br>
	 * 6、key = allTypes、value = 所有的差旅费用分类；<br>
	 * 7、key = allItems、value = 全部出差类型。
	 */
	public Map<String,Object> getDetailsShow(long tid) ;
	
	/**
	 * 查询所有已经通过的申请单信息
	 * @param currentPage 当前页
	 * @param lineSize 每页行
	 * @param column 模糊列
	 * @param keyWord 关键字
	 * @return 返回有如下的信息：<br>
	 * 1、key = allTravels、value = 所有通过的申请单；<br>
	 * 2、key = allDepts、value = 所有部门信息；<br>
	 * 3、key = allEmps、value = 所有发布的雇员信息。
	 */
	@RequiresRoles(value = {"travelaudit"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travelaudit:list"}, logical = Logical.OR)
	public Map<String,Object> listPass(long currentPage,int lineSize,String column,String keyWord) ;
	
	/**
	 * 进行出差申请单的审核处理操作
	 * @param vo 申请单的更新信息
	 * @return 成功返回true
	 */
	public boolean editAudti(Travel vo) ;
	
	/**
	 * 查看一个出产申请的详情信息
	 * @param tid 出差编号
	 * @return 返回有如下的信息内容：<br>
	 * 1、key = allLevels、value = 所有的级别信息；<br>
	 * 2、key = allDepts、value = 所有的部门信息；<br>
	 * 3、key = allEmps、value = 所有的出差人员的信息；<br>
	 * 4、key = allCosts、value = 所有的出差费用信息；<br>
	 * 5、key = travel、value = 出差单信息。<br>
	 * 6、key = allTypes、value = 所有的差旅费用分类；<br>
	 * 7、key = allItems、value = 全部出差类型。
	 */
	public Map<String,Object> getDetailsAudit(long tid) ;
	
	/**
	 * 进行所有待审核的出差单列表
	 * @param currentPage 当前页
	 * @param lineSize 每页行
	 * @param column 模糊列
	 * @param keyWord 关键字
	 * @return 包含有如下的返回信息：<br>
	 * 1、key = allTravels、value = 全部的申请单；<br>
	 * 2、key = allRecorders、value = 全部等待的申请单数量。
	 */
	@RequiresRoles(value = { "travelaudit" }, logical = Logical.OR)
	@RequiresPermissions(value = { "travelaudit:list" }, logical = Logical.OR)
	public Map<String,Object> listPrepare(long currentPage,int lineSize,String column,String keyWord) ;
	
	/**
	 * 进行出差单的申请提交，该提交要执行如下处理：<br>
	 * 1、要根据tid取得全部出差的雇员信息，目的是为了统计出个数；
	 * 2、要查询全部的出差费用信息，进行费用的计算；
	 * 3、要设置提交日期、审核状态、总费用、总人数
	 * @param tid
	 * @return 提交成功返回true
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:submit"}, logical = Logical.OR)
	public boolean editSubmit(long tid) ;
	
	/**
	 * 实现出差费用项的添加操作
	 * @param vo 出差费用信息
	 * @return 返回如下信息结果：<br>
	 * 1、key = status、value = 保存成功或失败的标记；<br>
	 * 2、key = cost、value = 出差信息项；<br>
	 * 3、key = type、value = 出差信息分类。<br>
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:edit"}, logical = Logical.OR)
	public Map<String,Object> addCost(TravelCost vo) ;
	/**
	 * 删除指定的费用信息
	 * @param tcid 费用编号
	 * @return 成功返回true
	 */
	public boolean deleteCost(long tcid) ;
	
	/**
	 * 列出指定出差申请单的所有费用信息
	 * @param tid 出差申请单
	 * @return 返回如下内容：<br>
	 * 1、key = allTypes、value = 所有费用分类；<br>
	 * 2、key = allCosts、value = 所有的支出信息。
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:edit"}, logical = Logical.OR)
	public Map<String,Object> listCost(long tid) ;
	
	/**
	 * 删除指定的出差人员信息
	 * @param vo 包括有出差编号、待选的雇员编号
	 * @return 删除成功返回true
	 */
	public boolean deleteTravelEmp(TravelEmp vo) ;
	
	/**
	 * 进行出差待选人员的配置
	 * @param vo 包括有出差编号、待选的雇员编号
	 * @return 返回的结果包含有如下信息：<br>
	 * 1、key = status、value = 是否增加成功的标记（true、false）<br>
	 * 2、key = emp、value = 新增雇员的信息；<br>
	 * 3、key = dept、value = 雇员所在的部门信息；<br>
	 * 4、key = level、value = 级别信息。<br>
	 */
	public Map<String,Object> addTravelEmp(TravelEmp vo) ;
	
	/**
	 * 进行出差人员配置的信息加载处理 
	 * @param tid 本次编辑的差旅信息编号
	 * @param did 部门编号
	 * @param currentPage 页
	 * @param lineSize 行
	 * @param column 列
	 * @param keyWord 关键字
	 * @return 返回如下数据内容：<br>
	 * 1、key = allEmps、value = 所有的雇员信息；<br>
	 * 2、key = allRecorders、value = 雇员的个数。
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:edit"}, logical = Logical.OR)
	public Map<String,Object> listByDept(long tid,long did,long currentPage,int lineSize,String column,String keyWord) ;
	
	/**
	 * 根据指定的出差编号列出该出差操作中所有的员工信息以及所有的部门信息
	 * @param tid 差旅编号 
	 * @return 返回如下数据：<br>
	 * 1、key = allDepts、value = 所有的部门信息；
	 * 2、key = emp、value = 出差发布者的雇员信息
	 * 3、key = allEmps、value = 所有待出差者信息；
	 * 4、key = allLevels、value = 所有级别信息。
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:edit"}, logical = Logical.OR)
	public Map<String,Object> listEmp(long tid) ;
	
	/**
	 * 删除指定的差旅信息项
	 * @param vo 要删除的差旅信息
	 * @return 删除成功返回true
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:delete"}, logical = Logical.OR)
	public boolean delete(Travel vo) ;
	
	/**
	 * 进行出差申请单填写的处理，能修改的申请单申请状态只能是9
	 * @param tid 要修改的申请单编号
	 * @return 包含有如下的返回结果：<br>
	 * 1、key = allItems、value = 所有的出差分类；<br>
	 * 2、key = travel、value = 单个申请单
	 */
	@RequiresRoles(value = { "travel" }, logical = Logical.OR)
	@RequiresPermissions(value = { "travel:edit" }, logical = Logical.OR)
	public Map<String,Object> editPre(Long tid) ;
	/**
	 * 出差填写，结束日期应该在开始日期之后处理
	 * @param vo 出差单信息
	 * @return 成功返回true
	 */
	@RequiresRoles(value = { "travel" }, logical = Logical.OR)
	@RequiresPermissions(value = { "travel:edit" }, logical = Logical.OR)
	public boolean edit(Travel vo) ;
	
	/**
	 * 进行所有个人申请单的列表显示
	 * @param seid 当前的经理信息
	 * @param currentPage 当前页
	 * @param lineSize 每页行
	 * @param column 模糊列
	 * @param keyWord 关键字
	 * @return 返回如下的数据内容：<br>
	 * 1、key = allTravles、value = 全部的出差列表；<br>
	 * 2、key = allRecorders、value = 出差单个数。
	 */
	@RequiresRoles(value = {"travel"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travel:self"}, logical = Logical.OR)
	public Map<String,Object> listSelf(String seid,long currentPage,int lineSize,String column,String keyWord) ;
	
	/**
	 * 进行出差申请单填写的处理
	 * @return 包含有如下的返回结果：<br>
	 * 1、key = allItems、value = 所有的出差分类；<br>
	 */
	@RequiresRoles(value = { "travel" }, logical = Logical.OR)
	@RequiresPermissions(value = { "travel:add" }, logical = Logical.OR)
	public Map<String,Object> addPre() ;
	/**
	 * 出差填写，结束日期应该在开始日期之后处理
	 * @param vo 出差单信息
	 * @return 成功返回true
	 */
	@RequiresRoles(value = { "travel" }, logical = Logical.OR)
	@RequiresPermissions(value = { "travel:add" }, logical = Logical.OR)
	public boolean add(Travel vo) ;
}
