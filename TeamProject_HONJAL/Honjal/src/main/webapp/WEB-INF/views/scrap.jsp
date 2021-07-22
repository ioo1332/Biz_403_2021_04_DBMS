<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<script>
      function selectAll(selectAll) {
        const checkboxes = document.getElementsByName("allcheck");

        checkboxes.forEach((checkbox) => {
          checkbox.checked = selectAll.checked;
        });
      }
</script>

<article class="main_box">
      <h2 class="board_title">스크랩</h2>
      <div class="search_box">
		<input class="search_input" type="text" placeholder="검색어를 입력하세요" />
        <button class="btn_search">검색</button>
		</div>

	<table class="board">
        <tr>
          <th width="5%">
            <input type="checkbox" name="allcheck" onclick="selectAll(this)" />
          </th>
          <th width="15%">No.</th>
          <th id="select" width="10%">
            말머리
            <select>
              <option selected>전체</option>
              <option>생활TIP-세탁&청소</option>
              <option>생활TIP-요리</option>
              <option>생활TIP-공간활용</option>
              <option>랜선집들이</option>
              <option>리뷰게시판</option>
            </select>
          </th>
          <!-- 체크박스 때문에 5% 빼고 체크박스에 5% 넣음-->
          <th width="35%">글제목</th>
          <th width="15%">작성자</th>
          <th width="10%">작성일</th>
          <th width="5%">조회</th>
          <th width="5%">추천</th>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>10</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>9</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>8</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>7</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>6</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>5</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>4</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>3</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>2</td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
          <td></td>
        </tr>
        <tr>
          <td><input type="checkbox" name="allcheck" /></td>
          <td>1</td>
          <td>공지사항</td>
          <td class="td_title">혼자서도 잘해요<span>[4]</span></td>
          <td>서녕</td>
          <td>2021.06.08</td>
          <td>729</td>
          <td></td>
        </tr>
      </table>
      <div id="scrap_delete_box">
      	<button id="scrap_delete">삭제</button>
      </div>
      <div class="paging_box">
        <a href="#">&laquo;</a>
        <a href="#" class="on">1</a>
        <a href="#">2</a>
        <a href="#">3</a>
        <a href="#">4</a>
        <a href="#">5</a>
        <a href="#">&raquo;</a>
      </div>
    </article></html>