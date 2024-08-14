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
<script>
    const msg = '${msg}';
    if (msg !== '') {
        alert(msg);
    }
</script>

<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<form action="/member/pointExchange" method="post" enctype="multipart/form-data" id="chargePoint">
    <h1 class="w-75 mx-auto">포인트 환전</h1>
    <div class="card mb-3 w-75 mx-auto allDiv-box">

        <div class="row g-0">
            <div class="col-md-4">
            포인트는 1P에 1원입니다.
                <p></p>
            환전 수수료는 5% 입니다.

            </div>

            <div class="col-md-4">
                <div class="card-body">
                    <p class="card-text"> 보유 포인트 : ${point}</p>


                    계좌번호
                    <p class="card-text">
                        <select id="bank" name="m_bank" class="product-category">
                            <option value="">은행</option>
                            <option value="농협">농협</option>
                            <option value="신한">신한</option>
                            <option value="우리">우리</option>
                            <option value="국민">국민</option>
                            <option value="하나">하나</option>
                            <option value="대구">대구</option>
                            <option value="기업">기업</option>
                        </select>
                    <input id="m_account" name="m_bankNum" type="text">
                    </p>
                    <p class="card-text">
                        <select id="category" class="product-category">
                            <option value="">직접입력</option>
                            <option value="1000">1000</option>
                            <option value="2000">2000</option>
                            <option value="5000">5000</option>
                            <option value="10000">10000</option>
                            <option value="20000">20000</option>
                            <option value="50000">50000</option>
                            <option value="100000">100000</option>
                        </select>
                    </p>

                        <input id="m_point" name="m_point" type="text">P

                </div>
            </div>
        </div>
    </div>
</form>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <button type="button" class="btn btn-primary btn-color-thebora" id="charge" onclick="charge()">환전하기</button>
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
        if($('#bank').val()===''){
            alert("환전받을 은행 입력해주세요");
            return
        }
        if($('#m_account').val()===''){
            alert("환전받을 계좌번호 입력해주세요");
            return
        }

        if(point  === '') {
            alert("환전할 포인트를 입력해주세요");
        }else if(!pattern.test(point)){
            alert("숫자만 입력해주세요");
        }else {
            if(confirm("환전하시겠습니까?")){
                $('#chargePoint').submit();
            }
        }
    }

</script>
</body>
</html>
