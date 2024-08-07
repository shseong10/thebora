<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
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
<section>
    <div id="chatting-wrapper" class="row">
        <div id="chat_left" class="col-4">
            <div>
                <h5>채팅목록</h5>
            </div>
            <div class="row chat_name">
                <div class="col">대화상대</div>
                <div class="col">채팅방 이름</div>
            </div>
            <div class="row chat_name">
                <c:if test="${empty chat}">
                    <div>
                        <h5>참여중인 채팅방이 없습니다.</h5>
                    </div>
                </c:if>
                <c:if test="${!empty chat}">
                    <c:forEach items="${chat}" var="critem">
                        <div class="col" onclick="chatRoom('${critem.c_sendid}','${critem.sellerId}')">
                            <c:if test="${critem.c_sendid == userId}">
                                ${critem.sellerId}
                            </c:if>
                            <c:if test="${critem.sellerId == userId}">
                                ${critem.c_sendid}
                            </c:if>
                        </div>
                        <div class="col">
                            ${critem.c_title}
                        </div>
                    </c:forEach>
                </c:if>
            </div>
        </div>
        <div id="chat_right" class="col-8">
            <div>
                <h5>채팅하기</h5>
            </div>
            <div id="chat_contents">
                <h5>목록에서 채팅방을 선택해주세요.</h5>
            </div>
            <div id="chat_input_field">
                <input type="text" class="form-control me-2" name="c_contents" id="c_contents" placeholder="메시지 입력"/>
                <input type="button" class="btn btn-primary btn-color-thebora" value="보내기" onclick="chatInsert()"/>
            </div>
        </div>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    $(() => {
        console.log('${userId}');

    })

    function chatRoom(buyer, seller) {
        $.ajax({
            method: "post",
            url: "/board/chatRoom",
            data: {"c_sendid": buyer, "sellerId": seller}
        }).done((resp) => {
            console.log(resp);
            let chatList = ``;
            $.each(resp, function (i, chat) {
                chatList +=`<div>`+ chat.c_contents +`</div>`;
                chatList +=`<input id="sellerId" type="text" hidden="hidden" value="`+chat.sellerId+`"/>`
                chatList +=`<input id="c_title" type="text" hidden="hidden" value="`+chat.c_title+`"/>`
                chatList +=`<input id="c_sendid" type="text" hidden="hidden" value="`+chat.c_sendid+`"/>`
            })
            $('#chat_contents').html(chatList);
            $('#chat_contents').css("overflow-y", "scroll");
            $('#chat_input_field').css("visibility", "visible");


        }).fail((err) => {
            console.log("에러원인:" + err);
        })
    }


    function chatInsert() {
        $.ajax({
            method: "post",
            url: "/board/chatInsert",
            data: {
                "c_title": $('#c_title').val(),
                "c_sendid": $('#c_sendid').val(),
                "sellerId": $('#sellerId').val(),
                "c_contents": $('#c_contents').val()
            }
        }).done((resp) => {
            console.log(resp);
            //웹 소켓 관련 로직 추가
            if (socket) {
                let socketMsg = {"type": "chat", "buyer": $('#c_sendid').val(), "seller": $('#seller').val(), "msg":$('#c_contents').val()};
                socket.send(JSON.stringify(socketMsg));
            }

            $('#c_contents').val('').focus();


        }).fail(function (err) {
            console.log(err);
        })
    }

    let websocket = null;
    $(document).ready(function () {
        //소켓 연결
        webConnectWs();
    });

    function webConnectWs() {
        //WebSocketConfig에서 설정한 endPoint("/push")로 연결
        const ws = new SockJS("/push");
        websocket = ws;

        ws.onopen = function () {
            console.log('open');
        };

        ws.onmessage = function (event) {
            try {
                const result = JSON.parse(event.data);
                console.log(result);
                if (result.type === "chat") {
                    $('#chat_contents').append(result.value);
                }

            } catch (e) {
                console.error("에러원인", e);
            }

        };

        ws.onclose = function () {
            console.log('close');
        };

    }
</script>
</body>
</html>
