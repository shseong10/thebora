<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 12.
  Time: 오후 4:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
</head>
<style>
    .file-size {
        display: flex;
        align-items: center;
        justify-items: center;

    }

    .file-size img {

        max-height: 200px; /* 높이를 자동으로 조정하여 가로 세로 비율 유지 */
        max-width: 200px; /* 높이를 자동으로 조정하여 가로 세로 비율 유지 */
        margin: auto;


    }

    .line-line {

        border: solid 1px black;
        border-radius: 10%;
        width: 300px;
        display: flex;
        justify-content: center;

    }

    .fileWide {
        display: flex;
        justify-content: center;
        overflow: hidden;
        width: 245px;
        height: 245px;

    }

    .fileWide img {
        width: 100%;
        height: 100%;
    }
    .none-auction{
        display: flex;
        justify-content: center;
        align-content: center;
        margin: 150px;
    }


</style>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<hr class="w-75 mx-auto" >
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <h2 class="article-t">판매완료 내역</h2>
</div>
<c:if test="${empty mEList}">
    <div class="none-auction">거래중인 상품이 없습니다.</div>
</c:if>
<div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
    <c:forEach var="eList" items="${mEList}">
        <div class="col">
            <div class="card mb-3">
                <div class="row g-0">
                    <div class="col-md-4">
                        <div class="fileWide">
                            <c:forEach var="file" items="${eList.bfList}" varStatus="loop">
                                <c:if test="${file.bf_sysFileName eq ''}">
                                    <img src="/upload/프사없음.jfif" class="img-fluid rounded-start" alt="...">
                                </c:if>
                                <c:if test="${!empty file.bf_sysFileName}">
                                    <div>
                                        <img src="/upload/${file.bf_sysFileName}"
                                             class="img-fluid rounded-start ${loop.index == 0 ? '' : 'img-none' }"
                                             alt="...">
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card-body">
                            <h5 class="card-title"><a href="/board/marketDetail?sb_num=${eList.sb_num}"
                                                      class="stretched-link">${eList.sb_title}</a></h5>
                            <p class="card-text">분류:${eList.sb_category}</p>
                            <p class="card-text">가격:${eList.sb_price}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


<script>
    $('.img-none').hide();


</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>