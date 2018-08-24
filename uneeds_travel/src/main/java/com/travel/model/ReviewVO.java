package com.travel.model;

import java.util.Date;

public class ReviewVO { 
	
	int rcode;
	String mid; // 
	int contentid; // mysql -> contentid
	String tourtext; // mysql -> tourtext
	int star; // mysql -> star
	Date tourdate; // 자동 입력
	
	// getter / setter
	public int getRcode() {
		return rcode;
	}
	public void setRcode(int rcode) {
		this.rcode = rcode;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
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
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public Date getTourdate() {
		return tourdate;
	}
	public void setTourdate(Date tourdate) {
		this.tourdate = tourdate;
	}
	
	//toString
	@Override
	public String toString() {
		return "ReviewVO [rcode=" + rcode + ", mid=" + mid + ", contentid=" + contentid
				+ ", tourtext=" + tourtext + ", star=" + star + ", tourdate=" + tourdate + "]";
	}

}
