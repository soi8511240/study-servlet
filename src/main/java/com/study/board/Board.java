package com.study.board;

import com.study.model.BoardModel;
import com.study.model.PagingModel;
import com.study.service.board.BoardService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Board {

    BoardService boardService = new BoardService();

    public List<BoardModel> getBoardList(int key) throws Exception {
        return boardService.getList(key);
    }

    public List<BoardModel> getBoardList(String keyword, String StartDt, String endDt, int paginationCurrentPage) throws Exception {
        return boardService.getList(keyword, StartDt, endDt, paginationCurrentPage);
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
