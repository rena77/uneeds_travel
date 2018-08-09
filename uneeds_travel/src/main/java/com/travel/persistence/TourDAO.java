package com.travel.persistence;

import com.travel.model.BookMarkVO;
import com.travel.model.TravelareainfoVO;

public interface TourDAO {
	public void insertTravelApiList(TravelareainfoVO vo);
	
	// BookMark (즐겨찾기용) 값 insert
	public void bookmarkinfo(BookMarkVO vo);
}
