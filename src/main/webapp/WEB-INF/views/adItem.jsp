<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<section class="w-75 mx-auto main-section border-bottom">
    <h3 class="article-t">광고상품</h3>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <c:forEach var="item" items="${adItem}">
            <div class="col">
                <div class="position-relative">
                    <c:set var="firstFile" value="${null}"/>
                    <c:forEach var="file" items="${files}">
                        <c:if test="${item.sb_num == file.bf_sb_num && empty firstFile}">
                            <c:set var="firstFile" value="${file}"/>
                        </c:if>
                    </c:forEach>
                    <c:if test="${empty firstFile}">
                        <div class="main-item-thumbnail rounded-2" style="background-image: url('/img/product_sample_02.png'); background-size: cover; background-position: 50% 50%;">

                        </div>
                    </c:if>
                    <c:if test="${not empty firstFile}">
                        <div class="main-item-thumbnail rounded-2" style="background-image: url('/upload/${firstFile.bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">

                        </div>
                    </c:if>
                    <div class="card-body">
                        <c:if test="${item.sb_saleKind == 1}">
                                <h5 class="card-title">
                                    <a href="/board/auctionDetail?sb_num=${item.sb_num}" class="stretched-link">${item.sb_title}</a>
                                </h5>
                                <h5 class="main-item-price">${item.sb_price}원</h5>
                                <small class="main-item-category rounded-3 color-3">경매</small>

                        </c:if>
                        <c:if test="${item.sb_saleKind == 2}">
                                <h5 class="card-title">
                                    <a href="/board/marketDetail?sb_num=${item.sb_num}" class="stretched-link">${item.sb_title}</a>
                                </h5>
                                <h5 class="main-item-price">${item.sb_price}원</h5>
                                <small class="main-item-category rounded-3 color-3">중고</small>
                                <small class="main-item-category rounded-3 color-5">${item.sb_local}</small>
                        </c:if>
                        <c:if test="${item.sb_saleKind == 3}">
                                <h5 class="card-title">
                                    <a href="/hotdeal/list/detail?sb_num=${item.sb_num}" class="stretched-link">${item.sb_title}</a>
                                </h5>
                                <h5 class="main-item-price">${item.sb_price}원</h5>
                                <small class="main-item-category rounded-3 color-3">핫딜</small>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
</body>
</html>
