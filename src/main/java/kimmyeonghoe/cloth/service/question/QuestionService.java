package kimmyeonghoe.cloth.service.question;

import java.util.List;

import kimmyeonghoe.cloth.domain.question.Question;

public interface QuestionService {
	List<Question> getQuestions();
	int addQuestion(Question question);
	int answerQuestion(Question question);
	int fixQuestion(Question question);
	int delQuestion(int questionNum);
	Question getQuestion(int questionNum);
}
