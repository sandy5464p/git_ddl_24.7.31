/*항상 범위 주석을 사용한다. */
CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE,
   MEMBER_PASSWORD VARCHAR2(255),
   MEMBER_AGE NUMBER(3) CONSTRAINT CHECK_AGE CHECK(MEMBER_AGE > 0)
);
CREATE TABLE TBL_ORDER(
	ID NUMBER CONSTRAINT PK_ORDER PRIMARY KEY,
	MEMBER_ID NUMBER,
	ORDER_DATE DATE  DEFAULT CURRENT_TIMESTAMP,/*현재 시간 */
	ORDER_COUNT NUMBER DEFAULT 1, 
	 CONSTRAINT FK_ORDER_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID)
);

/*동물원*/
/*동물*/

CREATE TABLE TBL_ZOO(
	 ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY,
   ZOO_NAME VARCHAR2(255),
   ZOO_ADDRESS VARCHAR2(255),
   ZOO_ADDRESS_DETAIL VARCHAR2(255),
   ZOO_MAX_ANIMAL NUMBER DEFAULT 0
	 );
	 
	
CREATE  TABLE TBL_ANIMAL(
	ID NUMBER CONSTRAINT PK_ANIMAL PRIMARY KEY,
   ANIMAL_NAME VARCHAR2(255),
   ANIMAL_TYPE VARCHAR2(255),
   ANIMAL_AGE NUMBER DEFAULT 0,
   ANIMAL_HEIGHT NUMBER(3, 5),
   ANIMAL_WEIGHT NUMBER(3, 5),
   ZOO_ID NUMBER,
   CONSTRAINT FK_ANIMAL_ZOO FOREIGN KEY(ZOO_ID)
   REFERENCES TBL_ZOO(ID)
);

/*논리적 설계 
   회원          주문              상품
   ----------------------------------------
   번호PK      번호PK          번호PK
   ----------------------------------------
   아이디U, NN   날짜NN          이름NN
   비밀번호NN      회원번호FK, NN      가격D=0
   이름NN      상품번호FK, NN      재고D=0
   주소NN
   이메일
   생일
*/
/*물리적 설계 
 * MEMBER 				
 * -----------
 * ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY	
 * -----------
 * MEMBER_NAME VARCHAR2(1000) UK NOT NULL 
 * MEMBER_PW VARCHAR2(1000) NOT NULL
 * MEMBER_NAME VARCHAR2(1000) NOT NULL 
 * MEMBER_ADDRESS VARCHAR2(1000) NOT NULL
 * MEMBER_EMAIL VARCHAR2(1000)
 * MEMBER_BIRTH DATE
 * 
 * 
 * PRODUCTNUMBER
 * -------------
 *	ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY
 * -------------
 * PRODUCTNUMBER_DATE DATE NOT NULL
 * MEMBER_ID NOT NULL
 * PRODUCT_ID NUMBER NOT NULL
 * 
 * 
 * 
 * PRODUCT
 * -------------
 * ID NUMBER CONSTRAINT PK_ZOO PRIMARY KEY
 * ---------------------------------------
 * PRODUCT_NAME VARCHAR2(1000)NOT NULL
 * PRODUCT_ STOCK NUMBER DEFAULT 0
 * PRODUCT_PRIC NUMBER DEFAULT 0
 * 
 * */

CREATE TABLE TBL_MEMBER2 (
  	ID NUMBER CONSTRAINT PK_MEMBER2 PRIMARY KEY,
  	MEMBER2_ID VARCHAR2(1000)CONSTRAINT UK_MEMBER2 UNIQUE NOT NULL,
  	MEMBER2_PW VARCHAR2(1000) NOT NULL,
   	MEMBER2_NAME VARCHAR2(1000) NOT NULL, 
	MEMBER2_ADDRESS VARCHAR2(1000) NOT NULL,
 	MEMBER2_EMAIL VARCHAR2(1000),
	MEMBER2_BIRTH DATE DEFAULT CURRENT_TIMESTAMP
);

CREATE  TABLE TBL_PRODUCT(
	ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
	PRODUCT_NAME VARCHAR2(1000)NOT NULL,
	PRODUCT_STOCK NUMBER DEFAULT 0,
	PRODUCT_PRIC NUMBER DEFAULT 0
);

CREATE  TABLE TBL_PRODUCTNUMBER(
	ID NUMBER CONSTRAINT PK_PRODUCTNUMBER PRIMARY KEY,
	PRODUCTNUMBER_DATE DATE DEFAULT CURRENT_TIMESTAMP NOT NULL,
	MEMBER2_ID NOT NULL,
	PRODUCT_ID NUMBER NOT NULL,
	CONSTRAINT FK_PRODUCTNUMBER_MEMBER2 FOREIGN KEY(MEMBER2_ID)
   REFERENCES TBL_MEMBER2(ID),   
   CONSTRAINT FK_PRODUCTNUMBER_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)   
);

/*숙제*/

/*1. 요구사항 분석
    꽃 테이블과 화분 테이블 2개가 필요하고,
    꽃을 구매할 때 화분도 같이 구매합니다.
    꽃은 이름과 색상, 가격이 있고,
    화분은 제품번호, 색상, 모양이 있습니다.
    화분은 모든 꽃을 담을 수 없고 정해진 꽃을 담아야 합니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현*/

/*논리 설계 */
/* 꽃 					화분
 * ------------------------------
 * 번호PK				번호PK
 * -------------------------------
 * 이름					제품번호
 * 색상					색상
 * 가격					모양
 * 						꽃 번호FK 
 * */

/*물리적 설계*/
/*FLOWER 
 *-------
 *ID NUMBER 
 *FLOWER_NAME VARCHAR2(200)
 *FLOWER_COLOR VARCHAR2(200)
 *FLOWER_PRIC NUMBER
 *
 *FLOWERPOT
 *----------
 *ID NUMBER
 *FLOWERPOT_PRPRODUCTNUMBER VARCHAR2(500)
 *FLOWERPOT_COLOR VARCHAR2(200)
 *FLOWERPOT_SHAPE VARCHAR2(200)
 *FLOWER_ID NUMBER
 **/

