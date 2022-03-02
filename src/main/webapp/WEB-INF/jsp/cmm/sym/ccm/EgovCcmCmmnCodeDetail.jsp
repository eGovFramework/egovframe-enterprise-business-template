<%--
  Class Name : EgovCcmCmmnCodeDetail.jsp
  Description : EgovCcmCmmnCodeDetail 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:url var="ImgUrl" value="/images"/>
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

<title>내부업무 사이트 > 내부시스템관리 > 공통코드관리</title>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<meta http-equiv="content-language" content="ko">
<link type="text/css" rel="stylesheet" href="/css_old/com.css">
<link href="<c:url value='/css_old/button.css' />" rel="stylesheet" type="text/css">
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInit(){
}
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fnList(){
    location.href = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeList.do'/>";
}
/* ********************************************************
 * 수정화면으로  바로가기
 ******************************************************** */
function fnModify(){
    var varForm              = document.all["Form"];
    varForm.action           = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeModify.do'/>";
    varForm.codeId.value     = "${result.codeId}";
    varForm.submit();
}
/* ********************************************************
 * 삭제 처리 함수
 ******************************************************** */
function fnDelete(){
    if (confirm("<spring:message code='common.delete.msg'/>")) {
        var varForm              = document.all["Form"];
        varForm.action           = "<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeRemove.do'/>";
        varForm.codeId.value     = "${result.codeId}";
        varForm.submit();
    }
}
//-->
</script>
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
                                        <li><a href="">내부시스템관리</a></li>
                                        <li><a href="">코드관리</a></li>
                                        <li>공통코드관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="Form" method="post" action="<c:url value='/sym/ccm/cca/EgovCcmCmmnCodeModify.do'/>">

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">공통코드관리</h2>

                                <div class="board_view2">
                                    <table summary="분류코드명, 코드ID, 코드ID명, 코드ID설명, 사용여부를 보여주는 공통코드 상세조회 페이지이다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">분류코드</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	${result.clCodeNm}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">코드ID</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	${result.codeId}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <span class="min">코드ID명</span>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                            	${result.codeIdNm}
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="codeIdDc">코드ID설명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <textarea class="f_txtar w_full h_80" cols="30" rows="10" disabled="disabled" id="codeIdDc" readonly="readonly">${result.codeIdDc}</textarea>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="useAt">사용여부</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select" for="useAt">
                                                    <select id="useAt" name="useAt" disabled="disabled">
                                                        <option value="Y" <c:if test="${result.useAt == 'Y'}">selected="selected"</c:if> >Yes</option>
                                                        <option value="N" <c:if test="${result.useAt == 'N'}">selected="selected"</c:if> >No</option>
                                                    </select>
                                                </label>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                
                                <!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:fnDelete(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fnModify(); return false;"><spring:message code="button.update" /></a><!-- 수정 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fnList(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <input name="codeId" type="hidden">
                                
                                </form>

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