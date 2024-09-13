<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 9.
  Time: 오전 10:48
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
<script>
    $(()=>{

        $('#product-register').click(()=>{

            let pattern = /^\d+$/;
            let category = $('.product-category').val()
            let title = $('.product-title').val()
            let count = $('#order_count').val()
            let start = $('.product-startPrice').val()
            let price = $('.product-price').val()
            let endTime = $('#myDatetime').val()
            let bid = $('.product-bid').val()
            let local = $('.product-local').val()

            if (category ===""){
                alert("카테고리를 선택 해주세요")
                return;
            }
            if (title ===""){
                alert("상품명을 입력 해주세요")
                return;
            }
            if(count === ""){
                alert("수량을 입력 해주세요")
                return;

            }if (!pattern.test(count)) {
                alert("수량은 숫자만 입력 해주세요")
                return;
            }
            if(start === ""){
                alert("시작가를 입력 해주세요")
                return;

            }if (!pattern.test(start)) {
                alert("시작가는 숫자만 입력 해주세요")
                return;
            }
            if(price === ""){
                alert("즉시구매가를 입력 해주세요")
                return;

            }if (!pattern.test(price)) {
                alert("즉시구매가는 숫자만 입력 해주세요")
                return;
            }
            if(endTime === ""){
                alert("종료시간을 입력 해주세요")
                return;

            }
            if (bid === ""){
                alert("입찰 최소단위를 입력 해주세요")
                return;
            }
            if (!pattern.test(bid)) {
                alert("입찰 최소단위는 숫자만 입력 해주세요")
                return;
            }
            if (local === ""){
                alert("지역을 선택 해주세요")
                return;
            }
            if(confirm('물품을 등록하시겠습니까?')){
                $('.register-form').submit();
            }
        })
    })
    //파일업로드 HTML요소 지정
    $(()=>{
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

<form action="/board/productRegister" method="post" enctype="multipart/form-data" class="register-form">
    <h1 class="w-75 mx-auto">경매 등록</h1>
    <div class="card mb-3 p-3 w-75 mx-auto">
        <div class="mb-3">
            <label for="product-picture" class="form-label">상품 이미지 (여러장 첨부 가능)</label>
            <input class="upload-name form-control" type="file" id="product-picture" name="attachment" multiple>
        </div>

        <div class="row mb-2">
            <div class="col-6">

                상품명
                <input type="text" name="sb_title" class="product-title form-control">
            </div>
            <div class="col-6">
                카테고리
                <select id="category" name="sb_category" class="product-category form-select">
                    <option value="">카테고리</option>
                    <c:forEach var="cList" items="${cateList}">
                        <option value=${cList}>${cList}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="row mb-2">
            <div class="col-6">
                시작가
                <input type="text" name="sb_startPrice" class="product-startPrice form-control">
            </div>
            <div class="col-6">
                입찰최소단위
                <input type="text" name="sb_bid" class="product-bid form-control">
            </div>
        </div>

        <div class="row mb-2">
            <div class="col-6">
                즉시구매가
                <input type="text" name="sb_price" class="product-price form-control">
            </div>
            <div class="col-6">
                종료시간
                <input type="datetime-local" id="myDatetime"  class="form-control myInput mt-1" placeholder="날짜를 선택하세요."  readonly="readonly"></p>
                <input type="text" name="sb_timer" id="sb_timer" hidden="hidden">
            </div>
        </div>

        <div>
            상품설명
            <textarea name="sb_contents" id="product-detail" class="form-control"></textarea>
            <input type="text" id="order_count" name="sb_count" value="1" hidden="hidden">
            <input type="text" value="4" name="sb_saleKind" hidden="hidden">
            <input type="text" value="1" name="sb_scope" hidden="hidden">
            <input type="text" value="경매" name="sb_local" hidden="hidden">
        </div>


    </div>
</form>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <button type="button" class="btn btn-primary btn-color-thebora" id="product-register">물품등록</button>
</div>
<script>
    const datetimeInput = document.getElementById('myDatetime');

    datetimeInput.addEventListener('change', function () {

        // const datetimeValue = this.value; // 현재 입력된 값
        // 이 값에 대해 필요한 처리 (예: 특정 형식으로 변경)
        // 예시: ISO 8601 형식 (24시간 형식)으로 변환
        // const isoDatetime = new Date(datetimeValue).toISOString().slice(0, 16); // 초 단위는 생략
        // this.value = isoDatetime;
        console.log(datetimeInput.value);
    });

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
    // const now = new Date();
    // const oneHourLater = new Date(now.getTime() + 60 * 60 * 1000);
    const myInput = document.querySelector(".myInput");
    const fp = flatpickr(myInput, {
        enableTime: true,
        dateFormat: "Y-m-d H:i",
        "locale": "ko",
        minDate: new Date().fp_incr(0) ,
        minTime: "12:00",
        maxDate: new Date().fp_incr(7) // 7 days from now

    });

    //달력에서 선택한 날짜를 전송용 필드에 입력하게 함
    fp.config.onChange.push(function (selectedDates, dateStr, fp) {
        const date = new Date(dateStr);
        const isoDatetime = new Date(date.getTime() - (date.getTimezoneOffset() * 60000)).toISOString().slice(0, 16);
        document.getElementById('sb_timer').value = isoDatetime;
    })

</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
