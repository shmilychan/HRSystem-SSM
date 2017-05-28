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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cn.mldn.travel.exception.DeptManagerExistException;
import cn.mldn.travel.exception.LevelNotEnoughException;
import cn.mldn.travel.service.back.IEmpServiceBack;
import cn.mldn.travel.vo.Dept;
import cn.mldn.travel.vo.Emp;
import cn.mldn.travel.vo.Level;
import cn.mldn.util.action.abs.AbstractBaseAction;
import cn.mldn.util.enctype.PasswordUtil;
import cn.mldn.util.split.ActionSplitPageUtil;
import cn.mldn.util.web.FileUtils;
import net.sf.json.JSONObject;

@Controller
@RequestMapping("/pages/back/admin/emp/*")
public class EmpActionBack extends AbstractBaseAction {
	private static final String FLAG = "雇员";

	@Resource
	private IEmpServiceBack empServiceBack;

	@RequestMapping("add_check")
	@RequiresUser
	@RequiresRoles("emp")
	@RequiresPermissions("emp:add")
	public ModelAndView check(HttpServletResponse response, String eid) {
		super.print(response, this.empServiceBack.getEid(eid) == null);
		return null;
	}

	@RequestMapping("add_pre")
	@RequiresUser
	@RequiresRoles("emp")
	@RequiresPermissions("emp:add")
	public ModelAndView addPre() {
		ModelAndView mav = new ModelAndView(super.getUrl("emp.add.page"));
		mav.addAllObjects(this.empServiceBack.getAddPre());
		return mav;
	}

	@RequestMapping("add")
	@RequiresUser
	@RequiresRoles("emp")
	@RequiresPermissions("emp:add")
	public ModelAndView add(Emp vo, MultipartFile pic,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(super.getUrl("back.forward.page"));
		FileUtils fileUtil = null;
		vo.setIneid(super.getEid()); // 通过Session取得当前操作者的雇员编号
		vo.setPassword(PasswordUtil.getPassword(vo.getPassword())); // 密码加密处理
		if (!pic.isEmpty()) { // 如果说现在文件有上传
			fileUtil = new FileUtils(pic);
			vo.setPhoto(fileUtil.createFileName()); // 把生成的文件名称保存在VO类之中
		}
		try {
			if (this.empServiceBack.add(vo)) {
				if (fileUtil != null) { // 准备上传文件
					fileUtil.saveFile(request, "upload/member/", vo.getPhoto());
				}
				super.setUrlAndMsg(request, "emp.add.action", "vo.add.success",
						FLAG);
			} else {
				super.setUrlAndMsg(request, "emp.add.action", "vo.add.failure",
						FLAG);
			}
		} catch (DeptManagerExistException e) { // emp.add.dept.mgr.failure
			super.setUrlAndMsg(request, "emp.add.action",
					"emp.add.dept.mgr.failure");
		}
		return mav;
	}

	@RequestMapping("edit_pre")
	@RequiresUser
	@RequiresRoles("emp")
	@RequiresPermissions("emp:edit")
	public ModelAndView editPre(String eid) {
		ModelAndView mav = new ModelAndView(super.getUrl("emp.edit.page"));
		mav.addAllObjects(this.empServiceBack.getEditPre(eid));
		return mav;
	}

