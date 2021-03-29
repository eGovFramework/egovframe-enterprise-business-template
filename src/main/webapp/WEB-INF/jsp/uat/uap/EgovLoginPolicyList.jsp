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
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>로그인정책 목록조회</title>

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
        if(confirm("삭제하시겠습니까?")) {
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
<!-- 전체 레이어 시작 -->
<div id="wrap">
    <!-- header 시작 -->
    <div id="header"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncHeader" /></div>
    <div id="topnavi"><c:import url="/sym/mms/EgovMainMenuHead.do" /></div>
    <!-- //header 끝 -->
    <!-- container 시작 -->
    <div id="container">
        <!-- 좌측메뉴 시작 -->
        <div id="leftmenu"><c:import url="/sym/mms/EgovMainMenuLeft.do" /></div>
        <!-- //좌측메뉴 끝 -->
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
                <div id="cur_loc">
                    <div id="cur_loc_align">
                        <ul>
                            <li>HOME</li>
                            <li>&gt;</li>
                            <li>사용현황관리</li>
                            <li>&gt;</li>
                            <li><strong>로그인정책 관리</strong></li>
                        </ul>
                    </div>
                </div>

                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>로그인정책 관리</strong></h2></div>
                    <form name="listForm" action="<c:url value='/uat/uap/selectLoginPolicyList.do'/>" method="post">
                    <input type="submit" id="invisible" class="invisible"/>
						<input type="hidden" name="emplyrId">
						<input type="hidden" name="pageIndex" value="<c:if test="${empty loginPolicyVO.pageIndex }">1</c:if><c:if test="${!empty loginPolicyVO.pageIndex }"><c:out value='${loginPolicyVO.pageIndex}'/></c:if>">
						<input type="hidden" name="searchCondition" value="1" >
                        <fieldset><legend>조건정보 영역</legend>
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="searchKeyword">사용자 명 : </label>
                                    <input id="searchKeyword" name="searchKeyword" type="text" value="<c:out value="${loginPolicyVO.searchKeyword}"/>" size="25" title="검색" onkeypress="press();" >
                                </li>
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#LINK" onclick="javascript:fncSelectLoginPolicyList('1')" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                    </div>
                                </li>
                            </ul>
                        </div>
                        </fieldset>
                    </form>
                </div>
                <!-- //검색 필드 박스 끝 -->
                <div id="page_info"><div id="page_info_align"></div></div>
                <!-- table add start -->
                <div class="default_tablestyle">
                    <table summary="로그인정책에 대한 목록을 제공한다." cellpadding="0" cellspacing="0">
                    <caption>로그인정책 관리</caption>
                    <colgroup>
                    <col width="20%" >
                    <col width="25%" >
                    <col width="20%" >
                    <col width="15%" >
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col" class="f_field" nowrap="nowrap">사용자 ID</th>
                        <th scope="col" nowrap="nowrap">사용자 명</th>
                        <th scope="col" nowrap="nowrap">IP 정보</th>
                        <th scope="col" nowrap="nowrap">제한여부</th>
                    </tr>
                    </thead>
                    <tbody>

                    <c:forEach var="loginPolicy" items="${loginPolicyList}" varStatus="status">
                    <!-- loop 시작 -->
                      <tr>
					    <td nowrap="nowrap">
					        <form name="item" method="post" action="<c:url value='/uat/uap/getLoginPolicy.do'/>">
					            <input type="hidden" name="emplyrId" value="<c:out value="${loginPolicy.emplyrId}"/>">
					            <input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>">
					            <input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>">
					            <input type="hidden" name="searchKeyword" value="<c:out value="${loginPolicyVO.searchKeyword}"/>">
					            <input type="submit" onclick="javascript:fncSelectLoginPolicy('<c:out value="${loginPolicy.emplyrId}"/>'); return false;"  value="등록" class="invisible">
					            <a href="#LINK" onclick="javascript:fncSelectLoginPolicy('<c:out value="${loginPolicy.emplyrId}"/>'); return false;" >
					                <c:out value="${loginPolicy.emplyrId}"/>
					            </a>
					        </form>
					    </td>
					    <td nowrap="nowrap"><c:out value="${loginPolicy.emplyrNm}"/></td>
					    <td nowrap="nowrap"><c:out value="${loginPolicy.ipInfo}"/></td>
					    <td nowrap="nowrap"><c:if test="${loginPolicy.lmttAt == 'Y'}">Y</c:if><c:if test="${loginPolicy.lmttAt == 'N'}">N</c:if></td>
                      </tr>
                     </c:forEach>
                    </tbody>
                    </table>
                </div>

                <!-- 페이지 네비게이션 시작 -->
                <c:if test="${!empty loginPolicyVO.pageIndex }">
                    <div id="paging_div">
                        <ul class="paging_align">
					        <ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="linkPage" />
                        </ul>
                    </div>
                <!-- //페이지 네비게이션 끝 -->
                </c:if>

            </div>
            <!-- //content 끝 -->
        </div>
        <!-- //container 끝 -->
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    </div>
    <!-- //전체 레이어 끝 -->
 </body>
</html>