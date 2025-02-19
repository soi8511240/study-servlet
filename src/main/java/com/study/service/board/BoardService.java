package com.study.service.board;

import com.study.connection.ConnectionTest;
import com.study.model.BoardModel;

import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class BoardService {

    Statement stmt = null;
    ConnectionTest connectionTest = new ConnectionTest();

    public List<BoardModel> getBoardList(int key) throws Exception {
        List<BoardModel> listBoardModel = new ArrayList<>();

        stmt = connectionTest.getStatement();
        String query;
        if (key == 0) {
            // 전체 리스트
            query = "SELECT * FROM board WHERE is_hide != 1;"; 
        }else{
            // 상세 페이지
            cntPlus(key);
            query = "SELECT * FROM board WHERE is_hide != 1 AND id = "+ key +";"; // 숨김처리 안된거만,
        }
        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {

            int id = rs.getInt("id");
            String title = rs.getString("title");
            String content = rs.getString("content");
            String writer = rs.getString("writer");
            int view_cnt = rs.getInt("view_cnt");
            String created_at = rs.getTimestamp("created_at").toString();
            String updated_at = rs.getTimestamp("updated_at").toString();

            // Board 객체 생성
            BoardModel board = new BoardModel();
            board.setId(id);
            board.setTitle(title);
            board.setContent(content);
            board.setWriter(writer);
            board.setViewCount(view_cnt);
            board.setCreatedAt(created_at);
            board.setUpdatedAt(updated_at);

            // 리스트에 Board 객체 추가
            listBoardModel.add(board);
        }

        rs.close();
        connectionTest.closeConnection(stmt);

        return listBoardModel;
    }

    // keyword 검색
    public List<BoardModel> getBoardList(String keyword) throws Exception {
        List<BoardModel> listBoardModel = new ArrayList<>();

        stmt = connectionTest.getStatement();
        String query;
        if (keyword.isEmpty()) {
            query = "SELECT * FROM board WHERE is_hide != 1;";
        }else{
            query = "SELECT * FROM board WHERE is_hide != 1 " +
                    "AND (title LIKE CONCAT('%', " + keyword + ", '%') " +
                    "OR content LIKE CONCAT('%', " + keyword + ", '%') " +
                    "OR writer LIKE CONCAT('%', " + keyword + ", '%'));";
        }

        ResultSet rs = stmt.executeQuery(query);

        while (rs.next()) {

            int id = rs.getInt("id");
            String title = rs.getString("title");
            String content = rs.getString("content");
            String writer = rs.getString("writer");
            int view_cnt = rs.getInt("view_cnt");
            String created_at = rs.getTimestamp("created_at").toString();
            String updated_at = rs.getTimestamp("updated_at").toString();

            // Board 객체 생성
            BoardModel board = new BoardModel();
            board.setId(id);
            board.setTitle(title);
            board.setContent(content);
            board.setWriter(writer);
            board.setViewCount(view_cnt);
            board.setCreatedAt(created_at);
            board.setUpdatedAt(updated_at);

            // 리스트에 Board 객체 추가
            listBoardModel.add(board);
        }

        rs.close();
        connectionTest.closeConnection(stmt);

        return listBoardModel;
    }

    public void insertBoard(BoardModel boardModel) throws Exception {

    }

    public void updateBoard(BoardModel boardModel) throws Exception {
        stmt = connectionTest.getStatement();
        String query =
                "UPDATE board SET " +
                    "title = '" + boardModel.getTitle() +
                    "', content = '" + boardModel.getContent() +
                    "', updated_at = NOW()'" +
                "' WHERE id = " + boardModel.getId() + ";";
        stmt.executeUpdate(query);
        connectionTest.closeConnection(stmt);
    }

    public void cntPlus(int id) throws Exception {
        stmt = connectionTest.getStatement();
        String query = "UPDATE board SET view_cnt = view_cnt + 1 WHERE id = " + id + ";";
        stmt.executeUpdate(query);
    }
}
