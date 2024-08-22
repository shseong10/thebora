<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link rel="stylesheet" href="/css/style.css">
    <script>
        const msg = '${msg}';
        if (msg !== '')
            alert(msg);
    </script>
</head>
<body>
<div id="login_wrapper">
    <div id="login_logo">
        <a href="/"></a>
    </div>
    <div id="login_input">
        <form action="/member/login" method="post">
            <input type="text" class="form-control me-2" id="id" name="username" placeholder="아이디"><br>
            <input type="password" class="form-control me-2" id="pw" name="password" placeholder="패스워드"><br>
            <input type="checkbox" class="form-check-input" type="checkbox"> 아이디 저장<br>
            <button type="submit" class="btn btn-primary btn-color-thebora" onclick="login()">로그인</button>
        </form>
    </div>
    <ul class="login_finder">
        <li><a href="/member/idFind">아이디 찾기</a></li>
        <li><a href="/member/pwFind">패스워드 찾기</a></li>
        <li><a href="/member/joindetail">회원가입</a></li>
    </ul>
</div>

<!-- csrf설정시, 비동기 통신은 https://determination.tistory.com/entry/스프링-시큐리티Spring-Security-CSRF-설정AJAX-POST-FORM -->
<!--<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">-->
</form>

<script>
    $(document).ready(function() {
        // 페이지가 로드될 때 저장된 아이디를 로드합니다.
        let savedUsername = localStorage.getItem('savedUsername');
        if (savedUsername) {
            $('#id').val(savedUsername);
            $('#id_save').prop('checked', true);
        }
    });

    function login() {
        let username = $('#id').val();
        let rememberMe = $('#id_save').is(':checked');

        if (rememberMe) {
            // 아이디를 로컬 저장소에 저장합니다.
            localStorage.setItem('savedUsername', username);
        } else {
            // 로컬 저장소에서 아이디를 제거합니다.
            localStorage.removeItem('savedUsername');
        }

        // 여기에 로그인 요청을 서버로 보내는 코드를 추가합니다.
        // 예: $.post('/login', { username: username, password: password }, function(response) { ... });

        // alert('로그인 시도: ' + username);
    }
    $('#login_logo').click(()=>{
        location.href="/";
    })
</script>
</body>
</html>