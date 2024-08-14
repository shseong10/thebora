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
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1.5.1/dist/sockjs.min.js"></script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main class="row w-75 mx-auto mb-5">
    <h1>채팅하기</h1>
    <div id="chatting-wrapper" class="row wrapper-border rounded-2">
        <div id="chat_left" class="col-4">
            <div class="row">
                <h5 style="border-bottom: #dee2e6 1px solid; margin-bottom: 0;">채팅목록</h5>
            </div>
                <c:if test="${empty chat}">
                    <div class="row">
                        <div class="col-12">
                            <h5>참여중인 채팅방이 없습니다.</h5>
                        </div>
                    </div>
                </c:if>
                <c:if test="${!empty chat}">
                    <c:forEach items="${chat}" var="critem">
                        <div class="row chat_name" onclick="chatRoom('${critem.c_sendid}','${critem.sellerId}','${critem.c_title}','${critem.sb_num}')">
                            <%-- 대화상대 --%>
                            <div class="col-6 pt-2">
                                <c:if test="${critem.c_sendid == userId}">
                                    <h5>${critem.sellerId}님</h5>
                                </c:if>
                                <c:if test="${critem.sellerId == userId}">
                                    <h5>${critem.c_sendid}님</h5>
                                </c:if>
                            </div>
                            <%-- 대화중인 상품 --%>
                            <div class="col-6 pt-2">
                                <h5>${critem.c_title}</h5>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>
        </div>
        <div id="chat_right" class="col-8">
            <div id="chat_contents">
                <h5>목록에서 채팅방을 선택해주세요.</h5>
            </div>
            <div id="chat_input_field">
                <input type="text" class="form-control me-2" name="c_contents" id="c_contents" placeholder="메시지 입력"/>
                <input type="button" class="btn btn-primary btn-color-thebora" id="sendButton" value="보내기" onclick="chatInsert()"/>
            </div>
        </div>
    </div>
</main>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    $(() => {
        console.log('${userId}');

    })

    function chatRoom(buyer, seller,title,num) {
        $.ajax({
            method: "post",
            url: "/board/chatRoom",
            data: {"c_sendid": buyer, "sellerId": seller, "c_title":title , "sb_num":num}
        }).done((resp) => {
            // console.log(resp);
            let chatList = ``;
            $.each(resp, function (i, chat) {
                chatList +=`<div>`+ chat.c_contents +`</div>`;
                chatList +=`<input id="sellerId" type="text" hidden="hidden" value="`+chat.sellerId+`"/>`
                chatList +=`<input id="c_title" type="text" hidden="hidden" value="`+chat.c_title+`"/>`
                chatList +=`<input id="c_sendid" type="text" hidden="hidden" value="`+chat.c_sendid+`"/>`
                chatList +=`<input id="sb_num" type="text" hidden="hidden" value="`+chat.sb_num+`"/>`
            })
            $('#chat_contents').html(chatList);
            $('#chat_contents').css("overflow-y", "scroll");
            $('#chat_contents').css("min-height", "15rem");
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
                "c_contents": $('#c_contents').val(),
                "sb_num": $('#sb_num').val()
            }
        }).done((resp) => {
            $('#chat_contents').append(`<div>`+'${userId}'+` : `+$('#c_contents').val()+`</div>`);
            // console.log(resp);
            //웹 소켓 관련 로직 추가
            if (socket) {
                let socketMsg = {"type": "chat", "buyer": $('#c_sendid').val(), "seller": $('#sellerId').val(), "msg":$('#c_contents').val(), "sb_num":$('#sb_num').val()};
                socket.send(JSON.stringify(socketMsg));
            }

            $('#c_contents').val('').focus();
            $("#chat_contents").scrollTop( $("#chat_contents").prop('scrollHeight'));

        }).fail(function (err) {
            console.log(err);
        })
    }

    $("#c_contents").keydown(function (e) {
        if (e.key === "Enter") { // Enter 키
            e.preventDefault(); // 기본 Enter 동작 방지
            $("#sendButton").click();


        }
    });

</script>
</body>
</html>
