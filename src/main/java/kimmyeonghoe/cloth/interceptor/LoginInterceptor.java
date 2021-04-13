package kimmyeonghoe.cloth.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kimmyeonghoe.cloth.common.Log;

public class LoginInterceptor implements HandlerInterceptor {
   @Override
   @Log
   public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView mv) throws Exception{
	   try {
		   HttpSession session = request.getSession();
		   ModelMap modelMap = mv.getModelMap();
		   Object user = modelMap.get("user");
		   Object admin = modelMap.get("admin");
		   
		   if(admin != null) {
			   session.setAttribute("login", admin);
			   savedIdCookie(request, response);
			   maintainLogin(request, response);
		   }
		   if(user != null) {
			   session.setAttribute("login", user);
			   savedIdCookie(request, response);
			   maintainLogin(request, response);
		   }
	   } catch(Exception e) {
	   }
   }
   
   public void savedIdCookie(HttpServletRequest request, HttpServletResponse response) {
	   String chkRemember = request.getParameter("rememberId");
	   
	   if(chkRemember != null) {
		   Cookie loginCookie = new Cookie("loginCookie", request.getParameter("userId"));
		   loginCookie.setPath(request.getContextPath()+"/");
		   loginCookie.setMaxAge(30);
		   
		   response.addCookie(loginCookie);
	   }
   }
   
   public void maintainLogin(HttpServletRequest request, HttpServletResponse response) {
	   Cookie loginStateCookie = new Cookie("loginState", "logined");
	   loginStateCookie.setPath(request.getContextPath()+"/");
	   loginStateCookie.setMaxAge(600);
	   
	   response.addCookie(loginStateCookie);
   }
   @Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	   HttpSession session = request.getSession();
	   if(session.getAttribute("login") != null) {
		   session.removeAttribute("login");
	   }
	   return true;
	}
}