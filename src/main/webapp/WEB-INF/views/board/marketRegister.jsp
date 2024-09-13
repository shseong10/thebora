<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 16.
  Time: 오후 12:11
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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<script>
    $(()=>{

        $('#product-register').click(()=>{

            let pattern = /^\d+$/;
            let category = $('.product-category').val()
            let title = $('.product-title').val()
            let count = $('#order_count').val()
            let price = $('.product-price').val()
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
            if(price === ""){
                alert("가격을 입력 해주세요")
                return;

            }if (!pattern.test(price)) {
                alert("가격은 숫자만 입력 해주세요")
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
<form action="/board/marketProductRegister" method="post" enctype="multipart/form-data" class="register-form">
    <h1 class="w-75 mx-auto">물품 등록</h1>
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
                가격
                <input type="text" name="sb_price" class="product-price form-control">
            </div>
            <div class="col-6">
                지역
                <select name="sb_local" id="local" class="product-local  form-select">
                    <option value="">지역선택</option>
                    <option value="서울">서울</option>
                    <option value="부산">부산</option>
                    <option value="대구">대구</option>
                    <option value="인천">인천</option>
                    <option value="광주">광주</option>
                    <option value="대전">대전</option>
                    <option value="울산">울산</option>
                    <option value="세종">세종</option>
                    <option value="경기">경기</option>
                    <option value="강원">강원</option>
                    <option value="충북">충북</option>
                    <option value="충남">충남</option>
                    <option value="전북">전북</option>
                    <option value="전남">전남</option>
                    <option value="경북">경북</option>
                    <option value="경남">경남</option>
                    <option value="제주">제주</option>
                </select>
            </div>
        </div>
        <div>
            상품설명
            <textarea name="sb_contents" id="product-detail" class="form-control"></textarea>
            <input type="text" id="order_count" name="sb_count" value="1" hidden="hidden">
        </div>

    </div>

</form>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <button type="button" class="btn btn-primary btn-color-thebora" id="product-register">물품등록</button>
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
