package com.main.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.main.domain.uMemberVO;

@Repository
public class LoginDAOImpl implements LoginDAO{

	@Inject SqlSession mysqlSession;
	
	private static final String namespace="com.main.mappers.MainMapper";
	
	
	//현재 시간
	@Override
	public String selectTime() {
		return mysqlSession.selectOne(namespace+".getTime");
	}


	@Override
	public boolean loginCheck(uMemberVO vo) {
		String name = mysqlSession.selectOne(namespace+".logincheck");
		return (name == null) ? false : true;
	}


	@Override
	public uMemberVO viewuMembers(uMemberVO vo) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public void logout(HttpSession session) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public HashMap<String, Object> selectOne(String usr) {
		HashMap<String, Object> list = mysqlSession.selectOne(namespace+".selectOne", usr);
		return list;
	}

	@Override
	public int login(String id, String site) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("mid", id);
		map.put("lname", site);
		mysqlSession.selectOne(namespace+".login", map);
		int result = (int) map.get("usercode");
		System.out.println("usercode: "+result);
		return result;
	}
}
