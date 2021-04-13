package kimmyeonghoe.cloth.dao.question;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimmyeonghoe.cloth.dao.map.question.QuestionMap;
import kimmyeonghoe.cloth.domain.question.Question;

@Repository
public class QuestionDaoImpl implements QuestionDao{
	@Autowired private QuestionMap questionMap;
	
	@Override
	public List<Question> selectQuestions() {
		return questionMap.selectQuestions();
	}
	
	@Override
	public int insertQuestion(Question question) {
		return questionMap.insertQuestion(question);
	}
	
	@Override
	public int updateQuestion(Question question) {
		return questionMap.updateQuestion(question);
	}
	
	
	@Override
	public int updateAnswer(Question question) {
		return questionMap.updateAnswer(question);
	}

	@Override
	public int deleteQuestion(int questionNum) {
		return questionMap.deleteQuestion(questionNum);
	}

	@Override
	public Question selectQuestion(int questionNum) {
		return questionMap.selectQuestion(questionNum);
	}
}
