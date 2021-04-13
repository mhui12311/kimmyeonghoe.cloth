package kimmyeonghoe.cloth.service.cloth.admin;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.dao.cloth.admin.AdminClothDao;
import kimmyeonghoe.cloth.domain.cloth.Cloth;

@Service("admin.clothService")
public class AdminClothServiceImpl implements AdminClothService {
	@Autowired private AdminClothDao clothDao;
	
	@Override
	public List<Cloth> getCloths() {
		return clothDao.selectCloths();
	}

	@Override
	public boolean addCloth(Cloth cloth) {
		return clothDao.insertCloth(cloth) > 0;
	}

	@Override
	public boolean fixCloth(Cloth cloth) {
		return clothDao.updateCloth(cloth) > 0;
	}

	@Override
	public boolean delCloth(int clothNum) {
		return clothDao.deleteCloth(clothNum) > 0;
	}
	
	@Override
	public Cloth findCloth(int clothNum) {
		return clothDao.searchCloth(clothNum);
	}
}
