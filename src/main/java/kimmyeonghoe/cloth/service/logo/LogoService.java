package kimmyeonghoe.cloth.service.logo;

public interface LogoService {
	int addImage(String fileName, String storedName, int fileSize);
	int addLogo(String logoName, String storedName);
	String getLogoName();
	String getStoredName(int logoNum);
	int getLogoNum();
	int delImage(int imageNum);
	int delLogo(int logoNum);
}
