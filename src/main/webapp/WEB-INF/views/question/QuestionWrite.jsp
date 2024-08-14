<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 24. 8. 9.
  Time: 오후 1:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>더보라</title>
</head>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    .write {
        margin: 20px 0;
        text-align: center;
    }
    #q_contents {
        width: 300px;
        height: 250px;
    }
    .op{
        text-align: center;
    }
</style>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<section>
    <div>
        <form action="/question/write" method="post" enctype="multipart/form-data">
            <h2 class="op">답변 작성</h2>
            <table class="table table-hover" style="width: 900px; margin: auto; text-align: center">
                <tr>
                    <td>
                        <input type="hidden" name="q_id" value="${userId}" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="text" name="q_title" placeholder="제목" required />
                    </td>
                </tr>
                <tr>
                    <td><textarea name="q_contents" id="q_contents" placeholder="내용을 적어주세요"></textarea></td>
                </tr>
                <tr>
                    <td>
                        <input type="file" name="attachments" id="attachments" multiple />
                    </td>
                </tr>
            </table>
            <div class="write">
                <input type="submit" value="작성" />
            </div>
        </form>
    </div>
</section>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
<script>
    $('#upload').on('change', function (){
        let files = document.getElementById('upload').files;
        console.log(files);
        let fileName = '';
        if(files.length > 1){
            fileName = files[0].name + ' 외 ' + (files.length-1) + '개';
        }else if(files.length === 1){
            fileName = files[0].name;
        }else{
            fileName = "파일 선택";
        }
        $(".upload-name").val(fileName);
    })
</script>
</body>
</html>
