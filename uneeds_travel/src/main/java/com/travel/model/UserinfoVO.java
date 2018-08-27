package com.travel.model;

public class UserinfoVO {
	
	int contentid;		//<contentid>264570</contentid>
	int contenttype;		//<contenttypeid>12</contenttypeid>
	int tourmembercode;
	int star;
	String mid;
	String tourtext;
	String userid;
	String infonumber;
	int rcode;
	
	
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
	public int getContenttype() {
		return contenttype;
	}
	public void setContenttype(int contenttype) {
		this.contenttype = contenttype;
	}
	public int getTourmembercode() {
		return tourmembercode;
	}
	public void setTourmembercode(int tourmembercode) {
		this.tourmembercode = tourmembercode;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getTourtext() {
		return tourtext;
	}
	public void setTourtext(String tourtext) {
		this.tourtext = tourtext;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getInfonumber() {
		return infonumber;
	}
	public void setInfonumber(String infonumber) {
		this.infonumber = infonumber;
	}
	@Override
	public String toString() {
		return "UserinfoVO [contentid=" + contentid + ", contenttype=" + contenttype + ", tourmembercode="
				+ tourmembercode + ", star=" + star + ", mid=" + mid + ", tourtext=" + tourtext + ", userid=" + userid
				+ ", infonumber=" + infonumber + ", rcode=" + rcode + "]";
	}
}
