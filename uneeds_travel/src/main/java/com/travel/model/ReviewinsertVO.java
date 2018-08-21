package com.travel.model;


public class ReviewinsertVO { 
	
	String tourmembercode;
	int contentid;
	String tourtext;
	int star;
	
	public String getTourmembercode() {
		return tourmembercode;
	}
	public void setTourmembercode(String tourmembercode) {
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
	
	@Override
	public String toString() {
		return "ReviewinsertVO [tourmembercode=" + tourmembercode + ", contentid=" + contentid + ", tourtext="
				+ tourtext + ", star=" + star + "]";
	}

}
