<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
<head>
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        //주문하기 버튼을 클릭하면 js로 hidden form을 만들어서 전송
        function view_order () {
            const qty = document.getElementById('view_qty')

            const formObj = document.createElement("form")
            const item_num = document.createElement("input");
            const item_price = document.createElement("input");
            const order_count = document.createElement("input");
            const order_id = document.createElement("input");
            const sb_title = document.createElement("input");
            const bf_sysfilename = document.createElement("input");
            const m_name = document.createElement("input");
            const m_phone = document.createElement("input");
            const m_addr = document.createElement("input");

            item_num.name = "item_num";
            item_price.name = "item_price";
            order_count.name = "order_count";
            order_id.name = "order_id";
            sb_title.name = "sb_title";
            bf_sysfilename.name = "bf_sysfilename";
            m_name.name = "m_name";
            m_phone.name = "m_phone";
            m_addr.name = "m_addr";

            item_num.value = ${inventory.sb_num};
            item_price.value = ${inventory.sb_price};
            order_count.value = qty.value;
            order_id.value = "${profile.m_id}";
            sb_title.value = "${inventory.sb_title}";
            bf_sysfilename.value = "${inventory.ifList[0].bf_sysfilename}";
            m_name.value = "${profile.m_name}";
            m_phone.value = "${profile.m_phone}";
            m_addr.value = "${profile.m_addr}";

            formObj.appendChild(item_num);
            formObj.appendChild(item_price);
            formObj.appendChild(order_count);
            formObj.appendChild(order_id);
            formObj.appendChild(sb_title);
            formObj.appendChild(bf_sysfilename);
            formObj.appendChild(m_name);
            formObj.appendChild(m_phone);
            formObj.appendChild(m_addr);
            formObj.style.visibility = "hidden";

            document.body.appendChild(formObj);

            console.log("${profile.m_addr}")

            formObj.method = "post";
            formObj.action = "/hotdeal/order"
            formObj.submit();
        }

        window.onload = function () {
            console.log("${profile}")


            //이미지 슬라이더
            //컨트롤러로 가져온 데이터 중 파일리스트로 배열 생성
            const curFiles = new Array();
            <c:forEach items="${inventory.ifList}" var="item">
                curFiles.push({filename : '${item.bf_sysfilename}'});
            </c:forEach>

            //파일리스트 배열을 슬라이더 요소로 생성
            const carouselInner = document.getElementById('carousel-inner');

            for (const file of curFiles) {
                //슬라이더 div 생성
                const carouselItem = document.createElement('div');
                carouselItem.className = 'carousel-item';

                //슬라이더 이미지 생성
                const img = '/upload/' + file.filename;
                const carouselItemImg = document.createElement('img');
                carouselItemImg.className = 'd- block w-100'
                carouselItemImg.setAttribute('src', img);

                //생성된 슬라이더 div와 이미지를 문서 내에 추가
                carouselInner.appendChild(carouselItem);
                carouselItem.appendChild(carouselItemImg);
            }

            //추가된 슬라이더중 첫번째 슬라이더에만 클래스(.active)추가 - 부트스트랩 슬라이더 사용 조건
            document.querySelector('.carousel-item').classList.add('active');

        }
    </script>
    <style>
        .text-body-secondary img {
            max-width: 100% !important;
        }

        .carousel-control-btn {
            color: #ced4da;
            font-weight: bold;
            font-size: 2.5rem;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main>
    <div class="row w-75 mx-auto">
        <div class="col-9">
            <h1 class="">핫딜</h1>
        </div>
        <div class="col-3" style="text-align: right">
            <sec:authorize access="hasRole('admin')">
                <a href="/hotdeal/update_item?sb_num=${inventory.sb_num}" class="btn btn-warning" role="button" style="color: #333;">수정</a>
                <a href="/hotdeal/delete_item?sb_num=${inventory.sb_num}" class="btn btn-danger" role="button" style="color: #fff;">삭제</a>
            </sec:authorize>
            <button onclick="document.location='/hotdeal/list'" class="btn btn-primary btn-color-thebora" style="display: inline-block">목록으로</button>
        </div>
    </div>
    <div class="card mb-3 w-75 mx-auto">
        <div class="row g-0">
            <div class="col-md-4 carousel slide" id="carousel">
                <div class="carousel-inner rounded-2" id="carousel-inner">

                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carousel" data-bs-slide="prev">
                    <span class="carousel-control-btn" aria-hidden="true"><i class="bi bi-chevron-left"></i></span>
                    <span class="visually-hidden">이전</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carousel" data-bs-slide="next">
                    <span class="carousel-control-btn" aria-hidden="true"><i class="bi bi-chevron-right"></i></span>
                    <span class="visually-hidden">다음</span>
                </button>
            </div>
            <div class="col-md-8">
                <div class="card-body">
                    <h4 class="card-title">${inventory.sb_title}</h4>
                    <small class="text-body-secondary">${inventory.sb_category}</small>
                    <h5 class="card-text">${inventory.sb_price}원</h5>
                    <small class="text-body-secondary">${inventory.sb_date}</small>
                    <h5 class="card-title mt-5" style="border-bottom: 1px #dee2e6 solid">핫딜 판매 정보</h5>
                    <p class="card-text" style="padding: 1rem;">
                        <small class="text-body-secondary">구매 가능 레벨</small>
                            <c:if test="${inventory.sb_buylevel == 0}">
                                <b>제한 없음</b>
                            </c:if>
                            <c:if test="${inventory.sb_buylevel > 0}">
                                <b>${inventory.sb_buylevel}부터</b>
                            </c:if>
                            <c:if test="${profile.p_level >= inventory.sb_buylevel}">
                                <span class="main-item-category rounded-3 color-5">구매가 가능해요!</span>
                            </c:if>
                        <br>
                        <small class="text-body-secondary">판매 기간</small>
                            <c:if test="${inventory.sb_timer_str == null}">
                                <b>재고 소진시까지</b>
                            </c:if>
                            <c:if test="${inventory.sb_timer_str != null}">
                                <b>${inventory.sb_timer_str}까지</b>
                            </c:if>
                    </p>
                    <div class="row">
                        <div class="col-8">

                        </div>
                        <div class="col-4">
                            <div class="input-group">
                                <c:if test="${profile.p_level >= inventory.sb_buylevel}">
                                    <span class="input-group-text">수량 선택</span>
                                    <input type="number" class="form-control" name="view_qty" id="view_qty" placeholder="1" value="1">
                                    <span class="input-group-text">개</span>
                                    <button class="btn btn-primary btn-color-thebora" onclick="view_order()">주문하기</button>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="mt-3 p-2 w-75 mx-auto">
        <h2 style="border-bottom: 1px #dee2e6 solid;" class="mb-4">상세설명</h2>
        <div>
            ${inventory.sb_contents}
        </div>
    </div>
    <div class="d-grid gap-2 w-75 mb-3 mx-auto">
        <a href="/hotdeal/list" class="btn btn-primary btn-color-thebora" role="button">목록으로</a>
    </div>
</main>
</body>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</html>
