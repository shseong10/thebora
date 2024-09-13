<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 8.
  Time: 오후 6:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags"
           prefix="sec" %>
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
    $(() => {
        const msg = '${msg}'
        if (msg)

            alert('${msg}')

    })
</script>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<form action="/board/adApply" method="post" enctype="multipart/form-data" class="register-form">
    <h1 class="w-75 mx-auto">광고 신청</h1>
    <div class="card mb-3 p-3 w-75 mx-auto">
        <p class="card-text">
            하루에 100포인트의 비용으로 광고를 신청하실 수 있습니다. (최대 7일)<br>
            신청한 광고는 관리자 검토 후 승인되면 메인 화면에 게재됩니다.<br>
            광고 상품의 내용에 따라 광고 승인이 거절될 수 있습니다.
        </p>

        <p class="card-text">
        <h5>광고 신청 상품 선택</h5>
            <div style="width: 30%">
                <select id="category" name="sb_num" class="form-select">
                    <option value="">상품 목록</option>
                    <c:forEach var="List" items="${myList}">
                        <option value=${List.sb_num}>${List.sb_title}</option>
                    </c:forEach>
                </select>
            </div>
        </p>

        <p class="card-text" style="width: 3rem;">
            <h5>광고 게재 희망 기간</h5>
            기간 선택 시 포인트는 자동으로 계산됩니다.<br>

            <div class="row mb-3">
                <div class="col-4">
                    <div class="input-group">
                        <select id="howLong" name="sb_date" class="form-select">
                            <option value="">기간</option>
                            <option value="1">1일</option>
                            <option value="2">2일</option>
                            <option value="3">3일</option>
                            <option value="4">4일</option>
                            <option value="5">5일</option>
                            <option value="6">6일</option>
                            <option value="7">7일</option>
                        </select>
                        <label class="input-group-text" for="howLong">일</label>
                    </div>
                </div>
                <div class="col-4">
                    <div class="input-group">
                        <input class="form-control" id="m_point" name="m_point" type="text" readonly style="width: 3rem;">
                        <label class="input-group-text" for="m_point">포인트</label>
                    </div>
                </div>
            </div>

        </p>

    </div>
</form>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <button type="button" class="btn btn-primary btn-color-thebora" id="product-register">신청</button>
</div>

<script>
    $('#howLong').change(()=>{
       $('#m_point').val(100*$('#howLong').val())
    })
    $('#product-register').click(() => {
        if(confirm("정말로 신청 하시겠습니까?")){
            if( $('#m_point').val()!=='' && $("#category").val()!==''){
                $('.register-form').submit();
            }else{
                alert("게시글 또는 기간을 입력해주세요")
            }



        }
    })

</script>



<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
