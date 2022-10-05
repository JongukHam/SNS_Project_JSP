package member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import board.boardDTO;
import db.JDBConnect;

public class memberDAO extends JDBConnect {
	//구현해야함
	public ArrayList<String> getSearch(String searchText){
		ArrayList<String> searched = new ArrayList<String>();
		try {
			String sql = "select * from membertbl where mid like ?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,"%"+searchText+"%");
			rs = psmt.executeQuery();
			while(rs.next()) {
				searched.add(rs.getString("mid"));
			}
		}catch(Exception e) {
			
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
					delStatus="<script> alert('탈퇴 되었습니다.');location.href='/sns/Login/Login.jsp'; </script>;";
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



}