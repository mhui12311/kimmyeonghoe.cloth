package kimmyeonghoe.cloth.web.cloth;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import kimmyeonghoe.cloth.domain.cloth.Cloth;
import kimmyeonghoe.cloth.service.cloth.ClothService;

@Controller("kimmyeonghoe.cloth.web.cloth")
@RequestMapping("cloth")
public class ClothController {
	@Autowired private ClothService clothService;
	
	@GetMapping("/clothList")
	public ModelAndView clothListAddr(ModelAndView mv) {
		mv.setViewName("cloth/clothList");
		return mv;
	}
	
	@ResponseBody
	@GetMapping("/list")
	public List<Cloth> getCloths() {
		return clothService.getCloths();
	}
	
	@ResponseBody
	@GetMapping("/clothDetail/find")
	public Cloth findCloth(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int clothNum = Integer.parseInt(String.valueOf(session.getAttribute("clothNum")));
		return clothService.findCloth(clothNum);
	}
	
	@GetMapping("/clothDetail/{clothNum}")
	public ModelAndView clothDetailAddr(ModelAndView mv, HttpServletRequest request, @PathVariable int clothNum) {
		HttpSession session = request.getSession();
		session.setAttribute("clothNum", clothNum);
		
		System.out.println("session clothNum : "+ session.getAttribute("clothNum") );
		
		mv.setViewName("cloth/clothDetail");
		return mv;
	}
	
	@ResponseBody
	@PostMapping("/clothDetail/purchase/{purQuantity}")
	public void purchaseCloth(HttpServletRequest request, @PathVariable int purQuantity) {
		HttpSession session = request.getSession();
		session.setAttribute("purQuantity", purQuantity);
	}
	
	@RequestMapping("/searchCloth")
	public String searchClothAddr() {
		return "/cloth/searchCloth";
	}
	
	@ResponseBody
	@PostMapping("/saveKeyword")
	public void saveKeyword(@RequestParam("keyword") String keyword, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("keyword", keyword);
	}
	
	@ResponseBody
	@PostMapping("/searchCloth")
	public List<Cloth> showSearchResult(HttpServletRequest request){
		HttpSession session = request.getSession();
		String keyword = (String) session.getAttribute("keyword");
		List<Cloth> result = clothService.searchClothWithKeyword(keyword);
		
		return result;
	}
}
