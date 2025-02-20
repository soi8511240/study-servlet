package com.study.service.board;

import com.study.Constants;
import com.study.connection.ConnectionTest;
import com.study.model.BoardModel;
import com.study.model.PagingModel;

import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class BoardService {

    Statement stmt = null;
    ConnectionTest connectionTest = new ConnectionTest();

    // 상세 가져오기
    public BoardModel getBoardDetail(String key) throws Exception {
        BoardModel board = new BoardModel();

        stmt = connectionTest.getStatement();
        String query = "SELECT * FROM board WHERE is_hide != 1 AND id = " + key + ";";
        System.out.println(query);

        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) {
            int id = rs.getInt("id");
            String title = rs.getString("title");
            String content = rs.getString("content");
            String writer = rs.getString("writer");
            int view_cnt = rs.getInt("view_cnt");
            String created_at = rs.getTimestamp("created_at").toString();
            String updated_at = rs.getTimestamp("updated_at").toString();

            board.setId(id);
            board.setTitle(title);
            board.setContent(content);
            board.setWriter(writer);
            board.setViewCount(view_cnt);
            board.setCreatedAt(created_at);
            board.setUpdatedAt(updated_at);
        }
        rs.close();
        connectionTest.closeConnection(stmt);

        return board;
    }

    // 페이징 관련 가져오기
    public PagingModel getPaging(String keyword, String startDt, String endDt, int paginationCurrentPage) throws Exception {
        PagingModel pagingModel = new PagingModel();

        String query;
        stmt = connectionTest.getStatement();

        query = "SELECT COUNT(*) AS total_cnt FROM board " +
                "WHERE is_hide != 1 " +
                "AND created_at BETWEEN '" + startDt + "' AND '" + endDt + "' " +
                "AND (title LIKE CONCAT('%', '" + keyword + "', '%') OR content LIKE CONCAT('%', '" + keyword + "', '%') OR writer LIKE CONCAT('%', '" + keyword + "', '%'));";

        System.out.println("query : " + query);

        ResultSet rs = stmt.executeQuery(query);

        if (rs.next()) {
            int totalCnt = rs.getInt("total_cnt");
            int totalPage = (int) Math.ceil((double) totalCnt / Constants.FETCH_COUNT);

            pagingModel.setTotalCnt(totalCnt+1);
            pagingModel.setCurrentPage(paginationCurrentPage);
            pagingModel.setTotalPage(totalPage);
        } else {
            pagingModel.setTotalCnt(0);
            pagingModel.setCurrentPage(0);
            pagingModel.setTotalPage(0);
        }

        rs.next();
        rs.close();
        connectionTest.closeConnection(stmt);

        return pagingModel;
    }

    // 리스트 가져오기
    public List<BoardModel> getList(
            String keyword, String startDt, String endDt, int paginationCurrentPage)
            throws Exception {
        List<BoardModel> listBoardModel = new ArrayList<>();
        String query;
        
        // Todo: 전체글 갯수 구하는 쿼리를 또 날려야함?
        //  한번에 다 가져오는게 맞는거임?

        stmt = connectionTest.getStatement();

        query = "SELECT * FROM board " +
                "WHERE is_hide != 1 " +
                "AND created_at BETWEEN '" + startDt + "' AND '" + endDt + "' " +
                "AND (title LIKE CONCAT('%', '" + keyword + "', '%') OR content LIKE CONCAT('%', '" + keyword + "', '%') OR writer LIKE CONCAT('%', '" + keyword + "', '%')) " +
                "LIMIT " + Constants.FETCH_COUNT * (paginationCurrentPage-1) + ", " +
                " " + Constants.FETCH_COUNT + ";";

        System.out.println(query);

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
