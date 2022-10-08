package member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

	
	

}