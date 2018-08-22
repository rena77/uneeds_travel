package com.travel.persistence;

import java.util.List;

import com.travel.model.BookMarkVO;
import com.travel.model.ReviewVO;
import com.travel.model.ReviewinsertVO;
import com.travel.model.TMemberVO;
import com.travel.model.TravelareainfoVO;
import com.travel.model.bookmarkrecommendVO;

public interface TourDAO {
	public void insertTravelApiList(TravelareainfoVO vo);
	
	// BookMark (즐겨찾기용) 값 insert
	public void bookmarkinsertinfo(BookMarkVO vo);
	
	// review (리뷰) 값 insert
	public void reviewinsertinfo(ReviewinsertVO vo);
	
	// 가입시 추가 정보 값 insert
	public void insertmembercheck(TMemberVO vo);
	
	// review 값 불러오기(select)
	public List<ReviewVO> reviewselectinfo(String contentid);

	// memeber 값 찾기(select)
	public List<TMemberVO> membercheckinfo(String mid);
	
	// bookmark 추천 값 찾기
	public List<bookmarkrecommendVO> bookmarkrecommendinfo(String mid);
	
	// contentid로 정보 가져오기
	public List<TravelareainfoVO> areabaseinfo(int contentid);
}
