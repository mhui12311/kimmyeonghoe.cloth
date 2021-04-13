package kimmyeonghoe.cloth.dao.notice;

import java.util.List;

import kimmyeonghoe.cloth.domain.notice.AdminNotice;

public interface AdminNoticeDao {
	List<AdminNotice> selectNotices();
	int insertNotice(AdminNotice notice);
	int updateNotice(AdminNotice notice);
	int deleteNotice(int noticeNum);
}
