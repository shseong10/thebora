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

    .text-body-secondary img {
        max-width: 100% !important;
    }

    .carousel-control-btn {
        color: #ced4da;
        font-weight: bold;
        font-size: 2.5rem;
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
    window.onload = function () {
        console.log("${profile}")


        //이미지 슬라이더
        //컨트롤러로 가져온 데이터 중 파일리스트로 배열 생성
        const curFiles = new Array();
        <c:forEach items="${file}" var="item">
        curFiles.push({filename : '${item.bf_sysFileName}'});
        </c:forEach>
        //파일리스트 배열을 슬라이더 요소로 생성
        const carouselInner = document.getElementById('carousel-inner');

        for (const file of curFiles) {
            //슬라이더 div 생성
            const carouselItem = document.createElement('div');
            carouselItem.className = 'carousel-item';

            //슬라이더 이미지 생성
            const img = '/upload/' + file.filename;
            const carouselItemImg = document.createElement('img');
            carouselItemImg.className = 'd- block w-100'
            carouselItemImg.setAttribute('src', img);

            //생성된 슬라이더 div와 이미지를 문서 내에 추가
            carouselInner.appendChild(carouselItem);
            carouselItem.appendChild(carouselItemImg);
        }

        //추가된 슬라이더중 첫번째 슬라이더에만 클래스(.active)추가 - 부트스트랩 슬라이더 사용 조건
        document.querySelector('.carousel-item').classList.add('active');

    }
</script>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>

<main>
    <div class="row w-75 mx-auto mb-2">
        <div class="col-11">
            <h1 class="">경매</h1>
        </div>
        <div class="col-1">
            <button onclick="document.location='/board/auctionList'" class="btn btn-color-thebora" style="cursor: pointer">목록으로</button>
        </div>
    </div>
    <div class="wrapper-border rounded-2 mb-3 w-75 mx-auto">
        <div class="row g-5">
            <%-- 상품이미지 --%>
            <div class="col-md-4 carousel slide" id="carousel">
                <div class="carousel-inner rounded-2" id="carousel-inner">

                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
                    <span class="carousel-control-btn" aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
                    <span class="visually-hidden">이전</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
                    <span class="carousel-control-btn" aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                    <span class="visually-hidden">다음</span>
                </button>
            </div>
            <div class="col-md-8">
                <div class="card-body p-3">
                    <h4 class="card-title">${bDto.sb_title}</h4>
                    <small class="text-body-secondary">${bDto.sb_category}</small>
                    <h5 class="card-title mt-4" style="border-bottom: 1px #dee2e6 solid">상세설명</h5>
                    <p style="padding: 1rem;">
                        ${bDto.sb_contents}
                    </p>
                    <table class="table table-bordered">
                        <tr>
                            <th class="table-light">즉시구매가</th>
                            <td>${bDto.element}원</td>
                            <th class="table-light">최소입찰가</th>
                            <td>${bDto.bid}원</td>
                        </tr>
                        <tr>
                            <th class="table-light">시작가</th>
                            <td>${bDto.start}원</td>
                            <th class="table-light">현재가</th>
                            <td id="nowPrice"><span id="np">${bDto.now}원</span></td>
                        </tr>
                        <tr>
                            <th class="table-light">경매시작일</th>
                            <td>${bDto.sb_date}</td>
                            <th class="table-light">경매종료일</th>
                            <td>${bDto.sb_timer}</td>
                        </tr>
                        <tr>
                            <th class="table-light">판매자</th>
                            <td>${bDto.sb_id}</td>
                            <th class="table-light">현재 입찰 예정자</th>
                            <td id="buyer">${bDto.a_joinId}</td>
                        </tr>
                    </table>
                    <div id="timer"></div>
                    <div class="row">
                        <div class="col-8">
                            <form action="/board/buyNow" method="post" id="buyNow">
                                <input type="hidden" name="sb_num" value="${bDto.sb_num}">
                                <input type="hidden" name="sb_id" value="${bDto.sb_id}">
                                <input type="hidden" name="sb_price" value="${bDto.sb_price}">
                                <input type="hidden" name="sb_timer" value="${bDto.sb_timer}">
                            <button class="btn btn-primary btn-color-thebora" onclick="buyNow()">즉시구매</button>
                            <button class="btn btn-primary btn-color-thebora" onclick="saleCart()">찜하기</button>
                            <sec:authorize access="hasRole('admin')">
                                <button class="btn btn-danger" onclick="deleteBtn()">삭제하기</button>
                            </sec:authorize>
                            </form>
                        </div>
                        <div class="col-4" style="text-align: right">
                            <div class="input-group">
                                <input type="number" class="form-control" name="a_bidPrice" id="bidPrice" placeholder="입찰가격">
                                <span class="input-group-text">원</span>
                                <button class="btn btn-primary btn-color-thebora" onclick="userbtnclic()">입찰하기</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>
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

    function buyNow() {
        if (user === joinId) {
            alert("본인의 상품은 구매할 수 없습니다.")
            return
        }
        if (confirm("즉시구매 하시겠습니까?")) {
            $('#buyNow').submit();
        }
    }

    function saleCart() {
        if (user === joinId) {
            alert("본인의 상품은 찜할 수 없습니다.")
            return

        }
        location.href = "/board/myAuctionCart?sb_num=${bDto.sb_num}"
    }

    function userbtnclic() {
        if (joinId === user) {

            alert("판매자는 경매에 참여할 수 없습니다.")

        } else {
            $.ajax({
                url: "/board/attend",
                method: "POST",
                data: {
                    "sb_num": "${bDto.sb_num}",
                    "a_joinId": user,
                    "a_bidPrice": $('#bidPrice').val(),
                    "sb_bid":${bDto.sb_bid},
                    "sb_startPrice":${bDto.sb_startPrice}
                },
            }).done((resp) => {
                console.log(resp)
                if (resp === "입찰 성공") {
                    if (socket) {
                        let socketMsg = {"type": "attend", "buyer": user, "a_bidPrice": $('#bidPrice').val()};
                        socket.send(JSON.stringify(socketMsg));
                        alert('입찰완료.');
                        location.reload();
                    }
                } else if (resp === "입찰 실패") {
                    alert('이미 입찰 했거나 최소입찰가보다 낮습니다.');
                } else if(resp === "포인트부족"){
                    alert('포인트가 부족합니다');
                } else if(resp ==="시작가미달"){
                    alert('시작가보다 낮습니다.')
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


</script>

<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
