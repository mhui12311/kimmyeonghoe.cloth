package kimmyeonghoe.cloth.web.cloth.admin;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import kimmyeonghoe.cloth.domain.cloth.Cloth;
import kimmyeonghoe.cloth.service.cloth.admin.AdminClothService;

@RestController("kimmyeonghoe.cloth.web.cloth.admin")
@RequestMapping("admin/cloth")
public class AdminClothController{
	@Autowired private AdminClothService clothService;
	
	@GetMapping("/clothList")
	public ModelAndView clothListAddr(ModelAndView mv) {
		mv.setViewName("admin/cloth/clothList");
		return mv;
	}
	
	@GetMapping("/insert")
	public ModelAndView clothInsertAddr(ModelAndView mv) {
		mv.setViewName("admin/cloth/insert");
		return mv;
	}
	
	@GetMapping("/update")
	public ModelAndView clothFixAddr(ModelAndView mv) {
		mv.setViewName("admin/cloth/update");
		return mv;
	}
		
	@GetMapping("/list")
	public List<Cloth> getCloths() {
		return clothService.getCloths();
	}
	
	@PostMapping("/add")
	public boolean addCloth(@RequestBody Cloth cloth) {
		return clothService.addCloth(cloth);
	}
	
	@PutMapping("/fix") 
	public boolean fixCloth(@RequestBody Cloth cloth) {
		return clothService.fixCloth(cloth);
	}
	
	@DeleteMapping("/del/{clothNum}")
	public boolean delCloth(@PathVariable int clothNum) {
		return clothService.delCloth(clothNum);
	}
	
	@PostMapping("/find/{clothNum}")
	public void findCloth(HttpServletRequest request, @PathVariable int clothNum) {
		HttpSession session = request.getSession();
		session.setAttribute("clothNum", clothNum);
	}
	
	@GetMapping("/find")
	public Cloth findCloth(HttpServletRequest request) {
		HttpSession session = request.getSession();
		int clothNum = Integer.parseInt(String.valueOf(session.getAttribute("clothNum")));
		return clothService.findCloth(clothNum);
	}
}
