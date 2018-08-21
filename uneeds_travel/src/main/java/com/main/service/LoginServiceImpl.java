package com.main.service;

import java.util.HashMap;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.main.domain.uMemberVO;
import com.main.persistence.LoginDAO;

@Service
public class LoginServiceImpl implements LoginService{
	
	@Inject
	LoginDAO loginDao;
	
	@Override
	public String getTime() {
		return loginDao.selectTime();
	}

	@Override
	public boolean loginCheck(HttpSession session, String usr, String pwd) {
		HashMap<String, Object> result = loginDao.selectOne(usr);
		if(result == null)
            return false;
        else {
        	String pw = (String) result.get("pw").toString();
        	String Lcode = (String) result.get("Lcode").toString();
        	if(pwd == null) {
        		return false;
        	}else {
        		if(pw.equals(pwd)) {
    	        	session.setAttribute("userid", usr);
    	        	session.setAttribute("Lcode", Lcode);
        			return true;
        		}
        		else 
        			return false;
        	}
        }
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
	
	// api 로그인
	@Override
	public int login(String id, String site) {
		return loginDao.login(id, site);
	}
}
