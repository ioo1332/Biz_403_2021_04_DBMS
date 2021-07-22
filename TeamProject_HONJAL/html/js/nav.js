// 메뉴 이동

document.addEventListener("DOMContentLoaded", () => {
  document.querySelector("#menu").addEventListener("click", (ev) => {
    let text = ev.target.textContent;
    let url = ""; // 초기화 꼭 해줘야함

    if (text == "공지사항") {
      url += "notice.html";
    } else if (text == "정보게시판") {
      url += "info.html";
    } else if (text == "생활 TIP") {
      url += "tip.html";
    } else if (text == "랜선집들이") {
      url += "interior.html";
    } else if (text == "혼잘TALK") {
      url += "talk.html";
    } else if (text == "리뷰게시판") {
      url += "review.html";
    } else if (text == "자취 Q&A") {
      url += "qna.html";
    }

    document.location.href = url;
  });
});