CREATE TABLE TBL_FLOWER(
 	ID NUMBER CONSTRAINT PK_FLOWER PRIMARY KEY,
 	FLOWER_NAME VARCHAR2(200) NOT NULL CONSTRAINT UK_FLOWER UNIQUE,
 /*NOT NULL -> 이름이 없는 꽃이 없기 때문에, UNIQE 이름이 같은 여러개의 꽃이 있기 때문에*/
 	FLOWER_COLOR VARCHAR2(200) NOT NULL,
 	FLOWER_PRIC NUMBER DEFAULT 0
);
 


CREATE  TABLE TBL_FLOWERPOT(
 	ID NUMBER CONSTRAINT PK_FLOWERPOT PRIMARY KEY,
 	FLOWERPOT_COLOR VARCHAR2(200) NOT NULL,
 	FLOWERPOT_SHAPE VARCHAR2(200) NOT NULL,
 	FLOWER_ID NUMBER,
 	CONSTRAINT FK_FLOWERPOT_FLOWER FOREIGN KEY(FLOWER_ID)
   REFERENCES TBL_FLOWER(ID)
);

/*슈퍼키, 서브키
 * 
 * FK를 PK로 설정한다.
 * 
 * */

/*구현된 테이블 구조 해석
 * 
 * 하나의 꽃은 하나의 화분에 담길 수 있고,
 * 하나의 화분에는 하나의 꽃만 담을 수 있는
 * 전형적인 1:1 구조이다.
 * 
 * */
CREATE TABLE TBL_FLOWER(
   ID NUMBER CONSTRAINT PK_FLOWER PRIMARY KEY,
   NAME VARCHAR2(255) NOT NULL CONSTRAINT UK_FLOWER UNIQUE,
   COLOR VARCHAR2(255) NOT NULL,
   PRICE NUMBER DEFAULT 0
);

CREATE TABLE TBL_FLOWER_POT(
   ID NUMBER CONSTRAINT PK_FLOWER_POT PRIMARY KEY,
   COLOR VARCHAR2(255) NOT NULL,
   SHAPE VARCHAR2(255) NOT NULL,
   CONSTRAINT FK_POT_FLOWER FOREIGN KEY(ID)
   REFERENCES TBL_FLOWER(ID)
);


/*1. 요구사항 분석
    안녕하세요, 동물병원을 곧 개원합니다.
    동물은 보호자랑 항상 같이 옵니다. 가끔 보호소에서 오는 동물도 있습니다.
    보호자가 여러 마리의 동물을 데리고 올 수 있습니다.
    보호자는 이름, 나이, 전화번호, 주소가 필요하고
    동물은 병명, 이름, 나이, 몸무게가 필요합니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/

/*논리 모델링 
동물 			보호자 		보호소  동물병원
--------------------------------
ID 				ID			ID
---------------------------------
병명				이름			병명
이름				나이			이름
나이				전화번호		나이
몸무게			주소 		몸무게
*/
/*
물리 모델링
*/
CREATE TABLE TBL_OWNER(
   ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
   NAME VARCHAR2(255) NOT NULL,
   AGE NUMBER,
   PHONE VARCHAR2(255) NOT NULL
);
/*보호자 테이블
 * 보호자 이름 - 중복 안됨
 * 보호자 나이
 * 보호자 전화 번호 - 중복 안됨 
 */

ALTER TABLE TBL_OWNER ADD(ADDRESS VARCHAR2(255)); 
/*보호자 주소 수정 삽입 */
ALTER TABLE TBL_OWNER RENAME COLUMN NAME TO OWNER_NAME;
ALTER TABLE TBL_OWNER RENAME COLUMN AGE TO OWNER_AGE;
ALTER TABLE TBL_OWNER RENAME COLUMN PHONE TO OWNER_PHONE;
ALTER TABLE TBL_OWNER RENAME COLUMN ADDRESS TO OWNER_ADDRESS;
/*보호자 컬럼 수정 */

CREATE TABLE TBL_PET(
   ID NUMBER CONSTRAINT PK_PET PRIMARY KEY,
   PET_ILL_NAME VARCHAR2(255),
   PET_NAME VARCHAR2(255),
   PET_AGE NUMBER,
   WEIGHT NUMBER(4, 2),
   OWNER_ID NUMBER,/*NOT NULL 안붙인 이유는 보호소에 오는 동물도 있어서*/
   CONSTRAINT FK_PET_OWNER FOREIGN KEY(OWNER_ID)
   REFERENCES TBL_OWNER(ID)
);

/*동물 
 * 동물 병명
 * 동물 이름
 * 동물 나이
 * 동물 몸무게
 * 보호자와 항상 같이 오기때문에 보호자FK로 설정 단, 보호소에서 동물이 가끔온다고함
 * 그래서 NOTNULL을 붙이지 않음 */

ALTER TABLE TBL_PET RENAME COLUMN WEIGHT TO PET_WEIGHT;
/* 동물 컬럼 수정 */

/*
1. 요구 사항
    커뮤니티 게시판을 만들고 싶어요.
    게시판에는 게시글 제목과 게시글 내용, 작성한 시간, 작성자가 있고,
    게시글에는 댓글이 있어서 댓글 내용들이 나와야 해요.
    작성자는 회원(tbl_MEMBER)정보를 그대로 사용해요.
    댓글에도 작성자가 필요해요.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/


/*개념 모델링 및 논리 모델링*/

/* 
 * 
 *게시글 내용
 *ID
 *댓글
 *댓글 내용
 *
	작성자 
	작성 시간 
	작성댓글 
 * */


CREATE TABLE TBL_MEMBER3( /*회원정보*/
   ID NUMBER CONSTRAINT PK_MEMBER3 PRIMARY KEY,
   MEMBER3_ID VARCHAR2(255) CONSTRAINT UK_MEMBER3 UNIQUE NOT NULL,
   MEMBER3_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER3_NAME VARCHAR2(255) NOT NULL,
   MEMBER3_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER3_EMAIL VARCHAR2(255),
   MEMBER3_BIRTH DATE
);
/*회원 정보
 * 회원 ID -중복은 허용하지 않지만 N
 * 회원 비밀번호
 * 회원 이름
 * 회원 주소
 * 회원 이메일
 * 회원 생일 */

