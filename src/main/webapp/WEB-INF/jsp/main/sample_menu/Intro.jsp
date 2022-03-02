<%--
  Class Name : Intro.jsp
  Description : 샘플화면 - 구성설명(sample)
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

<title>표준프레임워크 경량환경 내부업무 템플릿 소개</title>

<script type="text/javaScript" language="JavaScript">
<!--
/* ********************************************************
 * 취소처리
 ******************************************************** */
function fn_egov_cancel_popup() {
	parent.fn_egov_modal_remove();
}
//-->
</script>

</head>

<body>

<!-- 템플릿소개 팝업 -->
<!-- default : display: none 상태 -->
<div class="popup POP_TEMPLATE_INTRO">
    <div class="pop_inner">
        <div class="pop_header">
            <h1>내부업무 템플릿 소개</h1>
            <button type="button" class="close" onclick="fn_egov_cancel_popup(); return false;">닫기</button>
        </div>

        <div class="pop_container">
            <ul class="list">
                <li>경량환경 템플릿은 개발자가 프레임워크 쉽게 이해하고 활용할 수 있도록 지원합니다.</li>
                <li>홈페이지 템플릿은 공통컴포넌트를 기반으로 아래 그림과 같이 메뉴가 구성됩니다.</li>
                <li>관리자로 로그인하면 관리자용 메뉴를 추가로 사용할 수 있습니다.</li>
                <li>기울임체로 표시된 메뉴는 구성을 위한 샘플페이지가 제공되며 기능은 구현되지 않은 상태입니다.</li>
            </ul>

            <div class="list2">
                <div>
                    <h2>알림정보</h2>
                    <ul class="dep1">
                        <li>공지사항</li>
                        <li>업무게시판</li>
                    </ul>
                </div>
                <div>
                    <h2>직급관리</h2>
                    <ul class="dep1" style="font-style: italic;">
                        <li>입퇴사정보관리</li>
                        <li>직급정보관리</li>
                        <li>직위정보관리</li>
                    </ul>
                </div>
                <div>
                    <h2>진급관리</h2>
                    <ul class="dep1" style="font-style: italic;">
                        <li>업무평가점수관리</li>
                        <li>상벌정보관리</li>
                    </ul>
                </div>
                <div>
                    <h2>근태관리</h2>
                    <ul class="dep1" style="font-style: italic;">
                        <li>출퇴근정보관리</li>
                        <li>휴무정보관리</li>
                    </ul>
                </div>

                <div>
                    <h2>내부서비스관리</h2>
                    <ul class="dep2">
                        <li>게시판관리
                            <ul>
                                <li>-게시판생성관리</li>
                                <li>-게시판사용관리</li>
                                <li>-공지사항관리</li>
                                <li>-업무게시판관리</li>
                            </ul>
                        </li>
                        <li>사용현황관리
                            <ul>
                                <li>-접속로그관리</li>
                                <li>-접속통계관리</li>
                                <li>-로그인정책관리</li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div>
                    <h2>내부시스템관리</h2>
                    <ul class="dep2">
                        <li>사용자관리
                            <ul>
                                <li>-사용자등록관리</li>
                                <li>-사용자부재관리</li>
                            </ul>
                        </li>
                        <li>사용자권한관리
                            <ul>
                                <li>-권한관리</li>
                                <li>-사용자그룹관리</li>
                                <li>-사용자별권한관리</li>
                                <li>-롤관리</li>
                            </ul>
                        </li>
                        <li>메뉴관리
                            <ul>
                                <li>-프로그램목록관리</li>
                                <li>-메뉴생성관리</li>
                                <li>-메뉴목록관리</li>
                            </ul>
                        </li>
                        <li>코드관리
                            <ul>
                                <li>-분류코드관리</li>
                                <li>-공통코드관리</li>
                                <li>-상세코드관리</li>
                                <li>-우편번호관리</li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
            <p><img src="./images/img_POP_TEMPLATE_INTRO.png" alt=""></p>
<!--             <div class="btn_area al_c"> -->
<!--                 <a href="https://www.egovframe.go.kr/wiki/doku.php?id=egovframework:let" class="btn btn_blue_46" target="_blank">경량환경 템플릿 위키가이드 보기</a> -->
<!--             </div> -->
        </div>
    </div>
</div>
<!--// 템플릿소개 팝업 -->
    
</body>
</html>