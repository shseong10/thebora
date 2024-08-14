<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 9.
  Time: 오후 3:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<head>
    <title>더보라</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <style>
        .update{
            margin: 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <div class="update">
        <h2>글 수정하기</h2>
        <form action="/question/update" method="post" enctype="multipart/form-data">
            <table class="table table-success table-striped" style="width: 800px; margin: auto; text-align: center;">
                <tr>
                    <td style="width: 10%">제목</td>
                    <td style="width: 90%"><input type="text" name="q_title" value="${qDto.q_title}"></td>
                </tr>
                <tr style="height: 320px;">
                    <td style="width: 10%; text-align: center;">내용</td>
                    <td style="width: 90%">
                        <input type="text" name="q_contents" value="${qDto.q_contents}" style="width: 350px; height: 300px;"/>
                    </td>
                </tr>
                <tr>
                    <c:if test="${!empty qDto.qfList}">
                        <c:forEach var="files" items="${qDto.qfList}">
                            <td colspan="2">${files.qf_sysFileName} <i>${files.qf_oriFileName}</i></td>
                        </c:forEach>
                    </c:if>
                </tr>
                <tr>
                    <td colspan="2">
                        <input type="hidden" name="q_num" value="${qDto.q_num}">
                        <input type="file" name="attachments" id="attachments" multiple>
                        <input type="text" class="fileName" value="파일" readonly>
                    </td>
                </tr>
            </table>
            <div class="update">
                <button>수정</button>
            </div>
        </form>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    $('#attachments').on('change', function(){
        console.log($('#attachments'));
        let files = document.getElementById('attachments').files;
        console.log(files);
        let fileName = '';
        if(files.length > 1){
            fileName = files[0].name + ' 외 ' + (files.length - 1) + '개';
        }else if(files.length === 1){
            fileName = files[0].name;
        }else{
            fileName = "파일 없음"
        }
        $(".fileName").val(fileName);
    })
</script>
</body>
</html>