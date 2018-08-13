package com.travel.model;

import java.util.Date;

public class ReviewVO { 
	
	String tourmembercode; // mysql -> (int)TourMembercode
	int mysqltourmembercode; // mysql에서 입력 받을 때 사용
	int contentid; // mysql -> contentid
	String tourtext; // mysql -> tourtext
	int reviewstar; // mysql -> star
	Date tourdate; // 자동 입력
	
	// getter / setter
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
	public String getTourtext() {
		return tourtext;
	}
	public void setTourtext(String tourtext) {
		this.tourtext = tourtext;
	}
	public int getReviewstar() {
		return reviewstar;
	}
	public void setReviewstar(int reviewstar) {
		this.reviewstar = reviewstar;
	}
	public Date getTourdate() {
		return tourdate;
	}
	public void setTourdate(Date tourdate) {
		this.tourdate = tourdate;
	}
	
	// toString
	@Override
	public String toString() {
		return "ReviewVO [tourmembercode=" + tourmembercode + ", mysqltourmembercode=" + mysqltourmembercode
				+ ", contentid=" + contentid + ", tourtext=" + tourtext + ", reviewstar=" + reviewstar + ", tourdate="
				+ tourdate + "]";
	}
}
