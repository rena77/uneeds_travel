package com.travel.model;

public class TMemberVO {
	
	int tourmembercode;
	int mcode;
	String tmname;
	String tmgender;
	int tmage;
	String tmphone;
	String mid;
	
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public int getTourmembercode() {
		return tourmembercode;
	}
	public void setTourmembercode(int tourmembercode) {
		this.tourmembercode = tourmembercode;
	}
	public int getMcode() {
		return mcode;
	}
	public void setMcode(int mcode) {
		this.mcode = mcode;
	}
	public String getTmname() {
		return tmname;
	}
	public void setTmname(String tmname) {
		this.tmname = tmname;
	}
	public String getTmgender() {
		return tmgender;
	}
	public void setTmgender(String tmgender) {
		this.tmgender = tmgender;
	}
	public int getTmage() {
		return tmage;
	}
	public void setTmage(int tmage) {
		this.tmage = tmage;
	}
	public String getTmphone() {
		return tmphone;
	}
	public void setTmphone(String tmphone) {
		this.tmphone = tmphone;
	}
	
	@Override
	public String toString() {
		return "TMemberVO [tourmembercode=" + tourmembercode + ", mcode=" + mcode + ", tmname=" + tmname + ", tmgender="
				+ tmgender + ", tmage=" + tmage + ", tmphone=" + tmphone + ", mid=" + mid + "]";
	}
	
}
