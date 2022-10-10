package member;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import board.boardDTO;
import db.JDBConnect;

public class memberDAO extends JDBConnect {
	
	//검색한 문자가 포함된 아이디를 리스트 리턴
	public ArrayList<memberDTO> getSearch(String searchText){
		ArrayList<memberDTO> searched = new ArrayList<memberDTO>();
		try {
			String sql = "select * from membertbl where mid like ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,"%"+searchText+"%");
			rs = psmt.executeQuery();
			while(rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setPhone(rs.getString("phone"));
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
				dto.setBirth(sd.format(rs.getDate("birth")));
				dto.setPw(rs.getString("pw"));
				dto.setFollower(rs.getString("follower"));
				dto.setPfp(rs.getString("pfp"));
				dto.setMid(rs.getString("mid"));
				dto.setIntro(rs.getString("intro"));
				if(rs.getString("isprivate").equals("yes")) {
					dto.setIsprivate("비공개");
				}else if(rs.getString("isprivate").equals("no")) {
					dto.setIsprivate("공개");
				}else {
					dto.setIsprivate("공개");
				}
				searched.add(dto);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		return searched;
	}
	
	
	// mid를 매개변수로 받아서 db에 조회한 다음 일치하는 아이디가 있다면 dto에 셋팅하고 dto리턴
	public memberDTO getMemberInfo(HttpServletRequest request,HttpServletResponse response, String mid) {
		memberDTO memberInfo = new memberDTO();
		
		
		System.out.println(mid);
		try {
			String sql = "select * from membertbl where mid=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, mid);
			rs = psmt.executeQuery();
			while(rs.next()) {
				memberInfo.setName(rs.getString("name"));
				memberInfo.setEmail(rs.getString("email"));
				memberInfo.setPhone(rs.getString("phone"));
				SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd");
				memberInfo.setBirth(sd.format(rs.getDate("birth")));
				memberInfo.setPw(rs.getString("pw"));
				memberInfo.setFollower(rs.getString("follower"));
				memberInfo.setPfp(rs.getString("pfp"));
				memberInfo.setMid(mid);
				memberInfo.setIntro(rs.getString("intro"));
				if(rs.getString("isprivate").equals("yes")) {
					memberInfo.setIsprivate("비공개");
				}else if(rs.getString("isprivate").equals("no")) {
					memberInfo.setIsprivate("공개");
				}else {
					memberInfo.setIsprivate("공개");
				}
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return memberInfo;
	}
	
	
	// 데이터베이스에서 멤버 찾아서 삭제
	public String deleteAccount(HttpServletRequest request,HttpServletResponse response, String mid, String password,HttpSession session) {
		memberDTO dto = getMemberInfo(request,response,mid);
		//JDBC 에 reConnect 만듦
		reConnect();
		String delStatus = "";
		String sql = "delete from membertbl where mid=? and pw=?";
		if(dto.getPw().equals(password)) {
			try {
				psmt = con.prepareStatement(sql);
				psmt.setString(1, mid);
				psmt.setString(2, password);
				
				if(psmt.executeUpdate()>0) {
					session.removeAttribute("memberId");
					delStatus="<script> alert('탈퇴 되었습니다.');location.href='/sns/Login/LoginPage'; </script>;";
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				close();
			}
		}else {
			delStatus="<script> alert('비밀번호가 일치하지 않습니다.');location.href='/sns/controller/SettingPage'; </script>;";
		}
		return delStatus;
	}
	
	
	//공개범위 변경 공개 비공개
	public String changePrivateState(HttpServletRequest request,HttpServletResponse response,memberDTO dto) {
		String changeStatus="";
		String isPrivate = dto.getIsprivate();

		String sql = "update membertbl set isprivate=? where mid= ? ";
		
		if(isPrivate.equals("공개")) {
			try {
				reConnect();
				psmt = con.prepareStatement(sql);
				psmt.setString(1, "yes");
				psmt.setString(2, dto.getMid());
				
				if(psmt.executeUpdate()>0) {
					changeStatus="<script> alert('비공개로 전환 되었습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}else {
					changeStatus="<script> alert('설정이 실패했습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				close();
			}
		}else if(isPrivate.equals("비공개")) {
			try {
				reConnect();
				psmt = con.prepareStatement(sql);
				psmt.setString(1, "no");
				psmt.setString(2, dto.getMid());
				
				if(psmt.executeUpdate()>0) {
					changeStatus="<script> alert('공개로 전환 되었습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}else {
					changeStatus="<script> alert('설정이 실패했습니다.');location.href='/sns/controller/SettingPage'; </script>;";
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally{
				close();
			}
		}else {
			changeStatus="<script> alert('설정이 실패했습니다.');location.href='/sns/controller/SettingPage'; </script>;";
		}
		return changeStatus;
	}

	

	//계정정보 수정
		public void Aedit(HttpServletRequest request, HttpServletResponse response, String mid){            
			String sql = "update membertbl set pw=?,email=?,phone=?,name=?,birth=? where mid=?";
	        
	        ResultSet rs = null;    	  
		    PreparedStatement pstmt=null;
	        try {
				pstmt= con.prepareStatement(sql);  				
				pstmt.setString(1,request.getParameter("pw"));
				pstmt.setString(2,request.getParameter("email"));
				pstmt.setString(3,request.getParameter("phone"));
				pstmt.setString(4,request.getParameter("name"));
				pstmt.setString(5,request.getParameter("birth"));
				pstmt.setString(6,mid);
				pstmt.executeUpdate();
				System.out.println("계정정보 수정");
	        }
	        catch (Exception e) {
	            System.out.println("계정정보 수정하는 중 예외 발생");
	            e.printStackTrace();
	        }      	        
			
	    }
		
	//프로필 수정(소개, 사진)
	    public void Pedit(HttpServletRequest request, HttpServletResponse response, String mid) throws IOException {	    
	    	
	    	try{
	    		String realFolder= request.getSession().getServletContext().getRealPath("/upload");//올리는 곳의 경로
	        	MultipartRequest multi= new MultipartRequest(request, realFolder, 5*1024*1024, 
	        			"utf-8", new DefaultFileRenamePolicy()); //product_set에서 넘겨받은 정보 담고있는 객체//괄호안은 

	        	Enumeration files = multi.getFileNames();		
	        	String file = (String) files.nextElement();
	        	String filename = multi.getFilesystemName(file); //올린 이미지 파일이름
	        	
	        	String intro=multi.getParameter("intro");

	        	
	        	
	        	PreparedStatement pstmt=null;   
	        	String sql=null;
	        	
	    		if(intro!=null){
		    		sql = "update membertbl set pfp=?,intro=? where mid=?";	  
		    		pstmt= con.prepareStatement(sql);	
		    		pstmt.setString(1,"../upload/"+filename); 
					pstmt.setString(2,intro);
					pstmt.setString(3,mid);
		    		pstmt.executeUpdate();
	    		}
	    		System.out.println(realFolder+filename);
	    		System.out.println("프로필 수정");

	    	} catch(SQLException ex){
	    		System.out.println("프로필 수정 실패<br>");
	    		System.out.println("SQLException : " + ex.getMessage());
	    	}     	
	    		
	    }
	   
	
	

}