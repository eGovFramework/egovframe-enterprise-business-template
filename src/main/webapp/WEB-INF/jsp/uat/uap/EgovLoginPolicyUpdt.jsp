<%--
  Class Name : EgovLoginPolicyUpdt.jsp
  Description : EgovLoginPolicyUpdt 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01   lee.m.j            최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.02.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>

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
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="loginPolicy" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--

function fncSelectLoginPolicyList() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    varFrom.submit();       
}

function fncLoginPolicyUpdate() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/updtLoginPolicy.do'/>";

    if(confirm('<spring:message code="common.update.msg" />')){
        if(!validateLoginPolicy(varFrom)){           
            return;
        }else{
            if(ipValidate())
                varFrom.submit();
            else 
                return;
        } 
    }
}

function fncLoginPolicyDelete() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/removeLoginPolicy.do'/>";
    if(confirm('<spring:message code="common.delete.msg" />')){
        varFrom.submit();
    }
}

function ipValidate() {
    
    var varFrom = document.getElementById("loginPolicy");
    var IPvalue = varFrom.ipInfo.value;

    var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
    var ipArray = IPvalue.match(ipPattern);

    var result = "";
    var thisSegment;

    if(IPvalue == "0.0.0.0") {
        alert(IPvalue + "는 예외 아이피 입니다..");
        result = false;
    } else if (IPvalue == "255.255.255.255") {
        alert(result =IPvalue + "는 예외 아이피 입니다.");
        result = false;
    } else {
        result = true;
    }

    if(ipArray == null) {
        alert("형식이 일치 하지않습니다. ");
        result = false;
    } else {
        for (var i=1; i<5; i++) {
            
            thisSegment = ipArray[i];

            if (thisSegment > 255) {
                alert("형식이 일치 하지않습니다. ");
                result = false;
            }
            
            if ((i == 0) && (thisSegment > 255)) {
                alert("형식이 일치 하지않습니다. ");
                result = false;
            }
        }
    }

    return result;
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

								<form:form modelAttribute="loginPolicy" method="post" action="${pageContext.request.contextPath}/uat/uap/updtLoginPolicy.do">

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2">로그인정책관리</h2>
                                
                                <div class="board_view2">
                                    <table summary="로그인정책을 수정한다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자ID</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="" class="f_txt" name="emplyrId_view" value="<c:out value='${loginPolicy.emplyrId}'/>" disabled="disabled" title="사용자ID(화면출력용)" readonly="readonly">
                                                <input name="emplyrId" id="emplyrId" title="사용자ID" type="hidden" readonly="readonly" value="<c:out value='${loginPolicy.emplyrId}'/>" >
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrNm">사용자명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="" class="f_txt" name="emplyrNm_view" value="<c:out value='${loginPolicy.emplyrNm}'/>" disabled="disabled" title="사용자명(화면출력용)" readonly="readonly">
                                                <input name="emplyrNm" id="emplyrNm" title="사용자명" type="hidden" value="<c:out value='${loginPolicy.emplyrNm}'/>" maxLength="50" readonly="readonly">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="ipInfo">IP정보</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input id="ipInfo" class="f_txt" name="ipInfo" title="IP정보" type="text" value="<c:out value='${loginPolicy.ipInfo}'/>" maxLength="23" >
                                                <form:errors path="ipInfo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                            	<label for="lmttAt">IP제한여부</label>
                                            </td>
                                            <td>
                                                <label id="lmttAt" class="f_select" name="lmttAt" for="lmttAt">
                                                    <select name="lmttAt" id="lmttAt" title="IP제한여부">
                                                        <option value="Y" <c:if test="${loginPolicy.lmttAt == 'Y'}">selected</c:if> >Y</option>
                                                        <option value="N" <c:if test="${loginPolicy.lmttAt == 'N'}">selected</c:if> >N</option>
                                                    </select>
                                                </label>
                                                <span class="f_txt_inner ml15">(Y로 설정되면 등록된 IP에서의 접속만을 허용하도록 제한됨)</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="regDate">등록일시</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="regDate" id="regDate" class="f_txt" title="등록일시" type="text" value="<c:out value='${loginPolicy.regDate}'/>" maxLength="50" readOnly >
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    	<a href=<c:url value='/uat/uap/removeLoginPolicy.do'/>?emplyrId=<c:out value='${loginPolicyVO.emplyrId}'/>"" class="btn btn_skyblue_h46 w_100" onclick="fncLoginPolicyDelete(); return false;">
                                    		<spring:message code='button.delete' />
                                    	</a><!-- 삭제 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncLoginPolicyUpdate(); return false;"><spring:message code='button.save' /></a><!-- 저장 -->
                                        <a href="<c:url value='/uat/uap/selectLoginPolicyList.do'/>?pageIndex=<c:out value='${loginPolicyVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${loginPolicyVO.searchKeyword}"/>&amp;searchCondition=1" class="btn btn_blue_46 w_100" onclick="fncSelectLoginPolicyList(); return false;">
                                        	<spring:message code='button.list' />
                                        </a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
								<input type="hidden" name="dplctPermAt" value="Y" >
								<input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>" >
								<input type="hidden" name="searchKeyword" value="<c:out value='${loginPolicyVO.searchKeyword}'/>" >
								<input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>" >
			                    <!-- 검색조건 유지 -->
			                    
				                </form:form>
                                
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