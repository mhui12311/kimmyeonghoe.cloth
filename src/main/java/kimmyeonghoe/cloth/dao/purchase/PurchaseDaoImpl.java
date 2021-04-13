package kimmyeonghoe.cloth.dao.purchase;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimmyeonghoe.cloth.dao.map.purchase.PurchaseMap;
import kimmyeonghoe.cloth.domain.purchase.Purchase;

@Repository
public class PurchaseDaoImpl implements PurchaseDao{
	@Autowired private PurchaseMap purchaseMap;

	@Override
	public Purchase selectHistory(String userId) {
		return purchaseMap.selectHistory(userId);
	}

	@Override
	public List<Purchase> selectPchsItems(String userId) {
		return purchaseMap.selectPchsItems(userId);
	}

	@Override
	public List<Purchase> selectClothNames(String userId) {
		return purchaseMap.selectClothNames(userId);
	}

	@Override
	public int insertPurchase(Purchase purchase) {
		return purchaseMap.insertPurchase(purchase);
	}

	@Override
	public int insertCloPur(Purchase purchase) {
		return purchaseMap.insertCloPur(purchase);
	}
	
}
