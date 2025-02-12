<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.5.1/dist/sockjs.min.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div class="w-75 mt-3 mx-auto">
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid">
            <a class="navbar-brand" href="/">
                <img src="/img/logo.png" style="width: 150px;">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul id="main_nav" class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/board/marketList">중고거래</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/board/auctionList">중고경매</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/hotdeal/list">핫딜</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link display-4" href="/notice/list">공지사항</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle display-4" href="#" role="button" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            고객지원
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="/question/list">자주묻는질문</a></li>
                            <li><a class="dropdown-item" href="/report/list">문의하기</a></li>
                            <li><a class="dropdown-item" href="/board/auctionApply">경매 신청하기</a></li>
                            <li><a class="dropdown-item" href="/board/adApply">광고 신청하기</a></li>
                            <li><a class="dropdown-item" href="/member/pointCharge">포인트 충전</a></li>
                            <li><a class="dropdown-item" href="/member/pointExchange">포인트 환전</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                    <input id="header-keyWord" class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
                    <button class="btn btn-primary btn-color-thebora" type="button" id="button_search"><i
                            class="bi bi-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </nav>
    <div class="d-flex justify-content-end">
        <div class="d-flex">
            <ul class="nav nav-pills" id="user-nav">
                <li class="nav-item">
                    <sec:authorize access="isAnonymous()">
                        <a class="nav-link" href="/member/login">로그인</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAnonymous()">
                        <a class="nav-link" href="/member/joindetail">회원가입</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link disabled" aria-disabled="true"><sec:authentication property="name"/>님</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAuthenticated()">
                        <a href="#" class="nav-link" onclick="btn_logout()">로그아웃</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" aria-current="page" href="/member/myPage">마이페이지</a>
                    </sec:authorize>
                </li>
                <li class="nav-item">
                    <sec:authorize access="hasRole('admin')">
                        <a class="nav-link" aria-current="page" href="/member/admin">관리자페이지</a>
                    </sec:authorize>
                </li>
                <li class="nav-item position-relative">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" aria-expanded="false" href="/member/attendance">출석체크</a>
                    </sec:authorize>
                </li>
                <li class="nav-item position-relative" id="set-chat-badge">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" href="/member/chat" id="chatAlert" aria-expanded="false" onclick="chat()">채팅</a>
                    </sec:authorize>
                </li>
                <li class="nav-item position-relative" id="set-alert-badge">
                    <sec:authorize access="isAuthenticated()">
                        <a class="nav-link" href="#" onclick="alertInfo()" data-bs-toggle="dropdown" aria-expanded="false">알림<i class="bi bi-bell"></i></a>
                        <div id="alertBtn" class="dropdown-menu p-1">
                            <%-- 드롭다운 알림 목록 표시 부분 --%>
                        </div>
                    </sec:authorize>
                </li>
            </ul>
        </div>
    </div>
    <div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3">
        <%--        알람--%>
    </div>
</div>
<div id="main_banner" class="mx-auto mb-5">
    <img src="/img/event_banner.png" style="height: 100%">
</div>
<script>
    const userId = '<sec:authentication property="name"/>';


    function alertDel(sb_num) {
        $.ajax({
            method: "post",
            data: {"sb_num": sb_num, "sb_id": userId},
            url: "/board/alertDel",
        }).done((resp) => {

        }).fail((err) => {
            console.log("에러원인:" + err)
        })
    }

    function chat(){
        localStorage.removeItem("chatNewItem");
    }

    function alertInfo() {
        $.ajax({
            method: "post",
            data: {"sb_id": userId},
            url: "/board/alertInfo",
        }).done((resp) => {
            $('#newIcon').hide();
            localStorage.removeItem("newItem");
            let alertList = ``;
            $.each(resp, function (i, aList) {
                console.log(aList.msg)
                alertList +=
                    aList.msg + `<hr>`;
            })
            $('#alertBtn').html(alertList);

        }).fail((err) => {
            console.log("에러원인:" + err)
        })
    }

    // 전체검색
    $("#button_search").click(function () {
        let keyWord = $("#header-keyWord").val();
        if (keyWord === "") {
            alert("검색어를 입력하세요.");
            return;
        }
        location.href = "/board/allList?&keyWord=" + keyWord + "&pageNum=1";
    })

    $("#header-keyWord").keydown(function (e) {
        if (e.key === "Enter") { // Enter 키
            e.preventDefault(); // 기본 Enter 동작 방지
            $("#button_search").click();
        }
    });

    function btn_logout() {

        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = "/member/logout";
        }

    }

    let socket = null;
    $(document).ready(function () {
        //소켓 연결
        connectWs();
        $('#set-alert-badge').append(localStorage.getItem("newItem"))
        $('#set-chat-badge').append(localStorage.getItem("chatNewItem"))
    });

    function connectWs() {
        //WebSocketConfig에서 설정한 endPoint("/push")로 연결
        const ws = new SockJS("/push");
        socket = ws;

        ws.onopen = function () {
            console.log('open');
        };

        ws.onmessage = function (event) {

            try {
                const result = JSON.parse(event.data);
                if(result.type ==="reject"){
                    $('#toastContainer').append(result.contents);
                    localStorage.setItem("newItem", "<span id='newIcon' class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger'>NEW</span>");
                    $('#set-alert-badge').append(localStorage.getItem("newItem"))
                    const toastElements = document.querySelectorAll('.choose');
                    toastElements.forEach((toastElement) => {
                        const toastBootstrap = new bootstrap.Toast(toastElement);
                        toastBootstrap.show();
                    });
                }
                else
                if (result.type === "price") {
                    $('#np').html(result.value);
                }else
                if (result.type === "buyer") {
                    $('#buyer').html("현재 입찰 예정자 : " + result.name);
                }else
                if (result.type === "chat") {
                    $('#chat_contents').append(result.value);
                    $("#chat_contents").scrollTop( $("#chat_contents").prop('scrollHeight'));
                }else
                if(result.type ==="chatAlert"){
                    $('#toastContainer').append(result.contents);
                    localStorage.setItem("chatNewItem", "<span id='newIcon' class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger'>NEW</span>");
                    $('#set-chat-badge').append(localStorage.getItem("chatNewItem"))
                    const toastElements = document.querySelectorAll('.choose');
                    toastElements.forEach((toastElement) => {
                        const toastBootstrap = new bootstrap.Toast(toastElement);
                        toastBootstrap.show();
                    });
                }else{
                    $('#toastContainer').append(result.contents);
                    localStorage.setItem("newItem", "<span id='newIcon' class='position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger'>NEW</span>");
                    $('#set-alert-badge').append(localStorage.getItem("newItem"))
                    const toastElements = document.querySelectorAll('.choose');
                    toastElements.forEach((toastElement) => {
                        const toastBootstrap = new bootstrap.Toast(toastElement);
                        toastBootstrap.show();
                    });
                }


            } catch (e) {
                console.error("에러원인", e);
            }


        };

        ws.onclose = function () {
            console.log('close');
        };

    }

    // function alertbtn(){
    //
    // }

</script>
</body>
</html>