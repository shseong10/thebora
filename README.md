# 더보라
* 중고거래 & 경매 오픈 마켓 + 특가 제품 판매 이커머스 쇼핑몰
  * 개발 환경: Java/Spring Framework
  * 개발 기간: 2024. 07. 01 - 2024. 08. 20
  * 참여 인원 및 리소스: BE 1명, FE/BE 1명, DB 1명 (총 3명)
  * JAVA 풀스택 개발자 교육(2024. 03. 08 - 2024. 08. 20) 최종 팀 프로젝트


## 기술 스택
<table>
  <tr>
    <td>백엔드</td>
    <td>
      <img src="https://img.shields.io/badge/java-007396?style=for-the-badge&logo=java&logoColor=white">
      <img src="https://img.shields.io/badge/springboot-6DB33F?style=for-the-badge&logo=springboot&logoColor=white">
      <img src="https://img.shields.io/badge/gradle-02303A?style=for-the-badge&logo=gradle&logoColor=white">
      <img src="https://img.shields.io/badge/mybatis-DD0700?style=for-the-badge&logo=MyBatis&logoColor=white">
    </td>
  </tr>
  <tr>
    <td>서버</td>
    <td>
      <img src="https://img.shields.io/badge/apache tomcat-F8DC75?style=for-the-badge&logo=apachetomcat&logoColor=white">
    </td>
  </tr>
  <tr>
    <td>데이터베이스</td>
    <td>
      <img src="https://img.shields.io/badge/mysql-4479A1?style=for-the-badge&logo=mysql&logoColor=white">
    </td>
  </tr>
  <tr>
    <td>IDE</td>
    <td>
      <img src="https://img.shields.io/badge/intelliJ IDEA-000000?style=for-the-badge&logo=intelliJ IDEA&logoColor=white">
    </td>
  </tr>
  <tr>
    <td>프론트엔드</td>
    <td>
      <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white">
      <img src="https://img.shields.io/badge/css-1572B6?style=for-the-badge&logo=css3&logoColor=white">
      <img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black">
      <img src="https://img.shields.io/badge/jquery-0769AD?style=for-the-badge&logo=jquery&logoColor=white">
      <img src="https://img.shields.io/badge/VS CODE-0078d7?style=for-the-badge&logo=VS CODE&logoColor=white">
    </td>
  </tr>
  <tr>
    <td>형상관리</td>
    <td><img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white">
        <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white">
    </td>
  </tr>
  <tr>
    <td>외부 API</td>
    <td>      
      <img src="https://img.shields.io/badge/bootstrap-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white">
      <img src="https://img.shields.io/badge/ckeditor5-0287D0?style=for-the-badge&logo=ckeditor5&logoColor=white">
      <img src="https://img.shields.io/badge/KAKAO Maps-FFCD00?style=for-the-badge&logo=KAKAO Maps&logoColor=white">
      <img src="https://img.shields.io/badge/KAKAO Pay-FFCD00?style=for-the-badge&logo=KAKAO Pay&logoColor=white">
    </td>
  </tr>
</table>


## 미리보기



## 기능
* 회원가입/로그인
  * Spring Security를 통한 보안 강화 및 회원 유형별(일반회원/관리자회원) 권한 부여
  * 아이디, 비밀번호를 정해진 양식에 맞춰 입력하는지 체크
  * 주소 검색시 카카오맵 주소 찾기 API를 사용하여 입력할 수 있음


* 회원 전용 기능
  * 일일 출석체크
  * 회원 정보 확인 및 수정
  * 거래 내역 확인
  * 찜하기 등록한 게시물 확인 

  
* 회원간 채팅(Web Socket API)
* 현재 접속한 회원의 게시글에 변화가 있을 시 알림(Web Socket API)

  
* 광고상품 출력
  * 회원이 광고 신청을 한 상품을 관리자가 검토 후 승인하면 메인화면 광고상품 섹션에 출력


* 추천상품 출력
  * 중고상품 게시글 중 조회수가 높은 게시글을 메인화면 추천상품 섹션에 출력


* 중고거래
  * 판매/찜하기/구매신청/삭제/판매완료 기능
  * 등록된 상품에 구매신청시 회원간 채팅으로 연계  

  
* 경매
  * 판매/입찰/즉시구매/찜하기/삭제하기 기능
  * 상품 등록시 즉시구매가/최소입찰가/시작가/경매종료일을 입력해야함
  * 다른 회원이 입찰하면 입찰한 가격이 실시간으로 반영됨
  * 경매종료일이 되면 경매 게시물 목록에서 내려감

  
* 핫딜 상세 정보 이미지 출력, 주문 및 결제
  * 관리자만 등록 가능한 특가 상품 판매 게시판
  * 핫딜 구매 조건(회원 레벨, 상품 판매 기간)에 부합할 때만 주문 가능
  * 상품 등록 및 수정시 WYSIWYG 에디터를 사용하여 상세설명에도 이미지 등록 및 출력
  * 주문시 주문정보와 배송지 정보 입력 후 카카오페이 결제 API 연계하여 결제
  

* 관리자
  * 광고 신청 관리, 경매 신청 관리, 카테고리 관리, 회원 관리, 기타 게시글 관리
  * 특가구매 거래 현황 출력, 빠른 수정
  
## 시스템 아키텍처


## ERD




