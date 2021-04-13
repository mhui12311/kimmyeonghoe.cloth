package kimmyeonghoe.cloth.service.notice;

import java.util.List;

import kimmyeonghoe.cloth.domain.notice.AdminNotice;

public interface AdminNoticeService {
	List<AdminNotice> getNotices();
	int addNotice(AdminNotice notice);
	int fixNotice(AdminNotice notice);
	int delNotice(int noticeNum);
}
