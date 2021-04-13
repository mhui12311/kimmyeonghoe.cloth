package kimmyeonghoe.cloth.dao.map.logo;

import org.apache.ibatis.annotations.Param;

public interface LogoMap {
	int insertImage(@Param("fileName") String fileName, @Param("storedName") String storedName, @Param("fileSize") int fileSize);
	int insertLogo(@Param("logoName") String logoName, @Param("storedName") String storedName);
	String selectLogoName();
	String selectStoredName(@Param("logoNum") int logoNum);
	int deleteImage(@Param("imageNum") int imageNum);
	int deleteLogo(@Param("logoNum") int logoNum);
	int selectlogoNum();
}
