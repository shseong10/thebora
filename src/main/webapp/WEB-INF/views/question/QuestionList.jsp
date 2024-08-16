<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 9.
  Time: 오전 11:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <title>더보라</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        h2{
            text-align: center;
        }

        .All{
            width: 800px;
            margin: auto;
        }
        .search {
            border: 2px solid #dee2e6;
            width: 306px;
            /*margin: 0 0 0 auto;*/
        }

        .paging{
            text-align: right;
        }

        .page {
            margin: 40px;
            text-align: center;
        }
        .write{
            margin: auto;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <h2>자주 묻는 질문</h2>
    <div class="All">
        <div class="search">
            <select id="sel">
                <option value="q_title" name="q_title">제목</option>
                <option value="q_contents" name="q_contents">내용</option>
            </select>
            <input type="text" id="keyWord" />
            <button id="search">검색</button>
        </div>
        <table class="table table-striped" style="width: 800px; margin: auto; text-align: center;">
            <tr class="">
                <th>작성자</th>
                <th>제목</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:choose>
                <c:when test="${empty qList}">
                    <tr>
                        <th colspan="6" style="text-align: center;">게시글이 존재하지 않습니다.</th>
                    </tr>
                </c:when>
                <c:when test="${!empty qList}">
                    <c:forEach var="qitem" items="${qList}">
                        <tr>
                            <td>${qitem.q_id}</td>
                            <td><a href="/question/detail?q_num=${qitem.q_num}">${qitem.q_title}</a></td>
                            <td>${qitem.q_date}</td>
                            <td>${qitem.q_views}</td>
                        </tr>
                    </c:forEach>
                </c:when>
            </c:choose>
        </table><br>
        <div class="paging">
            <sec:authorize access="hasRole('admin')">
                <button class="write" onclick="location.href='/question/write'">답변글 작성</button>
            </sec:authorize>
            <div class="page">${pageHtml}</div>
        </div>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    $("#search").click(function () {
        let keyWord = $("#keyWord").val();
        if (keyWord === "") {
            alert("검색어를 입력하세요.");
            return;
        }
        let select = $("#sel").val();
        if (select === "") {
            return;
        }
        console.log(keyWord, select);
        location.href =
            "/question/list?colName=" +
            select +
            "&keyWord=" +
            keyWord +
            "&pageNum=1";
    });

    $("#keyWord").keydown(function (e) {
        if (e.key === "Enter") { // Enter 키
            e.preventDefault(); // 기본 Enter 동작 방지
            $("#search").click();
        }
    });
</script>
</body>
</html>
