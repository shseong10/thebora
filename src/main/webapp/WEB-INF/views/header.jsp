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
<header class="w-75 mt-3 mb-5 mx-auto">
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
                            <li><a class="dropdown-item" href="#">자주묻는질문</a></li>
                            <li><a class="dropdown-item" href="/report/list">문의하기</a></li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li><a class="dropdown-item" href="#">Something else here</a></li>
                        </ul>
                    </li>
                </ul>
                <form class="d-flex" role="search">
                    <input class="form-control me-2" type="search" placeholder="검색" aria-label="Search">
                    <button class="btn btn-primary btn-color-thebora" type="submit" id="button_search"><i class="bi bi-search"></i>
                    </button>
                </form>
            </div>
        </div>
    </nav>
    <div class="d-flex justify-content-end">
        <div class="d-flex">
            <ul class="nav nav-pills">
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
                        <button class="nav-link" onclick="btn_logout()">로그아웃</button>
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
                <li class="nav-item dropdown">
                    <div class="notification-target">
                        <sec:authorize access="isAuthenticated()">
                            <a class="nav-link" aria-expanded="false" href="/member/attendance">출석체크</a>
                        </sec:authorize>
<%--                        <span class="notification-badge">NEW</span>--%>
                    </div>
                </li>
                <li class="nav-item">
                    <div class="notification-target">
                        <sec:authorize access="isAuthenticated()">
                            <div class="nav-link">
                                <a href="/member/chat" aria-expanded="false">채팅</a>
                            </div>
                        </sec:authorize>
<%--                        <span class="notification-badge">NEW</span>--%>
                    </div>
                </li>
                <li class="nav-item">
                    <div class="notification-target">
                        <sec:authorize access="isAuthenticated()">
                            <div class="dropdown nav-link">
                                <a href="#" data-bs-toggle="dropdown" aria-expanded="false" onclick="alertInfo()">알림</a>
                                <a id="alertLink" type="button" data-bs-toggle="dropdown" aria-expanded="false"
                                   onclick="alertInfo()">
                                    <i class="bi bi-bell"></i>
                                </a>
                                <ul id="alertBtn" class="dropdown-menu">
                                </ul>
                            </div>
                        </sec:authorize>
<%--                        <span class="notification-badge">NEW</span>--%>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div id="toastContainer" class="toast-container position-fixed bottom-0 end-0 p-3">
        <%--        알람--%>
    </div>
</header>
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
                    `<hr>` +
                    aList.msg
            })
            $('#alertBtn').html(alertList);

        }).fail((err) => {
            console.log("에러원인:" + err)
        })
    }


    $("#header-search").click(function () {
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
            $("#header-search").click();
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
        $('#alertLink').append(localStorage.getItem("newItem"))
    });

    function connectWs() {
        //WebSocketConfig에서 설정한 endPoint("/push")로 연결
        const ws = new SockJS("/push");
        socket = ws;

        ws.onopen = function () {
            console.log('open');
        };

        ws.onmessage = function (event) {

            $('#toastContainer').append(event.data);
            localStorage.setItem("newItem","<span id='newIcon' class='notification-badge'>NEW</span>");
            $('#alertLink').append(localStorage.getItem("newItem"))

            const toastElements = document.querySelectorAll('.choose');
            toastElements.forEach((toastElement) => {
                const toastBootstrap = new bootstrap.Toast(toastElement);
                toastBootstrap.show();
            });



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