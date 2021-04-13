package kimmyeonghoe.cloth.service.cloth;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.dao.cloth.ClothDao;
import kimmyeonghoe.cloth.domain.cloth.Cloth;

@Service("clothService")
public class ClothServiceImpl implements ClothService {
	@Autowired private ClothDao clothDao;
	
	@Override
	public List<Cloth> getCloths() {
		return clothDao.selectCloths();
	}
	
	
	@Override
	public List<Cloth> searchClothWithKeyword(String keyword) {
		return clothDao.searchClothWithKeyword(keyword);
	}

	@Override
	public Cloth findCloth(int clothNum) {
		return clothDao.searchCloth(clothNum);
	}
	
}
