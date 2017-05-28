package cn.mldn.travel.dao;

import java.util.Set;

import cn.mldn.travel.vo.Action;
import cn.mldn.util.dao.IBaseDAO;

public interface IActionDAO extends IBaseDAO<String, Action> {
	/**
	 * 根据雇员编号查询该雇员对应的所有权限标记（权限id）
	 * @param eid 雇员编号
	 * @return 全部权限标记信息
	 */
	public Set<String> findAllIdByEmp(String eid) ;
}
