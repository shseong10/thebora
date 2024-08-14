<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>더보라</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/css/style.css">

</head>
<style>
    input[type="number"]::-webkit-inner-spin-button,
    input[type="number"]::-webkit-outer-spin-button {
        -webkit-appearance: none;
        margin: 0;
    }
    #product-detail {
        width: 450px;
        height: 500px;
    }

    .allDiv-box {
        height: 600px;

    }

    .carousel-item img {
        max-height: 500px; /* 높이를 자동으로 조정하여 가로 세로 비율 유지 */

    }
</style>
<script>

    $(() => {
        const msg = '${successMsg}'
        if (msg)

            alert('${successMsg}')


    })


</script>
<script>
    $(() => {
        const msg = '${msg}';
        if (msg !== '') {

            alert(msg);
        }
    })
</script>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<div class="card mb-3 w-75 mx-auto allDiv-box">
    <div class="row g-5">
        <div class="col-md-4">
            <div class="fileWide">
                <c:forEach var="img" items="${file}" varStatus="loop">
                    <c:if test="${!empty img.bf_sysFileName}">
                        <img src="/upload/${img.bf_sysFileName}" class="img-fluid rounded-start" alt="...">
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card-body">
                <p class="card-text">상품설명</p>
                <p class="card-text" id="product-detail"><small
                        class="text-body-secondary">${eDetail.sb_contents}</small>
                </p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card-body">
                <h5 class="card-title">상품명 : ${eDetail.sb_title}</h5>
                <hr>
                <div>즉시구매가 : <span class="card-text price">${eDetail.sb_price}</span></div>
                <p>
                <div>시작가 : <span class="card-text price">${eDetail.sb_startPrice}</span></div>
                <p>
                <div>입찰가 : <span class="card-text price">${eDetail.sb_nowPrice}</span></div>
                <p>
                <div>최소입찰가 : <span class="card-text price">${eDetail.sb_bid}</span></div>
                <p></p>
                <p class="card-text ">경매시작일 : ${eDetail.sb_date}</p>
                <p class="card-text">경매종료일 : ${eDetail.sb_timer}</p>
                <p>판매자 : ${eDetail.sb_id}</p>
                <p id="buyer">입찰자 : ${eDetail.a_joinId}</p>
                <div id="timer"></div>


            </div>
        </div>
    </div>
</div>

<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <a href="/member/myPage" class="btn btn-primary btn-color-thebora" role="button">목록으로</a>
</div>


<script>

    function formatNumber(number) {
        return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    window.onload = function () {
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
