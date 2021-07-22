<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<style>
	* {
		list-style: none;
	}
	
	.page_ul {
		display: flex;
	}
	
</style>

<article class="main_box">
	<h2 class="board_title">
		<c:choose>
			<c:when test="${MENU == 'NOT'}">
	    	공지사항
	    	</c:when>
			<c:when test="${MENU == 'INF'}">
	    	정보게시판
	    	</c:when>
			<c:when test="${MENU == 'TIP'}">
	    	생활 TIP
	    	</c:when>
			<c:when test="${MENU == 'INT'}">
	    	랜선 집들이
	    	</c:when>
			<c:when test="${MENU == 'TAL'}">
	    	혼잘 TALK
	    	</c:when>
			<c:when test="${MENU == 'REV'}">
	    	리뷰 게시판
	    	</c:when>
			<c:when test="${MENU == 'QNA'}">
	    	자취 Q&A
	    	</c:when>
		</c:choose>
	</h2>
	<div class="search_box">
		<form>
			<select id="search_type" name="search_type">
				<option value="title" selected>제목</option>
				<option value="text">내용</option>
				<option value="nname">작성자</option>
			</select>
			<input name="search_word" class="search_input" type="text" placeholder="검색어를 입력하세요" />
			<button class="btn_search">검색</button>
		</form>
	</div>

	<table class="board">
		<tr>
			<th width="15%">No.</th>

			<c:choose>
				<c:when test="${MENU == 'TIP'}">
					<th width="10%" class="content_head">말머리 <select class="content_head">
							<option selected>전체</option>
							<option value="TIP-1">청소 &amp;세탁</option>
							<option value="TIP-2">요리</option>
							<option value="TIP-3">공간활용</option>
							<option value="TIP-4">기타</option>
					</select>
					</th>
				</c:when>
				<c:when test="${MENU == 'TAL'}">
					<th width="10%" class="content_head">말머리 <select class="content_head">
							<option selected>전체</option>
							<option value="TAL-1">정보TALK</option>
							<option value="TAL-2">자유TALK</option>
					</select>
					</th>
				</c:when>
				<c:when test="${MENU == 'REV'}">
					<th width="10%" class="content_head">말머리 <select class="content_head">
							<option selected>전체</option>
							<option value="REV-1">생활용품</option>
							<option value="REV-2">음식점</option>
							<option value="REV-3">기타</option>
					</select>
					</th>
				</c:when>
			</c:choose>

			<th width="40%">글제목</th>
			<th width="15%">작성자</th>
			<th width="10%">작성일</th>
			<th width="5%">조회</th>
			<c:choose>
				<c:when
					test="${MENU == 'TIP' || MENU == 'INT' || MENU == 'REV'}">
					<th width="5%">추천</th>
				</c:when>
			</c:choose>
		</tr>
		
		<c:choose>
			<c:when test="${MENU == 'NOT' || MENU == 'INF' || MENU == 'QNA'}">
				<c:forEach items="${CONTENTS}" var="CONTENT">
					<tr data-cnum="${CONTENT.content_num}">
						<td class="content_num">${CONTENT.content_num}</td>
						<td class="content_title">${CONTENT.content_title}</td>
						<td class="member_nname">${CONTENT.member_nname}</td>
						<td class="content_date">${CONTENT.content_date}</td>
						<td class="content_view">${CONTENT.content_view}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${MENU == 'TIP' || MENU == 'REV'}">
				<c:forEach items="${CONTENTS}" var="CONTENT">
					<tr data-cnum="${CONTENT.content_num}">
						<td class="content_num">${CONTENT.content_num}</td>
						<td class="board_code">
							<c:choose>
								<c:when test="${CONTENT.board_code == 'TIP-1'}">청소 &amp;세탁</c:when>
								<c:when test="${CONTENT.board_code == 'TIP-2'}">요리</c:when>
								<c:when test="${CONTENT.board_code == 'TIP-3'}">공간활용</c:when>
								<c:when test="${CONTENT.board_code == 'TIP-4'}">기타</c:when>
								<c:when test="${CONTENT.board_code == 'REV-1'}">생활용품</c:when>
								<c:when test="${CONTENT.board_code == 'REV-2'}">음식점</c:when>
								<c:when test="${CONTENT.board_code == 'REV-3'}">기타</c:when>
							</c:choose>
						</td>
						<td class="content_title">${CONTENT.content_title}</td>
						<td class="member_nname">${CONTENT.member_nname}</td>
						<td class="content_date">${CONTENT.content_date}</td>
						<td class="content_view">${CONTENT.content_view}</td>
						<td class="content_good">${CONTENT.content_good}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${MENU == 'TAL'}">
				<c:forEach items="${CONTENTS}" var="CONTENT">
					<tr data-cnum="${CONTENT.content_num}">
						<td class="content_num">${CONTENT.content_num}</td>
						<td class="board_code">
							<c:choose>
								<c:when test="${CONTENT.board_code == 'TAL-1'}">정보TALK</c:when>
								<c:when test="${CONTENT.board_code == 'TAL-2'}">자유TALK</c:when>
							</c:choose>
						</td>
						<td class="content_title">${CONTENT.content_title}</td>
						<td class="member_nname">${CONTENT.member_nname}</td>
						<td class="content_date">${CONTENT.content_date}</td>
						<td class="content_view">${CONTENT.content_view}</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:when test="${MENU == 'INT'}">
				<c:forEach items="${CONTENTS}" var="CONTENT">
					<tr data-cnum="${CONTENT.content_num}">
						<td class="content_num">${CONTENT.content_num}</td>
						<td class="content_title">${CONTENT.content_title}</td>
						<td class="member_nname">${CONTENT.member_nname}</td>
						<td class="content_date">${CONTENT.content_date}</td>
						<td class="content_view">${CONTENT.content_view}</td>
						<td class="content_good">${CONTENT.content_good}</td>
					</tr>
				</c:forEach>
			</c:when>
		</c:choose>

	</table>
	<div class="btn_write_box">
	<c:choose>
		<c:when test="${MENU == 'NOT' or MENU == 'INF'}">
			<c:if test="${SESSION.member_level <= 0}">
				<button class="btn_write">글쓰기</button>
			</c:if>
		</c:when>
		<c:otherwise>
			<button class="btn_write">글쓰기</button>
		</c:otherwise>
	</c:choose>
	
	
	<!-- 공지사항, 정보게시판은 작성자에게만 글쓰기 버튼 보이게 -->
	</div>
	<div class="paging_box">
		<ul class="page_ul">
			<li data-pnum="1">&lt;&lt;</li>
			<li data-pnum="${PAGE_NUM - 1}">&lt;</li>
			<c:forEach begin="1" end="10" var="pageNum">
				<li data-pnum="${pageNum}" class="<c:if test="${PAGE_NUM == pageNum}">active</c:if>"></li>
			</c:forEach>
			<li data-pnum="${PAGE_NUM + 1}">&gt;</li>
			<li data-pnum="99">&gt;&gt;</li>
		</ul>
	</div>
	
	
