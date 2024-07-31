<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 18.
  Time: 오후 3:00
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>공지사항</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        body {
            font-family: "MapleStory";
        }
        h2{
            text-align: center;
        }

        .All{
            width: 800px;
            margin: auto;
        }
        .search {
            border: 2px solid green;
            background-color: gray;
            width: 306px;
            text-align: right;
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
    <script>
        if('${msg}'!=''){
            alert('${msg}')
        }
    </script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <h2>신고/문의</h2>
    <div class="All">
        <div class="search">
            <select id="sel">
                <option value="n_title" name="n_title" selected>제목</option>
                <option value="n_contents" name="n_contents">내용</option>
            </select>
            <input type="text" id="keyWord">
            <button id="search">검색</button>
        </div>
        <table class="table table-dark table-striped" style="width: 800px; margin: auto; text-align: center;">
            <tr>
                <th>작성자</th>
                <th>구분</th>
                <th>제목</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
            <c:choose>
                <c:when test="${empty rList}">
                    <tr>
                        <th colspan="6" style="text-align: center;">게시글이 존재하지 않습니다.</th>
                    </tr>
                </c:when>
                <c:when test="${!empty rList}">
                    <c:forEach var="ritem" items="${rList}">
                        <tr>
                            <td>${ritem.n_id}</td>
                            <td>${ritem.n_kind}</td>
                            <td><a href="/report/detail?n_num=${ritem.n_num}">${ritem.n_title}</a></td>
                            <td>${ritem.n_date}</td>
                            <td>${ritem.n_views}</td>
                        </tr>
                    </c:forEach>
                </c:when>
            </c:choose>
        </table>
        <br>
        <div class="paging">
            <sec:authorize access="isAuthenticated()">
            <button class="write" onclick="location.href='/report/write'">신고/문의 작성</button>
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
        location.href = "/report/list?colName=" + select
            + "&keyWord=" + keyWord + "&pageNum=1";
    });
</script>
</body>
</html>
