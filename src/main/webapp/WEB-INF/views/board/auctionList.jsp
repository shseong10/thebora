<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<!DOCTYPE html>
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
    <style>
        #auction-keyWord {
            width: 250px;
        }
    </style>
    <script>
        $(() => {
            const msg = '${msg}'
            if (msg)

                alert('${msg}')

        })
    </script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>

<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <h1 class="">경매</h1>
    <div class="search-bar">
        <input id="auction-keyWord" class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
        <button id="auction-search" class="btn btn-primary btn-color-thebora" type="button"><i class="bi bi-search"></i>
        </button>
    </div>
    <a href="/board/auctionApply" class="btn btn-primary btn-color-thebora" role="button">경매신청</a>
    <div>
        <ul id="sb_category">
            <li name="sb_category"><a href="/board/auctionList?pageNum=1">전체</a></li>
            <c:forEach var="cList" items="${cateList}">
                <li name="sb_category"><a href="/board/auctionList?sb_category=${cList}&pageNum=1">${cList}</a></li>
            </c:forEach>
        </ul>
    </div>


    <div class="row row-cols-1 row-cols-md-4 g-4">
        <c:if test="${!empty bList}">
            <c:forEach var="item" items="${bList}">
                <div class="col">
                    <div class="hotdeal-item-wrapper position-relative">
                        <div class="hotdeal-item-thumbnail rounded-1"
                             style="background-image: url('/upload/${item.bfList[0].bf_sysFileName}'); background-size: cover; background-position: 50% 50%;">
                                <%-- 카드 상 --%>
                        </div>
                        <div class="hotdeal-item-text">
                            <a href="/board/auctionDetail?sb_num=${item.sb_num}" class="stretched-link">
                                <h5>${item.sb_title}</h5></a>
                            <small class="text-body-secondary">${item.sb_category}</small>
                           <div><span class="card-text">즉시구매가격 : ${item.element}원</span></div>
                            <p class="hotdeal-item-price">현재가격 : ${item.now}원</p>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>


    <%--<div class="row row-cols-1 row-cols-md-2 g-4 w-75 mx-auto" id="cate-body">--%>
    <%--        <c:forEach var="item" items="${bList}">--%>
    <%--            <div class="col">--%>
    <%--                <div class="card mb-3">--%>
    <%--                    <div class="row g-0">--%>
    <%--                        <div class="col-md-4">--%>
    <%--                            <div class="fileWide">--%>

    <%--                                <c:forEach var="file" items="${item.bfList}" varStatus="loop">--%>
    <%--                                    <c:if test="${file.bf_sysFileName eq ''}">--%>
    <%--                                        <img src="/upload/프사없음.jfif" class="img-fluid rounded-start" alt="...">--%>
    <%--                                    </c:if>--%>
    <%--                                    <c:if test="${!empty file.bf_sysFileName}">--%>
    <%--                                        <div>--%>
    <%--                                            <img src="/upload/${file.bf_sysFileName}"--%>
    <%--                                                 class="img-fluid rounded-start ${loop.index == 0 ? '' : 'img-none' }"--%>
    <%--                                                 alt="...">--%>
    <%--                                        </div>--%>
    <%--                                    </c:if>--%>
    <%--                                </c:forEach>--%>

    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                        <div class="col-md-4">--%>
    <%--                            <div class="card-body">--%>
    <%--                                <h5 class="card-title"><a href="/board/auctionDetail?sb_num=${item.sb_num}"--%>
    <%--                                                          class="stretched-link">${item.sb_title}</a></h5>--%>
    <%--                                <p class="card-text">분류:${item.sb_category}</p>--%>
    <%--                                <p class="card-text">즉시구매가:${item.element}원</p>--%>
    <%--                                <p class="card-text">시작가:${item.start}원</p>--%>
    <%--                                <p class="card-text">현재가:${item.now}원</p>--%>
    <%--                                <p class="card-text">조회수:${item.sb_view}</p>--%>
    <%--                                <p class="card-text"><small--%>
    <%--                                        class="text-body-secondary">${fn:substring(item.sb_contents, 0, 15)}..</small></p>--%>

    <%--                            </div>--%>
    <%--                        </div>--%>
    <%--                    </div>--%>
    <%--                </div>--%>
    <%--            </div>--%>
    <%--        </c:forEach>--%>
    <%--</div>--%>
    <div class="pagination justify-content-center mt-4">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <!-- Previous button -->
                <li class="page-item <c:if test='${startPage == 1}'> disabled </c:if>'">
                    <a class="page-link"
                       href="?pageNum=${startPage - pageCount}&sb_category=${category}&keyWord=${keyWord}"
                       aria-label="Previous">
                        이전
                    </a>
                </li>
                <!-- Page numbers -->
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <li class="page-item<c:if test='${currentPage == i}'> active </c:if>'" aria-current="page">
                        <a class="page-link" href="?pageNum=${i}&sb_category=${category}&keyWord=${keyWord}">${i}</a>
                    </li>
                </c:forEach>
                <!-- Next button -->
                <li class="page-item <c:if test='${endPage == totalPages}'> disabled </c:if>'">
                    <a class="page-link" href="?pageNum=${endPage + 1}&sb_category=${category}&keyWord=${keyWord}"
                       aria-label="Next">
                        다음
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<script>
    $(document).ready(function () {
        ($('.img-none')).hide();


    });
    $("#auction-search").click(function () {
        let keyWord = $("#auction-keyWord").val();
        if (keyWord === "") {
            alert("검색어를 입력하세요.");
            return;
        }
        location.href = "/board/auctionList?&keyWord=" + keyWord + "&pageNum=1";
    })

    $("#auction-keyWord").keydown(function (e) {
        if (e.key === "Enter") { // Enter 키
            e.preventDefault(); // 기본 Enter 동작 방지
            $("#auction-search").click();
        }
    });

</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>