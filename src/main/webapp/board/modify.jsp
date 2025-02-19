<%@ page import="com.study.board.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String key = request.getParameter("key");

    Board board = new Board();
    List<BoardModel> boardList = null;
    try {
        boardList = board.getBoardList(key);
    } catch (Exception e) {
        throw new RuntimeException(e);
    }
%>
<%=key%>
<table class="table">
    <%
        // boardList가 null이 아닌 경우 리스트 출력
        if (boardList != null) {
            for (BoardModel boardItem : boardList) {
                out.println("<tr><th>ID</th><td>" + boardItem.getId() + "</td></tr>");
                out.println("<tr><th>Title</th><td>" + boardItem.getTitle() + "</td></tr>");
                out.println("<tr><th>Content</th><td>" + boardItem.getContent() + "</td></tr>");
                out.println("<tr><th>Writer</th><td>" + boardItem.getWriter() + "</td></tr>");
                out.println("<tr><th>Count</th><td>" + boardItem.getViewCount() + "</td></tr>");
                out.println("<tr><th>CreateDate</th><td>" + boardItem.getCreatedAt() + "</td></tr>");
                out.println("<tr><th>UpdateDate</th><td>" + boardItem.getUpdatedAt() + "</td></tr>");
            }
        } else {
            out.println("<p>No items found.</p>");
        }
    %>
</table>
</body>
</html>
