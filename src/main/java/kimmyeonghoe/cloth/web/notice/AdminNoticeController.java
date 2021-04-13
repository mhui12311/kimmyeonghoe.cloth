package kimmyeonghoe.cloth.web.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kimmyeonghoe.cloth.domain.notice.AdminNotice;
import kimmyeonghoe.cloth.service.notice.AdminNoticeService;

@Controller
@RequestMapping("/admin/notice")
public class AdminNoticeController {
	@Autowired private AdminNoticeService noticeService;
	
	@RequestMapping("/list")
	public String getListAddr() {
		return "admin/notice/list";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public List<AdminNotice> getList(){
		return noticeService.getNotices();
	}
	
	@PostMapping("/add")
	public int addNotice(@RequestBody AdminNotice notice) {
		return noticeService.addNotice(notice);
	}
	
	@PutMapping("/fix")
	public int fixNotice(@RequestBody AdminNotice notice) {
		return noticeService.fixNotice(notice);
	}
	
	@DeleteMapping("/del/{noticeNum}")
	public int delNotice(@PathVariable int noticeNum) {
		return noticeService.delNotice(noticeNum);
	}
}
