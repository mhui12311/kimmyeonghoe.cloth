package kimmyeonghoe.cloth.dao.cloth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimmyeonghoe.cloth.dao.map.cloth.ClothMap;
import kimmyeonghoe.cloth.domain.cloth.Cloth;

@Repository("clothDao")
public class ClothDaoImpl implements ClothDao {
	@Autowired private ClothMap clothMap;
	
	@Override
	public List<Cloth> selectCloths() {
		return clothMap.selectCloths();
	}
	
	
	@Override
	public List<Cloth> searchClothWithKeyword(String keyword) {
		return clothMap.searchClothWithKeyword(keyword);
	}

	@Override
	public Cloth searchCloth(int clothNum) {
		return clothMap.searchCloth(clothNum);
	}
}
