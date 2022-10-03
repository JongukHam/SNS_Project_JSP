package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

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
		case "/saveImage":
			System.out.println(requestURI);
			saveImage(request,response);
			break;
		}
		
	}
	
	//=======================Nav=======================//
	// 홈으로 가기
	private void goHome(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		response.sendRedirect("/sns/Home/Home.jsp");
	}
	// 검색한 아이디의 페이지로 이동하기 포워드로 아이디 정보를 아이디페이지 보여주는 메소드로 넘기게 한다.
	private void useSearch(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		String searchText = request.getParameter("searchText");
		ArrayList<memberDTO> list;
		memberDAO dao = new memberDAO();
		list = dao.getSearch(searchText);
		
		request.setAttribute("List", list);
		RequestDispatcher rd = request.getRequestDispatcher("/Home/AcHome.jsp");
		rd.forward(request,response);
	}

	//=======================Nav=======================//
	
	
	
	//=======================Write=======================//
	
	private void saveImage(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException{
		request.setCharacterEncoding("UTF-8");
		
		UploadUtil uploadUtil = UploadUtil.create(request.getServletContext());
		
		List<Part> parts = (List<Part>) request.getParts();
		
		for(Part part : parts) {
			
			if(!part.getName().equals("ImageFile")) continue; //ImageFile로 들어온 Part가 아니면 스킵
			if(part.getSubmittedFileName().equals("")) continue; //업로드 된 파일 이름이 없으면 스킵
			
			String fileName = part.getSubmittedFileName();
			
			uploadUtil.saveFiles(part, uploadUtil.createFilePath());
			System.out.println(fileName);
		}
		
	}
	
	
	
	
	//=======================Write=======================//
	
	
	
}//class end
