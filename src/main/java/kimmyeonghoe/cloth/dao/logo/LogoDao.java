package kimmyeonghoe.cloth.dao.logo;

public interface LogoDao {
	int insertImage(String fileName, String storedName, int fileSize);
	int insertLogo(String logoName, String storedName);
	String selectLogoName();
	String selectStoredName(int logoNum);
	int deleteImage(int imageNum);
	int deleteLogo(int logoNum);
	int selectlogoNum();
}
