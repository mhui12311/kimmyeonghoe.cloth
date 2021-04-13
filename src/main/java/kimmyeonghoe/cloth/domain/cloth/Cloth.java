package kimmyeonghoe.cloth.domain.cloth;


import java.time.LocalDate;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Cloth {
	private int clothNum;
	private String clothName;
	private String kind;
	private int price;
	private LocalDate regDate;
	private String content;
	private String imageName;
	private String displayState;
	private String clothLevel;
	private String color;
	private String clothSize;
	private int quantity;
	private String keyword;
	private int purchaseAmount;
}
