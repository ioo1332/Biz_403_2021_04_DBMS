<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<style>
div.msg {
	font-size: 10px;
	color: red;
	text-align: center;
	margin: 0;
}
</style>
<form id="join_form" method="POST">
	<h2 class="board_title">회원 가입</h2>
	<fieldset>
		<div>
			<label>아이디</label> <input name="member_id" type="text" id="member_id"
				placeholder="6자 이상 영문과 숫자 조합" />
			<button type="button"  id="btn_id_check">중복확인</button>
		</div>
		<div class="msg member id"></div>
		<div>
			<label>비밀번호</label> <input name="member_pw" type="password"
				id="member_password" placeholder="8자 이상 영문과 숫자 조합" />
		</div>
		<div class="msg member pw"></div>
		<div>
			<label>비밀번호 재입력</label> <input name="re_pw" type="password"
				id="member_password2" placeholder="재입력 해주세요" />
		</div>
		<div class="msg member pw1"></div>
		<div>
			<label>닉네임</label> 
			<input name="member_nname" type="text" id="member_nickname" />
		</div>
		<div class="msg member nickname"></div>
		<div>
			<label>e-mail</label> 
			<input name="member_email" type="email" required="required" id="member_email" />
		</div>
		<div class="msg member email"></div>
	</fieldset>

	<section id="join_btn">
		<button type="button">회원가입</button>
		<button>취소</button>
	</section>
</form>
<script>
//  location.href = "${rootPath}"
document.querySelector("input[name='member_id']").addEventListener("blur",(e)=>{
	let msg_member_id = document.querySelector("div.member.id")	
	let memberid = e.currentTarget.value
	
	msg_member_id.innerText = ""
	msg_member_id.style.padding="0"
  	if(memberid === ""){
  		msg_member_id.innerText = " * ID를 반드시 입력하세요"
  		return false
	}else if(memberid.length < 6){
		msg_member_id.innerText = " * ID는 6자 이상 입력하세요"
		return false
	}
	document.querySelector("#btn_id_check").addEventListener("click",(e)=>{
		
		fetch("${rootPath}/member/id_check?member_id="+memberid)
			.then(response=>response.text())
			.then(result=>{
				if(result === "USE_ID"){
					msg_member_id.innerText = " * 이미 가입된 ID 입니다"
					msg_member_id.style.color="red"
					e.currentTarget.focus()
					return false
				}else if(result === "NOT_USE_ID"){
					msg_member_id.innerText = " * 가입 가능한 ID 입니다"
					msg_member_id.style.color="blue"
					document.querySelector("#member_password").focus()
				}
			})
	})
})
document.querySelector("input[name='member_pw']").addEventListener("blur",(e)=>{
	let msg_member_pw = document.querySelector("div.member.pw")	
	
	msg_member_pw.innerText = ""
	msg_member_pw.style.padding="0"	
	
  	if((e.currentTarget.value) === ""){
  		msg_member_pw.innerText = " * 비밀번호를 반드시 입력하세요"
  		return false
	} else if((e.currentTarget.value.length) < 8){
		msg_member_pw.innerText = " * 비밀번호는 8자 이상 입력하세요"
		return false
	}
})
document.querySelector("input[name='re_pw']").addEventListener("blur",(e)=>{
	let memberpw = document.querySelector("input[name='member_pw']")
    let msg_member_pw1 = document.querySelector("div.member.pw1")	
	
	msg_member_pw1.innerText = ""
	msg_member_pw1.style.padding = "0"
	
	if(e.currentTarget.value != memberpw.value){
		msg_member_pw1.innerText = " * 비밀번호가 다릅니다"
		return false
	}
})
document.querySelector("input[name='member_nname']").addEventListener("blur",(e)=>{
	let msg_member_nickname = document.querySelector("div.member.nickname")
	let nickname = e.currentTarget.value;
	
	msg_member_nickname.innerText = "";
	msg_member_nickname.style.padding="0";
	if(nickname === ""){
		msg_member_nickname.innerText = " * 닉네임을 반드시 입력하세요";
		return false;
	}
})		
document.querySelector("input[name='member_email']").addEventListener("blur",(e)=>{
	let msg_member_email = document.querySelector("div.member.email")	
	let email = e.currentTarget.value
	
	msg_member_email.innerText = ""
	msg_member_email.style.padding="0"
  	if(email === ""){
  		msg_member_email.innerText = " * e-mail을 반드시 입력하세요"
  		return false
	}
})
  		
  		
document.querySelector("#join_btn").addEventListener("click", (e) => {      	
    
    if((member_id.value) == ""){
    	member_id.focus()
    	return false
    }else if((member_password.value)==""){
    	member_password.focus()
    	return false
    }else if((member_password2.value)==""){
    	member_password2.focus()
    }else if((member_nickname.value)==""){
    	member_nickname.focus()
    	return false
    }else if((member_email.value)==""){
    	member_email.focus()
     	return false
    }else{
    	document.querySelector("form").submit()
    	alert("회원 가입 성공하셨습니다~~")
    }
})
</script>