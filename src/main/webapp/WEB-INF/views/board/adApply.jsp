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
    <title>Title</title>
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
    <div class="card mb-3 w-75 mx-auto allDiv-box">

        <div class="row g-0">
            <div class="col-md-4">
                광고는 하루당 100포인트 입니다.

            </div>

            <div class="col-md-4">
                <div class="card-body">

                    <p class="card-text">
                        <select id="category" name="sb_num" class="product-category">
                            <option value="">게시글 목록</option>
                            <c:forEach var="List" items="${myList}">
                                <option value=${List.sb_num}>${List.sb_title}</option>
                            </c:forEach>
                        </select>
                    </p>

                    <p class="card-text">희망 기간
                        <select id="howLong"  name="sb_date">
                            <option value="1">1일</option>
                            <option value="2">2일</option>
                            <option value="3">3일</option>
                            <option value="4">4일</option>
                            <option value="5">5일</option>
                            <option value="6">6일</option>
                            <option value="7">7일</option>
                        </select>
                        <input id="m_point" name="m_point" type="text" readonly >P
                    </p>
                </div>
            </div>
        </div>
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
            $('.register-form').submit();
        }
    })

</script>



<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
