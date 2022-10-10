package servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import com.mysql.cj.Session;
import com.oreilly.servlet.MultipartRequest;

import board.boardDAO;
import comment.commentDAO;
import notice.NotiDAO;

import java.util.ArrayList;
import java.util.List;

import member.memberDAO;
import member.memberDTO;



@WebServlet("/controller/*")
@MultipartConfig(
	    fileSizeThreshold = 1024*1024,
	    maxFileSize = 1024*1024*50, //50메가
	    maxRequestSize = 1024*1024*50*5 // 50메가 5개까지
	)
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("==========service srt==========");
		
		
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		String LoginedID = (String)session.getAttribute("memberId");
		
		//=========================추가 시작
		// 기능
		String pageRoute = request.getParameter("pageRoute") == null ? null : request.getParameter("pageRoute");
		// 보드아이디
		String bid = request.getParameter("bid") == null ? null : request.getParameter("bid");
		// 댓글관련 변수
		String comment = request.getParameter("comment") == null ? null : request.getParameter("comment");
		// 스크롤위치
		String scroll = request.getParameter("scroll") == null ? null : request.getParameter("scroll");
		// 댓글관련 변수
		String commentDetail = request.getParameter("commentDetail") == null ? null : request.getParameter("commentDetail");
		//acHome 관련 변수
		String m2id=request.getParameter("m2id")==null? null : request.getParameter("m2id");
		//acContent 관련 변수
		String index=request.getParameter("index")==null? null : request.getParameter("index");
		//selfHome 관련 변수
		String memberId=request.getParameter("memberId")==null? null : request.getParameter("memberId");
		
		String pageMove = null;
		
		//=========================추가 끝
		
		
		
		
		
		
		
		String requestURI = request.getRequestURI();
		int lastSlash = requestURI.lastIndexOf("/");
		requestURI = requestURI.substring(lastSlash);
		System.out.println(requestURI);
		
		switch(requestURI) {
		// ===========================페이지로 보내는 컨트롤러===========================
		case "/HomePage":
			request.getRequestDispatcher("/Home/Home.jsp").forward(request, response);
			break;
		case "/LoginPage":
			request.getRequestDispatcher("/Login/Login.jsp").forward(request, response);
			break;
		case "/SettingPage":
			showMemberInfo(request,response,session);
			break;
		case "/WritePage":
			request.getRequestDispatcher("/Home/Write.jsp").forward(request, response);
			break;
		case "/MyPage":
			request.getRequestDispatcher("/Home/SelfHome.jsp").forward(request, response);
			break;
		case "/ProfileEditPage":
			request.getRequestDispatcher("/Setting/ProfileEdit.jsp").forward(request, response);
			break;	
		case "/AcEditPage":
			request.getRequestDispatcher("/Setting/AcEdit.jsp").forward(request, response);
			break;	
		case "/AcHomePage":
			request.getRequestDispatcher("/Home/AcHome.jsp").forward(request, response);
			break;
		case "/AcContentPage":
			request.getRequestDispatcher("/board/AcContent.jsp").forward(request, response);
			break;
		case "/SelfHomePage":
			request.getRequestDispatcher("/Home/SelfHome.jsp").forward(request, response);
			break;
			
		case "/NotiPage":
			NotiDAO dao = new NotiDAO();
			ArrayList<String> notiList = dao.allNotiList(LoginedID);
			request.setAttribute("notiList", notiList);
			request.getRequestDispatcher("/Home/Notice.jsp").forward(request, response);
			break;
			
		// ===========================기능 실행하는 컨트롤러===========================
		//Nav
		case "/getSearch":
			useSearch(request,response);
			break;
		//Nav
		case "/goMyPage":
			goMyPage(request,response,session);
			break;
		case "/Logout":
			setLogout(request,response,session);
			break;
		//알림확인 기능
		case "/checkNoti":
			CheckNoti(request,response,LoginedID);
			break;
		//Write
		case "/uploadBoard":
			uploadBoard(request,response);
			break;
		//Setting
		case "/deleteAccount" :
			deleteAccount(request,response,session);
			break;
		case "/changePrivateStatus":
			setPrivateAc(request,response,session);
			break;	
		case "/Aedit":
			Aedit(request,response,session);
			break;	
		case "/Pedit":
			Pedit(request,response,session);
			break;	
			
			
		
		//임시
		case "/Login":
			setLogin(request,response,session);
			break;
		
		//=========================추가 시작
			
			
			case "/selectBoard":
				System.out.println("selectBoard로 왔다");
				System.out.println("pageRoute : " + pageRoute);
				System.out.println("bid : " + bid);
				System.out.println("scroll : " + scroll);
				System.out.println("comment : " + comment);
				System.out.println("commentDetail : " + commentDetail);
				System.out.println("m2id " + m2id);
				pageMove = selectBoard(request, response, scroll, bid, comment, commentDetail, pageRoute, m2id);
				request.getRequestDispatcher(pageMove).forward(request, response);
				//
				break;
			case "/selectBoardDetail":
				pageMove = selectBoardDetail(request, response, bid);
				request.getRequestDispatcher(pageMove).forward(request, response);
				break;
			case "/likeWho":
				pageMove = likeWho(request, response, scroll, bid);
				request.getRequestDispatcher(pageMove).forward(request, response);
				break;
			case "/insertComment":
				System.out.println("insertComment로 왔다");
				session = request.getSession();
				session.setAttribute("scroll", scroll);
				pageMove = insertComment(request,response,scroll,bid,comment);
				System.out.println("pageRoute : " + pageRoute);
				System.out.println("bid : " + bid);
				System.out.println("scroll : " + scroll);
				System.out.println("comment : " + comment);
				System.out.println("commentDetail : " + commentDetail);
				request.getRequestDispatcher(pageMove).forward(request, response);
				break;
				
			case "/selectAc":
				System.out.println("selectAc로 왔다");
				System.out.println("m2id " + m2id);
				pageMove = selectAc(request, response, m2id, index, memberId);
				request.getRequestDispatcher(pageMove).forward(request, response);
				//
			
		//=========================추가 끝
		}
		
		
		session.setAttribute("notiCount", notiCount(request,response,LoginedID));
		System.out.println("==========service end==========");
		
	}
	
	//=======================Nav=======================//

	
	// 내 페이지 가기
	private void goMyPage(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException {

		PrintWriter out = response.getWriter();
		
		if((String)session.getAttribute("memberId") != null) {
			String mid = (String)session.getAttribute("memberId");
			if(!mid.equals("")) {
				response.sendRedirect("/sns/controller/MyPage");
			}else {
				out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/LoginPage'; </script>;");
				out.close();
			}
		}else {
			out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/LoginPage'; </script>;");
			out.close();
		}
		
		
	}
	
	
	// 검색한 문자가 포함된 아이디들 리턴
	private void useSearch(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		String searchText = request.getParameter("searchText");
		memberDAO dao = new memberDAO();
		
		ArrayList<memberDTO> searchedList = dao.getSearch(searchText);
		request.setAttribute("searchedList", searchedList);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Home/SearchedMember.jsp");
		rd.forward(request,response);
	}
	

	//====================================================//
	
	
	
	//=======================Write=======================//
	// 이미지 저장하고 ImageFile 아래 경로 구함
	private void uploadBoard(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{

		request.setCharacterEncoding("UTF-8");
		String ImageFolderPath = request.getServletContext().getRealPath("/ImageFile");
		String ImageFilePath = "";
		
		UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());

		List<Part> parts = (List<Part>) request.getParts();
		
		for(Part part : parts) {
			if(!part.getName().equals("ImageFile")) continue; //ImageFile로 들어온 Part가 아니면 스킵
			if(part.getSubmittedFileName().equals("")) continue; //업로드 된 파일 이름이 없으면 스킵
			System.out.println(part.getName());
			
			ImageFilePath = uploadUtil.saveFiles(part, uploadUtil.createFilePath());
			
			System.out.println("=========saveImage=========");
			System.out.println("ImageFolderPath : " + ImageFolderPath);
			System.out.println("ImageFilePath : " + ImageFilePath);
			System.out.println("=========saveImage=========");
		}
		boardDAO dao = new boardDAO();
		dao.uploadBoard(request, response, ImageFilePath);
		response.sendRedirect("/sns/controller/HomePage");
	}
	

	
	
	//====================================================//
	
	
	//=======================Setting=======================//
	//setting 페이지에 로그인된 회원 정보 뿌리고 이동
	private void showMemberInfo (HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		String mid = (String)session.getAttribute("memberId");

		System.out.println(mid);
		memberDAO dao = new memberDAO();
		memberDTO dto = dao.getMemberInfo(request, response, mid);
		request.setAttribute("memberInfo", dto);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Setting/Setting.jsp");
		rd.forward(request,response);
	}
	
	// 로그인된 회원 계정 삭제관련
	private void deleteAccount(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String mid = (String)session.getAttribute("memberId"); //세션에 로그인되있는 아이디
		String enterPassword = request.getParameter("password"); // 삭제를 위해서 입력한 비밀번호

		memberDAO dao = new memberDAO();
		String delStatus = dao.deleteAccount(request, response, mid, enterPassword,session);
		
		out.println(delStatus);
		out.close();
	}
	
	// 계정상태 비공개로 전환(공개="no" 비공개="yes")
	private void setPrivateAc(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		
		// 한글로 출력 위해서
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		
		String mid = (String)session.getAttribute("memberId");
		
		memberDAO dao = new memberDAO();
		memberDTO dto = dao.getMemberInfo(request, response, mid);
		
		String changeStatus = dao.changePrivateState(request, response, dto);
		out.println(changeStatus);
		out.close();
	}
	
	private void Aedit (HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		String mid = (String)session.getAttribute("memberId");

		System.out.println(mid);
		memberDAO dao = new memberDAO();
		dao.Aedit(request, response, mid);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Home/SelfHome.jsp");
		rd.forward(request,response);
	}
	
	private void Pedit (HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		String mid = (String)session.getAttribute("memberId");

		System.out.println(mid);
		memberDAO dao = new memberDAO();
		dao.Pedit(request, response, mid);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Home/SelfHome.jsp");
		rd.forward(request,response);
	}
	
	
	
	//====================================================//
	
	//=======================Log=======================//
	// 테스트용으로 로그인
	private void setLogin(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		response.setContentType("text/html;charset=utf-8");
		session.setAttribute("memberId", request.getParameter("mid"));
		response.sendRedirect("/sns/controller/HomePage");
	}
	
	private void setLogout(HttpServletRequest request,HttpServletResponse response,HttpSession session)throws ServletException, IOException{
		session.removeAttribute("memberId");
		response.sendRedirect("/sns/controller/LoginPage");
	}
	
	//====================================================//
	
	//=======================Notice=======================//
	//알림 갯수 리턴
	public int notiCount(HttpServletRequest request, HttpServletResponse response,String mid)throws ServletException, IOException {
		NotiDAO dao =new NotiDAO();
		ArrayList<String> notiList = dao.isNoti(mid);
		int notiCount = 0;
		for(int i=0;i<notiList.size();i++) {
			System.out.println("알림 : " + notiList.get(i));
			notiCount++;
		}
		return notiCount;
	}
	
	// 알림 확인
	public void CheckNoti(HttpServletRequest request, HttpServletResponse response,String mid)throws ServletException, IOException {

		NotiDAO dao =new NotiDAO();
		dao.CheckNoti(mid);

		response.sendRedirect("/sns/controller/NotiPage");
	}
	//====================================================//
	
	
	//=======================add from saemin START=======================//
	
	// Home/Home.jsp - 게시물 조회
		public String selectBoard(HttpServletRequest request, HttpServletResponse response, 
		String scroll, String bid, String comment, String commentDetail, String pageRoute, String m2id) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO(); 
			pageMove =dao.selectBoard(request, response, scroll, bid, comment, commentDetail, pageRoute, m2id);
			dao.close();
			return pageMove;
		}
		
		// Home/Home.jsp - 게시물 상세 조회
		public String selectBoardDetail(HttpServletRequest request, HttpServletResponse response, String bid) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO();
			pageMove =dao.selectBoardDetail(request, response, bid);
			dao.close();
			return pageMove;
		}

		// Home/Home.jsp - 게시물 좋아요 누가누가 조회
		public String likeWho(HttpServletRequest request, HttpServletResponse response, String scroll, String bid) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO();
			pageMove =dao.likeWho(request, response, scroll, bid);
			dao.close();
			return pageMove;
		}

		// Home/Home.jsp - 댓글 등록
		public String insertComment(HttpServletRequest request, HttpServletResponse response, String scroll, String bid, String comment) throws ServletException, IOException {
			String pageMove ="";
			commentDAO dao = new commentDAO();
			String commentDetail = request.getParameter("commentDetail");
			pageMove = dao.insertComment(request, response, scroll, bid, comment, commentDetail);
			dao.close();
			return pageMove;
		}
	//=======================add from saemin END=======================//
		
		
	//=======================add from hyunjun START=======================//
		public String selectAc(HttpServletRequest request, HttpServletResponse response, String m2id, String index, String memberId) throws ServletException, IOException {
			String pageMove ="";
			boardDAO dao = new boardDAO(); 
			pageMove =dao.selectAc(request, response, m2id, index, memberId);
			dao.close();
			return pageMove;
		}
		
	//=======================add from hyunjun END=======================//
}//class end
