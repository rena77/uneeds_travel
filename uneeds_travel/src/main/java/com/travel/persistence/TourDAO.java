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
	
	// BookMark (즐겨찾기용) 값 delete
	public void bookmarkdelete(BookMarkVO vo);
	
	// goomark 값 insert
	public void goodmarkinsertinfo(BookMarkVO vo);
	
	// BookMark (즐겨찾기용) 값 delete
	public void goodmarkdelete(BookMarkVO vo);
	
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
	
	/* 비 로그인 시 추천 여행지 추천 */
	public List<bookmarkrecommendVO> nologinrecommend();
	
	// contentid로 정보 가져오기
	public List<TravelareainfoVO> areabaseinfo(int contentid);
	
	// 즐겨찾기가 있는지 확인
	public Boolean checkboxbookmarkview(String id, int contentid);
	
	// 좋아요가 있는지 확인
	public Boolean checkboxgoodmarkview(String id, int contentid);
}
