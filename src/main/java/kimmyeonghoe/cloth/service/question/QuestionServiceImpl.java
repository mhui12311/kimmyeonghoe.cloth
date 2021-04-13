package kimmyeonghoe.cloth.service.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.dao.question.QuestionDao;
import kimmyeonghoe.cloth.domain.question.Question;

@Service
public class QuestionServiceImpl implements QuestionService {
	@Autowired private QuestionDao questionDao;
	
	@Override
	public List<Question> getQuestions() {
		return questionDao.selectQuestions();
	}

	@Override
	public int addQuestion(Question question) {
		return questionDao.insertQuestion(question);
	}
	
	@Override
	public int fixQuestion(Question question) {
		return questionDao.updateQuestion(question);
	}

	@Override
	public int answerQuestion(Question question) {
		return questionDao.updateAnswer(question);
	}

	@Override
	public int delQuestion(int questionNum) {
		return questionDao.deleteQuestion(questionNum);
	}

	@Override
	public Question getQuestion(int questionNum) {
		return questionDao.selectQuestion(questionNum);
	}
}
