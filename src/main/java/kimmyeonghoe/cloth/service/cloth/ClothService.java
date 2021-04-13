package kimmyeonghoe.cloth.service.cloth;

import java.util.List;

import kimmyeonghoe.cloth.domain.cloth.Cloth;

public interface ClothService {
	List<Cloth> getCloths();
	List<Cloth> searchClothWithKeyword(String keyword);
	Cloth findCloth(int itemNum);
}
