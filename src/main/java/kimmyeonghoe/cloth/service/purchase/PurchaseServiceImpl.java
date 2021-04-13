package kimmyeonghoe.cloth.service.purchase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.dao.purchase.PurchaseDao;
import kimmyeonghoe.cloth.domain.purchase.Purchase;

@Service
public class PurchaseServiceImpl implements PurchaseService{
	@Autowired PurchaseDao purchaseDao;

	@Override
	public Purchase getHistory(String userId) {
		return purchaseDao.selectHistory(userId);
	}

	@Override
	public List<Purchase> gettPchsItems(String userId) {
		return purchaseDao.selectPchsItems(userId);
	}

	@Override
	public List<Purchase> getClothNames(String userId) {
		return purchaseDao.selectClothNames(userId);
	}

	@Override
	public int purchaseCloth(Purchase purchase) {
		return purchaseDao.insertPurchase(purchase);
	}

	@Override
	public int purchaseCloth2(Purchase purchase) {
		return purchaseDao.insertCloPur(purchase);
	}
}
