package board;

import db.JDBConnect;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class boardDAO extends JDBConnect {
	
	//dto에 게시글정보 세팅한후 dto리턴
	public boardDTO setBoard(HttpServletRequest request,HttpServletResponse response, String ImageFilePath) {
		HttpSession session = request.getSession();
		boardDTO dto = new boardDTO();
		
		String memberID = (String)session.getAttribute("memberId");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		
		dto.setId(memberID);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setPhoto(ImageFilePath);
		
		return dto;
	}
	// 데이터베이스에 게시글 업로드
	public void uploadBoard(HttpServletRequest request,HttpServletResponse response, String ImageFilePath) {
		boardDTO dto = setBoard(request,response,ImageFilePath);
		String uploadSql = "insert into boardtbl(id,title,content,photo) value(?,?,?,?)";
		
		try {
			psmt = con.prepareStatement(uploadSql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getTitle());
			psmt.setString(3, dto.getContent());
			psmt.setString(4, dto.getPhoto());
			psmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
	}
	
	
	
	
}