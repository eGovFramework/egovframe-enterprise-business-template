<%--
  Class Name : EgovLoginPolicyList.jsp
  Description : EgovLoginPolicyList 화면
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   lee.m.j            최초 생성
     2011.08.31   JJY       경량환경 버전 생성

    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ page import="egovframework.com.cmm.LoginVO"%>
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

<title>내부업무 사이트 > 내부서비스관리 > 로그인정책관리</title>

<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncCheckAll() {
    var checkField = document.listForm.delYn;
    if(document.listForm.checkAll.checked) {
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

function fncManageChecked() {

    var checkField = document.listForm.delYn;
    var checkId = document.listForm.checkId;
    var returnValue = "";
    var returnBoolean = false;
    var checkCount = 0;

    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i<checkField.length; i++) {
                if(checkField[i].checked) {
                    checkCount++;
                    checkField[i].value = checkId[i].value;
                    if(returnValue == "")
                        returnValue = checkField[i].value;
                    else
                        returnValue = returnValue + ";" + checkField[i].value;
                }
            }
            if(checkCount > 0)
                returnBoolean = true;
            else {
                alert("선택된  로그인정책이 없습니다.");
                returnBoolean = false;
            }
        } else {
            if(document.listForm.delYn.checked == false) {
                alert("선택된  로그인정책이 없습니다.");
                returnBoolean = false;
            }
            else {
                returnValue = checkId.value;
                returnBoolean = true;
            }
        }
    } else {
        alert("조회된 결과가 없습니다.");
    }

    document.listForm.emplyrIds.value = returnValue;
    return returnBoolean;
}

function fncSelectLoginPolicyList(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    document.listForm.submit();
}

function fncSelectLoginPolicy(emplyrId) {
    document.listForm.emplyrId.value = emplyrId;
    document.listForm.action = "<c:url value='/uat/uap/getLoginPolicy.do'/>";
    document.listForm.submit();
}

function fncInsertCheckId() {

    var checkedCounter = 0;
    var checkIds = document.listForm.delYn;
    var checkIdv = document.listForm.checkId;
    var checkReg = document.listForm.regYn;

    if(checkIds == null) {
        alert("조회 후 등록하시기 바랍니다");
        return;
    }
    else {

        for(var i=0; i<checkIds.length; i++) {
            if(checkIds[i].checked) {
                if(checkReg[i].value == 'Y' ) {
                    alert("이미 로그인정책이 등록되어 있습니다.");
                    return;
                }
                checkedCounter++;
                document.listForm.emplyrId.value = checkIdv[i].value;
            }
        }

        if(checkedCounter > 1) {
            alert("등록대상 하나만 선택하십시오");
            return false;
        } else if(checkedCounter < 1) {
            alert("선택된 등록대상이  없습니다");
            return false;
        }

        return true;
    }
}

function fncAddLoginPolicyInsert() {

    if(fncInsertCheckId()) {
        document.listForm.action = "<c:url value='/uat/uap/addLoginPolicyView.do'/>";
        document.listForm.submit();
    }
}

function fncLoginPolicyListDelete() {
    if(fncManageChecked()) {
        if(confirm('<spring:message code="common.delete.msg" />')) {
            document.listForm.action = "<c:url value='/uat/uap/removeLoginPolicyList.do'/>";
            document.listForm.submit();
        }
    }
}

function linkPage(pageNo){
    document.listForm.searchCondition.value = "1";
    document.listForm.pageIndex.value = pageNo;
    document.listForm.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    document.listForm.submit();
}

function press() {

    if (event.keyCode==13) {
        fncSelectLoginPolicyList('1');
    }
}
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
                                        <li><a href="">내부서비스관리</a></li>
                                        <li><a href="">사용현황관리</a></li>
                                        <li>로그인정책관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2">로그인정책관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                	
                                	<form name="listForm" action="<c:url value='/uat/uap/selectLoginPolicyList.do'/>" method="post">
                                	
                                	<input type="hidden" name="emplyrId">
                                	<input type="hidden" name="pageIndex" value="<c:if test="${empty loginPolicyVO.pageIndex }">1</c:if><c:if test="${!empty loginPolicyVO.pageIndex }"><c:out value='${loginPolicyVO.pageIndex}'/></c:if>">
                                	<input type="hidden" name="searchCondition" value="1" >
                                	
                                    <span class="lb mr10"><label for="searchKeyword">사용자 명 : </label></span>

                                    <span class="item f_search">
                                        <input id="searchKeyword" class="f_input w_350" name="searchKeyword" type="text" value="<c:out value="${loginPolicyVO.searchKeyword}"/>" title="검색" onkeypress="press();" >
                                        <button class="btn" type="submit" onclick="javascript:fncSelectLoginPolicyList('1')"><spring:message code='button.inquire' /></button><!-- 조회 -->
                                    </span>
                                    
                                    </form>
                                    
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <div class="board_list">
                                    <table summary="로그인정책에 대한 목록을 제공한다.">
                                    	<caption>로그인정책 관리</caption>
                                        <colgroup>
                                            <col style="width: 50%;">
                                            <col style="width: 50%;">
                                            <col style="width: 50%;">
                                            <col style="width: 50%;">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <th scope="col">사용자ID</th>
                                                <th scope="col">사용자 명</th>
                                                <th scope="col">IP 정보</th>
                                                <th scope="col">제한여부</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        
                                        	<c:forEach var="loginPolicy" items="${loginPolicyList}" varStatus="status">
	                                            <tr>
	                                                <td>
	                                                	<form name="item" method="post" action="<c:url value='/uat/uap/getLoginPolicy.do'/>">
	                                                		<input type="hidden" name="emplyrId" value="<c:out value="${loginPolicy.emplyrId}"/>">
	                                                		<input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>">
	                                                		<input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>">
	                                                		<input type="hidden" name="searchKeyword" value="<c:out value="${loginPolicyVO.searchKeyword}"/>">
			                                                <a href="#LINK" class="lnk" onclick="javascript:fncSelectLoginPolicy('<c:out value="${loginPolicy.emplyrId}"/>'); return false;">
			                                                	<c:out value="${loginPolicy.emplyrId}"/>
			                                                </a>
		                                                </form>
	                                                </td>
	                                                <td><c:out value="${loginPolicy.emplyrNm}"/></td>
	                                                <td><c:out value="${loginPolicy.ipInfo}"/></td>
	                                                <td><c:if test="${loginPolicy.lmttAt == 'Y'}">Y</c:if><c:if test="${loginPolicy.lmttAt == 'N'}">N</c:if></td>
	                                            </tr>
                                            </c:forEach>
                                            
                                        </tbody>
                                    </table>
                                </div>

								<!-- 페이지 네비게이션 시작 -->
								<c:if test="${!empty loginPolicyVO.pageIndex }">
	                                <div class="board_list_bot">
	                                    <div class="paging" id="paging_div">
	                                        <ul>
	                                            <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
	                                        </ul>
	                                    </div>
	                                </div>
                                </c:if>
                                <!-- //페이지 네비게이션 끝 -->
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