package kimmyeonghoe.cloth.dao.map.cloth;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimmyeonghoe.cloth.domain.cloth.Cloth;

public interface ClothMap {
	List<Cloth> selectCloths();
	List<Cloth> searchClothWithKeyword(@Param("keyword") String keyword);
	int insertCloth(Cloth cloth);
	int updateCloth(Cloth cloth);
	int deleteCloth(int clothNum);
	Cloth searchCloth(int clothNum);
	int purchaseCloth(int clothNum, int purQuantity);
}
