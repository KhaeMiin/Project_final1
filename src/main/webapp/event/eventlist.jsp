<%@page import="data.dao.EventDao"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.EventDto"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400;700&display=swap" rel="stylesheet">
<style type="text/css">
table{
	margin : auto;
    width: 800px;
    height: 200px;
    border-top:solid 1px gray;
 	font-family: 'Noto Sans KR', sans-serif;
}

</style>
</head>
<%
	EventDao dao=new EventDao();
	//페이징 처리에 필요한 변수선언
	int perPage=5;//한페이지에 보여질 글의 갯수
	int totalCount; //총 글의 수
	int currentPage;//현재 페이지번호
	int totalPage;//총 페이지수
	int start;//각페이지에서 불러올 db 의 시작번호
	int perBlock=5;//몇개의 페이지번호씩 표현할것인가
	int startPage; //각 블럭에 표시할 시작페이지
	int endPage; //각 블럭에 표시할 마지막페이지
	//총 갯수
	totalCount=dao.getTotalCount();
	//현재 페이지번호 읽기(단 null 일경우는 1페이지로 설정)
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	//총 페이지 갯수 구하기
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	//각 블럭의 시작페이지
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
	if(endPage>totalPage)
		endPage=totalPage;
	//각 페이지에서 불러올 시작번호
	start=(currentPage-1)*perPage;
	//각페이지에서 필요한 게시글 가져오기
	List<EventDto> list=dao.getList(start, perPage);
	if(list.size()==0 && totalCount>0)
	{%>
	<script type="text/javascript">
	 location.href="index.jsp?main=event/eventlist.jsp?currentPage=<%=currentPage-1%>";		
	</script>
	<%}
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy년 MM월dd일 HH:mm z");
	//각페이지에 출력할 시작번호
	int no=totalCount-(currentPage-1)*perPage;
%>


<body>
    <section style="height: 100px;background-image: url('images/bg_2.jpg');"  data-stellar-background-ratio="0.5">
    </section>
    
<section style="margin-top:20px; margin-bottom:20px;">
<button type="button" class="btn btn-success"
style="width: 100px;margin-left: 20px;"
onclick="location.href='index.jsp?main=event/eventform.jsp'">
<span class="glyphicon glyphicon-pencil"></span>글추가</button>
	<%
	for(EventDto dto:list)
		{%>
	<table style="cursor:pointer;" onclick="location.href='index.jsp?main=event/eventdetail.jsp?num=<%=dto.getNum()%>&currentPage=<%= currentPage%>&key=list'">
		<tr>
			<td rowspan="4" width="200">
				<img src="/Team/save/<%=dto.getPhotoname()%>" style="margin-right:30px; margin-top:-25px; border-radius:7%" height="130">
			</td>
			<td style="color:tan; font-weight: 400;">
				<%=sdf.format(dto.getWriteday())%> 
			</td>
		</tr>
		
		<tr>
			<td style="font-weight: 700;">
			<%=dto.getSubject()%>
			</td>
		</tr>
		
		<tr>
			<td>
			<%=dto.getContent()%>
			</td>
		</tr>
		
		<tr>
			<td>
			참석자 : <%=dto.getReadcount()%>
			</td>
		</tr>
	</table>
		<%}
	%>
	<div id="enters"></div>
	<script type="text/javascript">

	$(window).scroll(function() {
    if ($(window).scrollTop() == $(document).height() - $(window).height()) {
      $("#enters").append("sdfd");
      
    }
});

</script>
</section>



</body>
</html>