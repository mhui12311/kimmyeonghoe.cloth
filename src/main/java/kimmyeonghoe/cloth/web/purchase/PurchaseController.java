package kimmyeonghoe.cloth.web.purchase;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kimmyeonghoe.cloth.domain.purchase.Purchase;
import kimmyeonghoe.cloth.service.purchase.PurchaseService;


@Controller("kimmyeonghoe.cloth.purchase.web")
@RequestMapping("/purchase")
public class PurchaseController {
	@Autowired PurchaseService purchaseService;
	
	@RequestMapping("/insertInfo")
	public String getInfoAddr() {
		return "purchase/insertInfo";
	}
	
	@RequestMapping("/purchaseHistory")
	public String getHistoryAddr() {
		return "purchase/purchaseHistory";
	}
	
	@ResponseBody
	@PostMapping("/insertInfo")
	public int insertInfo(@RequestBody Purchase purchase, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int clothNum = (int) session.getAttribute("clothNum");
		String userId = (String) session.getAttribute("userId");
		purchase.setClothNum(clothNum);
		purchase.setUserId(userId);
		
		int result = 0;
		result = purchaseService.purchaseCloth(purchase);
		if(result != 0) {
			System.out.println("테이블에 데이터를 입력했습니다.");
		}
		return result;
	}
	
	@ResponseBody
	@PostMapping("/insertInfo2")
	public int insertInfo2(@RequestBody Purchase purchase, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int clothNum = (int) session.getAttribute("clothNum");
		String userId = (String) session.getAttribute("userId");
		purchase.setClothNum(clothNum);
		purchase.setUserId(userId);
		
		int result = 0;
		result = purchaseService.purchaseCloth(purchase);
		if(result != 0) {
			System.out.println("테이블에 데이터를 입력했습니다.");
		}
		return result;
	}
	
	@ResponseBody
	@PostMapping("/detailPurchase")
	public void setPurchase(HttpServletRequest request, @RequestParam("purchaseAmount") int amount) {
		HttpSession session = request.getSession();
		session.setAttribute("purchase", 1);
		session.setAttribute("purchaseAmount", amount);
	}
	
	@ResponseBody
	@PostMapping("/cartPurchase")
	public void setPurchase2(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("purchase", 2);
	}
	
	@ResponseBody
	@PostMapping("/getPurType")
	public int getPurType(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int result = (int) session.getAttribute("purchase");
		return result;
	}
	
	@ResponseBody
	@PostMapping("/getPurAmount")
	public int getPurAmount(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int result = (int) session.getAttribute("purchaseAmount");
		return result;
	}
	
	@ResponseBody
	@PostMapping("/purchaseHistory")
	public Purchase getHistory(HttpServletRequest request){
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		Purchase result = purchaseService.getHistory(userId);
		return result;
	}
	
	@ResponseBody
	@PostMapping("/clothNames")
	public List<Purchase> getClothNames(HttpServletRequest request){
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		List<Purchase> cloths = purchaseService.getClothNames(userId);
		
		return cloths;
	}
	
	@RequestMapping("/success")
	public String successAddr() {
		return "/purchase/success";
	}
}
