<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>더보라</title>
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
<script>
    $(() => {
        const msg = '${msg}';
        if (msg !== '') {

            alert(msg);
        }

    })

    function auctionReject(num, id, title) {
        $.ajax({
            method: 'post',
            url: '/admin/auctionReject',
            data: {"sb_num": num}

        }).done((resp) => {
            if (resp) {
                goAuctionApply()
                console.log(resp)
                if (socket) {
                    let socketMsg = {"type": "reject", "seller": id, "sb_title": title, "sb_num": num};
                    socket.send(JSON.stringify(socketMsg));
                    alert('거절했습니다.');
                }
            }

        }).fail((err) => {
            console.log(err);
        })

    }


    function adApproval(num, date) {
        console.log(num);
        console.log(date);
        $.ajax({
            method: 'post',
            url: '/admin/adApproval',
            data: {'a_num': num, 'a_date': date}

        }).done((resp) => {
            if (resp) {
                alert("승인완료.")
                $('#ad-submit').modal('hide');
                goAdApply()
            } else {
                alert("승인실패.")
            }

            console.log(resp)
        }).fail((err) => {
            console.log(err)
        })
    }

    function goAdApply() {

        $.ajax({
            method: 'post',
            url: '/admin/adApplyList',

        }).done((resp) => {
            let dList = `<h5 style="text-align: left">광고 신청 관리</h5>
                <table class="table table-hover" id="ad-apply">
                <thead>
                <tr>
                    <th>#</th>
                    <th>거래유형</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>희망 기간</th>
                    <th>신청 시간</th>
                    <th>만료 기간</th>
                    <th>신청자</th>
                    <th>승인여부</th>
                    <th>&nbsp;</th>
                </tr>
                </thead>
                <tbody id="delList">`;
            $.each(resp, function (i, delList) {
                let saleKindUrl;
                let saleKind;
                switch (delList.sb_saleKind) {
                    case '1':
                        saleKindUrl = '/board/auctionDetail?sb_num=' + delList.sb_num;
                        saleKind = '경매'
                        break;
                    case '2':
                        saleKindUrl = '/board/marketDetail?sb_num=' + delList.sb_num;
                        saleKind = '중고거래'
                        break;
                    case '3':
                        saleKindUrl = '/hotdeal/list/detail?sb_num=' + delList.sb_num;
                        saleKind = '핫딜'
                        break;
                    default:
                        return;
                }

                dList += `
                <tr>
			        <th scope="row">` + delList.a_num + `</th>
                    <td>`
                    + saleKind +
                    `</td>
			        <td>
			        	<a href="` + saleKindUrl + `">` + delList.sb_title + `</a>
		        	</td>
			        <td>`
                    + delList.sb_category +
                    `</td>
                     <td>`
                    + delList.a_period +
                    `일</td>
                     <td>`
                    + delList.sb_date +
                    `</td>
                     <td>`
                    + delList.a_date +
                    `</td>
                     <td>`
                    + delList.sb_id +
                    `</td>
                     <td>`
                    + delList.a_app +
                    `</td>
                    <td>
			        	<button onclick="adReject(` + delList.a_num + `,` + delList.a_period + `,'` + delList.sb_id + `','` + delList.sb_title + `')" type="button" class="btn btn-primary btn-color-thebora"> 거절 </button>
			        	<button class="btn btn-primary btn-color-thebora" type="button" onclick="adSubmit(` + delList.a_num + `)"> 승인 </button>
		        	</td>
	        	</tr>
 </tbody>`

            })
            dList += `</table>`
            $('#admin-content').html(dList);
        }).fail((err) => {

        })
    }

    function adReject(num, point, id, title) {
        $.ajax({
            method: 'post',
            url: '/admin/adReject',
            data: {'a_num': num, 'a_period': point, 'sb_id': id},

        }).done((resp) => {
            if (resp) {
                alert("거절완료")
                if (socket) {
                    let socketMsg = {"type": "adReject", "seller": id, "sb_title": title, "sb_num": num};
                    socket.send(JSON.stringify(socketMsg));
                    alert('거절했습니다.');
                }
                goAdApply()

            } else {
                alert("거절실패")
                goAdApply()
            }

        }).fail((err) => {
            console.log(err)
        })
    }


    function goAuctionApply() {
        $.ajax({
            method: 'post',
            url: '/admin/auctionApplyList',

        }).done((resp) => {
            let dList = `<h5 style="text-align: left">경매 신청 관리</h5>
            <table class="table table-hover" id="auction-apply">
                <thead>
                <tr>
                    <th>#</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>수량</th>
                    <th>희망 즉시구매가</th>
                    <th>희망 시작가</th>
                    <th>희망 최소입찰가</th>
                    <th>희망 판매기간</th>
                    <th>신청 시간</th>
                    <th>신청자</th>
                    <th>&nbsp;</th>
                </tr>
                </thead>
                <tbody id="delList">`;
            $.each(resp, function (i, delList) {
                dList += `
                <tr>
			        <th scope="row">` + delList.sb_num + `</th>
			        <td>
			        	<a onclick="picture(`+delList.sb_num+`)">` + delList.sb_title + `</a>
		        	</td>
			        <td>`
                    + delList.sb_category +
                    `</td>
			        <td>`
                    + delList.sb_count +
                    `</td>
			        <td>`
                    + delList.sb_price +
                    `</td>
			        <td>`
                    + delList.sb_startPrice +
                    `</td>
                     <td>`
                    + delList.sb_bid +
                    `</td>
                     <td>`
                    + delList.sb_buyLevel +
                    `</td>
                     <td>`
                    + delList.sb_date +
                    `</td>
                     <td>`
                    + delList.sb_id +
                    `</td>
                    <td>
			        	<button onclick="auctionReject(` + delList.sb_num + `,'` + delList.sb_id + `','` + delList.sb_title + `')" type="button" class="btn btn-primary btn-color-thebora"> 거절 </button>
			        	<button class="btn btn-primary btn-color-thebora" type="button" onclick="reUpload(` + delList.sb_num + `)"> 경매 올리기 </button>
		        	</td>
	        	</tr>
 </tbody>`

            })
            dList += `</table>`
            $('#admin-content').html(dList);
            console.log(resp)
        }).fail((err) => {

        })
    }

    function picture(num){
        $.ajax({
            method: 'post',
            url: '/admin/picture',
            data:{"sb_num":num}
        }).done((resp)=>{
            console.log(resp)
            // if (resp.size!=null){
                // for (const i of resp) {
            //         console.log(i)
            //         $('#show_pic').append("<img src='/upload/"+i+"'>")
            //     }
            // }
            // $('#showPicture').modal('show');

        }).fail((err)=>{
            console.log(err)
        })
    }


    function goBoardManager() {

        $.ajax({
            method: 'post',
            url: '/admin/boardManager',

        }).done((resp) => {
            let dList = `<h5 style="text-align: left">경매 삭제 게시글 관리</h5>
            <table class="table table-hover" id="deleted-auction-list">
                <thead>
                <tr>
                    <th>#</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>판매가격</th>
                    <th>재고수량</th>
                    <th>판매기간</th>
                    <th>&nbsp;</th>
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
			        <td>`
                    + delList.sb_category +
                    `</td>
			        <td>`
                    + delList.sb_price +
                    `</td>
			        <td>`
                    + delList.sb_count +
                    `</td>
			        <td>`
                    + delList.sb_date +
                    `</td>
                    <td>
			        	<a class="btn btn-primary btn-color-thebora" onclick="auctionRealDelete(` + delList.sb_num + `)"> 삭제 </a>
			        	<a class="btn btn-primary btn-color-thebora" onclick="auctionRestore(` + delList.sb_num + `)"> 복원 </a>
		        	</td>
	        	</tr>
        </tbody>`

            })
            dList += `</table>`
            $('#admin-content').html(dList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })
    }

    function auctionRestore(num) {
        if (!confirm("복원하시겠습니까?")) {
            return
        }

        $.ajax({
            method: 'post',
            url: '/admin/restore',
            data: {"sb_num": num},
        }).done((resp) => {
            if (resp) {
                alert("복원완료")
                goBoardManager()
            }
        }).fail((err) => {
            console.log(err)
        })
    }

    function marketRestore(num) {
        if (!confirm("복원하시겠습니까?")) {
            return
        }

        $.ajax({
            method: 'post',
            url: '/admin/restore',
            data: {"sb_num": num},
        }).done((resp) => {
            if (resp) {
                alert("복원완료")
                goMarketBoardManager()
            }
        }).fail((err) => {
            console.log(err)
        })
    }

    function goMarketBoardManager() {
        $.ajax({
            method: 'post',
            url: '/admin/marketBoardManager',

        }).done((resp) => {
            let dList = `<h5 style="text-align: left">중고거래 삭제 게시글 관리</h5>
            <table class="table table-hover" id="deleted-auction-list">
                <thead>
                <tr>
                    <th>#</th>
                    <th>상품명</th>
                    <th>카테고리</th>
                    <th>판매가격</th>
                    <th>재고수량</th>
                    <th>판매기간</th>
                    <th>&nbsp;</th>
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
			        <td>`
                    + delList.sb_category +
                    `</td>
			        <td>`
                    + delList.sb_price +
                    `</td>
			        <td>`
                    + delList.sb_count +
                    `</td>
			        <td>`
                    + delList.sb_date +
                    `</td>
                     <td>
			        	<a class="btn btn-primary btn-color-thebora" onclick="marketRealDelete(` + delList.sb_num + `)"> 삭제 </a>
			        	<a class="btn btn-primary btn-color-thebora" onclick="marketRestore(` + delList.sb_num + `)" > 복원 </a>
		        	</td>
	        	</tr>
   </tbody>`

            })
            dList += `</table>`
            $('#admin-content').html(dList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })

    }

    function auctionRealDelete(num) {
        if (!confirm("삭제하시겠습니까?")) {
            return
        }
        $.ajax({
            method: 'post',
            url: '/admin/realDelete',
            data: {'sb_num': num},
        }).done((resp) => {
            if (resp) {
                alert("삭제완료")
                goBoardManager()

            } else {
                alert("삭제실패")
                console.log(resp)
            }

        }).fail((err) => {
            console.log(err)
        })
    }


    function marketRealDelete(num) {
        if (!confirm("삭제하시겠습니까?")) {
            return
        }
        $.ajax({
            method: 'post',
            url: '/admin/realDelete',
            data: {'sb_num': num},
        }).done((resp) => {
            if (resp) {
                alert("삭제완료")
                goMarketBoardManager()

            } else {
                alert("삭제실패")
                console.log(resp)
            }

        }).fail((err) => {
            console.log(err)
        })
    }


    function endAuctionRealDelete(num) {
        if (!confirm("삭제하시겠습니까?")) {
            return
        }
        $.ajax({
            method: 'post',
            url: '/admin/realDelete',
            data: {'sb_num': num},
        }).done((resp) => {
            if (resp) {
                alert("삭제완료")
                goAuctionEndManager()

            } else {
                alert("삭제실패")
                console.log(resp)
            }

        }).fail((err) => {
            console.log(err)
        })
    }

    function categoryList() {
        $.ajax({
            method: 'post',
            url: '/admin/categoryList',

        }).done((resp) => {
            let cateList = `
        <h5 style="text-align: left">카테고리 관리</h5>
        <table class="table table-hover" id="add-category">
            <tr>
                <td style="width: 90%"><input type="text" id="c_kind" placeholder="카테고리 추가" class="form-control"></td>
                <td><button type="button" id="cateAttend" class="btn btn-primary btn-color-thebora" onclick="cateAttend()" style="width: 100%">추가</button></td>
            </tr>
        `;
            $.each(resp, function (i, cList) {
                cateList += `
            <tr>
			        <td style="font-weight: bold">`
                    + cList +
                    `</td>
                    <td>
			        	<a onclick="cateDelete('` + cList + `')" class="btn btn-primary btn-color-thebora" style="width: 100%"> 삭제 </a>
		    	    </td>
            </tr>`
            })
            cateList += `</table>`
            $('#admin-content').html(cateList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })

    }

    function cateDelete(cate) {
        if (!confirm("카테고리를 삭제하시겠습니까?")) {
            return;
        }
        $.ajax({
            method: 'post',
            url: '/admin/cateDelete',
            data: {'c_kind': cate}
        }).done((resp) => {
            if (resp) {
                alert("삭제완료")
                categoryList()
            }
        }).fail((err) => {

        })
    }


    function cateAttend() {
        if ($('#c_kind').val() === '') {
            alert("추가할 카테고리를 입력해주세요")
            return
        }
        if (!confirm("카테고리를 추가하시겠습니까?")) {
            return;
        }
        $.ajax({
            method: 'post',
            url: '/admin/cateAttend',
            data: {'c_kind': $('#c_kind').val()}
        }).done((resp) => {
            if (resp) {
                alert("추가완료")
                categoryList()
            }
        }).fail((err) => {

        })
    }

    function memberList() {
        $.ajax({
            method: 'post',
            url: '/admin/memberList',

        }).done((resp) => {
            let memberList = `<h5 style="text-align: left">회원 관리</h5>`;
            $.each(resp, function (i, mList) {
                memberList += `
            <table class="table table-hover" id="memberList">
                <tr>
                    <th class="topborder">아이디</th>
                    <th class="topborder">이름</th>
                    <th class="topborder">전화번호</th>
                    <th class="topborder">주소</th>
                    <th class="topborder">권한</th>
                </tr>
                <tr>
			        <td>
                        <input type="text" id="m_id` + i + `" value="` + mList.m_id + `" class="form-control" readonly>
                    </td>
			        <td>
                        <input type="text" id="m_name` + i + `"  value="` + mList.m_name + `" class="form-control">
                    </td>
                    <td>
                        <input type="text" id="m_phone` + i + `" value="` + mList.m_phone + `" class="form-control">
                    </td>
                    <td>
			            <input type="text" id="m_addr` + i + `" value="` + mList.m_addr + `" class="form-control">
                    </td>
			        <td>
                         <select name="m_role" class="form-select" id="m_role` + i + `">
                             <option value="` + mList.m_role + `">` + mList.m_role + `</option>
                             <option value="admin">admin</option>
                             <option value="user">user</option>
                             <option value="company">company</option>
                         </select>
                    </td>
                </tr>
                <tr>
                    <th>사업자번호</th>
                    <th>보유포인트</th>
                    <th>누적포인트</th>
                    <th>포인트부여</th>
                    <th>
			        	<a class="btn btn-primary btn-color-thebora" onclick="memberUpdate($('#m_id` + i + `').val(),$('#m_name` + i + `').val(), $('#m_phone` + i + `').val(), $('#m_addr` + i + `').val(), $('#m_companyNum` + i + `').val(), $('#m_role` + i + `').val(), $('#m_point` + i + `').val())" style="width:100%;"> 수정 </a>
		        	</th>
                </tr>
                <tr>
			        <td>  <input type="text" id="m_companyNum` + i + `" value="`
                    + mList.m_companyNum +
                    `" class="form-control"> </td>
			        <td style="text-align: center"> `
                    + mList.m_point +
                    ` </td>
			        <td style="text-align: center">`
                    + mList.m_sumPoint +
                    `</td>
                    <td>
                        <input type="text" id="m_point` + i + `" placeholder="0" class="form-control" value="0">
                    </td>
                    <td>
                        <a onclick="memberDelete('` + mList.m_id + `')" class="btn btn-primary btn-color-thebora" style="width:100%;"> 삭제 </a>
                    </td>
                </tr>
</table>`
            })
            $('#admin-content').html(memberList);
            console.log(resp)
        }).fail(function (err) {
            console.log(err)
        })
    }

    function memberUpdate(id, name, phone, addr, company, role, point) {
        if (!confirm("수정하시겠습니까?")) {
            return
        }
        $.ajax({
            method: 'post',
            url: '/admin/memberUpdate',
            data: {
                'm_id': id,
                "m_name": name,
                "m_phone": phone,
                "m_addr": addr,
                "m_companyNum": company,
                "m_role": role,
                "m_point": point
            }
        }).done((done) => {
            if (done) {
                alert("수정완료")
                memberList();
            }
        }).fail((err) => {
            console.log(err)
        })
    }


    function memberDelete(id) {
        if (!confirm("삭제하시겠습니까?")) {
            return
        }
        $.ajax({
            method: 'post',
            url: '/admin/memberDelete',
            data: {'m_id': id}
        }).done((resp) => {
            if (resp) {
                alert("삭제완료")
                memberList();
            }
        }).fail((err) => {
            console.log(err)
        })
    }


    function goAuctionEndManager() {

        $.ajax({
            method: 'post',
            url: '/admin/AuctionEndManager',

        }).done((resp) => {
            let dList = `<h5 style="text-align: left">경매 완료 게시글 관리</h5>
        <table class="table table-hover" id="closed-auction-list">
            <thead>
            <tr>
                <th>#</th>
                <th>상품명</th>
                <th>카테고리</th>
                <th>판매가격</th>
                <th>판매기간</th>
                <th>판매자</th>
                <th>구매자</th>
                <th style="width: 15%">&nbsp;</th>
            </tr>
            </thead>
            <tbody id="delList">`;
            $.each(resp, function (i, delList) {
                dList += `
                <tr>
			        <th scope="row">` + delList.sb_num + `</th>
			        <td>
			        	<a href="/board/auctionEndDetail?sb_num=` + delList.sb_num + `">` + delList.sb_title + `</a>
		        	</td>
			        <td>`
                    + delList.sb_category +
                    `</td>
			        <td>`
                    + delList.sb_nowPrice +
                    `</td>
			        <td>`
                    + delList.sb_date +
                    `</td>
                     <td>`
                    + delList.sb_id +
                    `</td>
                     <td>`
                    + delList.a_joinId +
                    `</td>
                    <td>
			        	<a class="btn btn-primary btn-color-thebora" onclick="endAuctionRealDelete(` + delList.sb_num + `)"> 삭제 </a>
			        	<button class="btn btn-primary btn-color-thebora" type="button" onclick="reUpload(` + delList.sb_num + `)"> 다시올리기 </button>
		        	</td>
	        	</tr>
 </tbody>`

            })
            dList += `</table>`
            $('#admin-content').html(dList);
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
<main id="admin-page" class="d-grid gap-2 w-75 mb-3 mx-auto">
    <h1>관리자 전용 페이지</h1>
    <div id="admin-page-nav">
        <ul>
            <li onclick="goAdApply()">광고 신청 관리</li>
            <li onclick="goAuctionApply()">경매 신청 관리</li>
            <li onclick="goAuctionEndManager()">경매 완료 게시글 관리</li>
            <li onclick="goBoardManager()">경매 삭제 게시글 관리</li>
            <li onclick="goMarketBoardManager()">중고거래 삭제 게시글 관리</li>
            <li onclick="categoryList()">카테고리 관리</li>
            <li onclick="memberList()">회원 관리</li>
            <li class="noborder"><a href="/board/auctionRegister">경매 올리기</a></li>
        </ul>
    </div>
    <div id="admin-content">

    </div>
</main>
<div id="ad-submit" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">경매시간</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                종료시간 : <input type="datetime-local" id="adDatetime" class="form-control myInput mt-1"
                              placeholder="날짜를 선택하세요." readonly="readonly"></p>
                <input type="text" name="sb_timer" id="ad_timer" hidden="hidden">
                <input type="text" name="a_num" id="ad_num" hidden="hidden">
                <button class="btn btn-primary btn-color-thebora" type="button"
                        onclick="adApproval($('#ad_num').val(),$('#ad_timer').val())">올리기
                </button>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
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
                    종료시간 : <input type="datetime-local" id="myDatetime" class="form-control myInput mt-1"
                                  placeholder="날짜를 선택하세요." readonly="readonly"></p>
                    <input type="text" name="sb_timer" id="sb_timer" hidden="hidden">
                    <button class="btn btn-primary btn-color-thebora">올리기</button>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<div id="showPicture" class="modal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">경매시간</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="show_pic">

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<script>

    function reUpload(num) {
        $('#reUpNum').val(num)
        $('#reUp').modal('show');
    }

    function adSubmit(num) {
        $('#ad_num').val(num)
        $('#ad-submit').modal('show');
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

    const myInput = document.getElementById('myDatetime');
    const fp = flatpickr(myInput, {
        enableTime: true,
        minuteIncrement: 1,
        dateFormat: "Y-m-d H:i",
        "locale": "ko",
        minDate: new Date().fp_incr(0),
        minTime: "9:00",
        maxDate: new Date().fp_incr(7) // 7 days from now

    });

    //달력에서 선택한 날짜를 전송용 필드에 입력하게 함
    fp.config.onChange.push(function (selectedDates, dateStr, fp) {
        const date = new Date(dateStr);
        const isoDatetime = new Date(date.getTime() - (date.getTimezoneOffset() * 60000)).toISOString().slice(0, 16);
        document.getElementById('sb_timer').value = isoDatetime;
    })

    const adDatetimeInput = document.getElementById('adDatetime');

    adDatetimeInput.addEventListener('change', function () {

        // const datetimeValue = this.value; // 현재 입력된 값
        // 이 값에 대해 필요한 처리 (예: 특정 형식으로 변경)
        // 예시: ISO 8601 형식 (24시간 형식)으로 변환
        // const isoDatetime = new Date(datetimeValue).toISOString().slice(0, 16); // 초 단위는 생략
        // this.value = isoDatetime;
        console.log(adDatetimeInput.value);
    });

    const adInput = document.getElementById('adDatetime');
    const adFp = flatpickr(adInput, {
        enableTime: true,
        minuteIncrement: 1,
        dateFormat: "Y-m-d H:i",
        "locale": "ko",
        minDate: new Date().fp_incr(0) ,
        minTime: "9:00",
        maxDate: new Date().fp_incr(7) // 7 days from now

    });

    //달력에서 선택한 날짜를 전송용 필드에 입력하게 함
    adFp.config.onChange.push(function (selectedDates, dateStr, fp) {
        const adDate = new Date(dateStr);
        const adIsoDatetime = new Date(adDate.getTime() - (adDate.getTimezoneOffset() * 60000)).toISOString().slice(0, 16);
        document.getElementById('ad_timer').value = adIsoDatetime;
    })


</script>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>