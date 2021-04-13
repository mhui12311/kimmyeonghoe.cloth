package kimmyeonghoe.cloth.dao.cloth.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimmyeonghoe.cloth.dao.map.cloth.ClothMap;
import kimmyeonghoe.cloth.domain.cloth.Cloth;


@Repository("kimmyeonghoe.cloth.dao.cloth.admin")
public class AdminClothDaoImpl implements AdminClothDao{
	@Autowired private ClothMap clothMap;
	
	@Override
	public List<Cloth> selectCloths() {
		return clothMap.selectCloths();
	}
	
	@Override
	public int insertCloth(Cloth cloth) {
		return clothMap.insertCloth(cloth);
	}
	
	@Override
	public int updateCloth(Cloth cloth) {
		return clothMap.updateCloth(cloth);
	}
	
	@Override
	public int deleteCloth(int clothNum) {
		return clothMap.deleteCloth(clothNum);
	}
	
	@Override
	public Cloth searchCloth(int clothNum) {
		return clothMap.searchCloth(clothNum);
	}
}
