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
		//goHome 이라는 요청이 들어오면 리다이렉트로 Home.jsp로 가도록 함.
		case "/goHome":
			System.out.println(requestURI);
			goHome(request,response);
			break;
		case "/getSearch":
			System.out.println(requestURI);
			useSearch(request,response);
			break;
		case "/uploadBoard":
			System.out.println(requestURI);
			uploadBoard(request,response);
			break;
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
		case "/deleteAccount" :
			System.out.println(requestURI);
			deleteAccount(request,response);
			break;

		}
		
	}
	
	//=======================Nav=======================//
	// 홈으로 가기
	private void goHome(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.sendRedirect("/sns/Home/Home.jsp");
	}
	// 검색한 문자가 포함된 아이디를 arraylist에 담아서 arraylist 리턴
	private void useSearch(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		String searchText = request.getParameter("searchText");
		memberDAO dao = new memberDAO();
		
		ArrayList<String> searchedMid = dao.getSearch(searchText);
		request.setAttribute("searchedList", searchedMid);
		RequestDispatcher rd = request.getRequestDispatcher("/Home/AcHome.jsp");
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
	public void showMemberInfo (HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
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
	public void deleteAccount(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
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
	
	//=======================Setting=======================//
	
	//=======================Log=======================//
	// 테스트용으로 로그인
	public void setLogin(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();

		response.setContentType("text/html;charset=utf-8");
		session.setAttribute("memberId", request.getParameter("mid"));
		response.sendRedirect("/sns/Home/Home.jsp");
	}
	
	public void setLogout(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		HttpSession session = request.getSession();
		session.removeAttribute("memberId");
		response.sendRedirect("/sns/Login/Login.jsp");
	}
	
	//=======================Log=======================//
	
	
	
}//class end
