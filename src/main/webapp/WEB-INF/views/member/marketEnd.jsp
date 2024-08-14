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
<main>
    <div class="w-75 mx-auto">
        <h1 class="mb-5">거래내역</h1>
    </div>
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <h2 class="article-t">중고거래 완료 내역</h2>
    </div>
    <c:if test="${empty mEList}">
        <div class="none-auction">거래된 상품이 없습니다.</div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
        <c:forEach var="eList" items="${mEList}">
            <div class="col">
                <div class="card mb-3 position-relative my-trade-card"><%-- 카드 컨테이너 --%>
                    <div class="row g-0">
                        <div class="col-md-6"><%-- 카드 좌측 --%>
                            <c:forEach var="file" items="${eList.bfList}" varStatus="loop">
                                <c:if test="${file.bf_sysFileName eq ''}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/프사없음.jfif'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                                <c:if test="${!empty file.bf_sysFileName}">
                                    <div class="my-trade-thumbnail rounded-1 ${loop.index == 0 ? '' : 'img-none' }" style="background-image: url('/upload/${sfile.bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">

                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="col-md-6"><%-- 카드 우측 --%>
                            <div class="card-body" style="text-align: center">
                                <h5 class="card-title mt-4">
                                    <a href="/board/marketDetail?sb_num=${eList.sb_num}" class="stretched-link">
                                        <small class="main-item-category rounded-3 color-3">판매중</small> ${eList.sb_title}
                                    </a>
                                </h5>
                                <small class="text-body-secondary">${eList.sb_category}</small>
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
                                        <b>${eList.sb_price}원</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">등록일</small><br>
                                        <b>${eList.sb_date}</b>
                                    </div>
                                </div>

                                <div class="d-grid mt-5" style="text-align: center">
                                    <a type="button" class="btn btn-color-thebora btn-sm" href="/board/marketEndDetail?sb_num=${eList.sb_num}">보기</a>
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
        <h2 class="article-t">경매 완료 내역</h2>
    </div>
    <c:if test="${empty aEList}">
        <div class="none-auction">거래된 상품이 없습니다.</div>
    </c:if>
    <div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto">
        <c:forEach var="aList" items="${aEList}">
            <div class="col">
                <div class="card mb-3 position-relative my-trade-card"><%-- 카드 컨테이너 --%>
                    <div class="row g-0">
                        <div class="col-md-6"><%-- 카드 좌측 --%>
                            <c:forEach var="file" items="${aList.bfList}" varStatus="loop">
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
                                    <a href="/board/auctionEndDetail?sb_num=${aList.sb_num}">
                                        <small class="main-item-category rounded-3 color-3">경매</small> ${aList.sb_title}
                                    </a>
                                </h5>
                                <small class="text-body-secondary">${aList.sb_category}</small>
                                <div class="card-text row row-cols-1 row-cols-md-2 g-4 mt-1">
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">판매자</small><br>
                                        <b>${aList.sb_id}</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">즉시구매가</small><br>
                                        <b>${aList.sb_price}</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">입찰가</small><br>
                                        <b>${aList.sb_nowPrice}원</b>
                                    </div>
                                    <div class="col my-trade-card-col">
                                        <small class="text-body-secondary">ㅁㅁㅁㅁㅁㅁ</small><br>
                                        <b></b>
                                    </div>
                                </div>
                                <div class="d-grid mt-3">
                                    <a type="button" class="btn btn-color-thebora btn-sm" href="/board/auctionEndDetail?sb_num=${aList.sb_num}">보기</a>
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
        <h2 class="article-t">핫딜 구매 내역</h2>
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

    function formatNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    window.onload = function() {
        const elements = document.querySelectorAll('.price');
        elements.forEach(element => {
            let number = parseInt(element.textContent, 10);
            element.textContent = formatNumber(number);
        });
    }


</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
