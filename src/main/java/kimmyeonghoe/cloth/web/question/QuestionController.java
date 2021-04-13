package kimmyeonghoe.cloth.web.question;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kimmyeonghoe.cloth.domain.question.Question;
import kimmyeonghoe.cloth.service.question.QuestionService;

@Controller("kimmyeonghoe.cloth.web.question")
@RequestMapping("/question")
public class QuestionController{
	@Autowired private QuestionService questionService;
	
	@RequestMapping("/list")
	public String getListAddr() {
		return "question/list";
	}

	@RequestMapping("/add")
	public String getAddAddr() {
		return "question/add";
	}

	@RequestMapping("/fix")
	public String getfixAddr() {
		return "question/fix";
	}

	@RequestMapping("/find")
	public String getfindAddr() {
		return "question/find";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public List<Question> getList() {
		return questionService.getQuestions();
	}
	
	@ResponseBody
	@PostMapping("/add")
	public int addQuestion(@RequestBody Question question, HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		question.setUserId(userId);
		int result = questionService.addQuestion(question);
		return result;
	}	
	
	@GetMapping("/find?questionNo={questionNum}")
	public void findQuestionAddr() {
		
	}
	
	@GetMapping("/fix?questionNo={questionNum}")
	public void fixQuestionAddr() {
		
	}
	
	@ResponseBody
	@PostMapping("/find")
	public Question findQuestion(@RequestBody Question question, HttpServletRequest request) {
		
		return questionService.getQuestion(question.getQuestionNum());
	}
	
	@ResponseBody
	@PostMapping("/fix")
	public int fixQuestion(@RequestBody Question question) {
		return questionService.fixQuestion(question);
	}
	
	@ResponseBody
	@PostMapping("/del/{questionNum}")
	public String delQuestion(@PathVariable int questionNum) {
		String result = "";
		if (questionService.delQuestion(questionNum) != 0) {
			result = "deleted";
		}		
		return result;
	}
	
	@ResponseBody
	@PostMapping("/getId")
	public String getId(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userId");
		
		return userId;
	}
}
