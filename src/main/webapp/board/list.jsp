<%@ page import="com.study.board.Board" %>
<%@ page import="com.study.board.Category" %>
<%@ page import="com.study.util.CommonUtil" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.study.Constants" %>
<%@ page import="com.study.model.PagingModel" %>
<%@ page import="com.study.model.CategoryModel" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/common/header.jsp" />

  <%
    Board board = new Board();
    Map<String, Object> result;

    Category category = new Category();
    List<CategoryModel> categories;

    // request.setCharacterEncoding("utf-8");
    // 검색조건 설정하기
    String keyword     = request.getParameter("keyword");
    String startDt     = request.getParameter("startDt");
    String endDt       = request.getParameter("endDt");
    String currentPage = request.getParameter("currentPage");
    String type        = request.getParameter("type");

    keyword = (keyword == null || keyword.trim().isEmpty())
            ? ""
            : keyword.trim();
    startDt = (startDt == null || startDt.trim().isEmpty())
            ? CommonUtil.getOneYearAgo()
            : startDt.trim();
    endDt   = (endDt == null || endDt.trim().isEmpty())
            ? CommonUtil.getToday()
            : endDt.trim();
    currentPage = (currentPage == null || currentPage.trim().isEmpty())
            ? "1"
            : currentPage;
    type = (type == null || type.trim().isEmpty())
            ? ""
            : type;

    // paging
    int intCurrentPage;
    int totalCnt;
    int totalPage;

    intCurrentPage = Integer.parseInt(currentPage);

    try {
      result = board.getBoardList(keyword, startDt, endDt, intCurrentPage, type);
    } catch (Exception e) {
//      e.printStackTrace();
      result = null;
      out.println("<div>ERROR</div>");
    }

    List<BoardModel> boardList = (List<BoardModel>) result.get("boardList");
    PagingModel paging = (PagingModel) Objects.requireNonNull(result).get("boardPaging");
    totalCnt = paging.getTotalCnt();
    totalPage = paging.getTotalPage();

      try {
          categories = category.getCategoryList();
      } catch (Exception e) {
          categories = null;
          throw new RuntimeException(e);
      }
  %>

<div class="searchbar">
  <span>등록일</span>
  <div class="area-datepicker">
    <input type="text" class="input-datepicker" id="startDt" value="<%=startDt%>" />~
    <input type="text" class="input-datepicker" id="endDt"  value="<%=endDt%>"/>
  </div>
  <select class="select" id="categorySelect">
    <option value="">전체</option>

    <%
      if (categories.isEmpty()){
        out.println("<option>카테고리가 없습니다.</option>");
      } else {
        for (CategoryModel categoryItem : categories) {
          String displayValue = String.valueOf(categoryItem.getId());
          String displayName = categoryItem.getName();
          out.println("<option value='" + displayValue + "'>" + displayName + "</option>");
        }
      }
    %>
  </select>
  <input type="text" id="keyword" placeholder="검색어를 입력해 주세요. (제목 + 작성자 + 내용)" value="<%=keyword%>"/>
  <button id="sr-button" class="btn-sr" type="button">검색</button>
</div>

