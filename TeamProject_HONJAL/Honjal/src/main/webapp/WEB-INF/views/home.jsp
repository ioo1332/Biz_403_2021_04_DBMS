<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width,initial-scale=1" />
<title>혼자서도 잘해요</title>
<style>
/* 제목 - 여기어때잘난체 */
@font-face {
  font-family: "yg-jalnan";
  src: url("https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_four@1.2/JalnanOTF00.woff")
    format("woff");
  font-weight: normal;
  font-style: normal;
}

/* 메뉴 - 롯데마트드림체 */
@font-face {
  font-family: "LotteMartDream";
  font-style: normal;
  font-weight: 400;
  src: url("//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamMedium.woff2")
      format("woff2"),
    url("//cdn.jsdelivr.net/korean-webfonts/1/corps/lottemart/LotteMartDream/LotteMartDreamMedium.woff")
      format("woff");
}

/* 본문 - 나눔바른고딕 */
@font-face {
  font-family: "NanumBarunGothic";
  font-style: normal;
  font-weight: 400;
  src: url("//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot");
  src: url("//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.eot?#iefix")
      format("embedded-opentype"),
    url("//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.woff")
      format("woff"),
    url("//cdn.jsdelivr.net/font-nanumlight/1.0/NanumBarunGothicWeb.ttf")
      format("truetype");
}

* {
	box-sizing: border-box;
	margin: 0;
  padding: 0;
  text-decoration: none;
  outline: 0;
}

.main_box, #join_form, .write_form {
	font-family: "NanumBarunGothic";
  width: 1050px;
  margin: auto;
  text-align: center;
}

button {
  background-color: white;
  border: 2px solid #b3d83c;
  border-radius: 25px;
  color: rgb(39, 38, 38);
  outline: 0;
}

button:hover {
  cursor: pointer;
}

footer {
  width: 100%;
  margin: auto;
  margin-top: 40px;
  text-align: center;
  border-top: 3px solid #d6b26e;
  line-height: 5;
}

</style>
<link href="${rootPath}/static/css/nav.css?ver=2021-07-15-001" rel="stylesheet" />
<link href="${rootPath}/static/css/main.css?ver=2021-07-07-001" rel="stylesheet" />
<link href="${rootPath}/static/css/board.css?ver=2021-07-15-004" rel="stylesheet" />
<link href="${rootPath}/static/css/join.css?ver=2021-07-07-001" rel="stylesheet" />
<link href="${rootPath}/static/css/read.css?ver=2021-07-15-001" rel="stylesheet" />
<link href="${rootPath}/static/css/write_admin.css?ver=2021-07-07-001" rel="stylesheet" />
</head>
<body>
	<header>
		<img src="${rootPath}/static/images/logo_v5.jpg">
		<ul id="menu_box">
			<li class="menu_list">공지사항</li>
			<li class="menu_list">정보게시판</li>
			<li class="menu_list">생활 TIP</li>
			<li class="menu_list">랜선집들이</li>
			<li class="menu_list">혼잘TALK</li>
			<li class="menu_list">리뷰게시판</li>
			<li class="menu_list">자취 Q&amp;A</li>
		</ul>
	</header>
	<section id="main_sec">
		<c:choose>
			<c:when test="${BODY == 'BOARD_MAIN' }">
				<%@ include file="/WEB-INF/views/board_main.jsp"%>
			</c:when>
			<c:when test="${BODY == 'WRITE' }">
				<%@ include file="/WEB-INF/views/write.jsp"%>
			</c:when>
			<c:when test="${BODY == 'JOIN' }">
				<%@ include file="/WEB-INF/views/member/join.jsp"%>
			</c:when>
			<c:when test="${BODY == 'READ' }">
				<%@ include file="/WEB-INF/views/read.jsp"%>
			</c:when>
			<c:when test="${BODY == 'UPDATE' }">
				<%@ include file="/WEB-INF/views/update.jsp"%>
			</c:when>
			<c:otherwise>
				<%@ include file="/WEB-INF/views/main.jsp"%>
			</c:otherwise>
		</c:choose>
	</section>

	<footer>
		<address>&copy; 2021. honjal All pictures cannot be copied
			without permission.</address>
	</footer>
	
</body>
<script>
document.querySelector("header img").addEventListener("click", (e) => {
	location.href = "${rootPath}"
});

document.querySelector("#menu_box").addEventListener("click", (e) => {
    let text = e.target.textContent;
    let url = `${rootPath}/board`;

    if (text === "공지사항") {
      url += "/not";
    } else if (text === "정보게시판") {
      url += "/inf";
    } else if (text === "생활 TIP") {
      url += "/tip";
    } else if (text === "랜선집들이") {
      url += "/int";
    } else if (text === "혼잘TALK") {
      url += "/tal";
    } else if (text === "리뷰게시판") {
      url += "/rev";
    } else if (text === "자취 Q&A") {
      url += "/qna";
    }
    location.href = url;
  });
  
</script>
</html>
