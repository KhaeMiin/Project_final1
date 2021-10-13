<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;400&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<%
	//프로젝트의 경로
	String root=request.getContextPath();

%>

<!-- se2 폴더에서 js 파일 가져오기 -->
<script type="text/javascript" src="<%=root%>/se2/js/HuskyEZCreator.js"
	charset="utf-8"></script>

<script type="text/javascript" src="<%=root%>/se2/photo_uploader/plugin/hp_SE2M_AttachQuickPhoto.js"
	charset="utf-8"></script>	
</head>
<body>
    <section style="height: 100px;background-image: url('images/bg_2.jpg');"  data-stellar-background-ratio="0.5">
    </section>

<form action="event/eventaction.jsp" method="post">

	<table class="table table-bordered" style="font-family:'Noto Sans KR', sans-serif; width: 800px;margin-left: 100px;" >
		<tr>
			<th bgcolor="orange" width="100">작성자</th>
			<td>
				<input type="text" name="writer" class="form-control"
					required="required" style="width: 130px;">
			</td>
		</tr>
		<tr>
			<th bgcolor="orange" width="100">제  목</th>
			<td>
				<input type="text" name="subject" class="form-control"
					required="required" style="width: 500px;">
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea name="content" id="content"		
					required="required"			
					style="width: 100%;height: 300px;display: none;">
				</textarea>
				<input type="hidden" id="ct" name="ct">
				<input type="hidden" id="img" name="img">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<button type="button" class="btn btn-warning"
					style="width: 120px;" id="btnSave"
					onclick="submitContents(this)">DB저장</button>
				
				<button type="button" class="btn btn-warning"
					style="width: 120px;"
					onclick="location.href='index.jsp?main=event/eventlist.jsp'">목록</button>
			</td>
		</tr>
		
	</table>   
</form>

<!-- 스마트게시판에 대한 스크립트 코드 넣기 -->
<script type="text/javascript">
var oEditors = [];

nhn.husky.EZCreator.createInIFrame({

    oAppRef: oEditors,

    elPlaceHolder: "content",

    sSkinURI: "<%=request.getContextPath()%>/se2/SmartEditor2Skin.html",

    fCreator: "createSEditor2"

}); 

//‘저장’ 버튼을 누르는 등 저장을 위한 액션을 했을 때 submitContents가 호출된다고 가정한다.

function submitContents(elClickedObj) {

    // 에디터의 내용이 textarea에 적용된다.

    oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", [ ]);
    
    /**
     * argBody 안의 내용 중 지정 문자열 삭제
     * argBody : 삭제본문 ( ex : 가나다 <pre style="width:100px">안녕하세요</pre> )
     * argStartSection : 삭제 시작 문자 ( ex : <pre )
     * argEndSection : 삭제 끝 문자 ( ex : ;"> )
     * argRemoveSection : 별도 replace 문자 ( ex : </pre> )
      */
    	var removeStyleAndImage  = function(argBody, argStartSection, argEndSection, argRemoveSection){
        var bodyString = argBody;
        var sectionChk = bodyString.match(new RegExp(argStartSection,'g'));
        if(sectionChk != null){
            for(var i=0; i < sectionChk.length; i++){
                var tmpImg = bodyString.substring(bodyString.indexOf(argStartSection), (bodyString.indexOf(argEndSection)+(argEndSection.length)));
                bodyString = bodyString.replace(tmpImg, '').replace(/<br>/gi, '').replace(/&nbsp;/gi, ' ').replace(/<p>/gi, '').replace(/<\/p>/gi, ' ').replace(new RegExp(argRemoveSection,'gi'), '');
            }
        }
        return bodyString;
    };
	
    var varContent = oEditors.getById["content"].getIR();
	alert(varContent);
    varContent = removeStyleAndImage(varContent, '<pre', ';">', '</pre>');    // 스마트에디터 내부의 스타일 제거
    varContent = removeStyleAndImage(varContent, '<span', ';">', '</span>');  // 스마트에디터 내부의 스타일 제거
    varContent = removeStyleAndImage(varContent, '<img src=', '">', '');      // 스마트에디터 내부의 이미지 제거
    document.getElementById("ct").value = varContent;
 

    // 에디터의 내용에 대한 값 검증은 이곳에서

    // document.getElementById("textAreaContent").value를 이용해서 처리한다.
    try {
        elClickedObj.form.submit();
    } catch(e) { 

    }

}

// textArea에 이미지 첨부

function pasteHTML(filepath){
    var sHTML = '<img src="<%=request.getContextPath()%>/save/'+filepath+'">';
    oEditors.getById["content"].exec("PASTE_HTML", [sHTML]); 
	
    document.getElementById("img").value = filepath;
}
</script>

</body>
</html>






















