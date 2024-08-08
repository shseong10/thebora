<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .text-body-secondary img {
            display: none !important;
        }

        .img-fluid {
            object-fit: cover;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main id="hotdeal-wrapper" class="mx-auto">
    <div class="d-grid gap-2 mb-3">
        <div class="row">
            <div class="col-9">
                <h1 class="">핫딜</h1>
            </div>
            <div class="col-3">
                <a href="/hotdeal/add_item" class="btn btn-primary btn-color-thebora" role="button">상품등록</a>
                <a href="/hotdeal/admin/main" class="btn btn-primary btn-color-thebora" role="button">관리자페이지</a>
            </div>
        </div>
    </div>
    <div class="row row-cols-1 row-cols-md-2 g-4">
        <c:forEach var="item" items="${iList}">
            <div class="col">
                <div class="card"> <%-- 테두리 css 적용되는 부분 --%>
                    <div class="row g-0 h-100 hotdeal-item-wrapper"> <%-- 카드 내부 좌우구분 --%>
<%--                        <div class="col-md-4 h-100" style="background-image: url('/upload/${item.ifList[0].bf_sysfilename}'); background-size: cover; background-position: 50% 50%;">--%>
                        <div class="col-md-4 h-100 hotdeal-item-thumbnail bordder">
                                <%-- 카드 좌측 --%>
                            <img src="/upload/${item.ifList[0].bf_sysfilename}" class="img-fluid rounded-start">
                        </div>
                        <div class="col-md-8 h-100 hotdeal-item-text bordder">
                                <%-- 카드 우측 --%>
                            <div class="card-body h-100">
                                <h5 class="card-title"><a href="/hotdeal/list/detail?sb_num=${item.sb_num}" class="stretched-link">${item.sb_title}</a></h5>
                                <p class="card-text">${item.sb_category}</p>
                                <p class="card-text">${item.sb_startprice}원</p>
                                <p class="card-text"><small class="text-body-secondary">${item.sb_contents}</small></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="pagination justify-content-center mt-4">
        <nav aria-label="Page navigation">
            <ul class="pagination">
                <!-- Previous button -->
                <li class="page-item <c:if test='${startPage == 1}'> disabled </c:if>'">
                    <a class="page-link" href="?pageNum=${startPage - pageCount}" aria-label="Previous">
                        이전
                    </a>
                </li>
                <!-- Page numbers -->
                <c:forEach var="i" begin="${startPage}" end="${endPage}">
                    <li class="page-item<c:if test='${currentPage == i}'> active </c:if>'" aria-current="page">
                        <a class="page-link" href="?pageNum=${i}">${i}</a>
                    </li>
                </c:forEach>
                <!-- Next button -->
                <li class="page-item <c:if test='${endPage == totalPages}'> disabled </c:if>'">
                    <a class="page-link" href="?pageNum=${endPage + 1}" aria-label="Next">
                        다음
                    </a>
                </li>
            </ul>
        </nav>
    </div>
</main>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
