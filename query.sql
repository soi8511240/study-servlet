show databases;

use ebrainsoft_study;

show tables;

DROP table board;
CREATE TABLE board (
                       id INT AUTO_INCREMENT PRIMARY KEY, -- 게시글 고유 ID
                       title VARCHAR(255) NOT NULL,       -- 게시글 제목
                       content TEXT,                      -- 게시글 내용
                       writer VARCHAR(100),               -- 작성자 이름
                       view_cnt INT DEFAULT 0,             -- 조회수
                       is_hide VARCHAR(2) DEFAULT 0,      -- 삭제여부(0.show, 1.hide)
                       created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 생성 시각
                       updated_at DATETIME DEFAULT CURRENT_TIMESTAMP -- 수정 시각
);
COMMIT;

SELECT * FROM board;
SELECT * FROM board WHERE is_hide != 1 AND id=5;
SELECT id, title, content, writer, view_cnt, created_at, updated_at
FROM board
WHERE is_hide != 1 AND id = 1;

UPDATE board SET view_cnt = view_cnt + 1 WHERE id =1;

INSERT INTO board (title, content, writer, created_at, updated_at)
VALUES
    ('Hello World', '첫 번째 게시글입니다.', 'admin', NOW(), NOW()),
    ('Java Tutorial', 'Java에 대한 튜토리얼 자료입니다.', 'user1', NOW(), NOW()),
    ('Spring Boot 가이드', '초보자를 위한 Spring Boot 가이드.', 'user2', NOW(), NOW()),
    ('JDBC란 무엇인가?', 'JDBC의 개념과 사용법을 알아봅니다.', 'user3', NOW(), NOW()),
    ('Database Index의 중요성', '인덱스를 사용해야 하는 이유와 최적화 방법.', 'admin', NOW(), NOW()),
    ('HTTP와 HTTPS의 차이', '웹 보안에서 중요한 HTTP와 HTTPS의 차이를 다룹니다.', 'user4', NOW(), NOW()),
    ('REST API 설계 원칙', 'REST API 설계를 잘 하는 방법', 'user5', NOW(), NOW()),
    ('Docker 시작하기', 'Docker의 기본 사용법과 설치 방법.', 'user6', NOW(), NOW()),
    ('Kubernetes 개요', 'Kubernetes의 개념과 기본 구성요소.', 'user7', NOW(), NOW()),
    ('Git 기본 명령어', 'Git의 add, commit, push 명령어 활용법.', 'user8', NOW(), NOW()),
    ('비동기와 동기 프로그래밍', '코딩에서의 동시성 처리 기법 비교.', 'user9', NOW(), NOW());

UPDATE board
SET
    title = '또 수정된 제목11',
    content = '수정된 컨텐츠11',
    writer = '수정된 테스트11',
    updated_at = NOW()
WHERE
    id = 1;

SELECT *
FROM board
WHERE is_hide != 1
  AND (title LIKE CONCAT('%', 'ht', '%')
    OR content LIKE CONCAT('%', 'ht', '%')
    OR writer LIKE CONCAT('%', 'ht', '%'));


DROP table reply_board;
CREATE TABLE reply_board (
                             id INT AUTO_INCREMENT PRIMARY KEY, -- 댓글 고유 ID
                             board_id INT,                      -- 게시판 ID
                             content TEXT,                      -- 댓글 내용
                             writer VARCHAR(100),               -- 작성자 이름
                             is_hide VARCHAR(2) DEFAULT 0,      -- 삭제여부(0.show, 1.hide)
                             created_at DATETIME DEFAULT CURRENT_TIMESTAMP, -- 생성 시각
                             updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP -- 수정 시각
);

INSERT INTO reply_board (board_id, content, writer, created_at, updated_at)
VALUES( 1,'댓글1-1', '', NOW(), NOW());
INSERT INTO reply_board (board_id, content, writer, created_at, updated_at)
VALUES( 2,'댓글2-1', '', NOW(), NOW());

UPDATE reply_board
SET
    content = '수정된 댓글111',
    updated_at = NOW()
WHERE
    id = 1;

SELECT * FROM reply_board;


CREATE TABLE attach (
                        id INT AUTO_INCREMENT PRIMARY KEY, -- 첨부파일 ID
                        board_id INT,                      -- 게시판 번호
                        name TEXT,                         -- 파일 이름
                        size TEXT,                         -- 파일 크기
                        url TEXT                           -- 파일 경로
);
DROP table attach;

commit;