<script type="text/javascript" defer>
  // DATE Format
  const DATE_FORMAT = "yy-mm-dd";
  const dateFormatter = (date)=>{
    return date.toISOString().split('T')[0];
  }

  // DATE 오늘, 1년전 셋팅
  // const now = new Date();
  // const oneYearAgo = new Date();
  // oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);

  // url parameter 해석하기
  const searchFilter = ()=>{
    const url = new URL(window.location);
    const urlFilter = url.searchParams;
    return {
      keyword: urlFilter.get('keyword') || '',
      type: $('select#categorySelect').val() || '',
      startDt: urlFilter.get('startDt') || <%=endDt%>,
      endDt: urlFilter.get('endDt') || <%=startDt%>,
      currentPage: urlFilter.get('currentPage') || <%=currentPage%>,
    }
  }

  const keywordInput = document.querySelector('#keyword');
  const startDt = document.querySelector('#startDt');
  const endDt = document.querySelector('#endDt');

  // filter 초기화
  let defaultSearchFilter;
  const searchFilterInit = ()=>{
    $(startDt)
            .datepicker({dateFormat:DATE_FORMAT})
            // .datepicker("setDate", defaultSearchFilter.startDt);

    $(endDt)
            .datepicker({dateFormat:DATE_FORMAT})
            // .datepicker("setDate", defaultSearchFilter.endDt);

    keywordInput.value = defaultSearchFilter.keyword || '';
  }

  // search 이벤트 초기화
  const searchEventInit = ()=>{
    document.querySelector('#sr-button').addEventListener('click', ()=>goSearch(defaultSearchFilter));

    keywordInput.focus();
    keywordInput.addEventListener('keyup', function (e) {
      e.preventDefault();

      if ( e.keyCode === 13) {
        goSearch(defaultSearchFilter);
      }
    })
  }

  // 검색
  const goSearch = (params)=>{
    const url = new URL(window.location.href);

    Object.keys(params).forEach(key => {
      let value = '';
      try{
        value = document.getElementById(key).value.toString();
      }catch (e){
        value = params[key];
      }

      console.log('goSearch', key, params[key], value);
      url.searchParams.set(key, value);
    });

    window.location.href = url.toString();
  }

  const init = ()=>{
    defaultSearchFilter = searchFilter();
    searchFilterInit();
    searchEventInit();
    // setUiPaging();
    pagingInit();
  }

  window.addEventListener('load', init);
</script>

  <div class="table-top">
    총 <%=totalCnt%>건
  </div>

  <table class="table-list">
    <colgroup>
      <col style="width: 15%;" />
      <col style="" />
      <col style="width: 10%" />
      <col style="width: 10%" />
      <col style="width: 16%" />
      <col style="width: 16%" />
    </colgroup>
    <thead>
    <tr>
      <th>카테고리</th>
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
          out.println("<td>" + boardItem.getCategoryName() + "</td>");
          out.println("<td><a href=/board/detail.jsp?key="+ boardItem.getId() +">" + title + "</a></td>");
          out.println("<td>" + boardItem.getWriter() + "</td>");
          out.println("<td>" + CommonUtil.formatWithComma(boardItem.getViewCount()) + "</td>");
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
      <%
        for (int i = 1; i < totalPage+1; i++){
          if(i == intCurrentPage){
            out.println("<li><button class='active'>" + i + "</button></li>");
          }else{
            out.println("<li><button>" + i + "</button></li>");
          }
        }
      %>

      </ul>
      <button class="next">&gt;</button>
      <button class="last">&gt;&gt;</button>
    </div>
    <div class="right">
      <a href="insert.jsp" class="btn btn-default">등록</a>
    </div>
  </div>
<script type="text/javascript" defer>
  const totalCount = <%=totalCnt%> || 1;
  const currentPage = <%=currentPage%> || 1;
  const pagingList = <%=totalPage%>;

  const pagingBtnLink = (btn)=>{

    btn.addEventListener('click', (e)=>{
      let searchFilter = defaultSearchFilter;
      switch (e.target.attributes.class?.value) {
        case 'first':
          if ( currentPage === 1 ) {
            return;
          }

          searchFilter = {...searchFilter, currentPage: 1}
          goSearch(searchFilter);

          break;
        case 'prev':
          if ( currentPage === 1 ) {
            return;
          }
          searchFilter = {...searchFilter, currentPage: currentPage-1}
          goSearch(searchFilter);

          break;
        case 'next':
          if ( currentPage+1 > pagingList ) {
            return;
          }
          console.log('currentPage', currentPage, pagingList)
          searchFilter = {...searchFilter, currentPage: currentPage+1}
          goSearch(searchFilter);

          break;
        case 'last':
          if ( currentPage === pagingList ) {
            return;
          }

          searchFilter = {...searchFilter, currentPage: pagingList}
          goSearch(searchFilter);
          break;

        case 'active':
          break;

        default:
          // console.log('e.target.innerText', e.target.innerText)
          searchFilter = {...searchFilter, currentPage: e.target.innerText}
          console.log('searchFilter', searchFilter)
          goSearch(searchFilter);


          break;
      }
    });
  }
  const pagingInit = ()=>{
    document.querySelectorAll('.paging-area button').forEach(pagingBtnLink);
  }

</script>

<jsp:include page="/common/footer.jsp" />