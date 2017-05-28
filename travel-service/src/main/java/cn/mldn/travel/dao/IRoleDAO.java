package cn.mldn.travel.dao;

import java.util.Set;

import cn.mldn.travel.vo.Role;
import cn.mldn.util.dao.IBaseDAO;

public interface IRoleDAO extends IBaseDAO<String, Role> {
	/**
	 * 根据雇员编号查询所有的角色编号（角色id）
	 * @param eid 雇员id
	 * @return 所有的角色标记信息
	 */
	public Set<String> findAllIdByEmp(String eid) ;
}
