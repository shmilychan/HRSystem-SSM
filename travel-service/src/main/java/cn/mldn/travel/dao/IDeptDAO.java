package cn.mldn.travel.dao;

import cn.mldn.travel.vo.Dept;
import cn.mldn.util.dao.IBaseDAO;

public interface IDeptDAO extends IBaseDAO<Long, Dept> {
	/**
	 * 更新一个部门对应的领导信息
	 * @param vo 部门信息
	 * @return 更新成功返回true
	 */
	public boolean doUpdateManager(Dept vo) ;
}
