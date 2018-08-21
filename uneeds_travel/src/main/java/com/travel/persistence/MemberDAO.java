package com.travel.persistence;

import java.util.List;

import com.travel.model.TMemberVO;

public interface MemberDAO {

	public void insertMembers(TMemberVO vo);
	public List<TMemberVO> selectMembers();
}