CREATE TABLE TBL_POST( /* 게시글 */
   ID NUMBER CONSTRAINT PK_POST PRIMARY KEY,
   POST_TITLE VARCHAR2(255) NOT NULL,
   POST_CONTENT VARCHAR2(255) NOT NULL,
   CREATED_DATE DATE DEFAULT CURRENT_TIMESTAMP,
   MEMBER3_ID NUMBER,
   CONSTRAINTS FK_POST_MEMBER3 FOREIGN KEY(MEMBER3_ID)
   REFERENCES TBL_MEMBER3(ID)
);
/*게실물 작성 
 * 게시글 제목 - 중복 안됨
 * 게시글 댓글 - 중복 안됨
 * 게시글 쓰면 시간 날짜 써야함
 * 게실글 작성자가 있어야 하니까 회원 정보 불어 와야함 그래서 회원 정보FK 설정 */
ALTER TABLE TBL_POST MODIFY(MEMBER3_ID NULL);
ALTER TABLE TBL_POST MODIFY(MEMBER3_ID NOT NULL);
/*
수정 테이블 : 게시물의 FK설정한 회원정보를 중복 안됨으로 수정 함 
*/


CREATE TABLE TBL_REPLY( /*댓글*/
   ID NUMBER CONSTRAINT PK_REPLY PRIMARY KEY,
   REPLY_CONTENT VARCHAR2(255) NOT NULL,
   POST_ID NUMBER NOT NULL,
   MEMBER3_ID NUMBER NOT NULL,
   CONSTRAINTS FK_REPLY_POST FOREIGN KEY(POST_ID)
   REFERENCES TBL_POST(ID),
   CONSTRAINTS FK_REPLY_MEMBER3 FOREIGN KEY(MEMBER3_ID)
   REFERENCES TBL_MEMBER3(ID)
);

/* 댓글작성 
 * 댓글 내용 - 중복 안됨
 * 게시물에 댓글이 있어야 해서 게시물 FK로 설정
 * 댓글 작성자도 있어야 하기 때문에 FK로 설정 
 * 단, 둘다 중복이 있으면 안됨 그래서 각각 NOT NULL 설정 함  */

/* 요구 사항
    마이페이지에서 회원 프로필을 구현하고 싶습니다.
    회원당 프로필을 여러 개 설정할 수 있고,
    대표 이미지로 선택된 프로필만 화면에 보여주고 싶습니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/

/*회원 

마이페이지 
회원 ID
대표이미지 */

DROP TABLE TBL_REPLY ;
DROP TABLE TBL_POST ;
DROP TABLE TBL_MEMBER3;

	 CREATE TABLE TBL_MEMBER3( /*회원정보*/
   ID NUMBER CONSTRAINT PK_MEMBER3 PRIMARY KEY,
   MEMBER3_ID VARCHAR2(255) CONSTRAINT UK_MEMBER3 UNIQUE NOT NULL,
   MEMBER3_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER3_NAME VARCHAR2(255) NOT NULL,
   MEMBER3_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER3_EMAIL VARCHAR2(255),
   MEMBER3_BIRTH DATE
);
	
ALTER  TABLE TBL_MEMBER3 ADD(PROFILE VARCHAR2(255));
ALTER  TABLE TBL_MYPAGE ADD(STATUS NUMBER DEFAULT 0);
ALTER  TABLE TBL_MYPAGE ADD(PATH VARCHAR2(255) NOT NULL);
ALTER  TABLE TBL_MYPAGE ADD(MYPAGE_SIZE NUMBER DEFAULT 0);


CREATE  TABLE TBL_MYPAGE(
	ID NUMBER CONSTRAINT PK_MYPAGE PRIMARY KEY,
	MEMBER3_ID NUMBER NOT NULL, 
	CONSTRAINTS FK_MYPAGE_MEMBER3 FOREIGN KEY(MEMBER3_ID)
   REFERENCES TBL_MEMBER3(ID)
);

/*
1. 요구 사항
    회원들끼리 좋아요를 누를 수 있습니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/
DROP  TABLE TBL_MEMBER3;
DROP  TABLE TBL_MYPAGE ;

	 CREATE TABLE TBL_MEMBER( /*회원정보*/
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
  
  MEMBER_BIRTH DATE
);
	

CREATE TABLE TBL_LIKE(
   ID NUMBER CONSTRAINT PK_LIKE PRIMARY KEY,
   LIKE_RECEIVER NUMBER NOT NULL,
   LIKE_SENDER NUMBER NOT NULL,
   CONSTRAINT FK_LIKE_MEMBER_RECEIVER FOREIGN KEY(LIKE_RECEIVER)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_LIKE_MEMBER_SENDER FOREIGN KEY(LIKE_SENDER)
   REFERENCES TBL_MEMBER(ID)
);
/*좋아요 누르기
 * LIKE 수신 컬럼
 * LIKE 발송 컬럼
 * FK 2가지 설정 누가 누구를 좋아요 눌렀는지 
 * 누가에 대한 FK 설정
 * 누구를에 대한 FK 설정*/

/*
    1. 요구사항 분석 다:다 -> 다른 컬럼까지 해서 풀어주기
        안녕하세요 중고차 딜러입니다.
        이번에 자동차와 차주를 관리하고자 방문했습니다.
        자동차는 여러 명의 차주로 히스토리에 남아야 하고,
        차주는 여러 대의 자동차를 소유할 수 있습니다.
        그래서 우리는 항상 등록증(Registration)을 작성합니다.
        자동차는 브랜드, 모델명, 가격, 출시날짜가 필요하고
        차주는 이름, 전화번호, 주소가 필요합니다.

    2. 개념 모델링
    3. 논리 모델링
    4. 물리 모델링
    5. 구현
*/

