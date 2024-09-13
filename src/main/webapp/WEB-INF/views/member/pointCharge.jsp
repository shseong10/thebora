<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 12.
  Time: 오후 7:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<form action="/member/order" method="post" enctype="multipart/form-data" id="chargePoint">
    <h1 class="w-75 mx-auto">포인트 충전</h1>
    <div class="card mb-3 p-3 w-75 mx-auto">
        <p>1포인트에 1원의 비용으로 포인트를 충전하실 수 있습니다.</p>

        <div class="row mb-3">
            <div class="col-3">
                <div class="input-group mb-3">
                    <select id="category" class="form-select">
                        <option value="">충전할 포인트 선택</option>
                        <option value="1000">1000</option>
                        <option value="2000">2000</option>
                        <option value="5000">5000</option>
                        <option value="10000">10000</option>
                        <option value="20000">20000</option>
                        <option value="50000">50000</option>
                        <option value="100000">100000</option>
                    </select>
                </div>
            </div>
            <div class="col-2" style="text-align: center">
                또는
            </div>
            <div class="col-5">
                <div class="input-group mb-3">
                    <input id="m_point" name="item_price" type="text" placeholder="직접 입력" class="form-control">
                    <label class="input-group-text" for="m_point">포인트</label>
                </div>
            </div>
        </div>
    </div>
</form>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <button type="button" class="btn btn-primary btn-color-thebora" id="charge" onclick="charge()">충전하기</button>
</div>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>

<script>
    $('#category').change(()=>{
        $("#m_point").val($('#category').val());
    })

    let pattern = /^\d+$/;
    function charge(){
        let point = $('#m_point').val()
        if(point  === '') {
            alert("충전할 포인트를 입력해주세요");
        }else if(!pattern.test(point)){
            alert("숫자만 입력해주세요");
        }else {
            $('#chargePoint').submit();
        }
    }

</script>
</body>
</html>
