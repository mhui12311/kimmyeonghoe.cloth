package kimmyeonghoe.cloth.dao.map.user;

import org.apache.ibatis.annotations.Param;

import kimmyeonghoe.cloth.domain.user.User;


public interface UserMap {
	User login(@Param("userId") String userId, @Param("userPw") String userPw);
	int insertUser(User user);
	String selectId(@Param("userId") String userId);
	String selectEmail(@Param("email") String email);
	String selectIdWithEmail(@Param("email") String email);
	int updatePw(@Param("userId") String userId, @Param("userPw") String userPw);
	int updateEmail(@Param("email") String email, @Param("userId") String userId);
	int updateContact(@Param("contact") String contact, @Param("userId") String userId);
	int updateAddress(@Param("postcode") String postcode, @Param("address") String address, @Param("addressDetail") String addressDetail,@Param("userId") String userId);
	User selectUser(@Param("userId") String userId);
}
