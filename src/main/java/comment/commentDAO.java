package comment;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import db.JDBConnect;


public class commentDAO extends JDBConnect {

	
	//=======================add from saemin START=======================//
		// Home/Home - 댓글 등록
		public String insertComment(HttpServletRequest request, HttpServletResponse response, String bid, String comment, String commentDetail, String boardCount) {
			
			HttpSession session = request.getSession();
			session.setAttribute("boardCount", boardCount);
			String memberId = (String)session.getAttribute("memberId");
	        
			String pageMove="";
	    	try {
	        	String query = "INSERT INTO commenttbl(cid, content, id) VALUES(?, ?, ?)";
	            psmt = con.prepareStatement(query);
	        	psmt.setString(1, memberId);
	        	psmt.setString(2, comment);
	        	psmt.setString(3, bid);
	        	psmt.executeUpdate();
	            System.out.println(memberId + "가 " + bid + "번 게시글에 \"" + comment + "\" 내용으로 작성 성공");
	        }
	        catch (Exception e) {
	        	System.out.println(memberId + "가 " + bid + "번 게시글에 \"" + comment + "\" 내용으로 작성 실패");
	            e.printStackTrace();
	        }
	        
	    	if (commentDetail.equals("Home")) {
				pageMove = "/Home/Home.jsp";
			}
			else if (commentDetail.equals("HomeComment")) {
				pageMove = "/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=" + bid;
			}
	    	return pageMove;
	    }
		
		//=======================add from saemin END=======================//
}