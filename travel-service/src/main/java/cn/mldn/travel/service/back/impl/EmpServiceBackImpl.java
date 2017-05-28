package cn.mldn.travel.service.back.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import cn.mldn.travel.dao.IActionDAO;
import cn.mldn.travel.dao.IDeptDAO;
import cn.mldn.travel.dao.IEmpDAO;
import cn.mldn.travel.dao.ILevelDAO;
import cn.mldn.travel.dao.IRoleDAO;
import cn.mldn.travel.exception.DeptManagerExistException;
import cn.mldn.travel.exception.LevelNotEnoughException;
import cn.mldn.travel.service.back.IEmpServiceBack;
import cn.mldn.travel.service.back.abs.AbstractService;
import cn.mldn.travel.vo.Dept;
import cn.mldn.travel.vo.Emp;

@Service
public class EmpServiceBackImpl extends AbstractService
		implements
			IEmpServiceBack {
	@Resource
	private IEmpDAO empDAO;
	@Resource
	private IRoleDAO roleDAO;
	@Resource
	private IActionDAO actionDAO;
	@Resource
	private ILevelDAO levelDAO;
	@Resource
	private IDeptDAO deptDAO;

	@Override
	public boolean delete(Set<String> eids, String heid) {
		// 取得当前的操作者的雇员完整信息
		Emp humanEmp = this.empDAO.findById(heid);
		// 1、查询出所有要删除的雇员信息
		List<Emp> allEmp = this.empDAO.findAllByIds(eids.toArray());
		// 2、遍历出所有要进行删除的数据信息，检查是否存在有领导信息
		Iterator<Emp> iter = allEmp.iterator();
		int count = 0 ;
		while (iter.hasNext()) {
			Emp emp = iter.next();
			emp.setIneid(heid); 	// 设置操作者的eid信息
			if ("manager".equals(emp.getLid())) { // 该操作为领导
				if (emp.getEid().equals(heid)) {
					continue ;
				}
				if ("manager".equals(humanEmp.getLid())) {
					Dept dept = new Dept();
					dept.setDid(emp.getDid()); // 当前雇员所在的部门
					emp.setLid("staff");
					if (this.empDAO.doUpdateLevel(emp)) { // 先进行领导讲解
						if (this.deptDAO.doUpdateManager(dept)) { // 更新部门的领导信息
							emp.setLocked(2); // 逻辑删除位
							this.empDAO.doUpdateLocked(emp);
						}
					}
				}
			} else if ("chief".equals(emp.getLid())) {
				continue;
			} else {
				emp.setLocked(2); // 逻辑删除位
				this.empDAO.doUpdateLocked(emp);
			}
			count ++ ;
		}
		return eids.size() == count;
	}

	@Override
	public Map<String, Object> getEditPre(String eid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allDepts", this.deptDAO.findAll());
		map.put("allLevels", this.levelDAO.findAll());
		map.put("emp", this.empDAO.findById(eid));
		return map;
	}
	@Override
	public boolean edit(Emp vo)
			throws DeptManagerExistException, LevelNotEnoughException {
		// 1、取得当前操作者的信息，主要的目的是为了判断它的级别
		Emp humanEmp = this.empDAO.findById(vo.getIneid());
		// 如果现在要修改的雇员信息原本为经理，而且当前的修改者的级别不是经理，那么不能够修改
		Emp oldEmp = this.empDAO.findById(vo.getEid()); // 取得原始数据信息
		if (oldEmp.getEid().equals(humanEmp.getEid())) {	// 自己不能够修改自己
			return false ;
		}
		if ("manager".equals(oldEmp.getLid())) { // 如果其原本是一个经理
			if (!"manager".equals(humanEmp.getLid())) { // 修改者不是经理
				// 应该抛出一个异常，表示没有足够的级别
				throw new LevelNotEnoughException("您不具备有该级别用户的操作权限！");
			}
			// 如果现在发现部门没有改变，但是现在其领导的级别变为了员工
			if ("staff".equals(vo.getLid())
					|| oldEmp.getDid().equals(vo.getDid())) { // 原始为领导，现在为员工
				Dept newDept = new Dept();
				newDept.setDid(oldEmp.getDid()); // 原始部门编号
				this.deptDAO.doUpdateManager(newDept); // 删除原始的部门的领导的编号
				return this.empDAO.doUpdate(vo); // 直接修改员工信息
			}
			// 现在要更换部门领导，就需要判断要更换目标部门是否存在有领导
			if ("manager".equals(vo.getLid())
					|| (!oldEmp.getDid().equals(vo.getDid()))) {
				Dept dDept = this.deptDAO.findById(vo.getDid());
				if (dDept.getEid() != null) { // 要更换的部门存在有领导
					// 应该抛出一个异常，表示没有足够的级别
					throw new LevelNotEnoughException("您不具备有该级别用户的操作权限！");
				} else { // 如果现在该部门没有领导
					dDept.setEid(vo.getEid()); // 设置为新的部门领导编号
					if (this.deptDAO.doUpdateManager(dDept)) {
						return this.empDAO.doUpdate(vo);
					}
				}
			}
		} else { // 如果现在是之前的用户级别为普通员工
			if ("manager".equals(humanEmp.getLid())) { // 操作者级别为manager
				if ("staff".equals(vo.getLid())) {
					return this.empDAO.doUpdate(vo);
				} else {
					Dept dept = this.deptDAO.findById(vo.getDid()); // 判断要处理的部门信息
					if (dept.getEid() == null) { // 该部门现在没有经理
						dept.setEid(vo.getEid()); // 新雇员为部门经理
						if (this.deptDAO.doUpdateManager(dept)) { // 没有更新领导
							return this.empDAO.doUpdate(vo);
						}
					} else {
						throw new DeptManagerExistException(
								"该部门已经有经理了，无法进行新任经理的添加！");
					}
				}
			} else {
				// 应该抛出一个异常，表示没有足够的级别
				throw new LevelNotEnoughException("您不具备有该级别用户的操作权限！");
			}
		}
		return false;
	}

	@Override
	public Map<String, Object> list(long currentPage, int lineSize,
			String column, String keyWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		// 之所以定义一个变量进行接收，主要的目的：对于数据查询和统计都需要使用到Map集合
		Map<String, Object> param = super.handleParam(currentPage, lineSize,
				column, keyWord);
		map.put("allEmps", this.empDAO.findAllSplit(param));
		map.put("allRecorders", this.empDAO.getAllCount(param));
		map.put("allDepts", this.deptDAO.findAll());
		map.put("allLevels", this.levelDAO.findAll());
		return map;
	}

	@Override
	public Emp getEid(String eid) {
		return this.empDAO.findById(eid);
	}

	@Override
	public boolean add(Emp vo) throws DeptManagerExistException {
		if (this.empDAO.findById(vo.getEid()) == null) { // 1、判断要追加的用户的id是否存在，如果存在则无法进行保存
			vo.setHiredate(new Date()); // 雇佣日期设置为当前日期
			vo.setLocked(0); // 新增加用户默认为活跃状态
			System.out.println(vo);
			// 2、判断当前操作者的级别以及所在的部门信息，就需要首先取得操作者的相关信息
			Emp humanEmp = this.empDAO.findById(vo.getIneid());
			if (humanEmp.getDid().equals(2L)) { // 判断当前的操作者是否是人事部门
				if ("staff".equals(vo.getLid())) { // 3、判断当前要追加的新雇员信息是否级别为普通员工
					return this.empDAO.doCreate(vo);
				} else { // 不是员工就是经理或总监
					if ("manager".equals(humanEmp.getLid())) { // 操作者级别为manager
						Dept dept = this.deptDAO.findById(vo.getDid()); // 判断要处理的部门信息
						if (dept.getEid() == null) { // 该部门现在没有经理
							if (this.empDAO.doCreate(vo)) { // 保存新用户
								dept.setEid(vo.getEid()); // 新雇员为部门经理
								return this.deptDAO.doUpdateManager(dept);
							}
						} else {
							throw new DeptManagerExistException(
									"该部门已经有经理了，无法进行新任经理的添加！");
						}
					}
				}
			}
		}
		return false;
	}

	@Override
	public Map<String, Object> getAddPre() {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("allDepts", this.deptDAO.findAll());
		map.put("allLevels", this.levelDAO.findAll());
		return map;
	}

	@Override
	public Map<String, Object> getDetails(String eid) {
		Map<String, Object> map = new HashMap<String, Object>();
		Emp emp = this.empDAO.findById(eid);
		if (emp != null) {
			map.put("dept", this.deptDAO.findById(emp.getDid()));
			map.put("level", this.levelDAO.findById(emp.getLid()));
		}
		map.put("emp", emp);
		return map;
	}

	@Override
	public Map<String, Object> get(String eid, String password) {
		Map<String, Object> map = new HashMap<String, Object>();
		Emp emp = this.empDAO.findById(eid);
		if (emp != null) {
			if (password.equals(emp.getPassword())) {
				map.put("level", this.levelDAO.findById(emp.getLid()));
			}
		}
		map.put("emp", emp);
		return map;
	}

	@Override
	public Map<String, Set<String>> listRoleAndAction(String eid) {
		Map<String, Set<String>> map = new HashMap<String, Set<String>>();
		map.put("allRoles", this.roleDAO.findAllIdByEmp(eid));
		map.put("allActions", this.actionDAO.findAllIdByEmp(eid));
		return map;
	}

}
