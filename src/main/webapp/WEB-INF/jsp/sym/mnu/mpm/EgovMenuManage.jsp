<%--
  Class Name : EgovMenuManage.jsp
  Description : 메뉴관리 조회 화면
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
  String imagePath_icon   = "/images_old/egovframework/sym/mpm/icon";
  String imagePath_button = "/images_old/egovframework/sym/mpm/button";
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

<title>내부업무 사이트 > 내부시스템관리 > 메뉴목록관리</title>

<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.menuManageForm.checkField;
    if(document.menuManageForm.checkAll.checked) {
        if(checkField) {
            if(checkField.length > 1) {
                for(var i=0; i < checkField.length; i++) {
                    checkField[i].checked = true;
                }
            } else {
                checkField.checked = true;
            }
        }
    } else {
        if(checkField) {
            if(checkField.length > 1) {
                for(var j=0; j < checkField.length; j++) {
                    checkField[j].checked = false;
                }
            } else {
                checkField.checked = false;
            }
        }
    }
}
/* ********************************************************
 * 멀티삭제 처리 함수
 ******************************************************** */
function fDeleteMenuList() {
    var checkField = document.menuManageForm.checkField;
    var menuNo = document.menuManageForm.checkMenuNo;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {

        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + menuNo[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = menuNo.value;
            }
        }
    }   

    document.menuManageForm.checkedMenuNoForDel.value=checkMenuNos;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDelete.do'/>";
    document.menuManageForm.submit(); 
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//  document.menuManageForm.searchKeyword.value = 
    document.menuManageForm.pageIndex.value = pageNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectMenuManageList() { 
    document.menuManageForm.pageIndex.value = 1;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}

/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertMenuManage() {
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuRegistInsert.do'/>";
    document.menuManageForm.submit();   
}

/* ********************************************************
 * 일괄처리 화면호출 함수
 ******************************************************** */
/* function bndeInsertMenuManage() {
        document.menuManageForm.action = "<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>";
        document.menuManageForm.submit();   
    }
 */
function bndeInsertMenuManage() {
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuBndeRegist.do'/>";
    document.menuManageForm.submit();
} 
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtMenuManageDetail(menuNo) {
    document.menuManageForm.req_menuNo.value = menuNo;
    document.menuManageForm.action = "<c:url value='/sym/mnu/mpm/EgovMenuManageListDetailSelect.do'/>";
    document.menuManageForm.submit();   
}
/* ********************************************************
 * 최초조회 함수
 ******************************************************** */
function fMenuManageSelect(){ 
    document.menuManageForm.action = "<c:url value='/sym/mpm/EgovMenuManageSelect.do'/>";
    document.menuManageForm.submit();
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
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
                                        <li>메뉴목록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="menuManageForm" action ="<c:url value='/sym/mnu/mpm/EgovMenuManageSelect.do'/>" method="post">
								
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input name="checkedMenuNoForDel" type="hidden" />
								<input name="req_menuNo" type="hidden" />

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">메뉴목록관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <span class="lb mr10">메뉴명 : </span>
                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_350" name="searchKeyword" type="text" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="60" title="검색조건"/>
                                        <button class="btn" type="submit" onclick="javascript:selectMenuManageList(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_list_top">
                                    <div class="left_col">
                                    </div>

                                    <div class="right_col">
                                        <a href="<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>" class="btn btn_blue_46 w_100" onclick="bndeInsertMenuManage(); return false;">일괄등록</a><!-- 일괄등록 -->
                                        <a href="<c:url value='/sym/mpm/EgovMenuRegistInsert.do'/>" class="btn btn_blue_46 w_100" onclick="insertMenuManage(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fDeleteMenuList(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="메뉴관리 목록 조회화면으로 메뉴ID,메뉴한글명,프로그램파일명,메뉴설명,상위메뉴ID로 구성.">
                                    	<caption>메뉴관리 목록</caption>
                                        <colgroup>
                                            <col style="width: 80px;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">
                                                    <span class="f_chk_only chkAll">
                                                        <input type="checkbox" name="checkAll" onclick="javascript:fCheckAll();" title="전체선택"/>
                                                    </span>
                                                </th>
                                                <th scope="col">메뉴번호</th>
                                                <th scope="col">메뉴명</th>
                                                <th scope="col">프로그램파일명</th>
                                                <th scope="col">메뉴설명</th>
                                                <th scope="col">상위메뉴번호</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${empty list_menumanage}">
                                        		<tr>
                                        			<td colspan="6"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${list_menumanage}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="checkField" title="선택"/>
                                                        <input name="checkMenuNo" type="hidden" value="<c:out value='${result.menuNo}'/>"/>
                                                    </span>
                                                </td>
                                                <td><c:out value="${result.menuNo}"/></td>
                                                <td>
	                                                <a href="<c:url value='/sym/mpm/EgovMenuManageListDetailSelect.do?req_menuNo='/>${result.menuNo}" class="lnk" onclick="selectUpdtMenuManageDetail('<c:out value="${result.menuNo}"/>'); return false;">
	                                                	<c:out value="${result.menuNm}"/>
	                                                </a>
                                                </td>
                                                <td><c:out value="${result.progrmFileNm}"/></td>
                                                <td><c:out value="${result.menuDc}"/></td>
                                                <td><c:out value="${result.upperMenuId}"/></td>
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
                                <!-- // 페이지 네비게이션 끝 -->
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