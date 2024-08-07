<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 29.
  Time: 오후 4:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <script
            src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous">
    </script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
</head>
<style>
    .chatting {
        width: 900px;
        height: 500px;
        display: flex;
        margin: auto;
    }

    .chatList {
        text-align: center;
        overflow: scroll;
    }

</style>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <div class="chatting">
        <div class="chatList">

            <table class="table table-striped" style="width: 350px">
                <tr>
                    <th colspan="2" style="text-align: center">채팅목록</th>
                </tr>
                <tr style="text-align: center">
                    <th>상대</th>
                    <th>채팅방 제목</th>
                </tr>
                <c:if test="${empty chat}">
                    <tr style="height: 400px">
                        <td colspan="2">참여 중인 채팅방이 없습니다.</td>
                    </tr>
                </c:if>
                <c:if test="${!empty chat}">
                    <c:forEach items="${chat}" var="critem">
                        <tr class="crList" style="text-align: center" >
                            <td><a type="button" onclick="chatRoom('${critem.c_sendid}','${critem.sellerId}')">
                                <c:if test="${critem.c_sendid == userId}">
                                    ${critem.sellerId}
                                </c:if>
                                <c:if test="${critem.sellerId == userId}">
                                    ${critem.c_sendid}
                                </c:if>
                            </a>
                            </td>
                            <td><a type="button"
                            >${critem.c_title}</a>
                            </td>
                        </tr>
                    </c:forEach>
                </c:if>
            </table>
        </div>
        <div class="chattingRoom">
            <table class="table table-dark table-striped" id="chatting" style="width: 550px">
                <tr>
                    <th colspan="2" style="text-align: center">채팅내역</th>
                </tr>
                <tr style="height: 394px">
                    <td id="chat_contents" colspan="2">
                    </td>

                </tr>
                <tr>
                    <td>

                        <input type="text" name="c_contents" id="c_contents" style="width: 350px"
                               placeholder="상대에게 보낼 내용을 입력하세요."/>
                    </td>
                    <td><input type="button" value="보내기" onclick="chatInsert()"/></td>
                </tr>
            </table>
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
</script>
</body>
</html>
