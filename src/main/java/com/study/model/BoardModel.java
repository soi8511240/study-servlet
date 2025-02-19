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
    private String createdAt;
    private String updatedAt;
    private int viewCount;
    private String deletedAt;
}