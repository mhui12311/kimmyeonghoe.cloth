package kimmyeonghoe.cloth.web.logo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kimmyeonghoe.cloth.service.logo.LogoService;

@Controller("kimmyeonghoe.cloth.admin.logo.web")
@RequestMapping("/admin/logo")
public class LogoController {
	@Autowired private LogoService logoService; 
	
	@Value("${attachDir}") 
	private String attachDir; //파일경로
	
	@GetMapping("/logo")
	public String main() {
		return "admin/logo/logo";
	}
	
	@PostMapping("/attach") @ResponseBody //ResponseBody : restController는 기본적으로 포함되어 붙여줄 필요가 없었다.
	public boolean uploadFile(MultipartFile attachFile, HttpServletRequest request) {
		boolean isStored = false;
		
		String dir = attachDir;
		String originalFileName = attachFile.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String newFileName = uid+"_"+originalFileName;
		int fileSize = (int) attachFile.getSize();
		
		try {
			save(dir + "/" + newFileName, attachFile);
			int result = logoService.addImage(originalFileName, newFileName, fileSize);
			if(result != 0) isStored = true;
			logoService.addLogo(originalFileName, newFileName); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return isStored;
	}
	
	@ResponseBody
	@RequestMapping(value="/load", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String readFile() {
		String result = "";
		String fileName = logoService.getLogoName();
		if(fileName != null) {
			result = fileName;
		}
		return result;
	}
	@ResponseBody
	@PostMapping("/getNum")
	public int getNum() {
		return logoService.getLogoNum();
	}
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST, produces = "application/text; charset=utf8")
	public String deleteFile(@RequestParam("logoNum") int logoNum) {
		String result = "";
		String storedName = logoService.getStoredName(logoNum);
		String toDelFile = attachDir +"/"+ storedName;
		int resultDelLogo = logoService.delLogo(logoNum);
		int resultDelImage = logoService.delImage(logoNum);
		if(resultDelImage == 1 && resultDelLogo == 1) {
			
			File file = new File(toDelFile);
			file.delete();
			result = "deleted";
		}
		
		return result;
	}
	private void save(String fileName, MultipartFile attachFile) throws IOException{
		attachFile.transferTo(new File(fileName));;
	}
}
