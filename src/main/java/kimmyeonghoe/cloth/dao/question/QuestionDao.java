package kimmyeonghoe.cloth.dao.question;

import java.util.List;

import kimmyeonghoe.cloth.domain.question.Question;

public interface QuestionDao {
	List<Question> selectQuestions();
	int insertQuestion(Question question);
	int updateAnswer(Question question);
	int updateQuestion(Question question);
	int deleteQuestion(int questionNum);
	Question selectQuestion(int questionNum);
}