</article>

<script>
let rootPath = "${rootPath}/board"
let button_write = document.querySelector(".btn_write")

let type = document.querySelector("select#search_type")
type.addEventListener("change",(e)=>{
	let value = e.target.value
	let menu = "${MENU}"
	rootPath += menu
	rootPath += "/search/"
	rootPath += value
	document.querySelector(".btn_search").addEventListener("click",(e)=>{
		location.href = rootPath
	})
})

if(button_write) {
	button_write.addEventListener("click",(e)=>{
		fetch(rootPath + "/write")
			.then(response=>response.text())
			.then(result=>{
				if(result === "NULL") {
					if(confirm("로그인 후 이용 가능합니다")) {
						location.href = "${rootPath}"
					}
				} else if(result === "OK") {
					if(${MENU == 'NOT'}) {
						rootPath += "/not"
					} else if(${MENU == 'INF'}) {
						rootPath += "/inf"
					} else if(${MENU == 'TIP'}) {
						rootPath += "/tip"
					} else if(${MENU == 'INT'}) {
						rootPath += "/int"
					} else if(${MENU == 'TAL'}) {
						rootPath += "/tal"
					} else if(${MENU == 'REV'}) {
						rootPath += "/rev"
					} else if(${MENU == 'QNA'}) {
						rootPath += "/qna"
					}
					location.href = rootPath + "/write";
				}
			})
	})
}


let table = document.querySelector(".board")
if(table) {
	table.addEventListener("click",(e)=>{
		let rootPath = "${rootPath}/board";
		let target = e.target
		if(target.tagName === "TD") {
			let tr = target.closest("TR")
			let cNum = tr.dataset.cnum
			/*
			if(${MENU == 'NOTICE'}) {
				rootPath += '/notice'
			} else if(${MENU == 'INFO'}) {
				rootPath += "/info"
			} else if(${MENU == 'TIP'}) {
				rootPath += "/tip"
			} else if(${MENU == 'INTERIOR'}) {
				rootPath += "/interior"
			} else if(${MENU == 'TALK'}) {
				rootPath += "/talk"
			} else if(${MENU == 'REVIEW'}) {
				rootPath +="/review"
			} else if(${MENU == 'QNA'}) {
				rootPath += "/qna"
			}
			*/
			location.href = rootPath + "/read?content_num=" + cNum;
		}
	})
}

let select = document.querySelector("select.content_head")
if(select) {
	select.addEventListener("change",(e)=>{
		let value = e.target.value
		location.href = "${rootPath}/board/" + value
	})
}
</script>