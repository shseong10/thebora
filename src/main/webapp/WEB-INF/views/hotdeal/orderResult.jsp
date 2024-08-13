<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main>
    <div style="width: 50%;" class="mx-auto">
        <h5>주문내역</h5>
        <div class="row g-3 wrapper-border rounded-2 mt-1 mb-3 p-2">
            <div class="col-12">
                <h5>배송지</h5>
            </div>
            <div class="col-md-6">
                <label class="form-label">이름</label>
                <p>${order.m_name}</p>
            </div>
            <div class="col-md-6">
                <label class="form-label">전화번호</label>
                <p>${order.m_phone}</p>
            </div>
            <div class="col-12">
                <label class="form-label">주소</label>
                <p>${order.m_addr}</p>
            </div>
        </div>

        <div class="row g-3 wrapper-border rounded-2 mt-1 mb-3 p-2">
            <div class="col-12">
                <h5>주문상품</h5>
            </div>
            <div class="col-md-4">
                <img src="/upload/${order.bf_sysfilename}" style="width: 100%;">
            </div>
            <div class="col-md-8">
                <b>${order.item_name}</b><br>
                상품설명<br>
                ${order.quantity}<br>
                <b>${order.total_amount}</b>
            </div>
            <div class="col-12">
                <div class="row">
                    <div class="col-8">
                        <h5>총 주문금액</h5>
                    </div>
                    <div class="col-4" style="text-align: right;">
                        <h5><span style="color: #712cf9;">${order.total_amount}</span>원</h5>
                    </div>
                </div>
            </div>
        </div>
        <div class="row g-3 wrapper-border rounded-2 mt-1 mb-3 p-2">
            <div class="col-12">
                <h5>결제수단</h5>
                <b>카카오페이</b><br>
                <b>결제완료</b>
            </div>
        </div>
        <div class="col-12">
            <button type="submit" class="btn btn-primary btn-color-thebora" style="width: 100%;">확인</button>
        </div>
    </div>
</main>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>