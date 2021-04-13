package kimmyeonghoe.cloth.service.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kimmyeonghoe.cloth.domain.user.User;
import kimmyeonghoe.cloth.domain.user.ValiCode;


public interface UserService {
	User chkUser(String userId, String userPw);
	void sendValiCode(ValiCode code,HttpServletRequest request, HttpServletResponse response);
	User getUser(String userId);
	String getId(String userId);
	String getEmail(String email);
	String getIdWithEmail(String email);
	int addUser(User user);
	int fixPw(String userId, String userPw);
	int fixEmail(String email, String userId);
	int fixContact(String contact, String userId);
	int fixAddress(String postcode, String address, String addressDetail,String userId);
}
