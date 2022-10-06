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
		request.setCharacterEncoding("utf-8");
		String requestURI = request.getRequestURI();
		int lastSlash = requestURI.lastIndexOf("/");
		requestURI = requestURI.substring(lastSlash);
		
		
		switch(requestURI) {
		//Nav
		case "/goHome":
			System.out.println(requestURI);
			goHome(request,response);
			break;
		//Nav
		case "/getSearch":
			System.out.println(requestURI);
			useSearch(request,response);
			break;
		//Nav
		case "/goMyPage":
			System.out.println(requestURI);
			goMyPage(request,response);
			break;
		//Write
		case "/uploadBoard":
			System.out.println(requestURI);
			uploadBoard(request,response);
			break;
		//Setting
		case "/SettingPage":
			System.out.println(requestURI);
			showMemberInfo(request,response);
			break;
		//임시
		case "/Login":
			System.out.println(requestURI);
			setLogin(request,response);
			break;
		case "/Logout":
			System.out.println(requestURI);
			setLogout(request,response);
			break;
		//Setting
		case "/deleteAccount" :
			System.out.println(requestURI);
			deleteAccount(request,response);
			break;
		case "/changePrivateStatus":
			System.out.println(requestURI);
			setPrivateAc(request,response);
			break;
		}
		
	}
	
	//=======================Nav=======================//
	// 홈으로 가기
	private void goHome(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.sendRedirect("/sns/Home/Home.jsp");
	}
	
	
	// 내 페이지 가기
	private void goMyPage(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		// 한글로 출력 위해서
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");
		
		PrintWriter out = response.getWriter();
		
		if((String)session.getAttribute("memberId") != null) {
			String mid = (String)session.getAttribute("memberId");
			if(!mid.equals("")) {
				response.sendRedirect("/sns/Home/SelfHome.jsp");
			}else {
				out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/goHome'; </script>;");
				out.close();
			}
		}else {
			out.println("<script> alert('로그인 해 주십시오');location.href='/sns/controller/goHome'; </script>;");
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
	

	//=======================Nav=======================//
	
	
	
	//=======================Write=======================//
	// 이미지 저장하고 ImageFile 아래 경로 구함
	private void uploadBoard(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{

		request.setCharacterEncoding("UTF-8");
		//이미지 파일이 저장될 기본위치와, 실제 저장될 파일명
		// /Users/uk/Coding/Project/JSP/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/sns/ImageFile
		String ImageFolderPath = request.getServletContext().getRealPath("/ImageFile");
		String ImageFilePath = "";
		
		UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());

		List<Part> parts = (List<Part>) request.getParts();
//		System.out.println("title : " + request.getParameter("title"));
//		System.out.println("content : " + request.getParameter("content"));
		
		for(Part part : parts) {
			if(!part.getName().equals("ImageFile")) continue; //ImageFile로 들어온 Part가 아니면 스킵
			if(part.getSubmittedFileName().equals("")) continue; //업로드 된 파일 이름이 없으면 스킵
			System.out.println(part.getName());
			//String fileName = part.getSubmittedFileName();
			
			ImageFilePath = uploadUtil.saveFiles(part, uploadUtil.createFilePath());
			
			System.out.println("=========saveImage=========");
			System.out.println("ImageFolderPath : " + ImageFolderPath);
			System.out.println("ImageFilePath : " + ImageFilePath);
			System.out.println("=========saveImage=========");
		}
		boardDAO dao = new boardDAO();
		dao.uploadBoard(request, response, ImageFilePath);
	}
	

	
	
	//=======================Write=======================//
	
	
	//=======================Setting=======================//
	//setting 페이지에 로그인된 회원 정보 뿌림
	private void showMemberInfo (HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		String mid = (String)session.getAttribute("memberId");

		System.out.println(mid);
		memberDAO dao = new memberDAO();
		memberDTO dto = dao.getMemberInfo(request, response, mid);
		request.setAttribute("memberInfo", dto);
		
		RequestDispatcher rd = request.getRequestDispatcher("/Setting/Setting.jsp");
		rd.forward(request,response);
	}
	// 로그인된 회원 계정 삭제관련
	private void deleteAccount(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		PrintWriter out = response.getWriter();
		
		String mid = (String)session.getAttribute("memberId"); //세션에 로그인되있는 아이디
		String enterPassword = request.getParameter("password"); // 삭제를 위해서 입력한 비밀번호

		memberDAO dao = new memberDAO();
		String delStatus = dao.deleteAccount(request, response, mid, enterPassword,session);
		
		out.println(delStatus);
		out.close();
	}
	
	// 계정상태 비공개로 전환(공개="no" 비공개="yes")
	private void setPrivateAc(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		
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
	
	
	
	//=======================Setting=======================//
	
	//=======================Log=======================//
	// 테스트용으로 로그인
	private void setLogin(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();

		response.setContentType("text/html;charset=utf-8");
		session.setAttribute("memberId", request.getParameter("mid"));
		response.sendRedirect("/sns/Home/Home.jsp");
	}
	
	private void setLogout(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		session.removeAttribute("memberId");
		response.sendRedirect("/sns/Login/Login.jsp");
	}
	
	//=======================Log=======================//
	
	
	
}//class end
