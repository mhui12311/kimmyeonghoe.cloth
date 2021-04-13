package kimmyeonghoe.cloth.service.user;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.common.Log;
import kimmyeonghoe.cloth.dao.user.UserDao;
import kimmyeonghoe.cloth.domain.user.User;
import kimmyeonghoe.cloth.domain.user.ValiCode;

@Service
public class UserServiceImpl implements UserService {
	@Autowired private UserDao userDao;
	@Autowired private JavaMailSender mailSender;

	@Override
	@Log
	public User chkUser(String userId, String userPw) {
		return userDao.login(userId, userPw);
	}
	
	@Override
	public User getUser(String userId) {
		return userDao.selectUser(userId);
	}
	
	@Override
	public String getId(String userId) {
		return userDao.selectId(userId);
	}
	
	@Override
	public String getEmail(String email) {
		return userDao.selectEmail(email);
	}
	
	@Override
	public String getIdWithEmail(String email) {
		return userDao.selectIdWithEmail(email);
	}
	
	@Override
	public int addUser(User user) {
		return userDao.insertUser(user);
	}
	
	@Override
	@Log
	public int fixPw(String userId, String userPw) {
		return userDao.updatePw(userId, userPw);
	}
	
	@Override
	public int fixEmail(String email, String userId) {
		return userDao.updateEmail(email, userId);
	}


	@Override
	public int fixContact(String contact, String userId) {
		return userDao.updateContact(contact, userId);
	}

	@Override
	public int fixAddress(String postcode, String address, String addressDetail, String userId) {
		return userDao.updateAddress(postcode, address, addressDetail, userId);
	}

	@Override
	public void sendValiCode(ValiCode code,HttpServletRequest request, HttpServletResponse response) {
		String to = code.getTo();
		String subject = code.getSubject();
		String textUp = code.getTextUp();
		String textDown = code.getTextDown();
		int valicode = (int) ((Math.random())*900000+100000);
		String text = textUp+valicode+textDown;
		HttpSession session = request.getSession();
		session.setAttribute("valicode", valicode);
		
		MimeMessage msg = mailSender.createMimeMessage();
		
		try {
			msg.addRecipient(RecipientType.TO, new InternetAddress(to));
			msg.setSubject(subject);
			msg.setText(text,"utf-8","html");
		} catch(Exception e) {}
		
		mailSender.send(msg);
		
	}
}
