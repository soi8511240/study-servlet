<%@ page import="com.study.board.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    *{
      padding: 0;
      margin: 0;
    }
    .wrap{
      width: 1024px;
      margin: 0 auto;
    }
    table{
      width: 100%;
      border-collapse: collapse;
      border-top: 1px solid #666;
    }
    th{
      border-bottom: 1px solid #666;
      padding: 10px;
    }
    td{
      height: 40px;
      font-size: 14px;
      padding: 10px;
      border-bottom: 1px solid #ccc;
      text-align: center;
    }
    a{
      text-decoration: none;
    }
    a:hover{
      text-decoration: underline;
    }

  </style>
</head>
<body>
<div class="wrap">

  <div class="searchbar">
    <input type="text" id="content">
    <button id="sr-button" type="button">검색</button>
  </div>

  <script type="text/javascript">
    document.getElementById('sr-button').addEventListener('click', function () {
      window.location.href = '/board/list.jsp?keyword=' + document.getElementById('content').value;
    });
  </script>

  <table class="table">
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
      Board board = new Board();

      List<BoardModel> boardList;
      String keyword = request.getParameter("keyword");
      // Todo: 검색 키워드 처리하는거 수정해야댐. 영어랑 한글 안됨.
      try {
        if (keyword == null || keyword.trim().isEmpty()
        ){
          //전체
          boardList = board.getBoardList();
        }else{
          //검색결과
          boardList = board.getBoardList(keyword.trim());
        }
      } catch (Exception e) {
        throw new RuntimeException(e);
      }
      %>
      <script type="text/javascript">
        alert('<%= boardList %>');
      </script>
      <%
      // boardList가 null이 아닌 경우 리스트 출력
      if (boardList != null) {
        for (BoardModel boardItem : boardList) {
          out.println("<tr>");
          out.println("<td><a href=/board/detail.jsp?key="+ boardItem.getId() +">" + boardItem.getTitle() + "</a></td>");
          out.println("<td>" + boardItem.getWriter() + "</td>");
          out.println("<td>" + boardItem.getViewCount() + "</td>");
          out.println("<td>" + boardItem.getCreatedAt() + "</td>");
          out.println("<td>" + boardItem.getUpdatedAt() + "</td>");
          out.println("</tr>");
        }
      } else {
        out.println("<tr>데이터가 없습니다.</tr>");
      }
    %>

    </tbody>
  </table>

</div>


</body>
</html>
