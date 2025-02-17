<%@ page import="com.study.board.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>

<ul>
<%
    Board board = new Board();

    List<BoardModel> boardList = board.getBoardList();

    // boardList가 null이 아닌 경우 리스트 출력
    if (boardList != null) {
        for (BoardModel boardItem : boardList) {
            out.println("<li>" + boardItem.getId() + "</li>");
            out.println("<li><a href=/boardDetail/"+ boardItem.getId() +">" + boardItem.getTitle() + "</a></li>");
            out.println("<li>" + boardItem.getContent() + "</li>");
        }
    } else {
        out.println("<p>No items found.</p>");
    }

%>
    </ul>

</body>
</html>
