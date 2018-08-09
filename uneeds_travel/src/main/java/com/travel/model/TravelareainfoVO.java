package com.travel.model;

import java.util.Date;

public class TravelareainfoVO {
	
	int contentid;		//<contentid>264570</contentid>
	int contenttype;	//<contenttypeid>12</contenttypeid>
	double mapx;		//<mapx>127.0276129349</mapx>
	double mapy;		//<mapy>37.4978992118</mapy>
	int count;			//<readcount>30895</readcount>
	Date time;		// 시간 정보
	
	// getter / setter
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
	public double getMapx() {
		return mapx;
	}
	public void setMapx(double mapx) {
		this.mapx = mapx;
	}
	public double getMapy() {
		return mapy;
	}
	public void setMapy(double mapy) {
		this.mapy = mapy;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getTime() {
		return time;
	}
	public void setTime(Date time) {
		this.time = time;
	}
	
	// toString
	@Override
	public String toString() {
		return "travelareainfoVO [contentid=" + contentid + ", contenttype=" + contenttype + ", mapx=" + mapx
				+ ", mapy=" + mapy + ", count=" + count + ", time=" + time + "]";
	}
	
}
