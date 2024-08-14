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
    .text-body-secondary img {
        max-width: 100% !important;
    }

    .carousel-control-btn {
        color: #ced4da;
        font-weight: bold;
        font-size: 2.5rem;
    }
</style>
<body>
<script>
    $(() => {
        const msg = '${msg}';
        if (msg !== '') {

            alert(msg);
        }
    })
    window.onload = function (){
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
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main>
    <div class="row w-75 mx-auto">
        <div class="col-11">
            <h1 class="">중고거래</h1>
        </div>
        <div class="col-1">
            <button onclick="document.location='/board/marketList'" class="btn btn-primary btn-color-thebora" style="display: inline-block">목록으로</button>
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
                <div class="card-body">
                    <p class="mt-3">
                        <h4 class="card-title">${bDto.sb_title}</h4>
                        <small class="text-body-secondary">${bDto.sb_category}</small>
                        <h5 class="card-text">${bDto.element}원</h5>
                        <small class="text-body-secondary">${bDto.sb_date}</small>
                    </p>
                    <h5 class="card-title" style="border-bottom: 1px #dee2e6 solid">판매자 정보</h5>
                    <p class="card-text" style="padding: 1rem;">
                        <span style="font-weight: bold; font-size:1rem;">${bDto.sb_id}</span>
                        <span class="color-1 rounded-2 main-item-category">${bDto.sb_local}</span>
                    </p>
                    <h5 class="card-title" style="border-bottom: 1px #dee2e6 solid">상세설명</h5>
                    <p style="padding: 1rem;">
                        ${bDto.sb_contents}
                    </p>
                </div>
                <div id="timer"></div>
                <div class="row">

                </div>
                <form action="/board/attend" method="post" class="bid_form">
                    <button class="btn btn-primary btn-color-thebora" type="button" onclick="marketCart()">찜하기</button>
                    <button type="button" class="btn btn-primary btn-color-thebora" onclick="buyApply()">구매신청</button>
                    <input type="hidden" name="sb_num" value="${bDto.sb_num}">
                    <input type="button" id="reset-button" class="btn btn-primary btn-color-thebora" value="삭제하기" onclick="deleteBtn()">
                    <input type="button" id="end-button" class="btn btn-primary btn-color-thebora" value="판매완료" onclick="endBtn(${bDto.sb_num})">
                </form>
            </div>
        </div>
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
            alert("본인의 상품은 찜 할 수 없습니다.")
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
