<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 9.
  Time: 오후 2:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .action{
            text-align: center;
        }
        .notice{
            margin: auto;
        }
        h2{
            text-align: center;
        }
        img{
            width: 700px;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <div class="notice">
        <h2>자주 묻는 질문</h2>
        <table class="table table-striped table-hover" style="width: 900px; margin: auto; text-align: center;">
            <tr>
                <th style="width: 10%">작성자</th>
                <td colspan="3" style="width: 90%">${qDto.q_id}</td>
            </tr>
            <tr>
                <th style="width: 10%">제목</th>
                <td colspan="3" style="width: 90%">${qDto.q_title}</td>
            </tr>
            <tr>
                <th style="width: 10%">조회수</th>
                <td colspan="3" style="width: 90%">${qDto.q_views}</td>
            </tr>
            <tr>
                <th style="width: 10%">내용</th>
                <td colspan="3" style="width: 90%">
                    <c:if test="${!empty qDto.qfList}">
                        <c:forEach var="files" items="${qDto.qfList}" varStatus="loop">
                            <img src="/upload/${files.qf_sysFileName}" class="${loop.index == 0 ? '' : 'img-none' }">
                            <br><br>
                        </c:forEach>
                    </c:if>
                    ${qDto.q_contents}</td>
            </tr>
        </table>
        <div class="action">
            <button onclick="location.href='/question/list'">목록으로</button>
            <button id="update-btn" onclick="location.href='/question/update?q_num=' + ${qDto.q_num}">수정</button>
        </div>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    function upload(q_num){
        location.href = '/question/update?n_num=' + q_num;
    }
    $('.img-none').hide();

    const joinId = '${qDto.q_id}';
    const user = '<sec:authentication property="name" />';

    if(user === joinId){
        $('#update-btn').show();
    }else{
        $('#update-btn').hide();
    }
</script>
</body>
</html>
