package cn.mldn.util.action.abs;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.context.MessageSource;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

public abstract class AbstractBaseAction {
	@Resource
	private MessageSource messageSource;

	public Set<String> handleStringIds(String ids) {
		Set<String> set = new HashSet<String>();
		String result[] = ids.split(",");
		for (int x = 0; x < result.length; x++) {
			set.add(result[x]);
		}
		return set;
	}

	public Set<Long> handleLongIds(String ids) {
		Set<Long> set = new HashSet<Long>();
		String result[] = ids.split(",");
		for (int x = 0; x < result.length; x++) {
			set.add(Long.parseLong(result[x]));
		}
		return set;
	}

	public String getEid() {
		return SecurityUtils.getSubject().getPrincipal().toString();
	}
	public void setUrlAndMsg(HttpServletRequest request, String urlKey,
			String msgKey, Object... arg) {
		request.setAttribute("msg", this.getMsg(msgKey, arg));
		request.setAttribute("url", this.getMsg(urlKey));
	}

	public void print(HttpServletResponse response, Object val) {
		response.setCharacterEncoding("UTF-8");
		try {
			response.getWriter().print(val);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public String getUrl(String key) {
		return this.getMsg(key);
	}

	public String getMsg(String key, Object... args) {
		try {
			return this.messageSource.getMessage(key, args, null);
		} catch (Exception e) {
			return null;
		}
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) { // 在本程序里面需要针对于日期格式进行处理
		// 首先建立一个可以将字符串转换为日期的工具程序类
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 明确的描述此时需要注册一个日期格式的转化处理程序类
		binder.registerCustomEditor(java.util.Date.class,
				new CustomDateEditor(sdf, true));
	}
}
