<%--
  Class Name : Sample.jsp 
  Description : 샘플화면 - 관리용화면샘플(sample)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	
<title>내부업무 사이트 > 샘플화면(기능별 생성)</title>
</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
        <!-- Header -->
        <c:import url="/sym/mms/EgovHeader.do" />
        <!--// Header -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
                        <!-- Left menu -->
                        <c:import url="/sym/mms/EgovMenuLeft.do" />
                        <!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">샘플</a></li>
                                        <li>샘플화면</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">샘플</h1>

                                <h2 class="tit_2">샘플화면</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <span class="lb">상태정보</span>
                                    <label class="item f_select" for="sel1">
                                        <select name="" id="sel1" title="조건">
                                            <option value="">승인</option>
                                            <option value="">비승인</option>
                                        </select>
                                    </label>

                                    <span class="lb ml20">가입일자</span>

                                    <input class="f_date" type="text" value="2021-07-11">
                                    <a href="" class="btn btn_calendar mr10">달력</a>
                                    <input class="f_date" type="text" value="2021-07-11">
                                    <a href="" class="btn btn_calendar">달력</a>

                                    <label for="usernm" class="lb ml20">사용자명</label>
                                    <span class="item f_search">
                                        <input class="f_input w_130" type="text" name="" id="usernm" title="검색어">
                                        <button class="btn" type="submit">조회</button>
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="btn_area al_r">
                                    <a href="" class="item btn btn_blue_46 w_100">등록</a>
                                    <a href="" class="item btn btn_blue_46 w_100">삭제</a>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                            <col style="width: 150px;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">선택</th>
                                                <th scope="col">아이디</th>
                                                <th scope="col">상태</th>
                                                <th scope="col">회원명</th>
                                                <th scope="col">권한그룹</th>
                                                <th scope="col">등록일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="">
                                                    </span>
                                                </td>
                                                <td><a href="" class="lnk">admin_test01_0707</a></td>
                                                <td>승인</td>
                                                <td>홍길동</td>
                                                <td>관리자</td>
                                                <td>2021-06-13</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="">
                                                    </span>
                                                </td>
                                                <td><a href="" class="lnk">admin_test01_0707</a></td>
                                                <td>승인</td>
                                                <td>홍길동</td>
                                                <td>관리자</td>
                                                <td>2021-06-13</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="">
                                                    </span>
                                                </td>
                                                <td><a href="" class="lnk">admin_test01_0707</a></td>
                                                <td>승인</td>
                                                <td>홍길동</td>
                                                <td>관리자</td>
                                                <td>2021-06-13</td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <li class="btn"><a href="" class="first">처음</a></li>
                                            <li class="btn"><a href="" class="btn prev">이전</a></li>
                                            <li><strong>1</strong></li>
                                            <li><a href="">2</a></li>
                                            <li><a href="">3</a></li>
                                            <li><a href="">4</a></li>
                                            <li><a href="">5</a></li>
                                            <li><a href="">6</a></li>
                                            <li><a href="">7</a></li>
                                            <li><a href="">8</a></li>
                                            <li><a href="">9</a></li>
                                            <li><a href="">10</a></li>
                                            <li class="btn"><a href="" class="btn next">다음</a></li>
                                            <li class="btn"><a href="" class="btn last">마지막</a></li>
                                        </ul>
                                    </div>
                                </div>
                                <!--// 게시판 -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <c:import url="/sym/mms/EgovFooter.do" />
        <!--// Footer -->
    </div>
    
</body>
</html>