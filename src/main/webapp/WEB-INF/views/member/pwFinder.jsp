<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
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
        <a href="/"></a>
    </div>
    <div id="login_input">
        <input type="text" class="form-control me-2" name="m_id" id="id" placeholder="아이디"><br>
        <input type="text" class="form-control me-2" name="m_name" id="name" placeholder="이름"><br>
        <input type="text" class="form-control me-2" name="m_phone" id="phone" placeholder="전화번호"><br>
        <button type="button" class="btn btn-primary btn-color-thebora" onclick="pwFinder()">찾기</button>
        <ul class="login_finder">
            <li><a href="/member/idFind">아이디 찾기</a></li>
            <li><a href="/member/login">로그인</a></li>
            <li><a href="/member/joindetail">회원가입</a></li>
        </ul>
    </div>

    <div>
        <div id="new_pw" hidden="hidden">
            <form action="/member/pwChange" method="post">
                <input type="text" class="form-control me-2" name="m_id" placeholder="아이디"><br>
                <input type="password" class="form-control me-2" name="m_pw" id="pw" placeholder="새로운 패스워드">
                <input type="password" class="form-control me-2" id="re-pw" placeholder="패스워드 확인">
                <span class="pw-confirm"></span>
                <button class="btn btn-primary btn-color-thebora">변경</button>
                <ul class="login_finder">
                    <li><a href="/member/login">로그인</a></li>
                    <li><a href="/member/joindetail">회원가입</a></li>
                </ul>
            </form>
        </div>
    </div>
</div>
<script>
    $('#re-pw').on('input',()=>{
        if($('#re-pw').val()!==$('#pw').val()){
            $('.pw-confirm').html("일치하지 않습니다.").css({'font-size':'12px', 'color':'red'})
        }else{
            $('.pw-confirm').html("일치합니다.").css({'font-size':'12px', 'color':'green'})
        }
    })

    function pwFinder() {
        let name = document.getElementById("name");
        let phone = document.getElementById("phone");


        if (name.value == "" || phone.value == "" || $('#id').val() == "") {
            alert("아이디, 이름 또는 전화번호를 적어주세요")


        } else {
            $.ajax({
                method: 'post',
                url: '/member/pwFind',
                data: {"m_id": $('#id').val(), "m_name": name.value, "m_phone": phone.value},

            }).done((resp) => {
                    if (resp) {
                    $('#new_pw').removeAttr("hidden");
                    console.log(resp)
                    $('#login_input').hide();

                }
            }).fail(function (err) {
                console.log(err)
            })

        }


    }
</script>
</body>
</html>
