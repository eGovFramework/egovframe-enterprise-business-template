<%--
  Class Name : EgovProgramListManage.jsp
  Description : 프로그램목록 조회 화면
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

<title>내부업무 사이트 > 내부시스템관리 > 프로그램목록관리</title>

<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 모두선택 처리 함수
 ******************************************************** */
function fCheckAll() {
    var checkField = document.progrmManageForm.checkField;
    if(document.progrmManageForm.checkAll.checked) {
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
function fDeleteProgrmManageList() {
    var checkField = document.progrmManageForm.checkField;
    var ProgrmFileNm = document.progrmManageForm.checkProgrmFileNm;
    var checkProgrmFileNms = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkProgrmFileNms += ((checkedCount==0? "" : ",") + ProgrmFileNm[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkProgrmFileNms = ProgrmFileNm.value;
            }
        }
    }   

    document.progrmManageForm.checkedProgrmFileNmForDel.value=checkProgrmFileNms;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgrmManageListDelete.do'/>";
    document.progrmManageForm.submit(); 
}

/* ********************************************************
 * 페이징 처리 함수
 ******************************************************** */
function linkPage(pageNo){
//  document.menuManageForm.searchKeyword.value = 
    document.progrmManageForm.pageIndex.value = pageNo;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>";
    document.progrmManageForm.submit();
}

/* ********************************************************
 * 조회 처리 함수
 ******************************************************** */
function selectProgramListManage() { 
    document.progrmManageForm.pageIndex.value = 1;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>";
    document.progrmManageForm.submit(); 
}
/* ********************************************************
 * 입력 화면 호출 함수
 ******************************************************** */
function insertProgramListManage() {
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListRegist.do'/>";
    document.progrmManageForm.submit(); 
}
/* ********************************************************
 * 상세조회처리 함수
 ******************************************************** */
function selectUpdtProgramListDetail(progrmFileNm) {
    document.progrmManageForm.tmp_progrmNm.value = progrmFileNm;
    document.progrmManageForm.action = "<c:url value='/sym/prm/EgovProgramListDetailSelectUpdt.do'/>";
    document.progrmManageForm.submit(); 
}
/* ********************************************************
 * focus 시작점 지정함수
 ******************************************************** */
 function fn_FocusStart(){
        var objFocus = document.getElementById('F1');
        objFocus.focus();
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
                                        <li>프로그램목록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="progrmManageForm" action ="<c:url value='/sym/prm/EgovProgramListManageSelect.do'/>" method="post">
								
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
								<input name="checkedProgrmFileNmForDel" type="hidden" />

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">프로그램목록관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                    <span class="lb mr10">프로그램 한글명 : </span>
                                    <span class="item f_search">
                                        <input name="searchKeyword" class="f_input w_350" type="text" value="<c:out value='${searchVO.searchKeyword}'/>" maxlength="60" id="F1" title="검색조건">
                                        <button class="btn" type="submit" onclick="javascript:selectProgramListManage(); return false;"><spring:message code="button.inquire" /></button><!-- 조회 -->
                                    </span>
                                </div>
                                <!--// 검색조건 -->

                                <div class="board_list_top">
                                    <div class="left_col">
                                    </div>

                                    <div class="right_col">
                                        <a href="<c:url value='/sym/mpm/EgovProgramListRegist.do'/>" class="btn btn_blue_46 w_100" onclick="insertProgramListManage(); return false;"><spring:message code="button.create" /></a><!-- 등록 -->
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="fDeleteProgrmManageList(); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                    </div>
                                </div>

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="프로그램목록관리 목록으로 프로그램파일명, 프로그램명, url,프로그램설명 으로 구성">
                                    	<caption>프로그램목록관리 목록</caption>
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
                                                        <input type="checkbox" name="checkAll" onclick="javascript:fCheckAll();" title="전체선택">
                                                    </span>
                                                </th>
                                                <th scope="col">프로그램파일명</th>
                                                <th scope="col">프로그램 한글명</th>
                                                <th scope="col">URL</th>
                                                <th scope="col">프로그램설명</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        	
                                        	<c:if test="${empty list_progrmmanage}">
                                        		<tr>
                                        			<td colspan="5"><spring:message code="common.nodata.msg" /></td>
                                        		</tr>
                                        	</c:if>
                                        	
                                        	<c:forEach var="result" items="${list_progrmmanage}" varStatus="status">
                                            <tr>
                                                <td>
                                                    <span class="f_chk_only">
                                                        <input type="checkbox" name="checkField" title="선택">
                                                        <input name="checkProgrmFileNm" type="hidden" value="<c:out value='${result.progrmFileNm}'/>"/>
                                                    </span>
                                                </td>
                                                <td>
	                                                <a href="<c:url value='/sym/prm/EgovProgramListDetailSelectUpdt.do'/>?tmp_progrmNm=<c:out value="${result.progrmFileNm}"/>" class="lnk" onclick="selectUpdtProgramListDetail('<c:out value="${result.progrmFileNm}"/>'); return false;">
	                                                	<c:out value="${result.progrmFileNm}"/>
	                                                </a>
                                                </td>
                                                <td><c:out value="${result.progrmKoreanNm}"/></td>
                                                <td><c:out value="${result.URL}"/></td>
                                                <td><c:out value="${result.progrmDc}"/></td>
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
                                
                                <input type="hidden" name="cmd">
								<input type="hidden" name="tmp_progrmNm">
								
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