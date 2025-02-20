<%@ page import="com.study.board.Board" %>
<%@ page import="java.util.List" %>
<%@ page import="com.study.model.BoardModel" %>
<jsp:include page="/common/header.jsp" />
<%
    response.sendRedirect("/board/list.jsp");
%>
<jsp:include page="/common/footer.jsp" />