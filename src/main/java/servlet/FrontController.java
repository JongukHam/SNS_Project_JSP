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
		case "/AcHomePage":
			request.getRequestDispatcher("/Home/AcHome.jsp").forward(request, response);
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
		
		//임시
		case "/Login":
			setLogin(request,response,session);
			break;

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
	
}//class end
