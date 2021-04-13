package kimmyeonghoe.cloth.dao.map.purchase;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimmyeonghoe.cloth.domain.purchase.Purchase;

public interface PurchaseMap {
	Purchase selectHistory(@Param("userId") String userId);
	List<Purchase> selectPchsItems(@Param("userId") String userId);
	List<Purchase> selectClothNames(@Param("userId") String userId);
	int insertPurchase(Purchase purchase);
	int insertCloPur(Purchase purchase);
}
