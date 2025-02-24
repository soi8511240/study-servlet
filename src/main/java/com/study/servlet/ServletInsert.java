package com.study.servlet;

import com.study.board.Board;
import com.study.model.BoardModel;
import com.study.service.board.BoardService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Enumeration;

@WebServlet("/board/servletInsert")
public class ServletInsert extends HttpServlet {
    private static final long serialVersionUID = 1L;

    Board board = new Board();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("doGet");

        BoardModel boardModel = new BoardModel();

        String title = request.getParameter("title");
        String writer = request.getParameter("writer");
        String text = request.getParameter("text");

        System.out.println("title : " + title);
        System.out.println("writer : " + writer);
        System.out.println("text : " + text);

        boardModel.setTitle(title);
        boardModel.setWriter(writer);
        boardModel.setContent(text);

        int id;
        try {
            id = board.insertBoard(boardModel);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
//        response.getWriter().write("성공 success");

        if (id == 0) {
            response.setContentType("text/html; charset=UTF-8");
            response.getWriter().write("실패");
            return;
        }

        response.sendRedirect("/board/detail.jsp?key="+id);

    }
//    @Override
//    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        System.out.println("service");
//
//        BoardModel boardModel = new BoardModel();
//
//        request.setCharacterEncoding("utf-8");
////
////        Enumeration<String> key = request.getParameterNames();
////        for ( key.nextElement(); key.hasMoreElements();){
////            System.out.println(key.nextElement());
////        }
//
//        Enumeration<String> key = request.getAttributeNames();
//        while (key.hasMoreElements()) {
//            String attributeName = key.nextElement();
//            System.out.println("Attribute Name: " + attributeName + ", Value: " + request.getAttribute(attributeName));
//        }
//
//        String title = (String) request.getAttribute("title");
//        String writer = request.getParameter("writer");
//        String text = request.getParameter("text");
//
//        System.out.println("title : " + title);
//        System.out.println("writer : " + writer);
//        System.out.println("text : " + text);
//
//        boardModel.setTitle(title);
//        boardModel.setWriter(writer);
//        boardModel.setContent(text);
//
//        try {
//            boardService.insertBoard(boardModel);
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }
//    }

}
