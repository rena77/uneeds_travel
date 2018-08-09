package com.travel.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.travel.model.BookMarkVO;
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
	public void bookmarkinfo(BookMarkVO vo) {
		System.out.println("여기까지 됨?");
		mysqlSession.insert(namespace + ".t_bookmarkinfo", vo);
	}


}
