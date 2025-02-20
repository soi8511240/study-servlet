package com.study.board;

import com.study.model.BoardModel;
import com.study.service.board.BoardService;

import java.util.HashMap;
import java.util.Map;

public class Board {

    BoardService boardService = new BoardService();

    public BoardModel getBoardById(String key) throws Exception {
        return boardService.getBoardDetail(key);
    }

    static String pastKeyword;
    public Map<String, Object> getBoardList(String keyword, String StartDt, String endDt, int paginationCurrentPage) throws Exception {
        Map<String, Object> mapObject = new HashMap<>();

        int currentPage;
        currentPage = (pastKeyword != null && pastKeyword.equals(keyword))? paginationCurrentPage: 1;
        System.out.println("pastKeyword : " + pastKeyword);
        System.out.println("keyword : " + keyword);
        System.out.println("currentPage : " + currentPage);
        pastKeyword = keyword;

        mapObject.put("boardPaging", boardService.getPaging(keyword, StartDt, endDt, currentPage));
        mapObject.put("boardList", boardService.getList(keyword, StartDt, endDt, currentPage));


        return mapObject;

//        return boardService.getList(keyword, StartDt, endDt, paginationCurrentPage);
    }

//    public Map<String, Object> getBoardList(String keyword, String StartDt, String endDt, int paginationCurrentPage) throws Exception {
//        Map<String, Object> mapObject = new HashMap<>();
//        PagingModel paging = new PagingModel();
//        mapObject.put("paging", paging); //service
//        mapObject.put("List", boardService); //service
//    }
//
//    Map<String, Object>
//
//    paging: pagingModel,
//    list:List<BoardModel>

}
