package com.travel.model;

import java.util.Date;

public class ReviewVO { 
	
	int rcode;
	int tourmembercode; // mysql -> (int)TourMembercode
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
		return "ReviewVO [rcode=" + rcode + ", tourmembercode=" + tourmembercode + ", contentid=" + contentid
				+ ", tourtext=" + tourtext + ", star=" + star + ", tourdate=" + tourdate + "]";
	}

}
