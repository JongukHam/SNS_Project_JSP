package member;

import java.util.ArrayList;

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
}