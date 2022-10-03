package member;

import db.JDBConnect;

public class memberDAO extends JDBConnect {

	public String select() {
		
        String a = ""; 
        String b = ""; 

        String query = "SELECT * FROM member";

        try {
            stmt = con.createStatement();   // 쿼리문 생성
            rs = stmt.executeQuery(query);  // 쿼리 실행
            if (rs.next()) {
            	a = rs.getString(1);
            	b = rs.getString(2);
            }
            System.out.println("게시물 수 구하기 성공");
        }
        catch (Exception e) {
            System.out.println("게시물 수 구하기 실패");
            e.printStackTrace();
        }

        return a + "   " + b; 
    }
}