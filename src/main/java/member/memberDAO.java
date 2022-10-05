package member;

import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.boardDTO;
import db.JDBConnect;

public class memberDAO extends JDBConnect {

	public ArrayList<memberDTO> getSearch(String searchText){
		ArrayList<memberDTO> searched = new ArrayList<memberDTO>();
		try {
			String sql = "select * from membertbl where mid=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1,searchText);
			rs = psmt.executeQuery();
			while(rs.next()) {
				memberDTO dto = new memberDTO();
				dto.setMid(rs.getString("mid"));
				searched.add(dto);
				System.out.println(dto.getMid());
			}
		}catch(Exception e) {
			
		}finally {
			close();
		}
		return searched;
	}
	
	
	
	
	

	
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
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
		
		return memberInfo;
	}

	public void deleteAccount(HttpServletRequest request,HttpServletResponse response, String mid, String password) {
		memberDTO dto = new memberDTO();
		
	}



}