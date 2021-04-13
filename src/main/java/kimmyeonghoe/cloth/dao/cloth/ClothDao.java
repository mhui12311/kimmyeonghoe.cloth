package kimmyeonghoe.cloth.dao.cloth;

import java.util.List;

import kimmyeonghoe.cloth.domain.cloth.Cloth;

public interface ClothDao {
	List<Cloth> selectCloths();
	List<Cloth> searchClothWithKeyword(String keyword);
	Cloth searchCloth(int itemNum);
}
