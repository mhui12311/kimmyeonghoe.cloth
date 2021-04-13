package kimmyeonghoe.cloth.service.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimmyeonghoe.cloth.dao.notice.AdminNoticeDao;
import kimmyeonghoe.cloth.domain.notice.AdminNotice;

@Service
public class AdminNoticeServiceImpl implements AdminNoticeService{
	@Autowired private AdminNoticeDao noticeDao;

	@Override
	public List<AdminNotice> getNotices() {
		return noticeDao.selectNotices();
	}

	@Override
	public int addNotice(AdminNotice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int fixNotice(AdminNotice notice) {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int delNotice(int noticeNum) {
		return noticeDao.deleteNotice(noticeNum);
	}
}
