package com.travel.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.travel.model.BookMarkVO;
import com.travel.model.ReviewVO;
import com.travel.model.ReviewinsertVO;
import com.travel.model.TMemberVO;
import com.travel.model.TravelareainfoVO;
import com.travel.model.bookmarkrecommendVO;

@Repository
public class TourDAOImpl implements TourDAO {

	@Inject
	private SqlSession mysqlSession;

	private static final String namespace = "com.travel.travelMapper";

	
	@Override
	public void insertTravelApiList(TravelareainfoVO vo) {
		mysqlSession.insert(namespace + ".t_travelapilist", vo);
	}

	@Override
	public void bookmarkinsertinfo(BookMarkVO vo) {
		mysqlSession.insert(namespace + ".t_bookmarkinfo", vo);
	}
	
	@Override
	public void goodmarkinsertinfo(BookMarkVO vo) {
		mysqlSession.insert(namespace + ".t_goodmarkinfo", vo);
	}
	
	@Override
	public void bookmarkdelete(BookMarkVO vo) {
		mysqlSession.insert(namespace + ".t_bookmarkdelete", vo);
	}

	@Override
	public void goodmarkdelete(BookMarkVO vo) {
		mysqlSession.insert(namespace + ".t_goodmarkdelete", vo);
	}

	@Override
	public void reviewinsertinfo(ReviewinsertVO vo) {
		mysqlSession.insert(namespace + ".t_review_table", vo);
	}
	
	@Override
	public void insertmembercheck(TMemberVO vo) {
		mysqlSession.insert(namespace + ".t_member_table", vo);
	}

	@Override
	public List<ReviewVO> reviewselectinfo(String contentid) {
		List<ReviewVO> list = mysqlSession.selectList(namespace + ".t_reviewselectinfo", contentid);
		return list;
	}

	@Override
	public List<TMemberVO> membercheckinfo(String mid) {
		List<TMemberVO> list = mysqlSession.selectList(namespace + ".t_groubcheck", mid);
		return list;
	}

	@Override
	public List<bookmarkrecommendVO> bookmarkrecommendinfo(String mid) {
		List<bookmarkrecommendVO> list = mysqlSession.selectList(namespace + ".t_bookmarkrecommend", mid);
		return list;
	}

	@Override
	public List<TravelareainfoVO> areabaseinfo(int contentid) {
		List<TravelareainfoVO> list = mysqlSession.selectList(namespace + ".areabaseinfo", contentid);
		return list;
	}

	@Override
	public List<bookmarkrecommendVO> nologinrecommend() {
		List<bookmarkrecommendVO> list = mysqlSession.selectList(namespace + ".nologinrecommend");
		return list;
	}

	@Override
	public Boolean checkboxbookmarkview(String id, int contentid) {
		BookMarkVO vo = new BookMarkVO();
		
		vo.setContentid(contentid);
		vo.setTourmembercode(id);
		
		List<BookMarkVO> list = mysqlSession.selectList(namespace + ".checkboxbookmarkview", vo);
		
		if(list.isEmpty()) {
			return false;
		}else {
			return true;
		}
	}

	@Override
	public Boolean checkboxgoodmarkview(String id, int contentid) {
		BookMarkVO vo = new BookMarkVO();
		
		vo.setContentid(contentid);
		vo.setTourmembercode(id);
		
		List<BookMarkVO> list = mysqlSession.selectList(namespace + ".checkboxgoodmarkview", vo);
		
		if(list.isEmpty()) {
			return false;
		}else {
			return true;
		}
	}

}
