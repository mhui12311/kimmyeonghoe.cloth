package kimmyeonghoe.cloth.dao.user;

import kimmyeonghoe.cloth.domain.user.User;

public interface UserDao {
	User login(String userId, String userPw);
	String selectId(String userId);
	String selectIdWithEmail(String email);
	String selectEmail(String email);
	User selectUser(String userId);
	int insertUser(User user);
	int updatePw(String userId, String userPw);
	int updateEmail(String email, String userId);
	int updateContact(String contact, String userId);
	int updateAddress(String postcode, String address, String addressDetail,String userId);
}
