package kimmyeonghoe.cloth.dao.purchase;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimmyeonghoe.cloth.domain.purchase.Purchase;

public interface PurchaseDao {
	Purchase selectHistory(String userId);
	List<Purchase> selectPchsItems(String userId);
	List<Purchase> selectClothNames(String userId);
	int insertPurchase(Purchase purchase);
	int insertCloPur(Purchase purchase);
}
