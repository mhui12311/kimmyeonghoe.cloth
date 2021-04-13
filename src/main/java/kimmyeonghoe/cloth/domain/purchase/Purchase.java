package kimmyeonghoe.cloth.domain.purchase;

import java.time.LocalDate;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Purchase {
	private int purchaseNum;
	private int cloPurNum;
	private int clothNum;
	private int price;
	private int deliveryFee;
	@JsonFormat(pattern="yyyy-MM-dd", timezone="Asia/Seoul")
	private LocalDate purchaseDate;
	private String deliveryState;
	private String userId;
	private int purchaseAmount;
	private int totalPrice;
	
}
