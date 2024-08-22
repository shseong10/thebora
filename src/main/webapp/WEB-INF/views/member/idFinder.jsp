<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 4.
  Time: 오후 3:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<div id="login_wrapper">
    <div id="login_logo">
    </div>
    <div id="login_input">
        <input type="text" class="form-control me-2" name="m_name" id="name" placeholder="이름"><br>
        <input type="text" class="form-control me-2" name="m_phone" id="phone" placeholder="전화번호"><br>
        <p id="id" hidden="hidden"></p>
        <button type="button" class="btn btn-primary btn-color-thebora" onclick="idFinder()">찾기</button>
        <ul class="login_finder">
            <li><a href="/member/pwFind">패스워드 찾기</a></li>
            <li><a href="/member/joindetail">회원가입</a></li>
        </ul>
    </div>
</div>
<script>
    function idFinder() {
        let name = document.getElementById("name");
        let phone = document.getElementById("phone");
        console.log(name.value);
        console.log(phone.value);

        if (name.value == "" || phone.value == "") {
            alert("이름 또는 전화번호를 적어주세요")


        } else {
            $.ajax({
                method: 'post',
                url: '/member/idFind',
                data: {"m_name": name.value, "m_phone": phone.value},

            }).done((resp) => {

                $('#id').html("ID : " + resp).removeAttr("hidden");
                console.log(resp)
            }).fail(function (err) {
                console.log(err)
            })
        }
    }

    $('#login_logo').click(()=>{
        location.href="/";
    })
</script>
</body>
</html>
