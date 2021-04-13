package kimmyeonghoe.cloth.service.logo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.dao.logo.LogoDao;

@Service
public class LogoServiceImpl implements LogoService{
	@Autowired private LogoDao logoDao;
	@Override
	public int addImage(String fileName, String storedName, int fileSize) {
		return logoDao.insertImage(fileName, storedName, fileSize);
	}
	
	@Override
	public int addLogo(String logoName, String storedName) {
		return logoDao.insertLogo(logoName, storedName);
	}

	@Override
	public String getLogoName() {
		return logoDao.selectLogoName();
	}
	
	@Override
	public int getLogoNum() {
		return logoDao.selectlogoNum();
	}

	@Override
	public String getStoredName(int logoNum) {
		return logoDao.selectStoredName(logoNum);
	}

	@Override
	public int delImage(int imageNum) {
		return logoDao.deleteImage(imageNum);
	}

	@Override
	public int delLogo(int logoNum) {
		return logoDao.deleteLogo(logoNum);
	}
}
