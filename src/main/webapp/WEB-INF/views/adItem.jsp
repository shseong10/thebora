<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
<section class="w-75 mx-auto mb-5">
    <h1 class="article-t">광고상품</h1>
    <div class="row row-cols-1 row-cols-md-4 g-4">
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_01.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_02.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_03.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
        <div class="col">
            <div class="card h-100">
                <img src="/img/product_sample_03.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <a href="#" class="stretched-link"><h5 class="card-title">상품명</h5>
                        <p class="card-text">가격</p></a>
                </div>
                <div class="card-footer">
                    <small class="text-body-secondary">인천광역시 미추홀구</small>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>
