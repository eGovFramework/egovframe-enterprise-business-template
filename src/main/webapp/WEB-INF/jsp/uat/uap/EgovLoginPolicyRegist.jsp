<%--
  Class Name : EgovLoginPolicyRegist.jsp
  Description : EgovLoginPolicyRegist 화면
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

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>로그인정책 등록</title>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="loginPolicy" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectLoginPolicyList() {
    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/selectLoginPolicyList.do'/>";
    varFrom.submit();       
}

function fncLoginPolicyInsert() {

    var varFrom = document.getElementById("loginPolicy");
    varFrom.action = "<c:url value='/uat/uap/addLoginPolicy.do'/>";

    if(confirm("저장 하시겠습니까?")){
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
                            <li>사용자관리</li>
                            <li>&gt;</li>
                            <li><strong>로그인정책 등록</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>로그인정책 등록</strong></h2></div>
                </div>
                <form:form commandName="loginPolicy" method="post" action="${pageContext.request.contextPath}/uat/uap/addLoginPolicy.do"> 

                    <div class="modify_user" >
                        <table summary="로그인정책을 등록한다.">
						  <tr>
						    <th class="required_text" width="20%" scope="row" nowrap="nowrap">사용자ID
                            <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                             -->
                            </th>
						    <td nowrap="nowrap"><input name="emplyrId_view" value="<c:out value='${loginPolicy.emplyrId}'/>" disabled="disabled" title="사용자ID(화면출력용)">
						                        <input name="emplyrId" id="emplyrId" title="사용자ID" type="hidden" size="30" readonly="readonly" value="<c:out value='${loginPolicy.emplyrId}'/>"></td>
						  </tr>
						  <tr>
						    <th class="required_text" width="20%" scope="row" nowrap="nowrap">사용자명
                            <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                             -->
                            </th>
						    <td nowrap="nowrap"><input name="emplyrNm_view" value="<c:out value='${loginPolicy.emplyrNm}'/>" disabled="disabled" title="사용자명(화면출력용)">
						                        <input name="emplyrNm" id="emplyrNm" title="사용자명" type="hidden" maxLength="50" size="30" readonly="readonly" value="<c:out value='${loginPolicy.emplyrNm}'/>" ></td>
						  </tr>
						  <tr>
						    <th class="required_text" width="20%" scope="row" nowrap="nowrap">IP정보
                            <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                             -->
                            </th>
						    <td nowrap="nowrap"><input name="ipInfo" id="ipInfo" title="IP정보" type="text" maxLength="23" size="30"  >&nbsp;<form:errors path="ipInfo" /></td>
						  </tr>
						  <tr>
						    <th class="required_text" width="20%" scope="row" nowrap="nowrap">IP제한여부
                            <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                             -->
                            </th>
						    <td nowrap="nowrap">
						      <select name="lmttAt" id="lmttAt" title="IP제한여부">
						          <option value="Y">Y</option>
						          <option value="N">N</option>
						      </select>&nbsp;<form:errors path="lmttAt" />
						      (Y로 설정되면 등록된 IP에서의 접속만을 허용하도록 제한됨)
						    </td> 
						  </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                            <tr> 
                              <td>
                                <a href="#LINK" onclick="javascript:fncLoginPolicyInsert(); return false;" style="selector-dummy:expression(this.hideFocus=false);"><spring:message code="button.save" /></a>  
                              </td>
                              <td width="10"></td>
                              <td>
                                <a href="<c:url value='/uat/uap/selectLoginPolicyList.do'/>?pageIndex=<c:out value='${loginPolicyVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${loginPolicyVO.searchKeyword}"/>&amp;searchCondition=1" onclick="fncSelectLoginPolicyList(); return false;"><spring:message code="button.list" /></a>  
                              </td>
                            </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
					<input type="hidden" name="dplctPermAt" value="Y" >
					<input type="hidden" name="searchCondition" value="<c:out value='${loginPolicyVO.searchCondition}'/>" >
					<input type="hidden" name="searchKeyword" value="<c:out value='${loginPolicyVO.searchKeyword}'/>" >
					<input type="hidden" name="pageIndex" value="<c:out value='${loginPolicyVO.pageIndex}'/>" >
                    <!-- 검색조건 유지 -->
                </form:form>

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

