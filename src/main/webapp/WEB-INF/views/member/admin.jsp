<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"
            integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
            crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous">
    </script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
</head>
<style>
    input{
        width: 120px;
    }

</style>

<script>
    $(()=>{
        const msg = '${msg}';
        if (msg !== '') {

            alert(msg);
        }

    })

    function goBoardManager() {

        $.ajax({
            method: 'post',
            url: '/admin/boardManager',

        }).done((resp) => {
            let dList = `<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">#</th>
        <th scope="col">상품명</th>
        <th scope="col">카테고리</th>
        <th scope="col">판매가격</th>
        <th scope="col">재고수량</th>
        <th scope="col">판매기간</th>
    </tr>
    </thead>
    <tbody id="delList">`;
            $.each(resp, function (i, delList) {
                dList += `
                <tr>
			        <th scope="row">` + delList.sb_num + `</th>
			        <td>
			        	<a href="/board/auctionDetail?sb_num=` + delList.sb_num + `">` + delList.sb_title + `</a>
		        	</td>
			        <td id="_category">`
                    + delList.sb_category +
                    `</td>
			        <td id="_price">`
                    + delList.sb_price +
                    `</td>
			        <td id="_quantity">`
                    + delList.sb_count +
                    `</td>
			        <td id="_enddate">`
                    + delList.sb_date +
                    `</td>
                    <td>
			        	<a href="/admin/realDelete?sb_num=` + delList.sb_num + `" class="btn btn-primary"> 삭제 </a>
		        	</td>
                     <td>
			        	<a href="/admin/restore?sb_num=` + delList.sb_num + `" class="btn btn-primary"> 복원 </a>
		        	</td>
	        	</tr>
 </tbody>`

            })
            dList += `</table>`
            $('#management_btn').html(dList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })
    }

    function goMarketBoardManager() {
        $.ajax({
            method: 'post',
            url: '/admin/marketBoardManager',

        }).done((resp) => {
            let dList = `<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">#</th>
        <th scope="col">상품명</th>
        <th scope="col">카테고리</th>
        <th scope="col">판매가격</th>
        <th scope="col">재고수량</th>
        <th scope="col">판매기간</th>
    </tr>
    </thead>
    <tbody id="delList">`;
            $.each(resp, function (i, delList) {
                dList += `
                <tr>
			        <th scope="row">` + delList.sb_num + `</th>
			        <td>
			        	<a href="/board/marketDetail?sb_num=` + delList.sb_num + `">` + delList.sb_title + `</a>
		        	</td>
			        <td id="_category">`
                    + delList.sb_category +
                    `</td>
			        <td id="_price">`
                    + delList.sb_price +
                    `</td>
			        <td id="_quantity">`
                    + delList.sb_count +
                    `</td>
			        <td id="_enddate">`
                    + delList.sb_date +
                    `</td>
                     <td>
			        	<a href="/admin/realDelete?sb_num=` + delList.sb_num + `" class="btn btn-primary"> 삭제 </a>
		        	</td>
                    <td>
			        	<a href="/admin/restore?sb_num=` + delList.sb_num + `" class="btn btn-primary"> 복원 </a>
		        	</td>
	        	</tr>
   </tbody>`

            })
            dList += `</table>`
            $('#management_btn').html(dList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })

    }

    function categoryList() {
        $.ajax({
            method: 'post',
            url: '/admin/categoryList',

        }).done((resp) => {
            let cateList = `
<form action="/admin/cateAttend" method="post">
<table class="table table-striped">
    <thead>
    <tr>

        <th scope="col">카테고리 명</th>

    </tr>

    <tr>
 <td><input type="text" name="c_kind" placeholder="카테고리 추가"></td>
<td><button type="submit" class="btn btn-primary">추가</button></td>
</tr>
</form>
    </thead>
    <tbody id="cateList">`;
            $.each(resp, function (i, cList) {
                cateList += `
         <tr>
			        <td id="_category">`
                    + cList +
                    `</td>
         <td>
			        	<a href="/admin/cateDelete?c_kind=` + cList + `" class="btn btn-primary"> 삭제 </a>
		        	</td>

</tr>
   </tbody>
                `

            })
            cateList += `</table>`
            $('#management_btn').html(cateList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })

    }

    function memberList() {
        $.ajax({
            method: 'post',
            url: '/admin/memberList',

        }).done((resp) => {
            let memberList = ``;
            $.each(resp, function (i, mList) {
                memberList += `
 <form action="/admin/memberUpdate" method="post" id="update_form">
<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">아이디</th>
        <th scope="col">이름</th>
        <th scope="col">전화번호</th>
        <th scope="col">주소</th>
        <th scope="col">사업자번호</th>
        <th scope="col">보유포인트</th>
        <th scope="col">누적포인트</th>
        <th scope="col">포인트부여</th>
        <th scope="col">권한</th>
    </tr>
    </thead>
    <tbody id="memberList">
                <tr>
			        <td id="">
                 <input type="text" name="m_id" value="` + mList.m_id + `">
                 <input type="text" name="transId" hidden="hidden" value="` + mList.m_id + `">
                    </td>
			        <td id="">  <input type="text" name="m_name"  value="`
                    + mList.m_name +
                    `"> </td>
                    <td id="">  <input type="text" name="m_phone" value="`
                    + mList.m_phone +
                    `"> </td>
			        <td id=""> <input type="text" name="m_addr" value="`
                    + mList.m_addr +
                    `"> </td>
			        <td id="">  <input type="text" name="m_companyNum" value="`
                    + mList.m_companyNum +
                    `"> </td>
			        <td id=""> `
                    + mList.m_point +
                    ` </td>
			        <td id="">`
                    + mList.m_sumPoint +
                    `</td>
                    <td>
                    <input type="text" name="m_point" value="0">
                    </td>
			        <td id="">
                         <select name="m_role" id="">
                             <option value="` + mList.m_role + `">` + mList.m_role + `</option>
                             <option value="admin">admin</option>
                             <option value="user">user</option>
                             <option value="company">company</option>
                         </select>
                    </td>

                    <td>
			        	<button class="btn btn-primary"> 수정 </button>
		        	</td>
                    <td>
			        	<a href="/admin/memberDelete?m_id=` + mList.m_id + `" class="btn btn-primary"> 삭제 </a>
		        	</td>

                </tr>
</tbody>
</table>
</form>`

            })

            $('#management_btn').html(memberList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })

    }

    function goAuctionEndManager() {

        $.ajax({
            method: 'post',
            url: '/admin/AuctionEndManager',

        }).done((resp) => {
            let dList = `<table class="table table-striped">
    <thead>
    <tr>
        <th scope="col">#</th>
        <th scope="col">상품명</th>
        <th scope="col">카테고리</th>
        <th scope="col">판매가격</th>
        <th scope="col">판매기간</th>
        <th scope="col">판매자</th>
        <th scope="col">구매자</th>
    </tr>
    </thead>
    <tbody id="delList">`;
            $.each(resp, function (i, delList) {
                dList += `
                <tr>
			        <th scope="row">` + delList.sb_num + `</th>
			        <td>
			        	<a href="/board/auctionDetail?sb_num=` + delList.sb_num + `">` + delList.sb_title + `</a>
		        	</td>
			        <td id="_category">`
                    + delList.sb_category +
                    `</td>
			        <td id="_price">`
                    + delList.sb_nowPrice +
                    `</td>
			        <td id="_enddate">`
                    + delList.sb_date +
                    `</td>
                     <td id="_enddate">`
                    + delList.sb_id +
                    `</td>
                     <td id="_enddate">`
                    + delList.a_joinId +
                    `</td>
                    <td>
			        	<a href="/admin/realDelete?sb_num=` + delList.sb_num + `" class="btn btn-primary"> 삭제 </a>
		        	</td>
                     <td>
			        	<button class="btn btn-primary" type="button" onclick="reUpload(`+delList.sb_num +`)"> 다시올리기 </button>
		        	</td>
	        	</tr>
 </tbody>`

            })
            dList += `</table>`
            $('#management_btn').html(dList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })
    }

</script>

<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<div class="d-grid gap-2 w-75 mb-3 mx-auto">
    <h1>관리자 전용 페이지</h1>


    <div>
        <button type="button" class="btn btn-primary" onclick="goAuctionEndManager()">경매 완료 게시글 관리</button>
        <button type="button" class="btn btn-primary" onclick="goBoardManager()">경매 삭제 게시글 관리</button>
        <button type="button" class="btn btn-primary" onclick="goMarketBoardManager()">중고거래 삭제 게시글 관리</button>
        <button type="button" class="btn btn-primary" onclick="categoryList()">카테고리 관리</button>
        <button type="button" class="btn btn-primary" onclick="memberList()">회원 관리</button>

    </div>
    <div id="management_btn">

    </div>


</div>

<div id="reUp" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">경매시간</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="/admin/reUpload" method="post">
                    <input type="text" id="reUpNum" name="sb_num" hidden="hidden">
                    종료시간 : <input type="datetime-local" id="myDatetime"  class="form-control myInput mt-1" placeholder="날짜를 선택하세요." readonly="readonly"     ></p>
                    <input type="text" name="sb_timer" id="sb_timer" hidden="hidden">
                    <button class="btn btn-primary">올리기</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>
    function reUpload(num){
        $('#reUpNum').val(num)
        $('#reUp').modal('show');
    }

    const datetimeInput = document.getElementById('myDatetime');

    datetimeInput.addEventListener('change', function () {

        // const datetimeValue = this.value; // 현재 입력된 값
        // 이 값에 대해 필요한 처리 (예: 특정 형식으로 변경)
        // 예시: ISO 8601 형식 (24시간 형식)으로 변환
        // const isoDatetime = new Date(datetimeValue).toISOString().slice(0, 16); // 초 단위는 생략
        // this.value = isoDatetime;
        console.log(datetimeInput.value);
    });

    const myInput = document.querySelector(".myInput");
    const fp = flatpickr(myInput, {
        enableTime: true,
        dateFormat: "Y-m-d H:i",
        "locale": "ko",
        minDate: new Date().fp_incr(1) ,
        minTime: "12:00",
        maxDate: new Date().fp_incr(7) // 7 days from now

    });

    //달력에서 선택한 날짜를 전송용 필드에 입력하게 함
    fp.config.onChange.push(function (selectedDates, dateStr, fp) {
        const isoDatetime = new Date(dateStr).toISOString().slice(0, 16);
        document.getElementById('sb_timer').value = isoDatetime;
    })


</script>
</body>
</html>