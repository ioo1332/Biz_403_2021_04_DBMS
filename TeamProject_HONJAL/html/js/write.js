// 글쓰기 버튼 누르면 각 게시판 글쓰기 페이지로 이동

document.addEventListener("DOMContentLoaded", () => {
  document.querySelector("div.paging").addEventListener("click", (ev) => {
    let text = ev.target.textContent;
    let url = "";
    var CurrentFileName = document.URL.substring(
      document.URL.lastIndexOf("/") + 1,
      document.URL.lastIndexOf("/") + 30
    );
    // 현재 페이지 파일 이름.확장자 추출

    if (text == "글쓰기") {
      if (CurrentFileName == "tip.html") {
        url += "write_tip.html";
      } else if (CurrentFileName == "interior.html") {
        url += "write_interior.html";
      } else if (CurrentFileName == "talk.html") {
        url += "write_talk.html";
      } else if (CurrentFileName == "review.html") {
        url += "write_review.html";
      } else if (CurrentFileName == "qna.html") {
        url += "write_qna.html";
      }
    }
    // 이 js 파일 하나로 모든 게시판에서 다 쓸 수 있게 함

    document.location.href = url;
  });
});
