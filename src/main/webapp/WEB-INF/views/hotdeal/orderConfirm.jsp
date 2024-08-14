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
    <script>
        $(function(){
            $("#hotdeal-payment").click(function (){
                //카카오페이 결제 API 필수값
                const itemName = "${order.sb_title}";
                const totalPrice = ${order.order_count*order.item_price};
                const totalQty = ${order.order_count};

                //서비스 DB 저장을 위한 필수값
                const userId = "${order.order_id}";
                const name = "${order.m_name}";
                const phone = "${order.m_phone}";
                const addr = "${order.m_addr}";
                const itemNum = "${order.item_num}";
                const filename = "${order.bf_sysfilename}";

                let data = {
                    //카카오페이 결제 API 필수값
                    item_name: itemName,
                    total_amount: totalPrice,
                    quantity: totalQty,

                    //서비스 DB 저장을 위한 필수값
                    order_id: userId,
                    m_name: name,
                    m_phone: phone,
                    m_addr: addr,
                    item_num: itemNum,
                    bf_sysfilename: filename
                }

                //ajax로 api에 데이터 전송
                $.ajax({
                    type: 'POST',
                    url: '/hotdeal/order/pay/ready',
                    data: JSON.stringify(data),
                    contentType: 'application/json',
                    success:function (response) {
                        location.href = response.next_redirect_pc_url;
                    }
                })
            })
        })
    </script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
    <main>
        <div style="width: 50%;" class="mx-auto">
            <h5>주문/결제</h5>
            <div class="row g-3 wrapper-border rounded-2 mt-1 mb-3 p-2">
                <div class="col-12">
                    <h5>배송지</h5>
                </div>
                <div class="col-md-6">
                    <label for="inputName" class="form-label">이름</label>
                    <input type="text" class="form-control" id="inputName" value="${order.m_name}">
                </div>
                <div class="col-md-6">
                    <label for="inputTel" class="form-label">전화번호</label>
                    <input type="text" class="form-control" id="inputTel" value="${order.m_phone}">
                </div>
                <div class="col-md-10">
                    <label for="inputAddress" class="form-label">주소</label>
                    <input type="text" class="form-control" id="inputAddress" value="${order.m_addr}">
                </div>
                <div class="col-md-2">
                    <label for="searchAddress" class="form-label">&nbsp;</label><br>
                    <button type="button" onclick="execDaumPostcode()" class="btn btn-primary btn-findAddress btn-color-thebora">주소 검색</button>
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
                    <b>${order.sb_title}</b><br>
                    <b>${order.item_price}원</b><br>
                    ${order.order_count}개<br>
                </div>
                <div class="col-12 mb-3">
                    <div class="row">
                        <div class="col-8">
                            <h5>총 주문금액</h5>
                        </div>
                        <div class="col-4" style="text-align: right;">
                            <h5><span style="color: #712cf9;">${order.order_count*order.item_price}</span>원</h5>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row g-3 wrapper-border rounded-2 mt-1 mb-3 p-2">
                <div class="col-12 mb-3">
                    <h5>결제수단</h5>
                </div>
<%--                <fieldset>--%>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" id="gridRadios1" value="option1" checked>
                        <label class="form-check-label" for="gridRadios1">
                            카카오페이
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" id="gridRadios2" value="option2">
                        <label class="form-check-label" for="gridRadios2">
                            무통장입금
                        </label>
                    </div>
<%--                </fieldset>--%>
            </div>
            <div class="col-12">
                <button type="submit" class="btn btn-primary btn-color-thebora" style="width: 100%;" id="hotdeal-payment">결제하기</button>
            </div>
        </div>
    </main>
</body>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</html>