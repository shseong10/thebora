<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <title>더보라</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="https://npmcdn.com/flatpickr/dist/l10n/ko.js"></script>
    <link rel="stylesheet" href="/api/ckeditor5/style.css">
    <link rel="stylesheet" href="https://cdn.ckeditor.com/ckeditor5/42.0.1/ckeditor5.css">
    <link rel="stylesheet" href="/css/style.css">
    <script>
        const dataTransfer = new DataTransfer();

        function modalView(e){
            let objNum = parseInt(e.name); //클릭한 대상의 id값(=상품번호)을 가져와서 저장

            let httpRequest;
            httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () => {
                if (httpRequest.readyState === XMLHttpRequest.DONE) {
                    if (httpRequest.status === 200) {
                        console.log('새로운 모달창 열기')

                        const result = JSON.parse(httpRequest.responseText);

                        const modalViewTitle = document.getElementById('modal_containerLabel');
                        const modalViewNum = document.getElementById('sb_num');
                        const modalViewsb_title = document.getElementById('sb_title');
                        const modalViewPrice = document.getElementById('sb_price');
                        const modalViewEnddate = document.getElementById('sb_timer');
                        const modalViewBuylevel = document.getElementById('sb_buylevel');
                        const modalViewQty = document.getElementById('sb_count');
                        const modalViewDesc = document.getElementById('sb_contents_hidden');


                        modalViewTitle.textContent = result[0].sb_title;
                        modalViewNum.setAttribute('value', result[0].sb_num);
                        modalViewsb_title.setAttribute('value', result[0].sb_title);
                        modalViewPrice.setAttribute('value', result[0].sb_price);
                        modalViewEnddate.setAttribute('value', result[0].sb_timer);
                        modalViewBuylevel.setAttribute('value', result[0].sb_buylevel);
                        modalViewQty.setAttribute('value', result[0].sb_count);
                        modalViewDesc.innerHTML = result[0].sb_contents;

                        //비동기 데이터가 전부 로드되면 숨겨진 div에 클릭이벤트를 실행해서 api를 건드리게함(ㅠㅠ)
                        modalViewDesc.click();

                        //저장된 이미지 가져오기
                        const modalViewImgFilename = result[0].ifList[0].bf_sysfilename;
                        const modalViewImg = document.getElementById('preview_main_img');
                        modalViewImg.setAttribute('src', '/upload/' + modalViewImgFilename);

                        //DTO로 가져온 데이터로 배열 생성(원본파일명, 시스템파일명 조합)
                        const savedImgList = new Array();
                        for (let i = 0; i < result[0].ifList.length; i++){
                            savedImgList.push({oriFileName: result[0].ifList[i].bf_orifilename, sysFileName: result[0].ifList[i].bf_sysfilename});
                        }

                        //이미지 객체를 만들어서 문서 내에 추가
                        const previewSub = document.getElementById('preview_sub');

                        if (savedImgList.length > 0) {
                            for (let i = 0; i < savedImgList.length; i++) {
                                const savedImg = document.createElement('img');
                                savedImg.setAttribute('src', '/upload/' + savedImgList[i].sysFileName);
                                savedImg.setAttribute('alt', savedImgList[i].oriFileName);
                                savedImg.classList.add('w-25');
                                savedImg.classList.add('pre-sub-ori');
                                savedImg.style.cursor = 'pointer';
                                previewSub.appendChild(savedImg);

                                savedImg.addEventListener('click', removePreSubOri, false);
                            }
                        }



                        //저장된 카테고리 가져오기
                        const savedCategory = result[0].sb_category
                        const modalViewCategory = document.querySelector('select[name=sb_category]').options;
                        for (let i = 0; i < modalViewCategory.length; i++) {
                            if (modalViewCategory[i].value == savedCategory) modalViewCategory[i].selected = true;
                        }

                        //캘린더 출력 + 저장된 날짜 가져오기
                        const myInput = document.querySelector(".myInput");
                        const fp = flatpickr(myInput, {
                            enableTime: true,
                            dateFormat: "Y-m-d H:i",
                            "locale": "ko",
                            defaultDate: result[0].sb_timer
                        });
                        fp.config.onChange.push(function (selectedDates, dateStr, fp) {
                            const date = new Date(dateStr);
                            const isoDateTime = new Date(date.getTime() - (date.getTimezoneOffset() * 60000)).toISOString().slice(0, 16);

                            document.getElementById('sb_timer').value = isoDateTime;
                        })

                        //판매기간 체크
                        if (result[0].sb_timer != '') {
                            document.getElementById('radioDate1').checked = false;
                            document.getElementById('radioDate2').checked = true;
                        } else {
                            document.getElementById('radioDate1').checked = true;
                            document.getElementById('radioDate2').checked = false;
                        }

                        //구매제한 체크
                        const buylevel = result[0].sb_buylevel;
                        if (buylevel != 0) {
                            document.getElementById('radioMem1').checked = false;
                            document.getElementById('radioMem2').checked = true;
                        } else {
                            document.getElementById('radioMem1').checked = true;
                            document.getElementById('radioMem2').checked = false;
                        }

                    }
                }
            }
            httpRequest.open('GET', '/hotdeal/admin/quickview?sb_num='+objNum , true);
            httpRequest.send();
        }//modalView(e) end

        function quickUpdate(){
            const UpdateNum = document.getElementById('sb_num');
            const UpdateCategory = document.getElementById('sb_category');
            const Updatesb_title = document.getElementById('sb_title');
            const UpdatePrice = document.getElementById('sb_price');
            const UpdateEnddate = document.getElementById('sb_timer');
            const UpdateBuylevel = document.getElementById('sb_buylevel');
            const UpdateQty = document.getElementById('sb_count');
            const UpdateDesc = document.getElementById('sb_contents');

            let inputNum = UpdateNum.value;
            let inputCategory = UpdateCategory.value;
            let inputName = Updatesb_title.value;
            let inputPrice = UpdatePrice.value;
            let inputEnddate = UpdateEnddate.value;
            let inputBuylevel = UpdateBuylevel.value;
            let inputQty = UpdateQty.value;
            let inputDesc = UpdateDesc.value;

            //json형식으로 변경
            let reqJson = new Object();
            reqJson.sb_num = inputNum;
            reqJson.sb_category = inputCategory;
            reqJson.sb_title = inputName;
            reqJson.sb_price = inputPrice;
            if (inputEnddate != "null") reqJson.sb_timer = inputEnddate;
            reqJson.sb_buylevel = inputBuylevel;
            reqJson.sb_count = inputQty;
            reqJson.sb_contents = inputDesc;
            console.log(reqJson)

            let httpRequest;
            httpRequest = new XMLHttpRequest();
            httpRequest.onreadystatechange = () => {
                if (httpRequest.readyState === XMLHttpRequest.DONE) {
                    if (httpRequest.status === 200) {
                        let update_result = httpRequest.response.iList;
                        console.log('모달창 내용 업데이트')
                        console.log(update_result);

                        if (update_result.sb_timer != null) {
                            const enddate = new Date(update_result.sb_timer)

                            const yyyy = enddate.getFullYear()
                            const mm = enddate.getMonth() + 1 // getMonth() is zero-based
                            const dd = enddate.getDate()
                            const hh = enddate.getHours()
                            const ii = enddate.getMinutes()

                            const sb_timer = yyyy + '-' + mm + '-' + dd + ' ' + hh + ':' + ii
                            const listEnddate = document.getElementById(inputNum+'_enddate');
                            listEnddate.textContent = sb_timer;
                        }

                        const sb_category = update_result.sb_category;
                        const sb_title = update_result.sb_title;
                        const sb_price = update_result.sb_price;
                        const sb_count = update_result.sb_count;
                        const sb_buylevel = update_result.sb_buylevel;

                        const listName = document.getElementById(inputNum+'_name');
                        const listCategory = document.getElementById(inputNum+'_category');
                        const listPrice = document.getElementById(inputNum+'_price');
                        const listQuantity = document.getElementById(inputNum+'_quantity');
                        const listBuylevel = document.getElementById(inputNum+'_buylevel');
                        listName.textContent = sb_title;
                        listCategory.textContent = sb_category;
                        listPrice.textContent = sb_price;
                        listQuantity.textContent = sb_count;
                        listBuylevel.textContent = sb_buylevel;
                    }
                }
            }
            httpRequest.open('POST', '/hotdeal/admin/quickupdate', true);
            httpRequest.responseType = 'json';
            httpRequest.setRequestHeader('Content-Type', 'application/json');
            httpRequest.send(JSON.stringify(reqJson));
        }


        function removePreSub() {
            console.log('dataTransfer 추가 완료')

            console.log(dataTransfer.files)

            const fileName = this.alt; //선택한 이미지의 파일명을 변수에 저장
            const preSubAll = document.querySelectorAll('.pre-sub'); //문서 내 썸네일 요소를 배열에 저장

            //선택한 이미지가 업로드 목록 중 몇 번째 파일인지 검사
            let preSubIdx;
            for (let i = 0; i < preSubAll.length; i++) {
                if (preSubAll[i].alt == fileName) preSubIdx = i; //만일 i번째 파일이 파일명과 일치한다면 선택한 이미지는 i번
            }

            console.log(preSubIdx + '번째 파일 ' + fileName + '를 삭제')

            //dataTransfer에서 선택한 이미지의 순서에 해당하는 파일을 삭제
            dataTransfer.items.remove(preSubIdx);
            console.log('dataTransfer 삭제 완료')
            console.log(dataTransfer.files)

            fileElem.files = dataTransfer.files;

            //선택한 이미지를 화면에서 삭제
            this.remove();
        }

        function removePreSubOri() {
            const fileName = this.alt; //선택한 이미지의 파일명을 변수에 저장

            console.log('기존 파일 ' + fileName + '를 삭제')

            const deleteFile = document.createElement('input');
            deleteFile.setAttribute('type', 'hidden');
            deleteFile.setAttribute('name', 'deleteFile');
            deleteFile.setAttribute('id', fileName);
            deleteFile.setAttribute('value', fileName);
            document.getElementById('preview_sub').appendChild(deleteFile);

            //선택한 이미지를 화면에서 삭제
            this.remove();
        }


        //검색
        function search() {
            let keyWord = document.getElementById('keyWord').value;
            if (keyWord === '') {
                alert('검색어를 입력하세요.')
                return;
            }
            location.href = '/hotdeal/admin/main?keyWord='+keyWord+'&pageNum=1'
        }

    </script>
