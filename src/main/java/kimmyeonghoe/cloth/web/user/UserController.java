package kimmyeonghoe.cloth.web.user;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kimmyeonghoe.cloth.common.Log;
import kimmyeonghoe.cloth.domain.user.LoginDTO;
import kimmyeonghoe.cloth.domain.user.User;
import kimmyeonghoe.cloth.domain.user.ValiCode;
import kimmyeonghoe.cloth.service.user.UserService;

@Controller("kimmyeonghoe.cloth.web.user")
@RequestMapping("/user")
public class UserController{
	@Autowired private UserService userService;
	
	@RequestMapping("/login")
	public String login(LoginDTO loginDTO, @CookieValue(required=false) Cookie loginCookie) {
		if(loginCookie != null) loginDTO.setUserId(loginCookie.getValue());
		return "user/login";
	}
	
	@PostMapping("/login")
	public void loginchk(@Valid @RequestParam("userId") String userId, @RequestParam("userPw") String userPw, Model model, HttpServletRequest request){
		HttpSession session = request.getSession();
		User user = userService.chkUser(userId, userPw);
		session.setAttribute("userId", user.getUserId());
		if(user.getUserId().equals("admin")) {
			model.addAttribute("admin",user);
		}else {
			model.addAttribute("user",user);
		}
	}
	@ResponseBody
	@RequestMapping("/idChk")
	public String idChk(@RequestParam("userId") String userId, HttpServletRequest request, HttpServletResponse response) {
		String result = userService.getId(userId);
		if(result == null) result = "";
		
		return result;
	}
	
	@RequestMapping("/join")
	public String join(User user) {
		return "user/join";
	}
	
	@PostMapping("/join")
	public void joinUser(@RequestBody User user, Model model, HttpServletRequest request, HttpServletResponse response){
		String email = user.getEmail();
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		
		Cookie joinCookie = new Cookie("joinCookie", email);
		joinCookie.setPath(request.getContextPath()+"/user/joinEmail");
		joinCookie.setMaxAge(200);
		
		response.addCookie(joinCookie);
	}
	
	@RequestMapping("/joinEmail")
	public String joinEmailAddr() {
		return "user/joinEmail";
	}
	
	@PostMapping("/joinEmail")
	public void joinEmail(@RequestBody ValiCode valiCode, @CookieValue(required=false) Cookie joinCookie, HttpServletRequest request, HttpServletResponse response) {
		String to = joinCookie.getValue();
		valiCode.setTo(to);
		userService.sendValiCode(valiCode, request, response);
	}
	
	@RequestMapping("/joinSuccess")
	public String joinSuccessAddr() {
		return "uset/joinSuccess";
	}
	
	@GetMapping("/joinSuccess")
	public void joinSuccess(HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		userService.addUser(user);
	}
	
	@RequestMapping("/joinFail")
	public String joinFailAddr() {
		return "uset/joinSuccess";
	}
	
	@GetMapping("/joinFail")
	public void joinFail() {
		
	}
	
	@GetMapping("/logout")
	@Log
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/user/login";
	}
	
	@RequestMapping("/findId")
	public String findIdAddr() {
		return "user/findId";
	}
	
	@ResponseBody
	@PostMapping("/findId")
	public String getIdWithEmail(@RequestBody ValiCode valiCode,HttpServletRequest request, HttpServletResponse response) {
		String email = valiCode.getTo();
		String result = userService.getIdWithEmail(email);
		
		if(result != null) {
			Cookie loginCookie = new Cookie("loginCookie", result);
			loginCookie.setPath(request.getContextPath()+"/user/login");
			loginCookie.setMaxAge(300);
			response.addCookie(loginCookie);
		}
		return result;
	}
	
	@ResponseBody
	@PostMapping("/compareCode")
	public String compareCode(@RequestBody ValiCode valiCode, HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		int code = valiCode.getCode();
		HttpSession session = request.getSession();
		int sessionCode = (int) session.getAttribute("valicode");
		if(code == sessionCode) result="success";
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/compareEmail")
	public String compareEmail(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		String result = "";
		String email = user.getEmail();
		
		String dbEmail = userService.getEmail(email);
		if(!email.equals(dbEmail)) result="success";
		return result;
	}
	
	@PostMapping("/sendMail")
	public void findId(@RequestBody ValiCode valiCode,HttpServletRequest request, HttpServletResponse response) {
		userService.sendValiCode(valiCode, request, response);
	}
	
	@RequestMapping("/findPw")
	public String findPwAddr() {
		return "user/findPw";
	}
	
	@RequestMapping("/changePw")
	public String changePwAddr() {
		return "user/changePw";
	}
	
	@PostMapping("/changePw")
	public void saveId(@RequestBody User user, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.getAttribute("userId");
		
		if(user.getUserId() != null) {
			session.setAttribute("userId", user.getUserId());
		}
	}
	
	@PostMapping("/changePw2")
	public void changePw(@RequestParam("userPw") String userPw, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		if(userId != null) {
			userService.fixPw(userId, userPw);
		}
	}
	
	@ResponseBody
	@PostMapping("/changeEmail")
	public void changeEmail(HttpServletRequest request, @RequestBody User user) {
		String email = user.getEmail();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		userService.fixEmail(email, userId);
	}
	
	@ResponseBody
	@PostMapping("/changeContact")
	public void changeContact(HttpServletRequest request, @RequestBody User user) {
		String contact = user.getContact();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		userService.fixContact(contact, userId);
	}
	
	@ResponseBody
	@PostMapping("/changeAddress")
	public void changeAddr(HttpServletRequest request, @RequestBody User user) {
		String postcode = user.getPostcode();
		String address = user.getAddress();
		String addressDetail = user.getAddressDetail();
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		userService.fixAddress(postcode, address, addressDetail, userId);
	}
	
	@RequestMapping("/userDetail")
	public String getUserDetailAddr() {
		return "user/userDetail";
	}
	
	@ResponseBody
	@PostMapping("/userDetail")
	public User getDetail(HttpServletRequest request, @CookieValue(required=false) Cookie loginState){
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		return userService.getUser(userId);
	}
}
