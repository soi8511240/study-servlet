package com.study.board;

import com.study.model.BoardModel;
import com.study.service.board.BoardService;

import java.util.List;

public class Board {

    BoardService boardService = new BoardService();

    public List<BoardModel> getBoardList() throws Exception {
        return boardService.getBoardList(0);
    }

    public List<BoardModel> getBoardList(int key) throws Exception {
        return boardService.getBoardList(key);
    }

    public List<BoardModel> getBoardList(String keyword) throws Exception {
        return boardService.getBoardList(keyword);
    }

}
