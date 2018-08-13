package com.travel.model;

import java.util.Date;

public class BookMarkVO {
		
	String tourmembercode; // 로그인 한 사람 정보
	int mysqltourmembercode;  // mysql로 입력 받을 때 사용
	int contentid; // contentid로 여행 정보를 알 수 있어 추가
	Date bookmarktime; // 즐겨찾기 추가 한 시간
	
	//getter / setter
	public String getTourmembercode() {
		return tourmembercode;
	}
	public void setTourmembercode(String tourmembercode) {
		this.tourmembercode = tourmembercode;
	}
	public int getMysqltourmembercode() {
		return mysqltourmembercode;
	}
	public void setMysqltourmembercode(int mysqltourmembercode) {
		this.mysqltourmembercode = mysqltourmembercode;
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
		return "BookMarkVO [tourmembercode=" + tourmembercode + ", contentid=" + contentid + ", bookmarktime="
				+ bookmarktime + "]";
	}

}
