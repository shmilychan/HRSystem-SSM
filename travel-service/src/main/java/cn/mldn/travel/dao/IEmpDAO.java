package cn.mldn.travel.dao;

import java.util.List;
import java.util.Map;

import cn.mldn.travel.vo.Emp;
import cn.mldn.util.dao.IBaseDAO;

public interface IEmpDAO extends IBaseDAO<String, Emp> {
	/**
	 * 根据指定的雇员编号查询出所有的雇员信息
	 * @param ids 雇员编号
	 * @return 全部雇员信息
	 */
	public List<Emp> findAllByIds2(String ids) ;
	
	/**
	 * 根据差旅安排判断指定的雇员信息是否可用
	 * @param param 包含了差旅相关信息
	 * @return 如果该雇员可以安排差旅返回雇员信息，如果不能返回null
	 */
	public Emp findTravelById(Map<String,Object> param) ; 
	
	/**
	 * 根据指定的出差的编号信息，列出该出差任务所需要的所有雇员信息
	 * @param tid 出差编号
	 * @return 返回所有的出差人员信息
	 */
	public List<Emp> findAllByTravel(long tid) ;
	
	public List<Emp> findAllByDept(Map<String,Object> param) ;
	public Long getAllCountByDept(Map<String,Object> param) ;
	
	/**
	 * 根据差旅编号查询出发布此差旅信息的雇员
	 * @param tid 差旅编号
	 * @return 雇员信息
	 */
	public Emp findByTravel(long tid) ;
	
	/**
	 * 查询出所有指定编号的雇员信息
	 * @param eid 雇员编号
	 * @return 指定雇员信息
	 */
	public List<Emp> findAllByIds(Object eid[]) ;
	/**
	 * 进行locked字段的更新处理
	 * @param vo 主要需要的是用户编号以及用户的locked状态
	 * @return 更新成功返回true
	 */
	public boolean doUpdateLocked(Emp vo) ; 
	
	/**
	 * 更新一个雇员对应的级别处理
	 * @param vo 雇员信息
	 * @return 更新成功返回true
	 */
	public boolean doUpdateLevel(Emp vo) ;
	
	/*
	 * 查询出所有的部门的领导信息
	 */
	public List<Emp> findAllManager() ;
}
