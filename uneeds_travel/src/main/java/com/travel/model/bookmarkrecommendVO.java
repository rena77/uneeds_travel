package com.travel.model;

public class bookmarkrecommendVO {
	
	int bookmarkid;
	int tourmembercode;
	int contentid;
	int num;
	
	public int getBookmarkid() {
		return bookmarkid;
	}
	public void setBookmarkid(int bookmarkid) {
		this.bookmarkid = bookmarkid;
	}
	public int getTourmembercode() {
		return tourmembercode;
	}
	public void setTourmembercode(int tourmembercode) {
		this.tourmembercode = tourmembercode;
	}
	public int getContentid() {
		return contentid;
	}
	public void setContentid(int contentid) {
		this.contentid = contentid;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	@Override
	public String toString() {
		return "bookmarkrecommendVO [bookmarkid=" + bookmarkid + ", tourmembercode=" + tourmembercode + ", contentid="
				+ contentid + ", num=" + num + "]";
	}
}
