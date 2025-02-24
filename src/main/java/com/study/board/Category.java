package com.study.board;

import com.study.model.CategoryModel;
import com.study.service.board.BoardService;

import java.util.List;

public class Category {
    public List<CategoryModel> getCategoryList() throws Exception {
        BoardService boardService = new BoardService();
        return boardService.getCategoryList();
    }
}