/*자동차			차주(다)
ID PK 				ID PK
브랜드			이름
모델				전화번호
가격				주소
출시날짜	*/
DROP TABLE TBL_LIKE ;
DROP TABLE TBL_OWNER ;
DROP TABLE TBL_CAR;
DROP  TABLE TBL_REGISTRATION;
	
	CREATE  TABLE TBL_CAR (
 	ID NUMBER CONSTRAINT PK_CAR PRIMARY KEY,
 	CAR_BRAND VARCHAR2(50) NOT NULL,
 	CAR_MODEL VARCHAR2(50)NOT NULL,
 	CAR_PRICE NUMBER DEFAULT 0,
 	CAR_DATE DATE 
);

 	CREATE TABLE TBL_OWNER( /*회원정보*/
   	 ID NUMBER CONSTRAINT PK_OWNER PRIMARY KEY,
  	 OWNER_ID VARCHAR2(255),
  	 OWNER_ADDRESS VARCHAR2(255) NOT NULL,
  	 OWNER_PONE VARCHAR2(100) NOT NULL
);

	CREATE TABLE TBL_REGISTRATION(
	ID NUMBER CONSTRAINT PK_REGISTRATION PRIMARY KEY,
	REGISTRATION_DATE DATE, 
	REGISTRATION_EXPIRATIONDATE DATE, 
	REGISTRATION_VEHICLENUMBER VARCHAR2(1000),
  	OWNER_ID NUMBER,
	CAR_ID NUMBER,
	 CONSTRAINTS FK_REGISTRATION_CAR FOREIGN KEY(CAR_ID)
  	REFERENCES TBL_CAR(ID),
  	 CONSTRAINTS FK_REGISTRATION_OWNER FOREIGN KEY(OWNER_ID)
  	REFERENCES TBL_OWNER(ID)
	);

/*
    요구사항

    학사 관리 시스템에 학생과 교수, 과목을 관리합니다.
    학생은 학번, 이름, 전공, 학년이 필요하고
    교수는 교수 번호, 이름, 전공, 직위가 필요합니다.
    과목은 고유한 과목 번호와 과목명, 학점이 필요합니다.
    학생은 여러 과목을 수강할 수 있으며,
    교수는 여러 과목을 강의할 수 있습니다.
    학생이 수강한 과목은 성적(점수)이 모두 기록됩니다.
*/
/*학생
학번, 이름 , 전공, 학년
교수
교수번호, 이름, 전공, 직위
과목
과목번호, 과목명, 학점*/
DROP TABLE TBL_STUDENT;


CREATE TABLE TBL_STUDENT(
	ID NUMBER CONSTRAINT PK_STUDENT PRIMARY KEY,
	STUDENT_NUMBER VARCHAR2(255) NOT NULL,
	STUDENT_NAME VARCHAR2(20)NOT NULL,
	STUDENT_MAJOR VARCHAR2(50), 
	STUDENT_SCHOOLYEAR NUMBER(5)
);

	
CREATE TABLE TBL_PROFESSOR(
	ID NUMBER CONSTRAINT PK_PROFESSOR PRIMARY KEY,
	PROFESSOR_NUMBER VARCHAR2(255) NOT NULL,
	PROFESSOR_NAME VARCHAR2(20)NOT NULL,
	PROFESSOR_MAJOR VARCHAR2(50), 
	PROFESSOR_POSITION VARCHAR2(50)
	);
	
CREATE TABLE TBL_SUBJECT(
	ID NUMBER CONSTRAINT PK_SUBJECT PRIMARY KEY,
	SUBJECT_NUMBER VARCHAR2(255) NOT NULL,
	SUBJECT_NAME VARCHAR2(255) NOT NULL,
	SUBJECT_CREDIT VARCHAR2(255)
	);

CREATE TABLE TBL_GRADE (
	ID NUMBER CONSTRAINT PK_GRADE PRIMARY KEY,
 	STUDENT_ID NUMBER,
 	SUBJECT_ID NUMBER,
 	 CONSTRAINTS FK_GRADE_STUDENT FOREIGN KEY(STUDENT_ID)
  	REFERENCES TBL_STUDENT(ID),
  	CONSTRAINTS FK_GRADE_SUBJECT FOREIGN KEY(SUBJECT_ID)
  	REFERENCES TBL_SUBJECT(ID)
);

CREATE TABLE TBL_LECTURE(
	PROFESSOR_ID NUMBER,
	SUBJECT_ID NUMBER,
	CONSTRAINTS FK_LECTURE_PROFESSO FOREIGN KEY(PROFESSOR_ID)
  	REFERENCES TBL_PROFESSOR(ID),
  	CONSTRAINTS FK_LECTURE_SUBJECT FOREIGN KEY(SUBJECT_ID)
  	REFERENCES TBL_SUBJECT(ID)
);

/*
1. 요구사항
    대카테고리, 소카테고리가 필요해요.
    1		대		다 
    
2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/

CREATE TABLE TBL_BIGCATEGORY(
	ID NUMBER CONSTRAINT PK_BIGCATEGORY PRIMARY KEY,
	BIGCATEGORY_VEGETABLE VARCHAR2(200) NOT NULL,
	BIGCATEGORY_FRUIT VARCHAR2(200) NOT NULL
	);
	
CREATE TABLE TBL_SMALCATEGORY(
	ID NUMBER CONSTRAINT PK_SMALCATEGORY PRIMARY KEY,
	SMALCATEGORY_FRUIT_SUMMER VARCHAR2(200),
	SMALCATEGORY_FRUIT_WINTER VARCHAR2(200),
	SMALCATEGORY_VEGETABLE_SUMMER VARCHAR2(200),
	BIGCATEGORY_ID NUMBER,
	CONSTRAINTS FK_SMALCATEGORY_BIGCATEGORY FOREIGN KEY(BIGCATEGORY_ID)
  	REFERENCES TBL_BIGCATEGORY(ID)
	);

	
/*
 * 요구 사항
 * 
 * 회의실 예약 서비스를 제작하고 싶습니다.
 * 회원별로 등급이 존재하고 사무실마다 회의실이 여러 개 있습니다.
 * 회의실 이용 가능 시간은 파트 타임으로서 여러 시간대가 존재합니다.
 * 
 */

/*회원		회의실		사무실		시간  	예약
			다			1대							*/
DROP TABLE TBL_MEMEBER;

  /*회의실을 예약하는 것을 기획했으나, 각 파트타임 정보를 알아야 예약 관리가 가능 하기때문에
   * 파트타임으로 예약을 걸어야 한다.*/

