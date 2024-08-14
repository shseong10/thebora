<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 8.
  Time: 오후 2:54
  To change this template use File | Settings | File Templates.
--%>
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
</head>
<style>

    #product-detail {
        width: 450px;
        height: 500px;
        resize: none;
    }

    .allDiv-box {
        height: 600px;
    }


</style>
<script>
    $(() => {

        $('#product-register').click(() => {

            let pattern = /^\d+$/;
            let category = $('.product-category').val()
            let title = $('.product-title').val()
            let count = $('#order_count').val()
            let start = $('.product-startPrice').val()
            let price = $('.product-price').val()
            let bid = $('.product-bid').val()

            if (category === "") {
                alert("카테고리를 선택 해주세요")
                return;
            }
            if (title === "") {
                alert("상품명을 입력 해주세요")
                return;
            }
            if (count === "") {
                alert("수량을 입력 해주세요")
                return;

            }
            if (!pattern.test(count)) {
                alert("수량은 숫자만 입력 해주세요")
                return;
            }
            if (start === "") {
                alert("시작가를 입력 해주세요")
                return;

            }
            if (!pattern.test(start)) {
                alert("시작가는 숫자만 입력 해주세요")
                return;
            }
            if (price === "") {
                alert("즉시구매가를 입력 해주세요")
                return;

            }
            if (!pattern.test(price)) {
                alert("즉시구매가는 숫자만 입력 해주세요")
                return;
            }

            if (bid === "") {
                alert("입찰 최소단위를 입력 해주세요")
                return;
            }
            if (!pattern.test(bid)) {
                alert("입찰 최소단위는 숫자만 입력 해주세요")
                return;
            }

            if (confirm('물품을 등록하시겠습니까?')) {
                $('.register-form').submit();
            }
        })
    })
    //파일업로드 HTML요소 지정
    $(() => {
        const fileElem = document.getElementById('product-picture')
        fileElem.addEventListener('change', imgCreate, false);

        //파일업로드 내용이 바뀌면 다음 메소드를 실행
        function imgCreate() {
            const curFiles = fileElem.files; //파일업로드 요소의 파일 이름
            const preview = document.getElementById('preview'); //이미지 미리보기가 표시될 img요소 아이디 (예시:<img src="#" id="preview">)
            for (const file of curFiles) {
                //이미지 url 생성
                preview.src = URL.createObjectURL(file);
                preview.style.maxHeight = '500px';
                preview.style.maxWidth = '500px';
            }
        }

    })


</script>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<form action="/board/auctionApply" method="post" enctype="multipart/form-data" class="register-form">
    <h1 class="w-75 mx-auto">경매 신청</h1>
    <div class="card mb-3 w-75 mx-auto allDiv-box">

        <div class="row g-0">
            <div class="col-md-4">
                <label for="product-picture">
                    <img src="/img/product_upload.png" id="preview" class=" img-fluid rounded-start" alt="...">
                </label>
                <input type="file" id="product-picture" name="attachment" multiple hidden>
                <input type="text" class="upload-name" value="파일선택" readonly>
            </div>
            <div class="col-md-4">
                <div class="card-body">
                    <p class="card-text">상품설명</p>
                </div>
                <label for="product-detail"></label><textarea name="sb_contents" id="product-detail"></textarea>
            </div>
            <div class="col-md-4">
                <div class="card-body">
                    <p class="card-text">경매정보</p>
                    <p class="card-text"><select id="category" name="sb_category" class="product-category">
                        <option value="">카테고리</option>
                        <c:forEach var="cList" items="${cateList}">
                            <option value=${cList}>${cList}</option>
                        </c:forEach>
                    </select></p>

                    <p class="card-title">상품명 <input type="text" name="sb_title" class="product-title"></p>
                    <p class="card-text"><small class="text-body-secondary">수량 선택:<input type="text" id="order_count"
                                                                                         name="sb_count"
                                                                                         value="1">개</small></p>
                    <p class="card-text">희망 시작가 <input type="text" name="sb_startPrice" class="product-startPrice">원</p>
                    <p class="card-text">희망 입찰최소단위 <input type="text" name="sb_bid" class="product-bid">원</p>
                    <p class="card-text">희망 즉시구매가 <input type="text" name="sb_price" class="product-price">원</p>
                    <p class="card-text">희망 경매기간
                        <select name="sb_timer">
                            <option value="1">1일</option>
                            <option value="2">2일</option>
                            <option value="3">3일</option>
                            <option value="4">4일</option>
                            <option value="5">5일</option>
                            <option value="6">6일</option>
                            <option value="7">7일</option>
                        </select>
                        <input type="text" value="4" name="sb_saleKind" hidden="hidden">
                        <input type="text" value="1" name="sb_scope" hidden="hidden">
                        <input type="text" value="경매" name="sb_local" hidden="hidden">

                </div>
            </div>
        </div>

    </div>
</form>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <button type="button" class="btn btn-primary btn-color-thebora" id="product-register">물품등록</button>
    <a href="/board/auctionList" class="btn btn-primary btn-color-thebora" role="button">목록으로</a>
</div>
<script>

    $('#product-picture').on('change', function () {
        console.log($('#attachment'))
        let files = document.getElementById('product-picture').files
        console.log(files)

        let fileName = ''
        if (files.length > 1) {
            fileName = files[0].name + ' 외 ' + (files.length - 1) + '개';
        } else if (files.length == 1) {
            fileName = files[0].name;
        } else {
            fileName = "파일 선택";
        }
        $(".upload-name").val(fileName);
    })




</script>


<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
