package kimmyeonghoe.cloth.dao.logo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimmyeonghoe.cloth.dao.map.logo.LogoMap;

@Repository
public class LogoDaoImpl implements LogoDao {
	@Autowired private LogoMap logoMap;

	@Override
	public int insertImage(String fileName, String storedName, int fileSize) {
		return logoMap.insertImage(fileName, storedName, fileSize);
	}

	@Override
	public int insertLogo(String logoName, String storedName) {
		return logoMap.insertLogo(logoName, storedName);
	}

	@Override
	public String selectLogoName() {
		return logoMap.selectLogoName();
	}
	
	@Override
	public String selectStoredName(int logoNum) {
		return logoMap.selectStoredName(logoNum);
	}
	
	@Override
	public int selectlogoNum() {
		return logoMap.selectlogoNum();
	}

	@Override
	public int deleteImage(int imageNum) {
		return logoMap.deleteImage(imageNum);
	}

	@Override
	public int deleteLogo(int logoNum) {
		return logoMap.deleteLogo(logoNum);
	}
}
