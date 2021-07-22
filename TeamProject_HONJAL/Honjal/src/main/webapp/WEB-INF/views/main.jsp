<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />

	<article id="main_top">
      <section id="main_user">
        <c:choose>
			<c:when test="${MEMBER.member_num != NULL }">
				<%@ include file="/WEB-INF/views/include/include_member.jspf"%>
			</c:when>
			<c:otherwise>
				<form id="login_box" method="POST" action="http://localhost:8080/honjal/member/login">
					<input name="member_id" placeholder="ID" /> 
					<input name="member_pw" type="password" placeholder="PASSWORD" />
					<button class="btn_login" type="button">LOGIN</button>
					<button class="btn_signup" type="button">SIGN UP</button>
				</form>
			</c:otherwise>
		</c:choose>
      </section>
      <section id="main_slide">
        <div id="slide_img_box">
          <img src="${rootPath}/static/images/sample_slide.jpg">
          <img src="#" class="slide" alt="집" />
          <img src="#" class="slide" alt="집" />
        </div>
        <button class="btn left">&lang;</button>
        <button class="btn right">&rang;</button>
        <div id="circleBox">
          <div class="circle"></div>
          <div class="circle"></div>
          <div class="circle"></div>
        </div>
      </section>
    </article>


    <article id="main_middle">
      <section id="main_best">
        <h2>🔥 [ 생활TIP ] 최근 일주일 인기글</h2>
        <div>
          <img src="${rootPath}/static/images/sample_best.png"/>
          <ol>
            <li class="list_best">
              <span>1위 </span>1시간만에 끝! 벽걸이 에어컨 분해없는 셀프청소 노하우
            </li>
            <li class="list_best">
              <span>2위 </span>니트 세탁법: 이제 드라이 맡기지 말고 집에서 손쉽게!
            </li>
            <li class="list_best">
              <span>3위 </span>옷은 다 어디에 있냐고요? 예쁜 원룸 속 옷 수납법!
            </li>
            <li class="list_best">
              <span>4위 </span>천연세제 3종의 차이점과 활용법, 정리해봤어요
            </li>
            <li class="list_best">
              <span>5위 </span>공간에 따른 효율적인 수납Tip을 알아보아요
            </li>
          </ol>
        </div>
      </section>
      <section id="main_info">
        <h2>&#128270; 정보게시판</h2>
        <div>
          <img src="${rootPath}/static/images/sample_data.png"/>
          <ul>
            <li class="list_data">전국 생활 쓰레기 배출 정보</li>
            <li class="list_data">전국 전기 차 충전소 정보</li>
            <li class="list_data">전국 공중 화장실 정보</li>
            <li class="list_data">전국 여성 안심 택배함 정보</li>
            <li class="list_data">전국 자전거 보관소 정보</li>
          </ul>
        </div>
      </section>
    </article>
    
    
    <article id="main_bottom">
      <h2>&#128221; 최신글</h2>
      <table class="board">
		<tr>
			<th width="10%">No.</th>
			<th width="10%" class="content_head">게시판</th>
			<th width="40%">글제목</th>
			<th width="15%">작성자</th>
			<th width="10%">작성일</th>
			<th width="5%">조회</th>
			<th width="5%">추천</th>
		</tr>
		<c:forEach items="${CONTENTS}" var="CONTENT">
			<tr data-cnum="${CONTENT.content_num}" data-board="${CONTENT.board_code}">
				<td class="content_num">${CONTENT.content_num}</td>
				<td class="board_code">${CONTENT.board_code}</td>
				<td class="content_title">${CONTENT.content_title}</td>
				<td class="member_nname">${CONTENT.member_nname}</td>
				<td class="content_date">${CONTENT.content_date}</td>
				<td class="content_view">${CONTENT.content_view}</td>
				<td class="content_good">${CONTENT.content_good}</td>
			</tr>
		</c:forEach>
	</table>
    </article>
    
<script>

let btn_login = document.querySelector("button.btn_login")
let btn_join = document.querySelector("button.btn_signup")
let input_memberid = document.querySelector("input[name='member_id']")
let input_password = document.querySelector("input[name='member_pw']")
if(btn_join){
	btn_join.addEventListener("click",(e)=>{
		   let text = e.target.textContent
		   let url = `${rootPath}`
		   if(text === "SIGN UP"){
		      url += "/member/join";
		   }
		   location.href = url
		})
}
if(btn_login){
	btn_login.addEventListener("click",(e)=>{
		let member_id = input_memberid.value
		let member_pw = input_password.value
		let text = e.target.textContent
		let url = `${rootPath}`
		
		if(member_id == ""){
			alert("ID를 입력하세요")
			input_memberid.focus()
			return false
		}else if(member_pw == ""){
			alert("비밀번호를 입력하세요")
			input_password.focus()
			return false
		}
		
		document.querySelector("form").submit()	
	})
}
let login_fail = "${LOGIN_FAIL}"
	if(login_fail === "NOT_MEMBER_ID"){
		alert("사용자 ID가 틀렸습니다")
	}else if(login_fail === "NOT_PASS"){
		alert("사용자 비밀번호가 틀렸습니다")
	}
	
let table = document.querySelector(".board")
if(table) {
	table.addEventListener("click",(e)=>{
		let target = e.target
		if(target.tagName === "TD") {
			let tr = target.closest("TR")
			let cNum = tr.dataset.cnum
			/*
			let board = tr.dataset.board
			
			let controller = ""
			if(board === "REV-1") {
				controller = "review";
			}
			location.href = "${rootPath}/" + controller + "/read?content_num=" + cNum;
			*/
			location.href = "${rootPath}/board/read?content_num=" + cNum;
		}
	})
}

</script>