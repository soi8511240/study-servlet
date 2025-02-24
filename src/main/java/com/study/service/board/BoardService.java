package com.study.service.board;

import com.study.Constants;
import com.study.connection.ConnectionTest;
import com.study.model.BoardModel;
import com.study.model.CategoryModel;
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
        // Todo: erro 났을대 꺼줘야하는
        // Try With Close maybe..
        // prepaired 프리페어드
        rs.close();
        connectionTest.closeConnection(stmt);

        return board;
    }

    // 페이징 관련 가져오기
    public PagingModel getPaging(String keyword, String startDt, String endDt, int paginationCurrentPage, String category) throws Exception {
        PagingModel pagingModel = new PagingModel();

        String query;
        stmt = connectionTest.getStatement();

        query = "SELECT COUNT(*) AS total_cnt FROM board " +
                "WHERE is_hide != 1 " +
//                "AND b.category = '" + category + "' " +
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
            String keyword, String startDt, String endDt, int paginationCurrentPage, String category
    ) throws Exception {
        List<BoardModel> listBoardModel = new ArrayList<>();
        String query;

        stmt = connectionTest.getStatement();

        query = "SELECT b.*, c.name AS category_name " +
                "FROM board b " +
                "LEFT JOIN category c ON CAST(b.category AS UNSIGNED) = c.id " +
                "WHERE b.is_hide != 1 " +
//                "AND b.category = '" + category + "' " +
                "AND b.created_at BETWEEN '" + startDt + "' AND '" + endDt + "' " +
                "AND (b.title LIKE CONCAT('%', '" + keyword + "', '%') OR b.content LIKE CONCAT('%', '" + keyword + "', '%') OR b.writer LIKE CONCAT('%', '" + keyword + "', '%')) " +
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
            String categoryName = rs.getString("category_name");

            // Board 객체 생성
            BoardModel board = new BoardModel();
            board.setId(id);
            board.setTitle(title);
            board.setContent(content);
            board.setWriter(writer);
            board.setViewCount(view_cnt);
            board.setCategoryName(categoryName);
            board.setCreatedAt(created_at);
            board.setUpdatedAt(updated_at);

            // 리스트에 Board 객체 추가
            listBoardModel.add(board);
        }

        rs.close();
        connectionTest.closeConnection(stmt);

        return listBoardModel;
    }

    public List<CategoryModel> getCategoryList() throws Exception {
        List<CategoryModel> categoryList = new ArrayList<>();
        stmt = connectionTest.getStatement();
        String query = "SELECT * FROM category;";
        ResultSet rs = stmt.executeQuery(query);
        while (rs.next()) {
            int id = rs.getInt("id");
            String name = rs.getString("name");
            CategoryModel category = new CategoryModel();
            category.setId(id);
            category.setName(name);
            categoryList.add(category);
        }
        rs.close();
        connectionTest.closeConnection(stmt);

        return categoryList;
    }

    public int insertBoard(BoardModel boardModel) throws Exception {
        stmt = connectionTest.getStatement();
        String query =
                "INSERT INTO board (title, content, writer, created_at, updated_at) " +
                "VALUE ('" + boardModel.getTitle() + "', '" + boardModel.getContent() + "', '" + boardModel.getWriter() + "', NOW(), NOW());";
//        String selectQuery = "SELECT LAST_INSERT_ID() AS id;";
        String selectQuery = "SELECT * FROM board WHERE id = LAST_INSERT_ID();";

        System.out.println(query); //Todo : 로그백 사용

        int insertResult = stmt.executeUpdate(query);
        if (insertResult == 0) {
            return 0;
        }

        ResultSet rs = stmt.executeQuery(selectQuery);
        int id;
        if (rs.next()) {
            id = rs.getInt("id");
        }else{
            id = -1;
        }
        rs.close();
        connectionTest.closeConnection(stmt);

        return id;
    }

    /**
     *
     * @param boardModel
     * @throws Exception
     */
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
