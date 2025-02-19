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
        <%
            response.sendRedirect("/board/list.jsp?keyword=");
        %>

</div>


</body>
</html>
