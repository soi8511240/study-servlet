package com.study.board;

import com.study.connection.ConnectionTest;
import com.study.model.BoardModel;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class Board {


    public List<BoardModel> getBoardList() throws Exception {
        List<BoardModel> boardList = new ArrayList<>();

        ConnectionTest connectionTest = new ConnectionTest();
        Statement stmt = connectionTest.getStatement();

        String query = "SELECT id, title, writer FROM Board";
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String writer = rs.getString("writer");

            // Board 객체 생성
            BoardModel board = new BoardModel();
            board.setId(id);
            board.setTitle(title);
            board.setWriter(writer);

            // 리스트에 Board 객체 추가
            boardList.add(board);
        }

        rs.close();
        stmt.close();

        return boardList;
    }

}