CREATE TABLE TBL_MEMBER( 
   ID NUMBER CONSTRAINT PK_OFFIC PRIMARY KEY,
  	MEMBER_RATING VARCHAR2(50)
   );

  CREATE TABLE TBL_OFFIC(	/*사무실*/
	ID NUMBER CONSTRAINT PK_OFFIC PRIMARY KEY,
	OFFIC_NAMER VARCHAR2(200) NOT NULL,
	OFFIC_LOCATION VARCHAR2(200) NOT NULL
	);
  
CREATE  TABLE TBL_ROOM(	/*회의실*/
 	ID NUMBER CONSTRAINT PK_ROOM PRIMARY KEY,
 	ROOM_NAME VARCHAR2(200),
 	OFFIC_ID NUMBER,
 	CONSTRAINTS FK_ROOM_OFFIC FOREIGN KEY(OFFIC_ID)
  	REFERENCES TBL_OFFIC(ID)
 	);
/* 회의실 테이블 
 * 회실 이름 
 * 사물실 안에 많은 회의실이 있다고 했으니 사물실 FK로 설정 */

CREATE TABLE TBL_TIME(
	ID NUMBER CONSTRAINT PK_TIME PRIMARY KEY,
	TIM_PRATTIME DATE,
	ROOM_ID NUMBER,
		CONSTRAINTS FK_TIME_ROOM FOREIGN KEY(ROOM_ID)
  	REFERENCES TBL_ROOM(ID)
	);
/*파트 타임 
 * 회의실을 파트 타임으로 예약을 해야 해서 
 * 회의실을  FK로 설정 */

CREATE  TABLE TBL_RESERVATION(
	ID NUMBER CONSTRAINT PK_RESERVATION PRIMARY KEY,
	RESERVAITON_DATE DATE,
	MEMBER_ID NUMBER,
	TIME_ID NUMBER,
	CONSTRAINTS FK_RESERVATION_MEMBER FOREIGN KEY(MEMBER_ID)
  	REFERENCES TBL_MEMBER(ID),
  	CONSTRAINTS FK_RESERVATION_TIME FOREIGN KEY(TIME_ID)
  	REFERENCES TBL_TIME(ID)
);
/*파트타임으로 예약을 하려고 하면 */


/*요구사항 3가지 만들기 */
/*요구 사항 1.
 *  고객이 어플로 조회를 할수 있습니다. 
 * 고객			계좌				거래관리
 * 이름			계좌조회			대출
 * 나이			계좌생성			입금
 * 성별			계좌삭제			출금
 * 주소							
 * 전화 번호 		
 * */
CREATE TABLE TBL_COUTOMER(
	ID NUMBER CONSTRAINT PK_COUTOMER PRIMARY KEY,
	COUTOMER_NAME VARCHAR2(200),
	COUTOMER_AGE NUMBER(3),
	COUTOMER_GENDER NUMBER(3),
	COUTOMER_ADDRESS VARCHAR(200),
	COUTOMER_PHONE VARCHAR(200)
);

CREATE TABLE TBL_ACCOUNT(
	ID NUMBER CONSTRAINT PK_ACCOUNT PRIMARY KEY,
	ACCOUNT_INQUIRY VARCHAR2(200),
	ACCOUNT_CREATION VARCHAR2(200),
	ACCOUNT_ELIMINATION VARCHAR2(200),
	COUTOMER_ID NUMBER,
	CONSTRAINTS FK_ACCOUNT_COUTOMER FOREIGN KEY(COUTOMER_ID)
  	REFERENCES TBL_COUTOMER(ID)	
);

CREATE TABLE TBL_TRANSNCTION(
 	ID NUMBER CONSTRAINT PK_TRANSNCTION PRIMARY KEY,
 	TRANSNCTION_LOANS VARCHAR2(200),
 	TRANSNCTION_DEPOSIT VARCHAR2(200),
 	TRANSNCTION_WITHDRAWAL VARCHAR2(200),
 	ACCOUNT_ID NUMBER,
 	CONSTRAINTS FK_TRANSNCTION_ACCOUNT FOREIGN KEY(ACCOUNT_ID)
 	REFERENCES TBL_ACCOUNT(ID)
 );

/* 요구사항2
 *   도서관 
 *  회원들이 도서관에서 책을 빌리려고 합니다!
 * 회원			도서(책)			대출
 * 회원 번호 		제목				대출날짜
 * 이름			작가				반납날짜
 * 이메일			
 * 핸드폰 번호 
 * */

CREATE TABLE TBL_MEMBER (
 	ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
 	MEMBER_NAME VARCHAR2(200),
 	MEMBER_EMAILE VARCHAR2(200),
 	MEMBER_POHNE VARCHAR2(200)
);

CREATE	TABLE TBL_BOOK(
 	ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
 	BOOK_TITLE VARCHAR2(200),
 	BOOK_AUTHOR VARCHAR2(200)
);
CREATE TABLE TBL_LOAN(
	ID NUMBER CONSTRAINT PK_LOAN PRIMARY KEY,
	LOAN_LOAN_DATE DATE,
	LOAN_RETURN_DATE DATE,
	MEMBER_ID NUMBER,
	BOOK_ID NUMBER, 
 	CONSTRAINTS FK_LOAN_MEMBER FOREIGN KEY(MEMBER_ID)
 	REFERENCES TBL_MEMBER(ID),	
 	CONSTRAINTS FK_LOAN_BOOK FOREIGN KEY(BOOK_ID)
 	REFERENCES TBL_BOOK(ID)
 	);

/*병원 
 * 환자		의사		진료기록*
 * 이름		이름		진다명
 * 성별			나이		치료
 * 생일		전화번호	방문날짜	
 * 전화번호					
*/
 CREATE TABLE TBL_PATIENT(
	ID NUMBER CONSTRAINT PK_PATIENT PRIMARY KEY,
	PATIENT_NAME VARCHAR2(100) NOT NULL,
	PATIENT_BIRTHDAY DATE NOT NULL,
	PATIENT_GENDER VARCHAR2(10),
	PATINEN_PHONE VARCHAR2(100)
 );
 
