<%--
  Class Name : EgovMenuCreatManage.jsp
  Description : 메뉴생성관리 조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images_old/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images_old/egovframework/sym/mpm/button/";
%>
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
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<title>내부업무 사이트 > 내부시스템관리 > 메뉴생성관리</title>

<script type="text/javaScript">
<!--
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuCreatManageSelect(){ 
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
    document.menuCreatManageForm.pageIndex.value = pageNo;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuCreatManageList() { 
    document.menuCreatManageForm.pageIndex.value = 1;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatManageSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 메뉴생성 화면 호출
 ******************************************************** */
function selectMenuCreat(vAuthorCode) {
    document.menuCreatManageForm.authorCode.value = vAuthorCode;
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sym/mnu/mcm/EgovMenuCreatSelect.do'/>?authorCode=" + vAuthorCode + '" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 850,
        height: 900,
        title: "템플릿 목록"
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}

<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
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
                                        <li><a href="">메뉴관리</a></li>
                                        <li>메뉴생성관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="menuCreatManageForm" action ="<c:url value='/sym/mpm/EgovMenuCreatManageSelect.do'/>" method="post">
								
								<input name="checkedMenuNoForDel" type="hidden" />
								<input name="authorCode" type="hidden" />
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">메뉴생성관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <span class="lb mr10">보안설정대상 ID : </span>
                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_350" name="searchKeyword" type="text" value="" maxlength="60" title="검색조건"/>
                                        <button class="btn" type="submit" onclick="javascript:selectMenuCreatManageList(); return false;"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="메뉴생성관리  목록화면으로 권한코드, 권한명, 권한설명, 메뉴생성여부, 메뉴생성으로 구성됨">
                                    	<caption>메뉴생성관리 목록</caption>
                                        <colgroup>
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">권한코드</th>
                                                <th scope="col">권한명</th>
                                                <th scope="col">권한설명</th>
                                                <th scope="col">메뉴생성여부</th>
                                                <th scope="col">메뉴생성</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${empty list_menumanage}">
                                        		<tr>
                                        			<td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${list_menumanage}" varStatus="status">
                                            <tr>
                                                <td><c:out value="${result.authorCode}"/></td>
                                                <td><c:out value="${result.authorNm}"/></td>
                                                <td><c:out value="${result.authorDc}"/></td>
                                                <td>
                                                	<c:if test="${result.chkYeoBu > 0}">Y</c:if>
                                                	<c:if test="${result.chkYeoBu == 0}">N</c:if>
                                                </td>
                                                <td>
                                                	<a href="#LINK'" class="lnk" onclick="selectMenuCreat('<c:out value="${result.authorCode}"/>'); return false;" >메뉴생성</a>
                                                </td>
                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
                                <div class="board_list_bot">
                                    <div class="paging" id="paging_div">
                                        <ul>
                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage"/>
                                        </ul>
                                    </div>
                                </div>
                                <!-- //페이지 네비게이션 끝 -->
                                <!--// 게시판 -->
                                
                                <input type="hidden" name="req_menuNo">
                                
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