</head>
<body>
<header>
    <jsp:include page="../header.jsp"></jsp:include>
</header>
<main id="hotdeal-admin-page" class="w-75 mt-5 mx-auto">
    <div class="d-flex mb-2">
        <div class="p-2">
<%--            <a href="/hotdeal/admin/main"><img src="/upload/logo.png" width="25%"></a>--%>
            <h3>관리자페이지</h3>
        </div>
        <div class="d-flex ms-auto h-75 align-self-end">
            <input type="text" id="keyWord" class="form-control me-2" placeholder="검색하기" style="width: 10rem;">
            <button type="button" id="search" onclick="search()" class="btn btn-primary btn-color-thebora"><i class="bi bi-search"></i></button>
        </div>
    </div>
    <div class="border rounded-1 mb-3">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col">상품명</th>
                    <th scope="col"></th>
                    <th scope="col">카테고리</th>
                    <th scope="col">판매가격</th>
                    <th scope="col">재고수량</th>
                    <th scope="col">판매기간</th>
                    <th scope="col">구매제한</th>
                    <th scope="col">누적판매량</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${iList}">
                    <tr>
                        <th scope="row">${item.sb_num}</th>
                        <td>
                            <a href="#" data-bs-toggle="modal" data-bs-target="#modal_container" onclick="modalView(this)" name="${item.sb_num}" id="${item.sb_num}_name" class="item-title">${item.sb_title}</a>
                        </td>
                        <td>
                            <a href="/hotdeal/list/detail?sb_num=${item.sb_num}" target="_blank"><i class="bi bi-plus-square-fill"></i></a>
                        </td>
                        <td id="${item.sb_num}_category">
                            ${item.sb_category}
                        </td>
                        <td id="${item.sb_num}_price">
                            ${item.sb_price}
                        </td>
                        <td id="${item.sb_num}_quantity">
                            ${item.sb_count}
                        </td>
                        <td id="${item.sb_num}_enddate">
                            ${item.sb_timer_str}
                        </td>
                        <td id="${item.sb_num}_buylevel">
                            ${item.sb_buylevel}
                        </td>
                        <td>
                            1
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div class="d-grid gap-2 mb-3 mx-auto">
        <div class="pagination justify-content-center mt-4">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <!-- Previous button -->
                    <li class="page-item <c:if test='${startPage == 1}'> disabled </c:if>'">
                        <a class="page-link" href="?pageNum=${startPage - pageCount}" aria-label="Previous">
                            이전
                        </a>
                    </li>
                    <!-- Page numbers -->
                    <c:forEach var="i" begin="${startPage}" end="${endPage}">
                        <li class="page-item<c:if test='${currentPage == i}'> active </c:if>'" aria-current="page">
                            <a class="page-link" href="?pageNum=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <!-- Next button -->
                    <li class="page-item <c:if test='${endPage == totalPages}'> disabled </c:if>'">
                        <a class="page-link" href="?pageNum=${endPage + 1}" aria-label="Next">
                            다음
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <a href="/hotdeal/add_item" class="btn btn-primary btn-color-thebora" role="button">상품 등록 페이지를 열기</a>
        <a href="/hotdeal/list" class="btn btn-primary btn-color-thebora" role="button">판매 페이지로 돌아가기</a>
    </div>
