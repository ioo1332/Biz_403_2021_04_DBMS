<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<form class="write_form" method=POST>
	<h2 class="board_title">글 수정</h2>
		<fieldset>
			<div class="write_top">
			<c:choose>
				<c:when test="${MENU == 'TIP'}">
					<select>
						<option disabled>말머리</option>
						<option disabled <c:if test="${CONTENT.board_code == 'TIP-1'}">selected</c:if>> 청소&amp;세탁</option>
						<option disabled <c:if test="${CONTENT.board_code == 'TIP-2'}">selected</c:if>> 요리</option>
						<option disabled <c:if test="${CONTENT.board_code == 'TIP-3'}">selected</c:if>> 공간활용</option>
						<option disabled <c:if test="${CONTENT.board_code == 'TIP-4'}">selected</c:if>> 기타</option>
					</select>
				</c:when>
				<c:when test="${MENU == 'TAL'}">
					<select>
						<option disabled>말머리</option>
						<option disabled <c:if test="${CONTENT.board_code == 'TAL-1'}">selected</c:if>>정보 TALK</option>
						<option disabled <c:if test="${CONTENT.board_code == 'TAL-2'}">selected</c:if>>자유 TALK</option>
					</select>
				</c:when>
				<c:when test="${MENU == 'REV'}">
					<select>
						<option disabled>말머리</option>
						<option disabled <c:if test="${CONTENT.board_code == 'REV-1'}">selected</c:if>>생활용품</option>
						<option disabled <c:if test="${CONTENT.board_code == 'REV-2'}">selected</c:if>>음식점</option>
						<option disabled <c:if test="${CONTENT.board_code == 'REV-3'}">selected</c:if>>기타</option>
					</select>
				</c:when>
			</c:choose>
				<input name="content_title" class="write_title" value="${CONTENT.content_title}"/>
				<div class="file_box">
					<label for="ex_file">&#128190;</label> <input type="file" id="ex_file" />
				</div>
			</div>
			<textarea name="content_text" class="write_text" >${CONTENT.content_text}</textarea>
			
			<input name="content_num" type="hidden" value="${CONTENT.content_num}"/>
			<input name="member_num" type="hidden" value="${CONTENT.member_num}"/>
			<input name="member_nname" type="hidden" value="${CONTENT.member_nname}"/>
			<input name="board_code" type="hidden" value="${CONTENT.board_code}"/>
			<input name="content_date" type="hidden" value="${CONTENT.content_date}"/>
			<input name="content_time" type="hidden" value="${CONTENT.content_time}"/>
			<input name="content_view" type="hidden" value="${CONTENT.content_view}"/>
			<input name="content_good" type="hidden" value="${CONTENT.content_good}"/>
		</fieldset>
		<div class="write_bottom">
			<button id="btn_write" type="submit">등록</button>
			<button id="btn_cancel" type="button">취소</button>
		</div>
</form>

<script>
/*
let write_button = document.querySelector("#btn_write")
let cancel_button = document.querySelector("#btn_cancel");


write_button.addEventListener("click",(e)=>{
	location.href = "${rootPath}/board/read?content_num=" + ${CONTENT.content_num}
})

cancel_button.addEventListener("click",(e)=>{
	location.href = "${rootPath}/board/read?content_num=" + ${CONTENT.content_num}
})
*/

let rootPath = "${rootPath}/board"

document.querySelector("#btn_write").addEventListener("click",(e)=>{
//	location.href = "${rootPath}/board/read?content_num=${CONTENT.content_num}"
	if(confirm("수정하시겠습니까?")) {
		location.replace(rootPath + "/update?content_num=${CONTENT.content_num}")
	}
})

document.querySelector("#btn_cancel").addEventListener("click",(e)=> {
	if(confirm("글수정을 취소하시겠습니까?")) {
		location.href = rootPath + "/read?content_num=${CONTENT.content_num}";
	}
})

/*
document.querySelector("#btn_cancel").addEventListener("click",(e)=>{
	location.replace("${rootPath}/board/update?content_num=${CONTENT.content_num}")
})
*/


</script>