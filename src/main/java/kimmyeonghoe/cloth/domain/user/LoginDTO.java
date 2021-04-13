package kimmyeonghoe.cloth.domain.user;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor //기본 생성자
@AllArgsConstructor //parameter 생성자
public class LoginDTO {
	private String userId;
	private String userPw;
	//private boolean userCookie;
}