CREATE TABLE TBL_DOCTOR(
	ID NUMBER CONSTRAINT PK_PATIENT PRIMARY KEY,
	DOCTOR_NAME VARCHAR2(100) NOT NULL,
	DOCTOR_AGE NUMBER(10),
	DOCTOR_PHONE VARCHAR2(100)
);

CREATE TABLE TBL_MEDICAL(
	ID NUMBER CONSTRAINT PK_PATIENT PRIMARY KEY,
	MEDICAL_DIAGNOSIC VARCHAR2(50),
	MEDICAL_TREATMENT VARCHAR2(1000),
	MEDICAL_VISIT_DATE	DATE NOT NULL,
	PATIENT_ID NUMBER,
	DOCTOR_ID NUMBER,
	CONSTRAINTS FK_MEDICAL_PATIENT FOREIGN KEY(PATIENT_ID)
 	REFERENCES TBL_PATIENT(ID),
 	CONSTRAINTS FK_MEDICAL_DOCTOR FOREIGN KEY(DOCTOR_ID)
 	REFERENCES TBL_DOCTOR(ID)
);
/*
1. 요구사항
   유치원을 하려고 하는데, 아이들이 체험학습 프로그램을 신청해야 합니다.
   아이들 정보는 이름, 나이, 성별이 필요하고 학부모는 이름, 나이, 주소, 전화번호, 성별이 필요해요
   체험학습은 체험학습 제목, 체험학습 내용, 이벤트 이미지 여러 장이 필요합니다.
   아이들은 여러 번 체험학습에 등록할 수 있어요.
    
2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/
/*체험 학습
아이들		학부모		체험학습		유치원 	회원관리자
이름			이름			제목
나이			나이			내용
성별			주소			이벤트 
			전화번호
			성별*/
	

CREATE TABLE TBL_KINDERGARTEN(
   ID NUMBER CONSTRAINT PK_KINDERGARTEN PRIMARY KEY,
   KINDERGARTEN_NAME VARCHAR2(255),
   KINDERGARTEN_ADDRESS VARCHAR2(255)
);

CREATE TABLE TBL_PARENT(
   ID NUMBER CONSTRAINT PK_PARENT PRIMARY KEY,
   PARENT_NAME VARCHAR2(255) NOT NULL,
   PARENT_ADDRESS VARCHAR2(255) NOT NULL,
   PARENT_PHONE VARCHAR2(255) NOT NULL,
   PARENT_GENDER NUMBER DEFAULT 3
);

CREATE TABLE TBL_CHILD(
   ID NUMBER CONSTRAINT PK_CHILD PRIMARY KEY,
   CHILD_AGE NUMBER NOT NULL,
   CHILD_GENDER NUMBER DEFAULT 3,
   PARENT_ID NUMBER,
   CONSTRAINT FK_CHILD_PARENT FOREIGN KEY(PARENT_ID)
   REFERENCES TBL_PARENT(ID)
);

CREATE TABLE TBL_FIELD_TRIP(
   ID NUMBER CONSTRAINT PK_FIELD_TRIP PRIMARY KEY,
   FIELD_TRIP_TITLE VARCHAR2(255),
   FIELD_TRIP_CONTENT VARCHAR2(255),
   KINDERGARTEN_ID NUMBER,
   CONSTRAINT FK_FIELD_TRIP_KINDERGARTEN FOREIGN KEY(KINDERGARTEN_ID)
   REFERENCES TBL_KINDERGARTEN(ID)
);

CREATE TABLE TBL_FILE(
   ID NUMBER CONSTRAINT PK_FILE PRIMARY KEY,
   FILE_NAME VARCHAR2(255),
   FILE_PATH VARCHAR2(255),
   FILE_SIZE NUMBER
);

CREATE TABLE TBL_FIELD_TRIP_FILE(
   ID NUMBER CONSTRAINT PK_FIELD_DRIP_FILE PRIMARY KEY,
   FIELD_TRIP_ID NUMBER NOT NULL,
   CONSTRAINT FK_FIELD_TRIP_FILE_FIELD_TRIP FOREIGN KEY(FIELD_TRIP_ID)
   REFERENCES TBL_FIELD_TRIP(ID),
   CONSTRAINT FK_FIELD_TRIP_FILE_FILE FOREIGN KEY(ID)
   REFERENCES TBL_FILE(ID)
);

CREATE TABLE TBL_MEMBER(
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE,
   KINDERGARTEN_ID NUMBER,
   CONSTRAINT FK_MEMBER_KINDERGARTEN FOREIGN KEY(KINDERGARTEN_ID)
   REFERENCES TBL_KINDERGARTEN(ID)
);


/*
1. 요구사항
   안녕하세요, 광고 회사를 운영하려고 준비중인 사업가입니다.
   광고주는 기업이고 기업 정보는 이름, 주소, 대표번호, 기업종류(스타트업, 중소기업, 중견기업, 대기업)입니다.
   광고는 제목, 내용이 있고 기업은 여러 광고를 신청할 수 있습니다.
   기업이 광고를 선택할 때에는 카테고리로 선택하며, 대카테고리, 중카테고리, 소카테고리가 있습니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/

광고주(기업) ->광고주(기업)는 그래서 광고를 보고 광고를 여러개 선택 가능
	-> 광고주(기업)는 선택 할때 대카테고리, 중카테고리, 소카테고리로 선택 가능

[광고주] 				
이름,주소,대표번호 + 기업종류 
[광고]
내용,제목,광고주FK
[대카테고리]	
광고주FK,광고FK
[중카테고리]
대카테고리FK
광고주FK
광고FK
[소카테고리]
중카테고리FK 
광고주FK
광고FK
[지원]
광고주FK,광고종류FK 

CREATE TABLE TBL_COMPANY(	/*광고주(기업)*/
   ID NUMBER CONSTRAINT PK_COMPANY PRIMARY KEY,
   COMAPNY_NAME VARCHAR2(255) NOT NULL,
   COMAPNY_ADDRESS VARCHAR2(255) NOT NULL,
   COMAPNY_TEL VARCHAR2(255) NOT NULL,
   COMAPNY_TYPE NUMBER
);

CREATE TABLE TBL_CATEGORY_A( /*대카테고리*/
   ID NUMBER CONSTRAINT PK_CATEGORY_A PRIMARY KEY,
   CATEGORY_A_NAME VARCHAR2(255)
);

