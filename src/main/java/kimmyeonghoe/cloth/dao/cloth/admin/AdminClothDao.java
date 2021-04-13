package kimmyeonghoe.cloth.dao.cloth.admin;

import java.util.List;

import kimmyeonghoe.cloth.domain.cloth.Cloth;

public interface AdminClothDao {
	List<Cloth> selectCloths();
	int insertCloth(Cloth cloth);
	int updateCloth(Cloth cloth);
	int deleteCloth(int clothNum);
	Cloth searchCloth(int clothNum);
}
