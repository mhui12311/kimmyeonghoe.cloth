package kimmyeonghoe.cloth.dao.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimmyeonghoe.cloth.dao.map.user.UserMap;
import kimmyeonghoe.cloth.domain.user.User;


@Repository
public class UserDaoImpl implements UserDao{
	@Autowired private UserMap userMap;

	@Override
	public User login(String userId, String userPw) {
		return userMap.login(userId, userPw);
	}
	
	@Override
	public User selectUser(String userId) {
		return userMap.selectUser(userId);
	}
	
	@Override
	public String selectId(String userId) {
		return userMap.selectId(userId);
	}
	
	@Override
	public String selectEmail(String email) {
		return userMap.selectEmail(email);
	}
	
	@Override
	public String selectIdWithEmail(String email) {
		return userMap.selectIdWithEmail(email);
	}
	
	@Override
	public int insertUser(User user) {
		return userMap.insertUser(user);
	}

	@Override
	public int updatePw(String userId, String userPw) {
		return userMap.updatePw(userId, userPw);
	}
	
	@Override
	public int updateEmail(String email, String userId) {
		return userMap.updateEmail(email, userId);
	}

	@Override
	public int updateContact(String contact, String userId) {
		return userMap.updateContact(contact, userId);
	}

	@Override
	public int updateAddress(String postcode, String address, String addressDetail, String userId) {
		return userMap.updateAddress(postcode, address, addressDetail, userId);
	}
}
