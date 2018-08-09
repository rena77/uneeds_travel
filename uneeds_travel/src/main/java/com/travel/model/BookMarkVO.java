package com.travel.model;

import java.util.Date;

public class BookMarkVO {
	
	int TourMembercode; // 로그인 한 사람 정보
	int contentid; // contentid로 여행 정보를 알 수 있어 추가
	Date bookmarktime; // 즐겨찾기 추가 한 시간
	
	//getter / setter
	public int getTourMembercode() {
		return TourMembercode;
	}
	public void setTourMembercode(int tourMembercode) {
		TourMembercode = tourMembercode;
	}
	public int getContentid() {
		return contentid;
	}
	public void setContentid(int contentid) {
		this.contentid = contentid;
	}
	public Date getBookmarktime() {
		return bookmarktime;
	}
	public void setBookmarktime(Date bookmarktime) {
		this.bookmarktime = bookmarktime;
	}
	// to String
	@Override
	public String toString() {
		return "BookMarkVO [TourMembercode=" + TourMembercode + ", contentid=" + contentid + ", bookmarktime="
				+ bookmarktime + "]";
	}
}
