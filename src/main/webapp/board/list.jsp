<%@ page import="com.study.board.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<%@ page import="java.util.Objects" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/common/header.jsp" />
  <div class="searchbar">
    <span>등록일</span>
    <div class="area-datepicker">
      <input type="text" class="input-datepicker" id="startDt" />~
      <input type="text" class="input-datepicker" id="endDt" />
    </div>
    <input type="text" id="keyword" placeholder="검색어를 입력해 주세요. (제목 + 작성자 + 내용)" />
    <button id="sr-button" class="btn-sr" type="button">검색</button>
  </div>

  <script type="text/javascript" defer>
    const dateFormat = "yy-mm-dd";
    const dateFormatter = (date)=>{
      return date.toISOString().split('T')[0];
    }
  </script>

  <script type="text/javascript" defer>
    const now = new Date();
    const oneYearAgo = new Date();
    oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);

    //Todo : javascript 말고 그냥 query에 param 가져와서하자

    const setSearchFilter = ()=>{
      const filter = localStorage.getItem('searchFilter');
      if (filter !== null){ //localstrage 에 값 있을때
        localStorage.removeItem('searchFilter');
        return {
          keyword: filter.keyword,
          type: '',
          startDt: filter.startDt,
          endDt: filter.endDt
        };
      }
      return {
        keyword: '',
        type: '',
        startDt: dateFormatter(oneYearAgo),
        endDt: dateFormatter(now)
      }
    }


    const searchFilterInit = ()=>{
      const defaultSearchFilter = setSearchFilter();
      $("#startDt")
              .datepicker({dateFormat})
              .datepicker("setDate", defaultSearchFilter.startDt);

      $("#endDt")
              .datepicker({dateFormat})
              .datepicker("setDate", defaultSearchFilter.endDt);

      const input = document.getElementById('keyword');

      input.value = defaultSearchFilter.keyword || '';

      document.getElementById('sr-button').addEventListener('click', goSearch);

      input.focus();
      input.addEventListener('keyup', function (e) {
        e.preventDefault();

        if ( e.keyCode === 13) {
          goSearch();
        }
      })
    }

    function goSearch(){
      const url = new URL(window.location.href);
      url.searchParams.set('keyword', document.getElementById('keyword').value.toString());
      url.searchParams.set('startDt', document.getElementById('startDt').value.toString());
      url.searchParams.set('endDt',   document.getElementById('endDt').value.toString());
      window.location.href = url.toString();
    }

    const init = ()=>{
      searchFilterInit();
    }
    window.addEventListener('load', init);
  </script>

  <%
    Board board = new Board();

    List<BoardModel> boardList;
//      request.setCharacterEncoding("utf-8");
    String keyword = request.getParameter("keyword");

    try {
      if ( keyword == null || keyword.trim().isEmpty() ){
        //전체
        boardList = board.getBoardList();
      }else{
        //검색
        boardList = board.getBoardList(keyword.trim());
      }

    } catch (Exception e) {
      boardList = null;
    }

    int totalCount = Objects.requireNonNull(boardList).size();
  %>

  <div class="table-top">
    총 <%=totalCount%>건
  </div>

  <table class="table-list">
    <thead>
    <tr>
      <th>제목</th>
      <th>작성자</th>
      <th>조회수</th>
      <th>등록 일시</th>
      <th>수정 일시</th>
    </tr>
    </thead>
    <tbody>
    <%
      if (boardList == null || boardList.isEmpty()){
        out.println("<tr><td colspan=5>데이터가 없습니다.</td></tr>");
      } else {
        for (BoardModel boardItem : boardList) {

          String title = boardItem.getTitle().length() > 80 ? boardItem.getTitle().substring(0, 80) + "..." : boardItem.getTitle();
          String UpdateAt = Objects.equals(boardItem.getCreatedAt(), boardItem.getUpdatedAt()) ? "-" : boardItem.getUpdatedAt();

          out.println("<tr>");
          out.println("<td><a href=/board/detail.jsp?key="+ boardItem.getId() +">" + title + "</a></td>");
          out.println("<td>" + boardItem.getWriter() + "</td>");
          out.println("<td>" + boardItem.getViewCount() + "</td>");
          out.println("<td>" + boardItem.getCreatedAt() + "</td>");
          out.println("<td>" + UpdateAt + "</td>");
          out.println("</tr>");
        }
      }
    %>

    </tbody>
  </table>

  <div class="btns-foot">
    <div class="left"></div>
    <div class="paging-area">
      <button class="first">&lt;&lt;</button>
      <button class="prev">&lt;</button>
      <ul class="paging">
        <li><button class="active">1</button></li>
        <li><button>2</button></li>
        <li><button>3</button></li>
        <li><button>4</button></li>
      </ul>
      <button class="next">&gt;</button>
      <button class="last">&gt;&gt;</button>
    </div>
    <div class="right">
      <a href="insert.jsp" class="btn btn-default">등록</a>
    </div>
  </div>
<script type="text/javascript" defer>
// const pagingWrap = document.querySelector('.paging');
// pagingWrap.addEventListener('click', function (e) {
//   if (e.target.classList.contains('active')) {
//     return;
//   }
//   const active = pagingWrap.querySelector('.active');
//   active.classList.remove('active');
//   e.target.classList.add('active');
// });
</script>

<jsp:include page="/common/footer.jsp" />