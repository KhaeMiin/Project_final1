<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.RcommentDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="data.dto.LoginDto"%>
<%@page import="data.dao.LoginDao"%>
<%@page import="data.dto.RcommentDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
div.commentlist {
	width: 600px;
	margin-bottom: 30px;
}
div.icon {
	margin-left: 10px;
	margin-bottom: 10px;
	width: 90px;
}
div.icon>img {
	width: 30px;
	height: 100%;
}
div>img,div>span:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function () {
	$("div.commentlist").hide();
	$("div.icon").click(function () {
		$("div.commentlist").toggle();
	});
	
	// 댓글 삭제
	$("span.cdel").click(function () {
		let idx = $(this).attr("idx");
		let tag = $(this);
		//alert(idx);
		// 삭제확인창
		let cancel = confirm("댓글을 삭제하시겠습니까?");
		if(cancel){
			$.ajax({
				type:"get",
				dataType:"html",
				url:"review/commentDel.jsp",
				data:{"idx":idx},
				success:function(){
				//새로고침
					location.reload();
				}
			});
			
		}
		
	});
});
</script>
</head>

<% 
	String num = request.getParameter("num");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

	//아이디,닉네임 얻기
	String email = (String)session.getAttribute("myid");
	LoginDao Ldao = new LoginDao();
	LoginDto Ldto = Ldao.getUserInfo(2, email);
	//String rname = Ldto.getName();
	
	ReviewDao dao = new ReviewDao();
	RcommentDao rdao = new RcommentDao();
	
	//글번호에 대한 데이터
	ReviewDto dto = dao.getReviewData(num);
	
	List<RcommentDto> rlist = rdao.getAllcomment(dto.getNum());
	
	// 세션
	String login = (String)session.getAttribute("loginok");
	
	// 댓글 수
	int totalComment;
	totalComment = rdao.getCount(num);
	//System.out.println(totalComment);
	
%>

<body>

<!-- 댓글 리스트 -->
<div class="icon">
	<img src="images/review_comment.png"><span style="margin-left:8px;">댓글</span>
	<span><%= totalComment %></span>
</div>
<div class="commentlist">
	<table table class="table table-bordered" style="width: 900px;">
	<% 
			if(totalComment==0){
	%>
		<tr style="height: 60px;">
			<td style="padding-top: 20px;">
				<span style="margin-left: 10px;">댓글이 없습니다</span>
			</td>
		</tr>
	<% }else{
		for(RcommentDto rdto:rlist){
	%>
		<tr>
			<td align="left">
			<div style="margin-top: 8px;">
				<span class="glyphicon glyphicon-user" style="font-size: 20px; font-size: 15px; margin-right: 8px; padding-left: 10px;"></span>
				<% 
					String rname = rdto.getName();
				%>
				<span><%= rname %></span>
				<% // 후기글email=댓글email 경우 작성자 나오게
					if(dto.getEmail().equals(rdto.getEmail())){
				%>
					<span style="color: red; font-size: 8pt; margin-left: 8px;">작성자</span>
					<% } %><br>
			</div>
				<span style="padding-left: 40px;">
					<%= rdto.getContent().replace("\n", "<br>") %>
				</span><br>
				<span style=" margin-left: 10px; font-size: 8pt; color:gray; padding-left: 30px;">
					<%= sdf.format(rdto.getWriteday()) %>
				</span>
				<% // 로그인이면서 로그인한email=댓글작성자email or 관리자
					if(login!=null && rdto.getEmail().equals(email) || email.equals("admin")){
				%>
				<span class="glyphicon glyphicon-trash cdel" style="font-size: 12pt; cursor: pointer; margin-left: 820px; line-height: 30px;" idx="<%= rdto.getIdx() %>"></span>
				<% } %>
			</td>
		</tr>
		<% } 
		} %>
			<%
					// 입력폼은 로그인한 경우에만 보이게 하기
				if(login!=null){
			%>
					<jsp:include page="XXcommentForm.jsp"/>
			<% } %>
	</table>
	
	
</div>

</body>
</html>