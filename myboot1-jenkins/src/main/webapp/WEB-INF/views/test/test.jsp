<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="js/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
	// 이미지 업로드 

	$("#imgFile").click(function (e) {
		//e.preventDefault();
		//파일선택창 안보인
		$("#cancleNoti").attr("style", "display:unset");

		var form = $("#uploadForm")[0];
		var data = new FormData(form);
		$.ajax({
			url: "ajaxUpload",
			data: data,
			type: "post",
			dataType: "json",

			encType: "multipart/form-data",
			processData: false,
			contentType: false,

			success: function (resp) {

				if (Imgcount >= 6) {
					alert("사진은 6개 까지만 등록 가능합니다.")
					return false;
				}

				var str = '<span>';
				str += "<img src='http://localhost:8090/upload/" + resp.result + "' height=100 width=100 style='cursor:pointer' onclick='delImg(this)' >";
				str += '</span>';

				$(str).appendTo('#here');


				switch ("") {
					case $("#file1").val():
						$("#file1").val(resp.result);
						break;
					case $("#file2").val():
						$("#file2").val(resp.result);
						break;
					case $("#file3").val():
						$("#file3").val(resp.result);
						break;
					case $("#file4").val():
						$("#file4").val(resp.result);
						break;
					case $("#file5").val():
						$("#file5").val(resp.result);
						break;
					case $("#file6").val():
						$("#file6").val(resp.result);
						break;
				}

				Imgcount++;

			} // success 
		}); // ajax 
	}); // onclick

}); // onload 
</script>
</head>
<body>

<div class="insertproduct-title">물품등록</div>

				<form id="uploadForm" action="http://localhost:8090/registerProduct" method="post"
					enctype="multipart/form-data">

<!-- accept= ".png,.jpeg"  -->
<!-- <label for="imgFile">파일선택</label> [최대 6개 가능] -->
					물품사진 : <input id="imgFile" type="file" name="imgFile" value="파일선택[최대 6개 가능]"
					 onchange=
					 "javascript: document.getElementById('file1').value = this.value;document.getElementById('file1').style='display:unset'" ><br>
					<input id="file1" type="text" style="display:none" name="file1">
					<input id="file2" type="text" style="display:none" name="file2">
					<input id="file3" type="text" style="display:none" name="file3">
					<input id="file4" type="text" style="display:none" name="file4">
					<input id="file5" type="text" style="display:none" name="file5">
					<input id="file6" type="text" style="display:none" name="file6">
					<div id="cancleNoti" style="display:none">(사진 등록을 취소하시려면 해당 사진을 클릭해주세요.)</div>
					<div  id="here"></div>
					<br>
					<input type="submit" value="물품등록" >
				</form>

<hr>
<style>
.file_input_textbox
{
float: left
}
 
.file_input_div
{
position: relative;
width: 100px;
height: 23px;
overflow: hidden;
}
 
.file_input_button
{
width: 100px;
position: absolute;
top: 0px;
background-color: #33BB00;
color: #FFFFFF;
border-style: solid;
}
 
.file_input_hidden
{
font-size: 45px;
position: absolute;
right: 0px;
top: 0px;
opacity: 0;
 
filter: alpha(opacity=0);
-ms-filter: "alpha(opacity=0)";
-khtml-opacity: 0;
-moz-opacity: 0;
}
</style>
 
 
<input type="text" id="fileName" class="file_input_textbox" readonly="readonly">
 
<div class="file_input_div">
<input type="button" value="Search files" class="file_input_button" />
<input type="file" class="file_input_hidden" onchange="javascript: document.getElementById('fileName').value = this.value" />
</div>


</body>
</html>