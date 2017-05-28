package cn.mldn.travel.action;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginAction {
	@RequestMapping("/loginPage")
	public ModelAndView loginPage() {
		ModelAndView mav = new ModelAndView("login") ;
		return mav ;
	}
}