	@RequestMapping("edit")
	@RequiresUser
	@RequiresRoles("emp")
	@RequiresPermissions("emp:edit")
	public ModelAndView edit(Emp vo, MultipartFile pic,
			HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(super.getUrl("back.forward.page"));
		FileUtils fileUtil = null;
		vo.setIneid(super.getEid()); // 通过Session取得当前操作者的雇员编号
		if (!(vo.getPassword() == null || "".equals(vo.getPassword()))) { // 要修改密码
			vo.setPassword(PasswordUtil.getPassword(vo.getPassword())); // 密码加密处理
		} else {
			vo.setPassword(null); // “”字符串问题
		}
		if (!pic.isEmpty()) { // 如果说现在文件有上传
			fileUtil = new FileUtils(pic);
			if ("nophoto.png".equals(vo.getPhoto())) { // 原始没有图片名称
				vo.setPhoto(fileUtil.createFileName()); // 把生成的文件名称保存在VO类之中
			}
		}
		try {
			if (this.empServiceBack.edit(vo)) {
				if (fileUtil != null) { // 准备上传文件
					fileUtil.saveFile(request, "upload/member/", vo.getPhoto());
				}
				super.setUrlAndMsg(request, "emp.list.action",
						"vo.edit.success", FLAG);
			} else {
				super.setUrlAndMsg(request, "emp.list.action",
						"vo.edit.failure", FLAG);
			}
		} catch (DeptManagerExistException e) { // emp.add.dept.mgr.failure
			super.setUrlAndMsg(request, "emp.list.action",
					"emp.add.dept.mgr.failure");
		} catch (LevelNotEnoughException e) { // level.not.enough.failure
			super.setUrlAndMsg(request, "emp.list.action",
					"level.not.enough.failure");
		}
		return mav;
	}

	@RequestMapping("get")
	@RequiresUser
	@RequiresRoles(value = {"emp", "empshow"}, logical = Logical.OR)
	@RequiresPermissions(value = {"emp:get",
			"empshow:get"}, logical = Logical.OR)
	public ModelAndView get(String eid, HttpServletResponse response) {
		Map<String, Object> map = this.empServiceBack.getDetails(eid);
		JSONObject obj = new JSONObject();
		obj.put("emp", map.get("emp"));
		obj.put("dept", map.get("dept"));
		obj.put("level", map.get("level"));
		super.print(response, obj);
		return null;
	}

	@RequestMapping("list")
	@RequiresUser
	@RequiresRoles(value = {"emp", "empshow"}, logical = Logical.OR)
	@RequiresPermissions(value = {"emp:list",
			"empshow:list"}, logical = Logical.OR)
	public ModelAndView list(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(super.getUrl("emp.list.page"));
		ActionSplitPageUtil aspu = new ActionSplitPageUtil(request,
				"雇员编号:eid|雇员姓名:ename|联系电话:phone",
				super.getMsg("emp.list.action"));
		Map<String, Object> map = this.empServiceBack.list(
				aspu.getCurrentPage(), aspu.getLineSize(), aspu.getColumn(),
				aspu.getKeyWord());
		mav.addAllObjects(map); // 把内容交给request属性范围
		List<Dept> allDepts = (List<Dept>) map.get("allDepts");
		List<Level> allLevels = (List<Level>) map.get("allLevels");
		Map<Long, String> deptMap = new HashMap<Long, String>();
		Iterator<Dept> iter = allDepts.iterator();
		while (iter.hasNext()) {
			Dept dept = iter.next();
			deptMap.put(dept.getDid(), dept.getDname());
		}
		Map<String, String> levelMap = new HashMap<String, String>();
		Iterator<Level> iter2 = allLevels.iterator();
		while (iter2.hasNext()) {
			Level lev = iter2.next();
			levelMap.put(lev.getLid(), lev.getTitle());
		}
		mav.addObject("allDepts", deptMap); // 属性名称一样会出现覆盖
		mav.addObject("allLevels", levelMap); // 属性名称一样会出现覆盖
		return mav;
	}

	@RequestMapping("delete")
	@RequiresUser
	@RequiresRoles("emp")
	@RequiresPermissions("emp:delete")
	public ModelAndView delete(String ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(super.getUrl("back.forward.page"));
		if (this.empServiceBack.delete(super.handleStringIds(ids),super.getEid())) {
			super.setUrlAndMsg(request, "emp.list.action", "vo.delete.success",
					FLAG);
		} else {
			super.setUrlAndMsg(request, "emp.list.action", "vo.delete.failure",
					FLAG);
		}
		return mav;
	}
}
