package board;

import db.JDBConnect;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import comment.commentDTO;

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
		String uploadSql = "insert into boardtbl(id,content,photo) value(?,?,?)";
		
		try {
			psmt = con.prepareStatement(uploadSql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getPhoto());
			psmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close();
		}
	}
	
	
	//=======================add from saemin START=======================//
	// Home/Home - 게시물 조회
		public String selectBoard(HttpServletRequest request, HttpServletResponse response, String scroll, String bid, String comment, String commentDetail, String pageRoute) {
			String pageMove = "/Home/Home.jsp";
			ArrayList<boardDTO> listBoard = new ArrayList<boardDTO>();
			ArrayList<commentDTO> listComment = new ArrayList<commentDTO>();
			ArrayList<boardDTO> likeWhoId = new ArrayList<boardDTO>();
			
			ResultSet rs2;
	        try {
	        	String query = "SELECT A.bid, A.content, A.likecount, A.birth, A.id, A.photo, B.pfp, B.mid\r\n"
	        			+ ", (SELECT count(content) FROM commenttbl C WHERE A.bid = C.id) as '댓글 갯수'\r\n"
	        			+ ", A.likeWho\r\n"
	        			+ "FROM boardtbl A, membertbl B, commenttbl C GROUP BY A.bid ORDER BY birth DESC";
	            stmt = con.createStatement();
	            rs = stmt.executeQuery(query);
	            
	            // commenttbl에 댓글이 1개 이상일때
	            if (rs.next()) {
	            	rs = stmt.executeQuery(query);
	            	while (rs.next()) {
	                	boardDTO bdto = new boardDTO();
	                	bdto.setBid(rs.getString("bid"));
	                    bdto.setContent(rs.getString("content"));     
	                    bdto.setLikeCount(rs.getString("likeCount"));
	                    String[] birth = rs.getString("birth").substring(0, 10).split("-");
	    				if (birth[1].substring(0, 1).equals("0")) {
	    					birth[1] = birth[1].substring(1);
	    				}
	    				if (birth[2].substring(0, 1).equals("0")) {
	    					birth[2] = birth[2].substring(1);
	    				}
	    				bdto.setBirth(birth[0] + "년 " + birth[1] + "월 " + birth[2] + "일");
	                    bdto.setPfp(rs.getString("pfp"));
	                    bdto.setId(rs.getString("id"));
	                    bdto.setPhoto(rs.getString("photo"));
	                    bdto.setCommentCount(rs.getString(9));
	                    
	                    ////////////////////////////////////////////
	                    // 좋아요 리스트 조회에 필요한 코드, 미완성
	                    
	                    String db =  rs.getString("likeWho"); // a, b
	                    String[] db2 = db.split(", ");
		            	
		            	
		            	for (int i = 0; i < db2.length; i++) {
		            		boardDTO bdtoLike = new boardDTO();
		            		bdtoLike.setLikeId(db2[i]);
		            		bdtoLike.setBid(rs.getString("bid"));
		            		likeWhoId.add(bdtoLike);
		        		}
	                    
	                    
	                    //////////////////////////////////////////
	                    
	                    listBoard.add(bdto);
	                    
	                    if (!rs.getString(9).equals("0")) {
	                    	query = "SELECT DISTINCT C.cid, C.content, C.birth, C.likeCount, C.id\r\n"
	                    			+ ", (SELECT B.pfp FROM membertbl B WHERE C.cid=B.mid)\r\n"
	                    			+ "FROM membertbl B, commenttbl C WHERE id=?";
	                    	psmt = con.prepareStatement(query);
	                    	psmt.setString(1, rs.getString("bid"));
	    					rs2 = psmt.executeQuery();
	    					
	    					while (rs2.next()) {
	    						commentDTO cdto = new commentDTO();
	    						cdto.setContent(rs2.getString("content"));
	    						String[] birth2 = rs2.getString("birth").substring(0, 10).split("-");
	    						if (birth2[1].substring(0, 1).equals("0")) {
	    							birth2[1] = birth2[1].substring(1);
	    						}
	    						if (birth[2].substring(0, 1).equals("0")) {
	    							birth2[2] = birth2[2].substring(1);
	    						}
	    						cdto.setBirth(birth2[0] + "년 " + birth2[1] + "월 " + birth2[2] + "일");
	    						cdto.setLikeCount(rs2.getString("likeCount"));
	    						cdto.setId(rs2.getString("id"));
	    						cdto.setCid(rs2.getString("cid"));
	    						cdto.setPfp(rs2.getString(6));
	    						listComment.add(cdto);
	    					}
	    				}
	    			}
				}
	            
	            // commenttbl에 댓글이 없을때
	            else {
					try {
						query = "SELECT A.bid, A.content, A.likecount, A.birth, A.id, A.photo, B.pfp, B.mid\r\n"
								+ "FROM boardtbl A, membertbl B GROUP BY A.bid ORDER BY birth DESC";
			            stmt.close();
			            rs.close();
						stmt = con.createStatement();
			            rs = stmt.executeQuery(query);
			            
			            while (rs.next()) {
		                	boardDTO bdto = new boardDTO();
		                	bdto.setBid(rs.getString("bid"));
		                    bdto.setContent(rs.getString("content"));     
		                    bdto.setLikeCount(rs.getString("likeCount"));
		                    String[] birth = rs.getString("birth").substring(0, 10).split("-");
		    				if (birth[1].substring(0, 1).equals("0")) {
		    					birth[1] = birth[1].substring(1);
		    				}
		    				if (birth[2].substring(0, 1).equals("0")) {
		    					birth[2] = birth[2].substring(1);
		    				}
		    				bdto.setBirth(birth[0] + "년 " + birth[1] + "월 " + birth[2] + "일");
		                    bdto.setPfp(rs.getString("pfp"));
		                    bdto.setId(rs.getString("id"));
		                    bdto.setPhoto(rs.getString("photo"));
		                    bdto.setCommentCount("0");
		                    listBoard.add(bdto);
		    			}
			            
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
	            
	            // board
	            request.setAttribute("listBoard", listBoard);
	            request.setAttribute("listComment", listComment);
	            
	            // 좋아요
	            request.setAttribute("likeWhoId", likeWhoId);
	            
	            // 댓글
	            request.setAttribute("bid", bid);
	            request.setAttribute("comment", comment);
	            request.setAttribute("commentDetail", commentDetail);
	            request.setAttribute("pageRoute", pageRoute);
	            
	            System.out.println("게시물 조회 성공");
	        }
	        catch (Exception e) {
	            System.out.println("게시물 조회 실패");
	            e.printStackTrace();
	        }
	        return pageMove;
	    }
			
		// Home/Home - 게시물 상세 조회
		public String selectBoardDetail(HttpServletRequest request, HttpServletResponse response, String bid) {
			
			ArrayList<boardDTO> listBoardDetail = new ArrayList<boardDTO>();
			ArrayList<commentDTO> listCommentDetail = new ArrayList<commentDTO>();
			ResultSet rs2;
			Statement psmt2;
			String pageMove = "/Home/HomeComment.jsp";
	        
	        try {
	        	String query = "SELECT A.bid, A.content, A.likecount, A.birth, A.id, A.photo, B.pfp, B.mid\r\n"
	        			+ ", (SELECT count(content) FROM commenttbl C WHERE C.id=A.bid)\r\n"
	        			+ ", (SELECT pfp FROM boardtbl A, membertbl B WHERE A.bid=? AND A.id = B.mid)\r\n"
	        			+ "FROM boardtbl A, membertbl B, commenttbl C WHERE A.bid=? GROUP BY A.bid";
	            psmt = con.prepareStatement(query);
	        	psmt.setString(1, bid);
	        	psmt.setString(2, bid);
				rs = psmt.executeQuery();
				
				while (rs.next()) {
	            	boardDTO bdto = new boardDTO();
	            	bdto.setBid(rs.getString("bid"));
	                bdto.setContent(rs.getString("content"));     
	                bdto.setLikeCount(rs.getString("likeCount"));
	                String[] birth = rs.getString("birth").substring(0, 10).split("-");
					if (birth[1].substring(0, 1).equals("0")) {
						birth[1] = birth[1].substring(1);
					}
					if (birth[2].substring(0, 1).equals("0")) {
						birth[2] = birth[2].substring(1);
					}
					bdto.setBirth(birth[0] + "년 " + birth[1] + "월 " + birth[2] + "일");
	                bdto.setId(rs.getString("id"));
	                bdto.setPhoto(rs.getString("photo"));
	                bdto.setCommentCount(rs.getString(9));
	                bdto.setPfp(rs.getString(10));
	                listBoardDetail.add(bdto);
	                
	                if (!rs.getString(9).equals("0")) {
	                	query = "SELECT DISTINCT C.cid, C.content, C.birth, C.likeCount, C.id\r\n"
	                			+ ", (SELECT B.pfp FROM membertbl B WHERE C.cid=B.mid)\r\n"
	                			+ "FROM membertbl B, commenttbl C WHERE id=?";
	                	psmt = con.prepareStatement(query);
	                	psmt.setString(1, bid);
						rs2 = psmt.executeQuery();
						
						while (rs2.next()) {
							commentDTO cdto = new commentDTO();
							cdto.setContent(rs2.getString("content"));
							String[] birth2 = rs2.getString("birth").substring(0, 10).split("-");
							if (birth2[1].substring(0, 1).equals("0")) {
								birth2[1] = birth2[1].substring(1);
							}
							if (birth[2].substring(0, 1).equals("0")) {
								birth2[2] = birth2[2].substring(1);
							}
							cdto.setBirth(birth2[0] + "년 " + birth2[1] + "월 " + birth2[2] + "일");
							cdto.setLikeCount(rs2.getString("likeCount"));
							cdto.setId(rs2.getString("id"));
							cdto.setCid(rs2.getString("cid"));
							cdto.setPfp(rs2.getString(6));
							listCommentDetail.add(cdto);
						}
					}
				}
				
	            
	            request.setAttribute("listBoardDetail", listBoardDetail);
	            request.setAttribute("listCommentDetail", listCommentDetail);
	            
	            System.out.println("상세 게시물 조회 성공");
	        }
	        catch (Exception e) {
	            System.out.println("상세 게시물 조회 실패");
	            e.printStackTrace();
	        }
	        
	        return pageMove;
	    }
		

		// Home/Home.jsp - 게시물 좋아요 누가누가 조회
		public String likeWho(HttpServletRequest request, HttpServletResponse response, String scroll, String bid) {
			
	        String pageMove = "/Home/Home.jsp";
	        HttpSession session = request.getSession();
	        String memberId = (String)session.getAttribute("memberId");
	        session.setAttribute("scroll", scroll);
	        
	        try {
	        	String query = "SELECT likeWho FROM boardtbl WHERE bid=?";
	        	
	            psmt = con.prepareStatement(query);
	        	psmt.setString(1, bid);
	        	rs = psmt.executeQuery();
				
	        	// null만 아니면 if 들어감(사실상 무조건 들어감. 왜 이렇게 해놨지?)
	        	if (rs.next()) {
					String db = rs.getString(1);
					
					// 좋아요 아무도 안눌렀으면 첫 좋아요
					if (db.equals("")) {
						try {
							query = "UPDATE boardtbl SET likeWho = ? WHERE bid = ?";
							psmt.close();
							rs.close();
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, memberId);
				        	psmt.setString(2, bid);
				        	psmt.executeUpdate();
				        	
				        	query = "UPDATE boardtbl SET likecount = likecount + 1 WHERE bid = ?";
				        	psmt.close();
							rs.close();
				        	psmt = con.prepareStatement(query);
				        	psmt.setString(1, bid);
				        	psmt.executeUpdate();
				        	
							System.out.println(memberId + "가 " + bid + "번 게시글 첫 좋아요 성공");
						} 
						catch (Exception e) {
							System.out.println(memberId + "가 " + bid + "번 게시글 첫 좋아요 실패");
							e.printStackTrace();
						}
					}
					
					// 좋아요 1 이상일때
					else {

						String[] db2 = db.split(", ");
		            	ArrayList<boardDTO> likeWho = new ArrayList<boardDTO>();
		            	
		            	// 변수 db에 담긴 문자열들(아이디들)을 ,와 공백을 제거하여(숫자만 골라내기위해서) ArrayList에 담는다
		            	for (int i = 0; i < db2.length; i++) {
		            		boardDTO bdto = new boardDTO();
		            		bdto.setId(db2[i]);
		            		likeWho.add(bdto);
		        		}
		            	
		            	// 현재 로그인한 아이디가 ArrayList에 있는지 검색
		            	for (int i = 0; i < likeWho.size(); i++) {
		            		
		            		// 현재 로그인한 아이디가 ArrayList에 있으면(이미 좋아요를 눌렀으면) likeWho 배열에서 아이디 삭제
							if (likeWho.get(i).getId().equals(memberId)) {
								likeWho.remove(i);
								db = "";
							}
		            	}
		            	
		            	// 현재 로그인한 아이디가 ArrayList에 있으면 좋아요 취소	            	
		            	if (db.equals("")) {
							
		            		// 현재 로그인한 아이디가 삭제된 ArrayList에 있는 값들을 다시 Database에 넣기위해 변수 db에 담는다
			            	for (int k = 0; k < likeWho.size(); k++) {
			        			if (k == likeWho.size() - 1) {
			        				db += likeWho.get(k).getId();
			        				break;
			        			}
			        			db += likeWho.get(k).getId() + ", ";
			        		}
			            	
			            	try {
			            		query = "UPDATE boardtbl SET likeWho = ? WHERE bid = ?";
								psmt.close();
								rs.close();
					        	psmt = con.prepareStatement(query);
					        	psmt.setString(1, db);
					        	psmt.setString(2, bid);
					        	psmt.executeUpdate();
					        	
					        	query = "UPDATE boardtbl SET likecount = likecount - 1 WHERE bid = ?";
					        	psmt.close();
								rs.close();
					        	psmt = con.prepareStatement(query);
					        	psmt.setString(1, bid);
					        	psmt.executeUpdate();
					        	System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 취소 성공");
							} catch (Exception e) {
								e.printStackTrace();
								System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 취소 실패");
							}
						}
								
						// 현재 로그인한 아이디가 ArrayList에 없으면 좋아요
						else {
							try {
								query = "UPDATE boardtbl SET likeWho = CONCAT(likeWho, ?) WHERE bid = ?";
								psmt.close();
								rs.close();
					        	psmt = con.prepareStatement(query);
					        	psmt.setString(1, ", " + memberId);
					        	psmt.setString(2, bid);
					        	psmt.executeUpdate();

					        	query = "UPDATE boardtbl SET likecount = likecount + 1 WHERE bid = ?";
					        	psmt.close();
								rs.close();
					        	psmt = con.prepareStatement(query);
					        	psmt.setString(1, bid);
					        	psmt.executeUpdate();
					        	
					        	System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 성공");
							} catch (Exception e) {
								e.printStackTrace();
								System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 실패");
								
							}
						}
						request.setAttribute("likeWho", likeWho);
					}
				}
	            System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 조회 성공");
	        }
	        catch (Exception e) {
	        	System.out.println(memberId + "가 " + bid + "번 게시글 좋아요 조회 실패");
	            e.printStackTrace();
	        }
	        return pageMove;
	    }
		
	
	//=======================add from saemin END=======================//
	
	
}