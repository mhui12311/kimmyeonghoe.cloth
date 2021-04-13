package kimmyeonghoe.cloth.domain.user;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ValiCode {
	private String to;
	private String subject;
	private String textUp;
	private String textDown;
	private String phase;
	private String userId;
	private int code;
}