CREATE TABLE TBL_CATEGORY_B(	/*중카테고리*/
   ID NUMBER CONSTRAINT PK_CATEGORY_B PRIMARY KEY,
   CATEGORY_B_NAME VARCHAR2(255),
   CATEGORY_A_ID NUMBER,
   CONSTRAINT FK_CATEGORY_B_CATEGORY_A FOREIGN KEY(CATEGORY_A_ID)
   REFERENCES TBL_CATEGORY_A(ID)
);

CREATE TABLE TBL_CATEGORY_C(/*소카테고리*/
   ID NUMBER CONSTRAINT PK_CATEGORY_C PRIMARY KEY,
   CATEGORY_C_NAME VARCHAR2(255),
   CATEGORY_B_ID NUMBER,
   CONSTRAINT FK_CATEGORY_C_CATEGORY_B FOREIGN KEY(CATEGORY_B_ID)
   REFERENCES TBL_CATEGORY_B(ID)
);

CREATE TABLE TBL_ADVERTISEMENT(	/*광고(종류만 담을 수 있음) */
   ID NUMBER CONSTRAINT PK_ADVERTISEMENT PRIMARY KEY,
   ADVERTISEMENT_TITLE VARCHAR2(255) NOT NULL,
   ADVERTISEMENT_CONTENT VARCHAR2(255) NOT NULL,
   COMPANY_ID NUMBER,
   CONSTRAINT FK_ADVERTISEMENT_COMPANY FOREIGN KEY(COMPANY_ID)
   REFERENCES TBL_COMPANY(ID)
);

ALTER TABLE TBL_ADVERTISEMENT ADD (CATEGORY_C_ID NUMBER);
ALTER TABLE TBL_ADVERTISEMENT ADD 
CONSTRAINT FK_ADVERTISEMENT_CATEGORY_C FOREIGN KEY(CATEGORY_C_ID)
REFERENCES TBL_CATEGORY_C(ID);

CREATE TABLE TBL_APPLY(	/*광고를 지원 (광고종류를 선택하는곳)*/
   ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
   COMPANY_ID NUMBER NOT NULL, 
   ADVERTISEMENT_ID NUMBER NOT NULL,
   CONSTRAINT FK_APPLY_COMPANY FOREIGN KEY(COMPANY_ID)
   REFERENCES TBL_COMPANY(ID),
   CONSTRAINT FK_APPLY_ADVERTISEMENT FOREIGN KEY(ADVERTISEMENT_ID)
   REFERENCES TBL_ADVERTISEMENT(ID)
);
			
/*
1. 요구사항
   음료수 판매 업체입니다. 음료수마다 당첨번호가 있습니다. 
   음료수의 당첨번호는 1개이고 당첨자의 정보를 알아야 상품을 배송할 수 있습니다.
   당첨 번호마다 당첨 상품이 있고, 당첨 상품이 배송 중인지 배송 완료인지 구분해야 합니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/
/*고객 -> 음료수를 먹음 -> 당첨번호확인 -> 당첨자 -> 당첨된 상품 주문 -> 상품 배송 
-> 배송이 됬는지 구분 
[고객]
이름, 주소, 전화번호, 이메일
[음료]		
음료수이름,  음료수에 당첨번호가 있음
[당첨 번호]			
당첨번호 
[상품]
음료수의 당첨번호에 대한 상품
[생산]
음료FK, 상품FK

[주문배송현황]
배송완료
배송중인지*/

/*CREATE TABLE TBL_MEMBER(
	 ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
	 MEMBER_NAME VARCHAR2(200) NOT NULL,
	 MEMBER_ADDRESS VARCHAR2(200) NOT NULL,
	 MEMBER_PHONE VARCHAR2(200) NOT NULL,
	 MEMBER_EMAILE VARCHAR2(200) NOT NULL
);

CREATE TABLE TBL_DRINK(
	ID NUMBER CONSTRAINT PK_DRINK PRIMARY KEY,
	DRINK_NAME VARCHAR2(200) NOT NULL,
	DRINK_NUMBER NUMBER
);

CREATE TABLE TBL_WINNIG_NUMBER(
	ID NUMBER CONSTRAINT PK_WINNIG_NUMBER PRIMARY KEY,
	WINNING_NUMBER_NUMBER VARCHAR2(200), 
	MEMBER_ID NUMBER,
	DRINK_ID NUMBER,
	CONSTRAINT FK_WINNING_NUMBER_MEMBER FOREIGN KEY(MEMBER_ID)
    REFERENCES TBL_MEMBER(ID),
	CONSTRAINT FK_WINNING_NUMBER_DRINK FOREIGN KEY(DRINK_ID)
    REFERENCES TBL_DRINK(ID)
);

CREATE TABLE TBL_PRODUCT(
	ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
	PRODUUCT_NAME VARCHAR2(200),
	WINNING_NUMBER_ID NUMBER,
	CONSTRAINT FK_PRODUCT_WINNING_NUMBER FOREIGN KEY(WINNING_NUMBER _ID)
    REFERENCES TBL_WINNING_NUMBER (ID)
);

CREATE TABLE TBL_PRODUCTION(
	ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
	DRINK_ID NUMBER,
	WINNING_NUMBER_ID NUMBER,
	CONSTRAINT FK_PRODUCTION_DRINK FOREIGN KEY(DRINK_ID)
    REFERENCES TBL_DRINK(ID),
	CONSTRAINT FK_PRODUCTION_WINNING_NUMBER FOREIGN KEY(WINNING_NUMBER _ID)
    REFERENCES TBL_WINNING_NUMBER (ID)
);

CREATE TABLE TBL_SHIPPING(
	ID NUMBER CONSTRAINT PK_SHIPPING PRIMARY KEY,
	PRODUCTION_ID NUMBER,
	CONSTRAINT FK_SHIPPING_PRODUCTION FOREIGN KEY(PRODUCTION_ID)
	REFERENCES TBL_PRODUCTION(ID)
);*/
CREATE TABLE TBL_MEMBER( /*당첨자*/
   ID NUMBER CONSTRAINT PK_MEMBER PRIMARY KEY,
   MEMBER_ID VARCHAR2(255) CONSTRAINT UK_MEMBER UNIQUE NOT NULL,
   MEMBER_PASSWORD VARCHAR2(255) NOT NULL,
   MEMBER_NAME VARCHAR2(255) NOT NULL,
   MEMBER_ADDRESS VARCHAR2(255) NOT NULL,
   MEMBER_EMAIL VARCHAR2(255),
   MEMBER_BIRTH DATE
);

