package kimmyeonghoe.cloth.dao.map.notice;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimmyeonghoe.cloth.domain.notice.AdminNotice;

public interface AdminNoticeMap {
	List<AdminNotice> selectNotices();
	int insertNotice(AdminNotice notice);
	int updateNotice(AdminNotice notice);
	int deleteNotice(@Param("noticeNum") int noticeNum);
}
