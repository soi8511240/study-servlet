<%@ page import="com.study.board.Board" %>
<%@ page import="com.study.util.DateUtil" %>
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
    // DATE Format
    const DATE_FORMAT = "yy-mm-dd";
    const dateFormatter = (date)=>{
      return date.toISOString().split('T')[0];
    }

    // DATE 오늘, 1년전 셋팅
    const now = new Date();
    const oneYearAgo = new Date();
    oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);

    // url parameter 해석하기
    const setSearchFilter = ()=>{
      const url = new URL(window.location);
      const urlFilter = url.searchParams;
      return {
        keyword: urlFilter.get('keyword') || '',
        type: '',
        startDt: urlFilter.get('startDt') || dateFormatter(oneYearAgo),
        endDt: urlFilter.get('endDt') || dateFormatter(now)
      }
    }

    const keywordInput = document.querySelector('#keyword');
    const startDt = document.querySelector('#startDt');
    const endDt = document.querySelector('#endDt');
    // filter 초기화
    const searchFilterInit = ()=>{
      const defaultSearchFilter = setSearchFilter();
      $(startDt)
              .datepicker({dateFormat:DATE_FORMAT})
              .datepicker("setDate", defaultSearchFilter.startDt);

      $(endDt)
              .datepicker({dateFormat:DATE_FORMAT})
              .datepicker("setDate", defaultSearchFilter.endDt);

      keywordInput.value = defaultSearchFilter.keyword || '';
    }

    // search 이벤트 초기화
    const searchEventInit = ()=>{
      document.querySelector('#sr-button').addEventListener('click', goSearch);

      keywordInput.focus();
      keywordInput.addEventListener('keyup', function (e) {
        e.preventDefault();

        if ( e.keyCode === 13) {
          goSearch();
        }
      })
    }

    const goSearch = ()=>{
      const url = new URL(window.location.href);
      url.searchParams.set('keyword', document.getElementById('keyword').value.toString());
      url.searchParams.set('startDt', document.getElementById('startDt').value.toString());
      url.searchParams.set('endDt',   document.getElementById('endDt').value.toString());
      window.location.href = url.toString();
    }

    const init = ()=>{
      searchFilterInit();
      searchEventInit();
    }

    window.addEventListener('load', init);
  </script>

  <%
    Board board = new Board();

    List<BoardModel> boardList;
    // request.setCharacterEncoding("utf-8");

    // 검색조건 설정하기
    String keyword    = request.getParameter("keyword");
    String startDt    = request.getParameter("startDt");
    String endDt      = request.getParameter("endDt");
    keyword = (keyword == null || keyword.trim().isEmpty())
            ? ""
            : keyword.trim();
    startDt = (startDt == null || startDt.trim().isEmpty())
            ? DateUtil.getToday()
            : startDt.trim();
    endDt   = (endDt == null || endDt.trim().isEmpty())
            ? DateUtil.getToday()
            : endDt.trim();

    // Paging
    String pagingNum  = request.getParameter("pagingNow");
    String pagingCnt  = request.getParameter("paging");

//    out.println("keyword : ");
//    out.println(keyword);
//    out.println("<br>startDt : ");
//    out.println(startDt);
//    out.println("<br>endDt : ");
//    out.println(endDt);

    try {
      boardList = board.getBoardList(keyword, startDt, endDt, 1);
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
      if (boardList.isEmpty()){
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

</script>

<jsp:include page="/common/footer.jsp" />