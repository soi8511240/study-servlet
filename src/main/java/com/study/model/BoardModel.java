package com.study.model;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Getter
@Setter
public class BoardModel {
    private int id;
    private String title;
    private String content;
    private String writer;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int viewCount;
    private LocalDateTime deletedAt;
}