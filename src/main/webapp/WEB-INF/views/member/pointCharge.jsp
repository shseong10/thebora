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
    <title>Title</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<form action="" method="post" enctype="multipart/form-data" id="chargePoint">
    <h1 class="w-75 mx-auto">포인트 충전</h1>
    <div class="card mb-3 w-75 mx-auto allDiv-box">

        <div class="row g-0">
            <div class="col-md-4">
            포인트는 1P에 1원입니다.

            </div>

            <div class="col-md-4">
                <div class="card-body">

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
    <button type="button" class="btn btn-primary btn-color-thebora" id="charge" onclick="charge()">충전</button>
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
