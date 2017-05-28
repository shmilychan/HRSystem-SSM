package cn.mldn.travel.action.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
/**
 * 在已有的Form认证授权器基础上扩展一个新的子类
 * @author mldn 
 */
public class CustomerFormAuthenticationFilter extends FormAuthenticationFilter {
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		// 1、如果要想取得在Session中出现的验证码，则必须取得HttpSession接口对象
		HttpServletRequest req = (HttpServletRequest) request ;
		HttpSession session = req.getSession() ;	// 取得当前的session对象
		String rand = (String) session.getAttribute("rand") ;	// 取得生成的验证码
		// 2、取得用户提交表单过来的验证码数据
		String code = request.getParameter("code") ;
		if (rand == null || code == null || "".equals(rand) || "".equals(code)) {
			request.setAttribute("code", "验证码不允许为空！");
			return true ;	// 拒绝访问，不再进行用户名或密码的检测
		} else {
			if (!code.equalsIgnoreCase(rand)) {	// 验证码输入错误
				request.setAttribute("code", "验证码输入错误！");
				return true ;
			}
		}
		return super.onAccessDenied(request, response) ; // 操作继续向后执行
	}
}