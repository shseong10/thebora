<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>더보라</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<style>
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
<div class="w-75 mx-auto">
    <h1 class="mb-5">나의 거래</h1>
</div>
<main>
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <h2 class="article-t">구매중인 물건</h2>
    </div>
    <c:if test="${empty myTrading}">
        <div class="none-auction">거래중인 상품이 없습니다.</div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
        <c:forEach var="trading" items="${myTrading}">
            <div class="col">
                <div class="card mb-3 position-relative my-trade-card"><%-- 카드 컨테이너 --%>
                    <div class="row g-0">
                        <div class="col-md-6"><%-- 카드 좌측 --%>
                            <c:forEach var="file" items="${trading.bfList}" varStatus="loop">
                                <c:if test="${file.bf_sysFileName eq ''}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/프사없음.jfif'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                                <c:if test="${!empty file.bf_sysFileName}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/${file.bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="col-md-6"><%-- 카드 우측 --%>
                            <div class="card-body" style="text-align: center">
                                <h5 class="card-title mt-1">
                                    <small class="main-item-category rounded-3 color-3">중고</small> ${trading.sb_title}
                                </h5>
                                <small class="text-body-secondary">${trading.sb_category}</small>
                                <div class="card-text row row-cols-1 row-cols-md-2 g-4 mt-1">
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">판매자</small><br>
                                        <b>${trading.sb_id}</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">지역</small><br>
                                            <b>${trading.sb_local}</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">가격</small><br>
                                            <b>${trading.sb_price}원</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">등록일</small><br>
                                            <b>${trading.sb_date}</b>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col d-grid">
                                        <a type="button" class="btn btn-color-thebora btn-sm" href="/board/marketDetail?sb_num=${trading.sb_num}">보기</a>
                                    </div>
                                    <div class="col d-grid">
                                        <a type="button" class="btn my-trade-btn-del btn-sm" href="/board/myTradeDel?sb_num=${trading.sb_num}">삭제</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <hr class="w-75 mx-auto" >
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <h2 class="article-t">참여중인 경매</h2>
    </div>
    <c:if test="${empty myTrade}">
        <div class="none-auction">참여중인 경매가 없습니다.</div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
        <c:forEach var="item" items="${myTrade}">
            <div class="col">
                <div class="card mb-3 position-relative my-trade-card"><%-- 카드 컨테이너 --%>
                    <div class="row g-0">
                        <div class="col-md-6"><%-- 카드 좌측 --%>
                            <c:forEach var="file" items="${item.bfList}" varStatus="loop">
                                <c:if test="${file.bf_sysFileName eq ''}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/프사없음.jfif'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                                <c:if test="${!empty file.bf_sysFileName}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/${file.bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="col-md-6"><%-- 카드 우측 --%>
                            <div class="card-body" style="text-align: center">
                                <h5 class="card-title mt-1">
                                    <a href="/board/auctionDetail?sb_num=${item.sb_num}">
                                        <small class="main-item-category rounded-3 color-3">경매</small> ${item.sb_title}
                                    </a>
                                </h5>
                                <small class="text-body-secondary">${item.sb_category}</small>
                                <div class="card-text row row-cols-1 row-cols-md-2 g-4 mt-1">
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">판매자</small><br>
                                        <b>${item.sb_id}</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">즉시구매가</small><br>
                                        <b>${item.sb_price}</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">현재가</small><br>
                                        <b>${item.sb_nowPrice}원</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">내 입찰 금액</small><br>
                                        <b>${item.a_bidPrice}</b>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col d-grid">
                                        <a type="button" class="btn btn-color-thebora btn-sm" href="/board/auctionDetail?sb_num=${item.sb_num}">보기</a>
                                    </div>
                                    <div class="col d-grid">
                                        <a type="button" class="btn my-trade-btn-del btn-sm" href="/board/myTradeDel?sb_num=${item.sb_num}">삭제</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <hr class="w-75 mx-auto" >
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <h2 class="article-t">판매중인 물건</h2>
    </div>
    <c:if test="${empty mySales}">
        <div class="none-auction">판매중인 물품이 없습니다.</div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
        <c:forEach var="Sales" items="${mySales}">
            <div class="col">
                <div class="card mb-3 position-relative my-trade-card"><%-- 카드 컨테이너 --%>
                    <div class="row g-0">
                        <div class="col-md-6"><%-- 카드 좌측 --%>
                            <c:forEach var="sfile" items="${Sales.bfList}" varStatus="loop">
                                <c:if test="${sfile.bf_sysFileName eq ''}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/프사없음.jfif'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                                <c:if test="${!empty sfile.bf_sysFileName}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/${sfile.bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="col-md-6"><%-- 카드 우측 --%>
                            <div class="card-body" style="text-align: center">
                                <h5 class="card-title mt-4">
                                    <a href="/board/marketDetail?sb_num=${Sales.sb_num}">
                                        <small class="main-item-category rounded-3 color-3">판매중</small> ${Sales.sb_title}
                                    </a>
                                </h5>
                                <small class="text-body-secondary">${Sales.sb_category}</small>
                                <div class="card-text row row-cols-1 row-cols-md-2 g-4 mt-1">
    <%--                                <div class="col my-trade-card-col">--%>
    <%--                                    <small class="text-body-secondary">판매자</small><br>--%>
    <%--                                    <b>${Sales.sb_id}</b>--%>
    <%--                                </div>--%>
    <%--                                <div class="col my-trade-card-col">--%>
    <%--                                    <small class="text-body-secondary">지역</small><br>--%>
    <%--                                    <b>${Sales.sb_price}</b>--%>
    <%--                                </div>--%>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">가격</small><br>
                                        <b>${Sales.sb_price}원</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">등록일</small><br>
                                        <b>${Sales.sb_date}</b>
                                    </div>
                                </div>

                                <div class="row mt-5">
                                    <div class="col d-grid">
                                        <a type="button" class="btn btn-color-thebora btn-sm" href="/board/marketDetail?sb_num=${Sales.sb_num}">보기</a>
                                    </div>
                                    <div class="col d-grid">
                                        <a type="button" class="btn my-trade-btn-del btn-sm" href="/board/myTradeDel?sb_num=${Sales.sb_num}">삭제</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <hr class="w-75 mx-auto" >
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <h2 class="article-t">핫딜 구매 상품</h2>
    </div>
    <c:if test="${empty myOrder}">
        <div class="none-auction">구매한 상품이 없습니다.</div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
        <c:forEach var="myOrder" items="${myOrder}">
            <div class="col">
                <div class="card mb-3 position-relative my-trade-card"><%-- 카드 컨테이너 --%>
                    <div class="row g-0">
                        <div class="col-md-6"><%-- 카드 좌측 --%>
                            <c:forEach var="file" items="${myOrder.bfList}" varStatus="loop">
                                <c:if test="${file.bf_sysFileName eq ''}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/프사없음.jfif'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                                <c:if test="${!empty file.bf_sysFileName}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/${file.bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="col-md-6"><%-- 카드 우측 --%>
                            <div class="card-body" style="text-align: center">
                                <h5 class="card-title mt-4">
                                    <a href="${myOrder.order_num}">
                                        <small class="main-item-category rounded-3 color-3">핫딜</small> ${myOrder.sb_title}
                                    </a>
                                </h5>
                                <div class="card-text row row-cols-1 row-cols-md-2 g-4 mt-1">
    <%--                                <div class="col my-trade-card-col">--%>
    <%--                                    <small class="text-body-secondary">판매자</small><br>--%>
    <%--                                    <b>${Sales.sb_id}</b>--%>
    <%--                                </div>--%>
    <%--                                <div class="col my-trade-card-col">--%>
    <%--                                    <small class="text-body-secondary">지역</small><br>--%>
    <%--                                    <b>${Sales.sb_price}</b>--%>
    <%--                                </div>--%>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">가격</small><br>
                                        <b>${myOrder.item_price}원</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">주문일자</small><br>
                                        <b>${myOrder.order_date}</b>
                                    </div>
                                </div>

                                <div class="row mt-5">
                                    <div class="col d-grid">
                                        <a type="button" class="btn btn-color-thebora btn-sm" href="/hotdeal/list/detail?sb_num=${myOrder.order_num}">보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</main>


<script>
    $('.img-none').hide();


</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