</main>

<!-- Modal -->
<div class="modal fade modal-xl" id="modal_container" tabindex="-1" aria-labelledby="modal_containerLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="modal_containerLabel"></h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="p-3">
                    <div class="row row-cols-2">
                        <div class="col-md-4">
                            <div class="text-center align-middle h-100">
                                <div onclick="upload()" id="preview_main">
                                    <img src="/img/logo.png" id="preview_main_img">
                                </div>
                                <div id="preview_sub" class="row row-cols-4">
                                </div>
                            </div>
                            <input type="file" name="attachments" id="attachments" multiple accept="image/*" hidden="hidden"/>
                        </div>
                        <div class="col-md-8">
                            <div class="row row-cols-2 gy-3">
                                <div class="col-6">
                                    <input type="hidden" id="sb_num" name="sb_num" value="#">
                                    상품명
                                    <input type="text" class="form-control" id="sb_title" name="sb_title">
                                </div>
                                <div class="col-6">
                                    카테고리
                                    <select id="sb_category" name="sb_category" class="form-select">
                                        <option>카테고리 선택</option>
                                        <c:forEach var="category" items="${cList}">
                                            <option value="${category.c_kind}">${category.c_kind}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-6">
                                    가격
                                    <input type="text" class="form-control" id="sb_price" name="sb_price">
                                </div>
                                <div class="col-6">
                                    수량
                                    <input type="text" class="form-control" id="sb_count" name="sb_count">
                                </div>
                                <div class="col-6">
                                    <div class="row row-cols-2 g-2">
                                        <div class="col-3">
                                            판매기간
                                        </div>
                                        <div class="col-9">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioDate" id="radioDate1" value="option1" checked>
                                                <label class="form-check-label" for="radioDate1">
                                                    지정안함
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioDate" id="radioDate2" value="option2">
                                                <label class="form-check-label" for="radioDate2">
                                                    지정일까지
                                                </label>
                                                <input type="datetime-local" class="form-control myInput mt-1" placeholder="날짜를 선택하세요." readonly="readonly">
                                                <input type="text" name="sb_timer" id="sb_timer" hidden="hidden">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="row row-cols-2 g-2">
                                        <div class="col-3">
                                            구매제한
                                        </div>
                                        <div class="col-9">
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioMem" id="radioMem1" value="option1" checked>
                                                <label class="form-check-label" for="radioMem1">
                                                    모든 회원
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="radioMem" id="radioMem2" value="option2">
                                                <label class="form-check-label" for="radioMem2">
                                                    <div class="row">
                                                        <div class="col-auto">
                                                            구매 가능 레벨
                                                        </div>
                                                        <div class="col-auto p-0">
                                                            <input type="text" class="form-control" size="1em" id="sb_buylevel" name="sb_buylevel" value="${inventory.sb_buylevel}">
                                                        </div>
                                                        <div class="col-auto">
                                                            부터
                                                        </div>
                                                    </div>
                                                </label>
                                            </div>
                                        </div><!-- 구매제한 내용 오른쪽-->
                                    </div><!-- 구매제한 내용 좌우정렬 -->
                                </div><!-- 구매제한 랩핑 끝-->
                            </div><!-- 상품정보 input 좌우정렬 -->
                            <div>
                                <label class="form-label">상품설명</label>
                                <div class="main-container">
                                    <div class="editor-container editor-container_classic-editor" id="editor-container">
                                        <div class="editor-container__editor">
                                            <textarea id="sb_contents" name="sb_contents"></textarea>
                                            <div id="sb_contents_hidden" style="display: none">desc</div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div><!-- 상품정보 랩핑 끝-->
                    </div><!-- 상품이미지/상품정보 좌우정렬 -->
                </div><!-- 전체 내용 랩핑 끝 -->
            </div>
            <div class="modal-footer d-flex">
                <button type="button" class="btn btn-danger me-auto" data-bs-dismiss="modal">상품 삭제</button>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                <button type="button" class="btn btn-primary btn-color-thebora" onclick="quickUpdate()" data-bs-dismiss="modal" id="quicksave">변경사항 저장</button>
            </div>
        </div>
    </div>
    <script type="importmap">
        {
            "imports": {
                "ckeditor5": "https://cdn.ckeditor.com/ckeditor5/42.0.1/ckeditor5.js",
                "ckeditor5/": "https://cdn.ckeditor.com/ckeditor5/42.0.1/"
            }
        }
    </script>
    <script type="module" src="/api/ckeditor5/main.js"></script>
</div>
<footer>
    <jsp:include page="../footer.jsp"></jsp:include>
</footer>
</body>
</html>
