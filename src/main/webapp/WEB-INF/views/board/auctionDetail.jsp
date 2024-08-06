<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 8.
  Time: 오후 5:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>

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

    .carousel-control-prev-icon {
        background-color: #cccccc;
    }

    .carousel-control-next-icon {
        background-color: #cccccc;
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
                <div id="carouselExample" class="carousel slide">
                    <div class="carousel-inner">
                        <c:forEach var="img" items="${file}" varStatus="loop">
                            <c:if test="${empty img.bf_sysFileName}">
                                <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                    <img src="/upload/프사없음.jfif" class="img-fluid rounded-start" alt="...">
                                </div>
                            </c:if>
                            <c:if test="${!empty img.bf_sysFileName}">
                                <div class="carousel-item ${loop.index == 0 ? 'active' : ''}">
                                    <img src="/upload/${img.bf_sysFileName}" class="img-fluid rounded-start" alt="...">
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample"
                            data-bs-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Previous</span>
                    </button>
                    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample"
                            data-bs-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="visually-hidden">Next</span>
                    </button>
                </div>
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
                <p class="card-text">즉시구매가 : ${bDto.sb_price}</p>
                <p class="card-text">시작가 : ${bDto.sb_startPrice}</p>
                <p id="nowPrice" class="card-text">현재가 : <span id="np">${bDto.sb_nowPrice}</span> </p>
                <p class="card-text">최소입찰가 : ${bDto.sb_bid}</p>
                <p class="card-text">경매시작일 : ${bDto.sb_date}</p>
                <p class="card-text">경매종료일 : ${bDto.sb_timer}</p>
                <p>판매자 : ${bDto.sb_id}</p>
                <p id="buyer">현재 입찰 예정자 : ${bDto.a_joinId}</p>

                <div id="timer"></div>
                <%--                <form action="/board/attend" method="post" class="bid_form">--%>
                <div class="d-grid gap-2 d-md-block mb-3">
                    <%--                        <input type="hidden" name="sb_num" value="${bDto.sb_num}">--%>
                    <input type="text" name="a_bidPrice" id="bidPrice" placeholder="입찰가격">
                    <input type="button" class="btn btn-primary" onclick="userbtnclic()" value="입찰하기">
                </div>
                <%--                </form>--%>

                <form action="#">
                    <input type="hidden" name="h_o_p_num" value="${bDto.sb_num}">
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#now-buy">
                        즉시구매
                    </button>
                    <input class="btn btn-primary" type="button" onclick="saleCart()" value="찜하기">
                    <input type="button" id="reset-button" class="btn btn-primary" value="삭제하기" onclick="deleteBtn()">

                </form>

            </div>
        </div>
    </div>
</div>

<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <a href="/board/auctionList" class="btn btn-primary" role="button">목록으로</a>
</div>

<%--즉시구매--%>
<!-- Modal -->
<div class="modal fade" id="now-buy" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Modal title</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/board/buyNowGo">
                    <button class="btn btn-primary">
                        QR코드로 구매하기
                    </button>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

            </div>
        </div>
    </div>
</div>


<script>
    const joinId = '${bDto.sb_id}';
    const user = '<sec:authentication property="name"/>'
    let bid = '${bDto.sb_bid}';
    let nowPrice = '${bDto.sb_nowPrice}';
    const boardId = "${bDto.sb_num}";
    const boardTitle = "${bDto.sb_title}";
    const boardWriter = "${bDto.sb_id}";
    const replyWriter = "${bDto.sb_id}";
    const np = $('#np').html();
    console.log(np);
    function saleCart() {
        if (user === joinId) {
            alert("본인의 상품은 장바구니에 넣을 수 없습니다.")
            return

        }
        location.href = "/board/myAuctionCart?sb_num=${bDto.sb_num}"
    }


    if (user === joinId) {
        $('#reset-button').show();
    } else {
        $('#reset-button').hide();
    }

    function userbtnclic() {
        console.log($('#bidPrice').val() - np);
        if (joinId === user) {

            alert("판매자는 경매에 참여할 수 없습니다.")

        } else {
            $.ajax({
                url: "/board/attend",
                method: "POST",
                data: {"sb_num": "${bDto.sb_num}", "a_joinId": user, "a_bidPrice": $('#bidPrice').val(), "sb_bid":${bDto.sb_bid}},
            }).done((resp) => {
                console.log(resp)
                if (resp === "입찰 성공") {
                    if (socket) {
                        let socketMsg = {"type": "attend", "buyer": user, "a_bidPrice": $('#bidPrice').val()};
                        socket.send(JSON.stringify(socketMsg));
                        alert('입찰완료.');
                        location.reload();
                    }
                } else {
                    alert('이미 입찰 했거나 최소입찰가보다 낮습니다.');
                }
            }).fail((err) => {
                console.log(err)
            })


            // $('.bid_form').submit();


        }
    }


    function deleteBtn() {
        location.href = "/board/auctionDelete?sb_num=${bDto.sb_num}"
    }

    function buyApply() {
        if (user === joinId) {
            alert("본인의 상품은 구매하실 수 없습니다.")
            return

        }

        //
        // $.ajax({
        //     url: "/board/attend",
        //     type: "post",
        //     data: param,
        //     success: function (resp) {
        //         alert('구매신청완료.');
        //         location.reload();
        //         //웹 소켓 관련 로직 추가
        //         if (boardWriter != replyWriter) {	//글쓴이와 댓글작성자가 다를 경우 소켓으로 메세지 보냄
        //             if (socket) {
        //                 let socketMsg = "reply," + replyWriter + "," + boardWriter + "," + boardId + "," + boardTitle;
        //                 socket.send(socketMsg);
        //             }
        //         }
        //     },
        //     error: function (XMLHttpRequest, textStatus, errorThrown) {
        //         alert('댓글 등록이 실패하였습니다.');
        //     }
        // });


    }

    let websocket = null;
    $(document).ready(function () {
        //소켓 연결
        webConnectWs();
    });

    function webConnectWs() {
        //WebSocketConfig에서 설정한 endPoint("/push")로 연결
        const ws = new SockJS("/push");
        websocket = ws;

        ws.onopen = function () {
            console.log('open');
        };

        ws.onmessage = function (event) {
            try {
                const result = JSON.parse(event.data);
                console.log(result);
                if (result.type === "price") {
                    $('#np').html(result.value);
                }
                if (result.type === "buyer") {
                    $('#buyer').html("현재 입찰 예정자 : "+result.name);
                }
            } catch (e) {
                console.error("에러원인", e);
            }

        };

        ws.onclose = function () {
            console.log('close');
        };

    }


</script>
<sec:authorize access="hasRole('admin')">
    <script>
        $('#reset-button').show();
    </script>
</sec:authorize>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
