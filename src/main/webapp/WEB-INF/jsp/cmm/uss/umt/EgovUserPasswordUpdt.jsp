<%--
  Class Name : EgovPasswordUpdt.jsp
  Description : 암호수정 JSP
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.03   JJY              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 JJY
    since    : 2009.03.03
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
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

<title>내부업무 사이트 > 내부시스템관리 > 사용자등록관리</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="passwordChgVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.passwordChgVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.passwordChgVO.submit();
}
function fnUpdate(){
    if(validatePasswordChgVO(document.passwordChgVO)){
        if(document.passwordChgVO.newPassword.value != document.passwordChgVO.newPassword2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
        document.passwordChgVO.submit();
    }
}
<c:if test="${!empty resultMsg}">alert("<spring:message code="${resultMsg}" />");</c:if>
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
                                        <li><a href="">사용자관리</a></li>
                                        <li>사용자등록관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="passwordChgVO" method="post" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserPasswordUpdt.do" >
								<!-- onsubmit="javascript:return FormValidation(document.passwordChgVO);" >  -->
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
								<input name="checkedIdForDel" type="hidden" />
								<!-- 검색조건 유지 -->
								<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
								<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
								<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
								<!-- 우편번호검색 -->
								<input type="hidden" name="url" value="<c:url value='/sym/ccm/zip/EgovCcmZipSearchPopup.do'/>" />

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">사용자등록관리</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 190px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자아이디</label>
                                            </td>
                                            <td>
                                                <input name="emplyrId" id="emplyrId" class="f_txt" title="사용자아이디" type="text" value="<c:out value='${userManageVO.emplyrId}'/>" maxlength="20" readonly="readonly"/>
                                                <input name="uniqId" id="uniqId" title="uniqId" type="hidden" value="<c:out value='${userManageVO.uniqId}'/>"/>
                                                <input name="userTy" id="userTy" title="userTy" type="hidden" value="<c:out value='${userManageVO.userTy}'/>"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="oldPassword">기존 비밀번호</label>
                                            </td>
                                            <td>
                                                <input name="oldPassword" id="oldPassword" class="f_txt" title="기존 비밀번호" type="password" value="" maxlength="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="newPassword">비밀번호</label>
                                            </td>
                                            <td>
                                                <input name="newPassword" id="newPassword" class="f_txt" title="비밀번호" type="password" value="" maxlength="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="newPassword2">비밀번호확인</label>
                                            </td>
                                            <td>
                                                <input name="newPassword2" id="newPassword2" class="f_txt" title="비밀번호확인" type="password" value="" maxlength="100" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.passwordChgVO.reset();"><spring:message code="button.reset" /></a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
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