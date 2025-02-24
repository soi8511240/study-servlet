<%@ page import="com.study.board.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<jsp:include page="/common/header.jsp" />
<%
    String key = request.getParameter("key");

    Board board = new Board();
    BoardModel boardDetail;

    try {
        boardDetail = board.getBoardById(key);
    } catch (Exception e) {
        boardDetail = null;
    }
%>
<%=key%>
<table class="table-horizontal">
<%
    // boardList가 null이 아닌 경우 리스트 출력
    if (boardDetail == null) {
        out.println("<p>데이터없음</p>");
    } else {
        out.println("<tr><th>ID</th><td>" + boardDetail.getId() + "</td></tr>");
        out.println("<tr><th>Title</th><td>" + boardDetail.getTitle() + "</td></tr>");
        out.println("<tr><th>Content</th><td>" + boardDetail.getContent() + "</td></tr>");
        out.println("<tr><th>Writer</th><td>" + boardDetail.getWriter() + "</td></tr>");
        out.println("<tr><th>Count</th><td>" + boardDetail.getViewCount() + "</td></tr>");
        out.println("<tr><th>CreateDate</th><td>" + boardDetail.getCreatedAt() + "</td></tr>");
        out.println("<tr><th>UpdateDate</th><td>" + boardDetail.getUpdatedAt() + "</td></tr>");
    }
%>
</table>

<div class="btns-foot">
    <div class="left"></div>
    <div class="right">
        <a href="list.jsp" class="btn btn-default primary">목록</a>
    </div>
</div>
<jsp:include page="/common/footer.jsp" />
