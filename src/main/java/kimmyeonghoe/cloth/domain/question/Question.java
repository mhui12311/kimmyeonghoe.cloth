package kimmyeonghoe.cloth.domain.question;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Question {
	private int questionNum;
	private String title;
	private String content;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate regDate;
	private String answerContent;
	private String userId;
}
