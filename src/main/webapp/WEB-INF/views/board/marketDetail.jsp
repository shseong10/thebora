<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>더보라</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.5.1/dist/sockjs.min.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<style>
    .carousel-item {

        margin: auto;
        width: auto; /* 너비를 자동으로 조정하여 가로 세로 비율 유지 */
        height: auto; /* 높이를 자동으로 조정하여 가로 세로 비율 유지 */


    }

    .carousel-inner {
        display: flex;
        align-items: center;
        justify-content: center;
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
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main>
    <div class="card mb-3 w-75 mx-auto allDiv-box">
        <div class="row g-5">
            <div class="col-md-4">
                <div class="fileWide">
                    <c:forEach var="img" items="${file}" varStatus="loop">
                        <c:if test="${!empty img.bf_sysFileName}">
                            <div class="${loop.index == 0 ? 'active' : ''}">
                                <img src="/upload/${img.bf_sysFileName}" class="img-fluid rounded-start" alt="...">
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-body">
                    <p class="card-text">상품설명</p>
                    <p class="card-text" id="product-detail"><small class="text-body-secondary">${bDto.sb_contents}</small>
                    </p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card-body">
                    <h5 class="card-title">상품명 : ${bDto.sb_title}</h5>
                    <hr>
                    <p class="card-text">분류 : ${bDto.sb_category}</p>
                    <p class="card-text">가격 : ${bDto.element}원</p>
                    <p class="card-text">지역 : ${bDto.sb_local}</p>
                    <p class="card-text">날짜 : ${bDto.sb_date}</p>
                    <p>판매자 : ${bDto.sb_id}</p>
                    <div id="timer"></div>
                    <form action="/board/attend" method="post" class="bid_form">
                        <div class="d-grid gap-2 d-md-block mb-3">
                            <button class="btn btn-primary btn-color-thebora" type="button" onclick="marketCart()">찜하기</button>
                            <button type="button" class="btn btn-primary btn-color-thebora" onclick="buyApply()">구매신청</button>
                            <input type="hidden" name="sb_num" value="${bDto.sb_num}">
                        </div>
                    </form>
                    <form action="#">
                        <input type="hidden" name="h_o_p_num" value="${bDto.sb_num}">

                        <input type="button" id="reset-button" class="btn btn-primary btn-color-thebora" value="삭제하기" onclick="deleteBtn()">
                        <input type="button" id="end-button" class="btn btn-primary btn-color-thebora" value="판매완료" onclick="endBtn(${bDto.sb_num})">

                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="w-75 mb-3 mx-auto">
        <a href="/board/marketList" class="btn btn-primary btn-color-thebora" role="button">목록으로</a>
    </div>
</main>
<script>
    function endBtn(num){
        location.href = "/board/marketEnd?sb_num=" + num

    }


    const sellerId = '${bDto.sb_id}';
    const user = '<sec:authentication property="name"/>';
    let boardId = "${bDto.sb_num}"
    let boardTitle = "${bDto.sb_title}"
    let boardWriter = "${bDto.sb_id}"
    let replyWriter = user


    if (user === sellerId) {
        $('#reset-button').show();
        $('#end-button').show();
    } else {
        $('#reset-button').hide();
        $('#end-button').hide();
    }

    function deleteBtn() {
        location.href = "/board/marketDelete?sb_num=" +
        ${bDto.sb_num}
    }


    function buyApply() {
        if (user === sellerId) {
            alert("본인의 상품은 구매하실 수 없습니다.")
            return
        }
        $.ajax({
            url: "/board/buyApply",
            method: "post",
            data: {"sb_num": "${bDto.sb_num}", "sb_id": "${bDto.sb_id}", "a_joinId": user},
        }).done((resp) => {
            if (resp) {
                //웹 소켓 관련 로직 추가
                if (socket) {
                    let socketMsg = {
                        "type": "apply",
                        "buyer": replyWriter,
                        "seller": boardWriter,
                        "sb_num": boardId,
                        "sb_title": boardTitle
                    };
                    socket.send(JSON.stringify(socketMsg));
                    alert('구매신청완료.');
                    location.reload();
                }
            } else {
                alert('이미 구매 신청하셨습니다.');
                location.reload();
            }

        }).fail((err) => {
            console.log(err)
        })
    }

    function marketCart() {
        if (user === sellerId) {
            alert("본인의 상품은 장바구니에 넣을 수 없습니다.")
            return

        }
        location.href = "/board/mySalesCart?sb_num=${bDto.sb_num}"
    }

    <sec:authorize access="hasRole('admin')">
    $('#reset-button').show();
    </sec:authorize>

</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
