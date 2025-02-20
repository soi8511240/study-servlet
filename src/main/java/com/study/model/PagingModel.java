package com.study.model;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PagingModel {
    private int currentPage;
    private int totalCnt;
    private int totalPage;
}
