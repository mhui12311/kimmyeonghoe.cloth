package kimmyeonghoe.cloth.web.question.admin;

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

@Controller("kimmyeonghoe.cloth.web.question.admin")
@RequestMapping("admin/question")
public class AdminQuestionController{
	@Autowired private QuestionService questionService;
	
	@RequestMapping("/list")
	public String getListAddr() {
		return "admin/question/list";
	}

	@RequestMapping("/answer")
	public String getfixAddr() {
		return "admin/question/answer";
	}

	@RequestMapping("/find")
	public String getfindAddr() {
		return "admin/question/find";
	}
	
	@ResponseBody
	@PostMapping("/list")
	public List<Question> getList() {
		return questionService.getQuestions();
	}
	
	@GetMapping("/find?questionNo={questionNum}")
	public void findQuestionAddr() {
		
	}
	
	@GetMapping("/answer?questionNo={questionNum}")
	public void fixQuestionAddr() {
		
	}
	
	@ResponseBody
	@PostMapping("/find")
	public Question findQuestion(@RequestBody Question question, HttpServletRequest request) {
		HttpSession session = request.getSession();
		int questionNum = question.getQuestionNum();
		session.setAttribute("questionNum", questionNum);
		
		return questionService.getQuestion(questionNum);
	}
	
	@ResponseBody
	@PostMapping("/answer")
	public int answerQuestion(@RequestBody Question question) {
		return questionService.answerQuestion(question);
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
}
