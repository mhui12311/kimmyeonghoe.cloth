package kimmyeonghoe.cloth.service.purchase;

import java.util.List;

import kimmyeonghoe.cloth.domain.purchase.Purchase;

public interface PurchaseService {
	Purchase getHistory(String userId);
	List<Purchase> gettPchsItems(String userId);
	List<Purchase> getClothNames(String userId);
	int purchaseCloth(Purchase purchase);
	int purchaseCloth2(Purchase purchase);
}