CREATE TABLE TBL_SOFT_DRINK(	/*음료*/
   ID NUMBER CONSTRAINT PK_SOFT_DRINK PRIMARY KEY,
   SOFT_DRINK_NAME VARCHAR2(255)
);

CREATE TABLE TBL_PRODUCT(	/*상품*/
   ID NUMBER CONSTRAINT PK_PRODUCT PRIMARY KEY,
   PRODUCT_NAME VARCHAR2(255) NOT NULL,
   PRODUCT_PRICE NUMBER DEFAULT 0,
   PRODUCT_STOCK NUMBER DEFAULT 0
);

CREATE TABLE TBL_LOTTERY(	/*당첨번호*/
   ID NUMBER CONSTRAINT PK_LOTTERY PRIMARY KEY,
   LOTTERY_NUMBER VARCHAR2(255) NOT NULL,
   PRODUCT_ID NUMBER,
   CONSTRAINT FK_LOTTERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);
/*당첨번호에 상품을 넣기*/

CREATE TABLE TBL_CIRCULATION(	/*생산 (음료+당첨번호)*/
   ID NUMBER CONSTRAINT PK_CIRCULATION PRIMARY KEY,
   SOFT_DRINK_ID NUMBER,
   LOTTERY_ID NUMBER,
   CONSTRAINT FK_CIRCULATION_SOFT_DRINK FOREIGN KEY(SOFT_DRINK_ID)
   REFERENCES TBL_SOFT_DRINK(ID),
   CONSTRAINT FK_CIRCULATION_LOTTERY FOREIGN KEY(LOTTERY_ID)
   REFERENCES TBL_LOTTERY(ID)
);

CREATE TABLE TBL_DILIVERY(	/*배송*/
   ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
   MEMBER_ID NUMBER NOT NULL,
   PRODUCT_ID NUMBER NOT NULL,
   STATUS NUMBER DEFAULT 0,
   CONSTRAINT FK_DILIVERY_MEMBER FOREIGN KEY(MEMBER_ID)
   REFERENCES TBL_MEMBER(ID),
   CONSTRAINT FK_DILIVERY_PRODUCT FOREIGN KEY(PRODUCT_ID)
   REFERENCES TBL_PRODUCT(ID)
);

/*
1. 요구사항
   이커머스 창업 준비중입니다. 기업과 사용자 간 거래를 위해 기업의 정보와 사용자 정보가 필요합니다.
   기업의 정보는 기업 이름, 주소, 대표번호가 있고
   사용자 정보는 이름, 주소, 전화번호가 있습니다. 
   결제 시 사용자 정보와 기업의 정보, 결제한 카드의 정보 모두 필요하며,
   상품의 정보도 필요합니다. 상품의 정보는 이름, 가격, 재고입니다.
   사용자는 등록한 카드의 정보를 저장할 수 있으며, 카드의 정보는 카드번호, 카드사, 회원 정보가 필요합니다.

2. 개념 모델링
3. 논리 모델링
4. 물리 모델링
5. 구현
*/
기업
이름, 주소, 대표번호
사용자
이름,주소, 전화번호
상품정보
상품이름, 가격, 재고 
카드
카드번호, 카드사, 사용자FK
결제
상품FK,카드FK,기업FK
지원
기업FK,

CREATE TABLE TBL_COMPANY(
	 ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
	 COMPANY_NAME VARCHAR2(200) NOT NULL,
	 COMPANY_ADDRESS VARCHAR2(200)NOT NULL,
	 COMPANY_TELL VARCHAR2(200) NOT NULL
);

CREATE TABLE TBL_USER(
	 ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
	 USER_NAME VARCHAR2(200) NOT NULL,
	 USER_ADDRESS VARCHAR2(200)NOT NULL,
	 USER_PHONE VARCHAR2(200) NOT NULL
);
CREATE TABLE TBL_CARD(
 	ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
 	CARD_NAME VARCHAR2(200) NOT NULL,
 	CARD_NUMBER VARCHAR2(200) NOT NULL,
 	USER_ID NUMBER,
 	CONSTRAINT FK_CARD_USER FOREIGN KEY(USER_ID)
   REFERENCES TBL_USER(ID)
);

CREATE TABLE TBL_PRODUT(
	 ID NUMBER CONSTRAINT PK_DILIVERY PRIMARY KEY,
	 PRODUCT_NAME VARCHAR2(200) NOT NULL,
	 PRODUCT_PRICE NUMBER DEFAULT 0,
	 PRODUCT_STOKE NUMBER DEFAULT 0,
	 COMPANY_ID NUMBER,
	 CONSTRAINT FK_PRODUT_COMPANY FOREIGN KEY(COMPANY_ID)
   	REFERENCES TBL_COMPANY(ID)
);

CREATE TABLE TBL_PAYMENT(
	ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
	CARD_ID NUMBER, /*누가*/
	PRODUT_ID NUMBER, /*뭐를*/ 
   CONSTRAINT FK_PAYMENT_CARD FOREIGN KEY(CARD_ID)
   REFERENCES TBL_CARD(ID),
   CONSTRAINT FK_PAYMENT_PRODUT FOREIGN KEY(PRODUT_ID)
   REFERENCES TBL_PRODUT(ID)
);

CREATE TABLE TBL_APPLY(
	ID NUMBER CONSTRAINT PK_APPLY PRIMARY KEY,
	COMPANY_ID NUMBER,
	USER_ID NUMBER,
	CONSTRAINT FK_APPLY_COMMPANY FOREIGN KEY(COMMPANY_ID)
    REFERENCES TBL_COMMPANY(ID),
	CONSTRAINT FK_APPLY_USER FOREIGN KEY(USER_ID)
    REFERENCES TBL_USER(ID)
);

