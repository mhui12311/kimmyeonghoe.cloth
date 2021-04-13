package kimmyeonghoe.cloth.domain.logo;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Logo {
	private int logoNum;
	private String logoName;
	private String storedName;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate regDate;
	private int imageNum;
}
