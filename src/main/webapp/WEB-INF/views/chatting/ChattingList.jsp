<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>더보라</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<style>
    .All{
        width: 1000px;
        text-align: center;
        margin: auto;
    }
    .title{
        text-align: center;
    }
    .search{
        text-align: right;
    }
    .page {
        margin: auto;
        text-align: center;
    }
    .createChat{
        text-align: right;
    }
</style>
<body>
    <header>
        <jsp:include page="../header.jsp"></jsp:include>
    </header>
    <div class="All">
    <h2 class="title">채팅하기</h2>
        <div class="search">
            <input type="text" placeholder="채팅방 검색">
            <input type="button" id="search" value="검색">
        </div><br>
        <table class="table table-striped" style="width: 1000px; margin: auto">
            <tr>
                <th colspan="2" style="text-align: center">채팅목록</th>
            </tr>
            <tr>
                <th style="text-align: center">거래자 ID</th>
                <th style="text-align: center">채팅방 제목</th>
            </tr>
        <c:if test="${empty cList}">
                <tr>
                    <td colspan="2" style="text-align: center">채팅방이 존재하지 않습니다.</td>
                </tr>
        </c:if>
            <c:if test="${!empty cList}">
                <c:forEach var="citem" items="${cList}">
                    <tr>
                        <td>${citem.c_id}</td>
                        <td><a href="/chatting/chatRoom?c_title=${citem.c_title}">${citem.c_title}</a></td>
                    </tr>
                </c:forEach>
            </c:if>
        </table><br>
        <div class="createChat">
            <input type="button" value="채팅방 생성" onclick="location.href='/chatting/createRoom'">
        </div>
        <div class="paging">
            <div class="page">${pageHtml}</div>
        </div>
    </div>
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
            "/chatting/list?colName=" +
            select +
            "&keyWord=" +
            keyWord +
            "&pageNum=1";
    });
</script>
</body>
</html>
