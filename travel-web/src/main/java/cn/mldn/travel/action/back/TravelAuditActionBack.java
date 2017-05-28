package cn.mldn.travel.action.back;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.mldn.travel.service.back.ITravelServiceBack;
import cn.mldn.travel.vo.Dept;
import cn.mldn.travel.vo.Emp;
import cn.mldn.travel.vo.Travel;
import cn.mldn.util.ListToMapUtils;
import cn.mldn.util.action.abs.AbstractBaseAction;
import cn.mldn.util.split.ActionSplitPageUtil;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/pages/back/admin/travelaudit/*")
public class TravelAuditActionBack extends AbstractBaseAction {
	private static final String FLAG = "出差审核";
	@Resource
	private ITravelServiceBack travelServiceBack;

	@RequestMapping("list")
	@RequiresUser
	@RequiresRoles(value = {"travelaudit"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travelaudit:list"}, logical = Logical.OR)
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(
				super.getUrl("travelaudit.list.page"));
		ActionSplitPageUtil aspu = new ActionSplitPageUtil(request,
				"申请标题:title", super.getMsg("travelaudit.prepare.action"));
		Map<String, Object> map = this.travelServiceBack.listPass(
				aspu.getCurrentPage(), aspu.getLineSize(), aspu.getColumn(),
				aspu.getKeyWord());
		Map<String,Object> empMap = new HashMap<String,Object>() ;
		Iterator<Emp> iterEmp = ((List<Emp>)map.get("allEmps")).iterator() ;
		while (iterEmp.hasNext()) {
			Emp emp = iterEmp.next() ;
			empMap.put(emp.getEid(), emp) ;	// 方便比对
		}
		mav.addAllObjects(map) ;
		mav.addObject("allEmps", empMap) ;
		mav.addObject("allDepts", new ListToMapUtils<Long, String>("did", "dname")
				.converter((List<Dept>) map.get("allDepts"))) ;
		return mav;
	}
	
	@RequestMapping("show")
	@RequiresUser
	@RequiresRoles(value = {"travelaudit"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travelaudit:list"}, logical = Logical.OR)
	public ModelAndView show(HttpServletResponse response,long tid) {
		JSONObject obj = new JSONObject() ;
		obj.putAll(this.travelServiceBack.getDetailsShow(tid));
		super.print(response, obj);
		return null ;
	}

	@RequestMapping("prepare")
	@RequiresUser
	@RequiresRoles(value = {"travelaudit"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travelaudit:list"}, logical = Logical.OR)
	public ModelAndView prepare(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(
				super.getUrl("travelaudit.prepare.page"));
		ActionSplitPageUtil aspu = new ActionSplitPageUtil(request,
				"申请标题:title", super.getMsg("travelaudit.prepare.action"));
		mav.addAllObjects(this.travelServiceBack.listPrepare(
				aspu.getCurrentPage(), aspu.getLineSize(), aspu.getColumn(),
				aspu.getKeyWord()));
		return mav;
	}

	@RequestMapping("handle_pre")
	@RequiresUser
	@RequiresRoles(value = {"travelaudit"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travelaudit:handle"}, logical = Logical.OR)
	public ModelAndView handlePre(long tid) {
		ModelAndView mav = new ModelAndView(
				super.getUrl("travelaudit.handle.page"));
		Map<String, Object> map = this.travelServiceBack.getDetailsAudit(tid);
		System.out.println(map);
		mav.addAllObjects(map);
		mav.addObject("allDepts",
				new ListToMapUtils<Long, String>("did", "dname")
						.converter((List<Dept>) map.get("allDepts")));
		mav.addObject("allItems",
				new ListToMapUtils<Long, String>("iid", "title")
						.converter((List<Dept>) map.get("allItems")));
		mav.addObject("allLevels",
				new ListToMapUtils<String, String>("lid", "title")
						.converter((List<Dept>) map.get("allLevels")));
		mav.addObject("allTypes",
				new ListToMapUtils<Long, String>("tpid", "title")
						.converter((List<Dept>) map.get("allTypes")));
		return mav;
	}

	@RequestMapping("handle")
	@RequiresUser
	@RequiresRoles(value = {"travelaudit"}, logical = Logical.OR)
	@RequiresPermissions(value = {"travelaudit:handle"}, logical = Logical.OR)
	public ModelAndView handle(HttpServletRequest request, Travel vo) {
		ModelAndView mav = new ModelAndView(super.getUrl("back.forward.page"));
		vo.setAeid(super.getEid());
		if (this.travelServiceBack.editAudti(vo)) {
			super.setUrlAndMsg(request, "travelaudit.prepare.action",
					"travelaudit.handle.success");
		} else {
			super.setUrlAndMsg(request, "travelaudit.prepare.action",
					"travelaudit.handle.failure", FLAG);
		}
		return mav;
	}
}
