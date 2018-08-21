package com.travel.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.travel.model.TMemberVO;
import com.travel.model.TravelareainfoVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Inject
	private SqlSession mysqlSession;

	private static final String namespace = "com.travel.MemberMapper";

	@Override
	public void insertMembers(TMemberVO vo) {
		mysqlSession.insert(namespace + ".isnertMember", vo);
	}

	@Override
	public List<TMemberVO> selectMembers() {
		List<TMemberVO> list = mysqlSession.selectList(namespace + ".listMember");
		return list;
	}

}
