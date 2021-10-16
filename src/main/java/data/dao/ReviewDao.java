package data.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.ReviewDto;
import mysql.db.DbConnect;

public class ReviewDao {

	DbConnect db = new DbConnect();
	
	//리뷰 게시글 총 갯수
	public int getTotalCount() {
		int n = 0;
		
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select count(*) from review";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				n = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return n;
	}
	
	// 페이지에서 필요한 만큼만 리턴 -페이징
	public List<ReviewDto> getReviewlist(int start, int perpage) {
		
		List<ReviewDto> list = new Vector<ReviewDto>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from review order by num desc limit ?,?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, perpage);
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ReviewDto dto = new ReviewDto();
				dto.setNum(rs.getString("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadcount(rs.getString("readcount"));
				dto.setEmail(rs.getString("email"));
				
				list.add(dto); 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// 리뷰 insert
	public void insertReview(ReviewDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "insert into review (car, subject, content, name, email, writeday) values (?,?,?,?,?,now())";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCar());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getName());
			pstmt.setString(5, dto.getEmail());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 방금 추가된 최종 시퀀스 num 값 리턴
	public String getMaxNum() {
		ReviewDto dto = new ReviewDto();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select max(num) from review";
		String num = "";
		
		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				num = rs.getString(1);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return num;
	}
	
	// 게시글 번호에 대한 데이터 가져오기
	public ReviewDto getReviewData(String num) {
		
		ReviewDto dto = new ReviewDto();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from review where num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setCar(rs.getString("car"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getString("readcount"));
				dto.setChu(rs.getInt("chu"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	// 조회수 증가
	public void updateReadcount(String num) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "update review set readcount=readcount+1 where num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 리뷰 게시글 수정
	public void updateReview(ReviewDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		String sql = "update review set car=?, subject=?, content=?, name=? where num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getCar());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getName());
			pstmt.setString(5, dto.getNum());
			
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 리뷰 게시글 삭제
	public void reviewdel(String num) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "delete from review where num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			pstmt.execute();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}
	
	// 추천수 증가
	public void updateChu(String num) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		
		String sql = "update review set chu=chu+1 where num=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, num);
			
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 이전글 데이터 반환
	public ReviewDto getReviewPre(String num) {
		
		ReviewDto dto = new ReviewDto();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from review where num < ? order by num desc limit 1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setCar(rs.getString("car"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getString("readcount"));
				dto.setChu(rs.getInt("chu"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	// 다음글 데이터 반환
	public ReviewDto getReviewNext(String num) {
		
		ReviewDto dto = new ReviewDto();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from review where num > ? order by num asc limit 1";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setCar(rs.getString("car"));
				dto.setEmail(rs.getString("email"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcount(rs.getString("readcount"));
				dto.setChu(rs.getInt("chu"));
				dto.setWriteday(rs.getTimestamp("writeday"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	// 리뷰 전체 데이터 반환 (해민 추가)
	public List<ReviewDto> getTotal() {
		      
		List<ReviewDto> list = new Vector<ReviewDto>();
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from review";

		try {
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDto dto = new ReviewDto();
				dto.setNum(rs.getString("num"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setName(rs.getString("name"));
				dto.setWriteday(rs.getTimestamp("writeday"));
				dto.setReadcount(rs.getString("readcount"));
				dto.setEmail(rs.getString("email"));
				dto.setCar(rs.getString("car"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	// 테스트
	public ArrayList<ReviewDto> getlist(String sDivide, String search, int pageNumber) {
	//public ArrayList<ReviewDto> getlist(String sDivide, String searchType, String search, int pageNumber) {
	//	if(sDivide.equals("전체")) {
	//		sDivide = "";
	//	}
		ArrayList<ReviewDto> reviewList = null;
		String sql = "";
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			if(sDivide.equals("제목")) {
				sql = "select * from review where subject like ? order by num desc limit "+pageNumber*10+", "+pageNumber*10+11;
			} else if (sDivide.equals("내용")) {
				sql = "select * from review where content like ? order by num desc limit "+pageNumber*10+", "+pageNumber*10+11;
			}
			
			conn = db.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+sDivide+"%");
			
			if(sDivide.equals("car")) {
				sql = "select * from review where car like ? order by num desc limit "+pageNumber*10+","+pageNumber*10+11;
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%"+sDivide+"%");
			pstmt.setString(2, "%"+search+"%");
			
			rs = pstmt.executeQuery();
			
			reviewList = new ArrayList<ReviewDto>();
			
			while (rs.next()) {
				ReviewDto Review = new ReviewDto();
				Review.setNum(rs.getString("num"));
				Review.setName(rs.getString("name"));
				Review.setCar(rs.getString("car"));
				Review.setEmail(rs.getString("email"));
				Review.setSubject(rs.getString("subject"));
				Review.setContent(rs.getString("content"));
				Review.setReadcount(rs.getString("readcount"));
				Review.setChu(rs.getInt("chu"));
				Review.setWriteday(rs.getTimestamp("writeday"));
				
				reviewList.add(Review);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return reviewList;
		
	}
	
	
	
}