package kimmyeonghoe.cloth.dao.map.question;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimmyeonghoe.cloth.domain.question.Question;

public interface QuestionMap {
	List<Question> selectQuestions();
	int insertQuestion(Question question);
	int updateAnswer(Question question);
	int updateQuestion(Question question);
	int deleteQuestion(int questionNum);
	Question selectQuestion(@Param("questionNum") int questionNum);
}
