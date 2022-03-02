<%--
  Class Name : EgovAuthorInsert.jsp
  Description : EgovAuthorInsert 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.02.01    lee.m.j              최초 생성
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

<c:set var="registerFlag" value="${empty authorManageVO.authorCode ? 'INSERT' : 'UPDATE'}"/>
<c:set var="registerFlagName" value="${empty authorManageVO.authorCode ? '권한 등록' : '권한 수정'}"/>

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

<title>내부업무 사이트 > 내부시스템관리 > 권한관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="authorManage" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
function fncSelectAuthorList() {
    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/sec/ram/EgovAuthorList.do'/>";
    varFrom.submit();       
}

function fncAuthorInsert() {

    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/sec/ram/EgovAuthorInsert.do'/>";

    if(confirm('<spring:message code="common.regist.msg" />')){
        if(!validateAuthorManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncAuthorUpdate() {
    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/sec/ram/EgovAuthorUpdate.do'/>";

    if(confirm('<spring:message code="common.update.msg" />')){
        if(!validateAuthorManage(varFrom)){           
            return;
        }else{
            varFrom.submit();
        } 
    }
}

function fncAuthorDelete() {
    var varFrom = document.getElementById("authorManage");
    varFrom.action = "<c:url value='/sec/ram/EgovAuthorDelete.do'/>";
    if(confirm('<spring:message code="common.delete.msg" />')){
        varFrom.submit();
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
                                        <li><a href="">사용자권한관리</a></li>
                                        <li>권한관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form:form modelAttribute="authorManage" method="post" >

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">권한관리</h2>

                                <div class="board_view2">
                                    <table summary="권한을 등록하는 테이블입니다.권한 코드,권한 명,설명,등록일자의 정보를 담고 있습니다.">
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="authorCode">권한코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="authorCode" id="authorCode" class="f_txt" type="text" value="<c:out value='${authorManage.authorCode}'/>" title="권한코드" />
                                                &nbsp;<form:errors path="authorCode" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="authorNm">권한명</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <input name="authorNm" id="authorNm" class="f_txt" type="text" value="<c:out value='${authorManage.authorNm}'/>" maxLength="50" title="권한명" />
                                                &nbsp;<form:errors path="authorNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="authorDc">설명</label>
                                            </td>
                                            <td>
                                                <input name="authorDc" id="authorDc" class="f_txt w_full" type="text" value="<c:out value='${authorManage.authorDc}'/>" maxLength="50" title="설명" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="">등록일자</label>
                                            </td>
                                            <td>
                                                <input name="authorCreatDe" id="authorCreatDe" class="f_txt" type="text" value="<c:out value='${authorManage.authorCreatDe}'/>" maxLength="50" readonly="readonly" title="등록일자"/>
                                            </td>
                                        </tr>
                                    </table>
                                </div>

                                <!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                    	<c:if test="${registerFlag == 'UPDATE'}">
                                    		<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncAuthorDelete()"><spring:message code='button.delete' /></a><!-- 삭제 -->
                                    	</c:if>
                                    </div>

                                    <div class="right_col btn1">
                                    	<c:if test="${registerFlag == 'INSERT'}">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncAuthorInsert()"><spring:message code='button.save' /></a><!-- 저장 -->
                                        </c:if>
                                        <c:if test="${registerFlag == 'UPDATE'}">
                                        	<a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncAuthorUpdate()"><spring:message code='button.save' /></a><!-- 저장 -->
                                        </c:if>
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="javascript:fncSelectAuthorList()"><spring:message code='button.list' /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <!-- 검색조건 유지 -->
                                <c:if test="${registerFlag == 'UPDATE'}">
	                                <input type="hidden" name="searchCondition" value="<c:out value='${authorManageVO.searchCondition}'/>"/>
	                                <input type="hidden" name="searchKeyword" value="<c:out value='${authorManageVO.searchKeyword}'/>"/>
	                                <input type="hidden" name="pageIndex" value="<c:out value='${authorManageVO.pageIndex}'/>"/>
                                </c:if>
                                
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