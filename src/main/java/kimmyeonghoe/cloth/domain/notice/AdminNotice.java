package kimmyeonghoe.cloth.domain.notice;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminNotice {
	private int noticeNum;
	private String title;
	private String content;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate regDate;
}
