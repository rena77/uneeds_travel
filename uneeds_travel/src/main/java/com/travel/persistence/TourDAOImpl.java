package com.travel.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.travel.model.BookMarkVO;
import com.travel.model.ReviewVO;
import com.travel.model.TravelareainfoVO;

@Repository
public class TourDAOImpl implements TourDAO {

	@Inject
	private SqlSession mysqlSession;

	private static final String namespace = "com.travel.MemberMapper";

	
	@Override
	public void insertTravelApiList(TravelareainfoVO vo) {
		mysqlSession.insert(namespace + ".t_travelapilist", vo);
	}

	@Override
	public void bookmarkinsertinfo(BookMarkVO vo) {
		mysqlSession.insert(namespace + ".t_bookmarkinfo", vo);
	}

	@Override
	public void reviewinsertinfo(ReviewVO vo) {
		mysqlSession.insert(namespace + ".t_review_table", vo);
	}

	@Override
	public List<ReviewVO> reviewselectinfo() {
		List<ReviewVO> list = mysqlSession.selectList(namespace + ".reviewselectinfo");
		return list;
	}


}
