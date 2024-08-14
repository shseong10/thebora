<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 7. 8.
  Time: 오전 8:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>더보라</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .profile-update {
            display: flex;
            justify-content: center;
            margin: 10px;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main class="row w-75 mx-auto mb-5">
    <div class="info-title">
        <h1>마이페이지</h1>
    </div>
    <section id="my-info" class="col-3">
        <div class="position-relative">
            <div id="my-info-img" class="color-1 rounded-2" data-bs-toggle="modal" data-bs-target="#profile-up">
                이미지 업로드
            </div>
            <c:if test="${empty profile.pf_oriFileName}">
                <img src="/upload/프사없음.jfif" class="card-img-top profile-picture" data-bs-toggle="modal" data-bs-target="#profile-up" style="cursor: pointer">
            </c:if>
            <c:if test="${!empty profile.pf_oriFileName}">
                <img src="/upload/${profile.pf_sysFileName}" class="card-img-top profile-picture" data-bs-toggle="modal" data-bs-target="#profile-up" style="cursor: pointer">
            </c:if>
            <div class="card-body my-info-list">
                <ul>
                    <li><h5>${profile.m_name}</h5></li>
                    <li><h5><span style="font-size: 1rem;">레벨</span> ${profile.p_level}</h5></li>
                    <li><h5><span style="font-size: 1rem;">포인트</span> ${profile.m_point}P</h5></li>
                </ul>
                <p class="card-text" style="text-align: center">${profile.m_addr}
                    <b><a class="btn btn-primary btn-color-thebora" href="/member/infoUpdate">수정하기</a></b>
                </p>
            </div>
        </div>
    </section>
    <section class="col-9 my-info-list">
        <ul style="height: 100%">
            <li style="cursor: pointer" class="position-relative">
                <h2 style="margin-top:30%">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-receipt-cutoff mb-3" viewBox="0 0 16 16">
                        <path d="M3 4.5a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 1 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h6a.5.5 0 0 1 0 1h-6a.5.5 0 0 1-.5-.5M11.5 4a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1zm0 2a.5.5 0 0 0 0 1h1a.5.5 0 0 0 0-1z"/>
                        <path d="M2.354.646a.5.5 0 0 0-.801.13l-.5 1A.5.5 0 0 0 1 2v13H.5a.5.5 0 0 0 0 1h15a.5.5 0 0 0 0-1H15V2a.5.5 0 0 0-.053-.224l-.5-1a.5.5 0 0 0-.8-.13L13 1.293l-.646-.647a.5.5 0 0 0-.708 0L11 1.293l-.646-.647a.5.5 0 0 0-.708 0L9 1.293 8.354.646a.5.5 0 0 0-.708 0L7 1.293 6.354.646a.5.5 0 0 0-.708 0L5 1.293 4.354.646a.5.5 0 0 0-.708 0L3 1.293zm-.217 1.198.51.51a.5.5 0 0 0 .707 0L4 1.707l.646.647a.5.5 0 0 0 .708 0L6 1.707l.646.647a.5.5 0 0 0 .708 0L8 1.707l.646.647a.5.5 0 0 0 .708 0L10 1.707l.646.647a.5.5 0 0 0 .708 0L12 1.707l.646.647a.5.5 0 0 0 .708 0l.509-.51.137.274V15H2V2.118z"/>
                    </svg><br>
                    <a href="/member/marketEnd" style="display: block" class="stretched-link">거래내역</a>
                </h2>
            </li>
            <li style="cursor: pointer" class="position-relative">
                <h2 style="margin-top:30%">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-basket3-fill mb-3" viewBox="0 0 16 16">
                        <path d="M5.757 1.071a.5.5 0 0 1 .172.686L3.383 6h9.234L10.07 1.757a.5.5 0 1 1 .858-.514L13.783 6H15.5a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5H.5a.5.5 0 0 1-.5-.5v-1A.5.5 0 0 1 .5 6h1.717L5.07 1.243a.5.5 0 0 1 .686-.172zM2.468 15.426.943 9h14.114l-1.525 6.426a.75.75 0 0 1-.729.574H3.197a.75.75 0 0 1-.73-.574z"/>
                    </svg><br>
                    <a href="/member/myTrade" style="display: block" class="stretched-link">나의거래</a>
                </h2>
            </li>
            <li style="cursor: pointer" class="position-relative">
                <h2 style="margin-top:30%">
                    <svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-bookmark-heart-fill mb-3" viewBox="0 0 16 16">
                        <path d="M2 15.5a.5.5 0 0 0 .74.439L8 13.069l5.26 2.87A.5.5 0 0 0 14 15.5V2a2 2 0 0 0-2-2H4a2 2 0 0 0-2 2zM8 4.41c1.387-1.425 4.854 1.07 0 4.277C3.146 5.48 6.613 2.986 8 4.412z"/>
                    </svg><br>
                    <a href="/member/myCart" style="display: block" class="stretched-link">관심상품</a>
                </h2>
            </li>
        </ul>
    </section>
</main>

<!-- Modal -->
<div class="modal fade" id="profile-up" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">프로필 등록</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="profile-update">
                    <form action="/member/profileUpdate" method="post" enctype="multipart/form-data">
                        <input type="text" class="upload-name" value="파일선택" readonly>
                        <label for="attachment" class="btn btn-primary btn-color-thebora">프로필 사진찾기</label>
                        <input type="file" id="attachment" name="attachment" hidden="hidden">

                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="button" class="btn btn-primary btn-color-thebora" onclick="basicProfile()">기본 프로필</button>
                            <button type="submit" class="btn btn-primary btn-color-thebora">등록</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('#attachment').on('change', function () {
        console.log($('#attachment'))
        let files = document.getElementById('attachment').files
        console.log(files)

        let fileName = ''

        if (files.length == 1) {
            fileName = files[0].name;
        } else {
            fileName = "파일 선택";
        }
        $(".upload-name").val(fileName);
    })
    function basicProfile() {
        location.href="/member/profileDelete"
    }
</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
