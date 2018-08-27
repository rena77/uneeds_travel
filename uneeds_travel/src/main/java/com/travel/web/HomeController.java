package com.travel.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;

import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.model.BookMarkVO;
import com.travel.model.ReviewVO;
import com.travel.model.ReviewinsertVO;
import com.travel.model.TMemberVO;
import com.travel.model.TravelareainfoVO;
import com.travel.model.UserinfoVO;
import com.travel.model.bookmarkrecommendVO;
import com.travel.persistence.TourDAO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Inject
	private TourDAO dao;

	
	// 그냥 화면 보이게 하는 부분
	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	@RequestMapping(value = "/viewtest")
	public String test(Locale locale, Model model) {
		return "viewtest";
	}
	
	@RequestMapping(value = "/main")
	public String main(Locale locale, Model model) {
		return "main";
	}
	
	@RequestMapping(value = "/customerlist")
	public String customerlist(Locale locale, Model model) {
		return "customerlist";
	}
	
	@RequestMapping(value = "/bookmark")
	public String bookmark(Locale locale, Model model) {
		return "bookmark";
	}
	
	@RequestMapping(value = "/detailpage")
	public String detailfage(Locale locale, Model model) {
		return "detailpage";
	}
	
	@RequestMapping(value = "/additionmemberinfo")
	public String additionmemberinfo(Locale locale, Model model) {
		return "additionmemberinfo";
	}
	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

	// 관광 정보 API 부분
	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	// 시의 이름 정보 가져오는 부분
	@RequestMapping(value = "areasidocode", method = RequestMethod.GET)
	public ResponseEntity<String> areasidocode(HttpServletRequest request) throws Exception {

		StringBuilder urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode"); /* URL */
		URL url = null;
		HttpURLConnection conn = null;
		BufferedReader rd = null;
		StringBuilder sb = new StringBuilder();
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/xml; charset=utf-8");

			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "= 1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D");
			urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + URLEncoder.encode("1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D", "UTF-8")); /* 공공데이터포털에서 발급받은 인증키 */
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /* 한 페이지 결과수 */
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /* 현재 페이지 번호 */
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* IOS (아이폰), AND (안드로이드), WIN (원도우폰), ETC */
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /* 서비스명=어플명 */
			urlBuilder.append("&" + URLEncoder.encode("areaCodeYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 서비스명=어플명 */

			url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json; charset=utf-8");

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			String line = "";
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();
		
		return new ResponseEntity<String>(sb.toString(), responseHeaders, HttpStatus.CREATED);
	}

	// 시를 정한 후 군구 정보 가져오는 부분
	@RequestMapping(value = "areagungucode", method = RequestMethod.GET)
	public ResponseEntity<String> areagungucode(HttpServletRequest request) throws Exception {
		
		StringBuilder urlBuilder = new StringBuilder( "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaCode"); /* URL */
		URL url = null;
		HttpURLConnection conn = null;
		BufferedReader rd = null;
		StringBuilder sb = new StringBuilder();
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/xml; charset=utf-8");

			urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "= 1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D"); /* Service Key */
			urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + URLEncoder.encode("1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D (URL - Encode)", "UTF-8")); /* 공공데이터포털에서 발급받은 인증키 */
			urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /* 한 페이지 결과수 */
			urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /* 현재 페이지 번호 */
			urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* IOS (아이폰), AND (안드로이드), WIN (원도우폰), ETC */
			urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /* 서비스명=어플명 */

			String areaCode = request.getParameter("areaCode");
			areaCode = Objects.isNull(areaCode) ? "1" : areaCode;

			urlBuilder.append("&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode(areaCode, "UTF-8")); /* 서비스명=어플명 */
			
			url = new URL(urlBuilder.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Content-type", "application/json; charset=utf-8");

			if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
				rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			} else {
				rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}

			String line = "";
			while ((line = rd.readLine()) != null) {
				sb.append(line);
			}
			rd.close();
			conn.disconnect();

		return new ResponseEntity<String>(sb.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	// 시/군구/컨텐츠 타입에 따른 공통 정보 가져오는 부분
	@RequestMapping(value = "coordinates", method = RequestMethod.GET)
	public ResponseEntity<String> coordinates(HttpServletRequest request) throws Exception {
		
		String areaCode = request.getParameter("areaCode");
		areaCode = Objects.isNull(areaCode) ? "1" : areaCode;
		String sigunguCode = request.getParameter("sigunguCode");
		sigunguCode = Objects.isNull(sigunguCode) ? "1" : sigunguCode;
		String contenttype = request.getParameter("contenttype");
		contenttype = Objects.isNull(contenttype) ? "12" : contenttype;

		StringBuilder urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "= 1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D"); /*Service Key */
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + URLEncoder.encode("1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D (URL- Encode)", "UTF-8")); /* 공공데이터포털에서 발급받은 인증키 */
		urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /* 현재 페이지 번호 */
		urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("100", "UTF-8")); /* 한 페이지 결과 수 */
		urlBuilder.append("&" + URLEncoder.encode("MobileApp", "UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /* 서비스명=어플명 */
		urlBuilder.append("&" + URLEncoder.encode("MobileOS", "UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /* IOS (아이폰), AND (안드로이드),WIN (원도우폰), ETC */
		urlBuilder.append("&" + URLEncoder.encode("arrange", "UTF-8") + "=" + URLEncoder.encode("A", "UTF-8")); /* (A=제목순, B=조회순, C=수정일순, D=생성일순) , 대표이미지가 반드시 있는 정렬 (O=제목순, P=조회순, Q=수정일순, R=생성일순)  */
		urlBuilder.append("&" + URLEncoder.encode("cat1", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /* 대분류 코드 */
		urlBuilder.append("&" + URLEncoder.encode("contentTypeId", "UTF-8") + "=" + URLEncoder.encode(contenttype, "UTF-8")); /* 관광타입(관광지, 숙박 등) ID */
		urlBuilder.append("&" + URLEncoder.encode("areaCode", "UTF-8") + "=" + URLEncoder.encode(areaCode, "UTF-8")); /* 지역코드 */
		urlBuilder.append("&" + URLEncoder.encode("sigunguCode", "UTF-8") + "=" + URLEncoder.encode(sigunguCode, "UTF-8")); /* 시군구코드(areaCode 필수) */
		urlBuilder.append("&" + URLEncoder.encode("cat2", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /* 중분류 코드(cat1필수) */
		urlBuilder.append("&" + URLEncoder.encode("cat3", "UTF-8") + "=" + URLEncoder.encode("", "UTF-8")); /* 소분류 코드(cat1,cat2필수) */
		urlBuilder.append("&" + URLEncoder.encode("listYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 목록 구분 (Y=목록, N=개수) */
		urlBuilder.append("&" + URLEncoder.encode("overviewYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 콘텐츠 개요 조회여부 */
		urlBuilder.append("&" + URLEncoder.encode("introYN", "UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /* 소개정보 조회 */

		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/xml; charset=utf-8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();

		return new ResponseEntity<String>(sb.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	
	// 컨텐츠ID / 컨텐츠타입을 통하여 상세 정보 가져오는 부분
	@RequestMapping(value = "/detailedinformation", method = RequestMethod.GET)
	public ResponseEntity<String> detailedinformation(HttpServletRequest request) throws Exception {
		
		String contenttype = request.getParameter("contenttype");
		contenttype = Objects.isNull(contenttype) ? "12" : contenttype;
		String contentId = request.getParameter("contentId");
		
		StringBuilder urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro"); /* URL */
		urlBuilder.append("?" + URLEncoder.encode("ServiceKey", "UTF-8") + "= 1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D"); /*Service Key */
		urlBuilder.append("&" + URLEncoder.encode("ServiceKey", "UTF-8") + "=" + URLEncoder.encode("1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D (URL- Encode)", "UTF-8")); /* 공공데이터포털에서 발급받은 인증키 */
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("2", "UTF-8")); /*한 페이지 결과수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*현재 페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS (아이폰), AND (안드로이드), WIN (원도우폰), ETC*/
        urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*서비스명=어플명*/
        urlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + URLEncoder.encode(contentId, "UTF-8")); /*콘텐츠 ID*/
        urlBuilder.append("&" + URLEncoder.encode("contentTypeId","UTF-8") + "=" + URLEncoder.encode(contenttype, "UTF-8")); /*관광타입(관광지, 숙박 등) ID*/
        urlBuilder.append("&" + URLEncoder.encode("introYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*소개정보 조회*/

		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/xml; charset=utf-8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();

		return new ResponseEntity<String>(sb.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	// 컨텐츠ID / 컨텐츠타입을 통하여 상세 정보 가져오는 부분
	@RequestMapping(value = "/overviewinformaiton", method = RequestMethod.GET)
	public ResponseEntity<String> overviewinformaiton(HttpServletRequest request) throws Exception {
		
		String contenttype = request.getParameter("contenttype");
		String contentId = request.getParameter("contentId");
		
		StringBuilder urlBuilder = new StringBuilder("http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("ServiceKey","UTF-8") + "=1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("ServiceKey","UTF-8") + "=" + URLEncoder.encode("1T7BS1EDFAZ2UpQNRMnhaTeNc%2FF0Mv2DGlpwUgzubu22EGQofVc%2BqWuWTOYydw%2BryYH3uIsZRCc1g8FfZbPzYA%3D%3D", "UTF-8")); /*공공데이터포털에서*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*현재 페이지 번호*/
        urlBuilder.append("&" + URLEncoder.encode("MobileOS","UTF-8") + "=" + URLEncoder.encode("ETC", "UTF-8")); /*IOS(아이폰),AND(안드로이드),WIN(원도우폰),ETC*/
        urlBuilder.append("&" + URLEncoder.encode("MobileApp","UTF-8") + "=" + URLEncoder.encode("AppTest", "UTF-8")); /*서비스명=어플명*/
        urlBuilder.append("&" + URLEncoder.encode("contentId","UTF-8") + "=" + URLEncoder.encode(contentId, "UTF-8")); /*콘텐츠ID*/
        urlBuilder.append("&" + URLEncoder.encode("contentTypeId","UTF-8") + "=" + URLEncoder.encode(contenttype, "UTF-8")); /*관광타입(관광지, 숙박 등) ID*/
        urlBuilder.append("&" + URLEncoder.encode("defaultYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*기본정보 조회여부*/
        urlBuilder.append("&" + URLEncoder.encode("firstImageYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*원본, 썸네일 대표이미지 조회여부*/
        urlBuilder.append("&" + URLEncoder.encode("areacodeYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*지역코드, 시군구코드 조회여부*/
        urlBuilder.append("&" + URLEncoder.encode("catcodeYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*대,중,소분류코드 조회여부*/
        urlBuilder.append("&" + URLEncoder.encode("addrinfoYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*주소, 상세주소 조회여부*/
        urlBuilder.append("&" + URLEncoder.encode("mapinfoYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*좌표 X,Y 조회여부*/
        urlBuilder.append("&" + URLEncoder.encode("overviewYN","UTF-8") + "=" + URLEncoder.encode("Y", "UTF-8")); /*콘텐츠 개요 조회여부*/
        
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "application/xml; charset=utf-8");

		URL url = new URL(urlBuilder.toString());
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Content-type", "application/json");
		BufferedReader rd;
		if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
			rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		} else {
			rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
		}
		StringBuilder sb = new StringBuilder();
		String line;
		while ((line = rd.readLine()) != null) {
			sb.append(line);
		}
		rd.close();
		conn.disconnect();

		return new ResponseEntity<String>(sb.toString(), responseHeaders, HttpStatus.CREATED);
	}
	
	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	
	// 저장 부분 
	/* 여행 list 자동 저장 등록 */
	@RequestMapping(value = "t_travelapilist", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertMemberAjax(HttpServletRequest r, TravelareainfoVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.insertTravelApiList(vo);
		
		return states;
	}
	
	/* 즐겨찾기 저장 */
	@RequestMapping(value = "t_bookmarkinfo", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertbookmarkinfo(HttpServletRequest r, BookMarkVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.bookmarkinsertinfo(vo);
		
		return states;
	}
	
	/* 즐겨찾기 삭제 */
	@RequestMapping(value = "t_bookmarkdelete", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertbookmarkdelete(HttpServletRequest r, BookMarkVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.bookmarkdelete(vo);
		
		return states;
	}
	
	/* 좋아요 저장 */
	@RequestMapping(value = "t_goodmarkinfo", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertgoodmarkinfo(HttpServletRequest r, BookMarkVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.goodmarkinsertinfo(vo);
		
		return states;
	}
	
	/* 좋아요 삭제 */
	@RequestMapping(value = "t_goodmarkdelete", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertgoodmarkdelete(HttpServletRequest r, BookMarkVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.goodmarkdelete(vo);
		
		return states;
	}
	
	/* 리뷰 정보 저장 */
	@RequestMapping(value = "t_reviewinsert", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertreviewinfo(HttpServletRequest r, ReviewinsertVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.reviewinsertinfo(vo);
		
		return states;
	}
	
	/* reveiw 삭제 */
	@RequestMapping(value = "t_reviewdelete", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> reveiwdelete(HttpServletRequest r, UserinfoVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.reveiwdelete(vo);
		
		return states;
	}
	
	/* 추가 가입 정보 저장 */
	@RequestMapping(value = "t_additionmemberinfo", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, String> insertmembercheck(HttpServletRequest r, TMemberVO vo) {
		try {
			r.setCharacterEncoding("utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// 초기
		HashMap<String, String> states = new HashMap<String, String>();
		states.put("state", "ok");
		// insert
		dao.insertmembercheck(vo);
		
		return states;
	}
	
	// 불러오기 부분 
	// ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	/* 리뷰 정보 불러오기 */
	@RequestMapping(value = "/reviewselectinfo", method = RequestMethod.GET)
	public @ResponseBody List<ReviewVO> reviewselectinfo(@RequestParam("contentid") String contentid) {
		return dao.reviewselectinfo(contentid);
	}
	
	/* 로그인 시 추가 입력 사항 확인 */
	@RequestMapping(value = "/membercheck", method = RequestMethod.GET)
	public @ResponseBody List<TMemberVO> membercheckinfo(@RequestParam("mid") String mid) {
		return dao.membercheckinfo(mid);
	}
	
	/* 나이별 추천 여행지 추천 */
	@RequestMapping(value = "/bookmarkrecommend", method = RequestMethod.GET)
	public @ResponseBody List<bookmarkrecommendVO> bookmarkrecommendinfo(@RequestParam("mid") String mid) {
		return dao.bookmarkrecommendinfo(mid);
	}
	
	/* 비 로그인 시 추천 여행지 추천 */
	@RequestMapping(value = "/nologinrecommend", method = RequestMethod.GET)
	public @ResponseBody List<bookmarkrecommendVO> nologinrecommend() {
		return dao.nologinrecommend();
	}
	
	/* 지역 기반 자료 찾기 */
	@RequestMapping(value = "/areabase", method = RequestMethod.GET)
	public @ResponseBody List<TravelareainfoVO> areabaseinfo(@RequestParam("contentid") int contentid) {
		return dao.areabaseinfo(contentid);
	}
	
	/* 좋아요, bookmark check 표시용*/
	@RequestMapping(value = "/checkboxbookmarkview", method = RequestMethod.GET)
	public @ResponseBody Boolean checkboxbookmarkview(HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("mid");
		String i = httpServletRequest.getParameter("contentid");
		int contentid = Integer.parseInt(i);
		return dao.checkboxbookmarkview(id, contentid);
	}
	
	/* 좋아요, bookmark check 표시용*/
	@RequestMapping(value = "/checkboxgoodmarkview", method = RequestMethod.GET)
	public @ResponseBody Boolean checkboxgoodmarkview(HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("mid");
		String i = httpServletRequest.getParameter("contentid");
		int contentid = Integer.parseInt(i);
		return dao.checkboxgoodmarkview(id, contentid);
	}
	
	/* id로 전체 값 얻기 */
	@RequestMapping(value = "/userinfolist", method = RequestMethod.GET)
	public @ResponseBody List<UserinfoVO> userinfo(HttpServletRequest httpServletRequest) {
		String id = httpServletRequest.getParameter("userid");
		String userwrite = httpServletRequest.getParameter("infonumber");
		return dao.userinfolist(id, userwrite);
	}
}
