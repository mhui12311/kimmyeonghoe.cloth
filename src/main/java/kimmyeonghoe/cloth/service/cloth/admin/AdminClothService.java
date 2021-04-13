package kimmyeonghoe.cloth.service.cloth.admin;

import java.util.List;

import kimmyeonghoe.cloth.domain.cloth.Cloth;

public interface AdminClothService {
	List<Cloth> getCloths();
	boolean addCloth(Cloth cloth);
	boolean fixCloth(Cloth cloth);
	boolean delCloth(int clothNum);
	Cloth findCloth(int clothNum);
}
