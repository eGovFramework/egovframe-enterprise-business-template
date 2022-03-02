<%--
  Class Name : EgovUserSelectUpdt.jsp
  Description : 사용자상세조회, 수정 JSP
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

<title>사용자 상세 및 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>";
    document.userManageVO.submit();
}
function fnDeleteUser(checkedIds) {
    if(confirm("<spring:message code="common.delete.msg" />")){
        document.userManageVO.checkedIdForDel.value=checkedIds;
        document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserDelete.do'/>";
        document.userManageVO.submit(); 
    }
}
function fnPasswordMove(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>";
    document.userManageVO.submit();
}
function fnUpdate(){
    if(validateUserManageVO(document.userManageVO)){
        document.userManageVO.submit();
    }
}
function fn_egov_inqire_cert() {
    var url = '/uat/uia/EgovGpkiRegist.do';
    var popupwidth = '500';
    var popupheight = '400';
    var title = '인증서';

    Top = (window.screen.height - popupheight) / 3;
    Left = (window.screen.width - popupwidth) / 2;
    if (Top < 0) Top = 0;
    if (Left < 0) Left = 0;
    Future = "fullscreen=no,toolbar=no,location=no,directories=no,status=no,menubar=no, scrollbars=no,resizable=no,left=" + Left + ",top=" + Top + ",width=" + popupwidth + ",height=" + popupheight;
    PopUpWindow = window.open(url, title, Future)
    PopUpWindow.focus();
}

function fn_egov_dn_info_setting(dn) {
    var frm = document.userManageVO;
    
    frm.subDn.value = dn;
}

function fn_egov_ZipSearch(){
    
    var $dialog = $('<div id="modalPan"></div>')
	.html('<iframe style="border: 0px; " src="' + "<c:url value='/sym/cmm/EgovCcmZipSearchList.do'/>" +'" width="100%" height="100%"></iframe>')
	.dialog({
    	autoOpen: false,
        modal: true,
        width: 1100,
        height: 700
	});
    $(".ui-dialog-titlebar").hide();
	$dialog.dialog('open');
}

function fn_egov_returnValue(retVal){
	
	if (retVal) {
		document.getElementById("zip_view").value  = retVal.sAddr;
	}
	
	fn_egov_modal_remove();
}

/**********************************************************
 * 모달 종료 버튼
 ******************************************************** */
function fn_egov_modal_remove() {
	$('#modalPan').remove();
}
//-->
</script>

</head>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<body>

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

								<form:form modelAttribute="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserSelectUpdt.do" name="userManageVO" method="post" >
								
								<!-- 상세정보 사용자 삭제시 prameter 전달용 input -->
								<input name="checkedIdForDel" type="hidden" />
								<!-- 검색조건 유지 -->
								<input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
								<input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
								<input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
								<input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/>"/>
								<!-- 우편번호검색 -->
								<input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />
								<!-- 사용자유형정보 : password 수정화면으로 이동시 타겟 유형정보 확인용, 만약검색조건으로 유형이 포함될경우 혼란을 피하기위해 userTy명칭을 쓰지 않음-->
								<input type="hidden" name="userTyForPassword" value="<c:out value='${userManageVO.userTy}'/>" />

                                <h1 class="tit_1">내부시스템관리</h1>

                                <h2 class="tit_2">업무사용자 상세조회(수정)</h2>

                                <div class="board_view2">
                                    <table>
                                        <colgroup>
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                            <col style="width: 160px;">
                                            <col style="width: auto;">
                                        </colgroup>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrId">사용자아이디</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="emplyrId" id="emplyrId" class="f_txt w_full" maxlength="20" readonly="readonly" />
                                                <form:errors path="emplyrId" />
                                                <form:hidden path="uniqId" />
                                            </td>
                                            <td class="lb">
                                                <label for="moblphonNo">핸드폰번호</label>
                                            </td>
                                            <td>
                                                <form:input path="moblphonNo" id="moblphonNo" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="moblphonNo" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="passwordHint">비밀번호힌트</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="passwordHint">
                                                    <form:select path="passwordHint" id="passwordHint" name="passwordHint" title="비밀번호힌트">
                                                    	<form:option value="" label="선택하세요"/>
                                                    	<form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="passwordHint" cssClass="error"/>
                                            </td>
                                            <td class="lb">
                                                <label for="passwordCnsr">비밀번호정답</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input class="f_txt w_full" path="passwordCnsr" id="passwordCnsr" maxlength="100" />
                                                <form:errors path="passwordCnsr" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrNm">이름</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <form:input path="emplyrNm" id="emplyrNm" class="f_txt w_full" maxlength="60" />
                                                <form:errors path="emplyrNm" />
                                            </td>
                                            <td class="lb">
                                                <label for="insttCode">소속기관</label>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="insttCode">
                                                    <form:select path="insttCode" id="insttCode" name="insttCode" title="소속기관">
                                                    	<form:option value="" label="선택하세요"/>
                                                    	<form:options items="${insttCode_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="insttCode" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="orgnztId">부서</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="orgnztId">
                                                    <form:select path="orgnztId" id="orgnztId" name="orgnztId" title="부서">
                                                    	<form:option value="" label="선택하세요"/>
                                                    	<form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="orgnztId" />
                                            </td>
                                            <td class="lb">
                                                <label for="ofcpsNm">직위명</label>
                                            </td>
                                            <td>
                                                <form:input path="ofcpsNm" id="ofcpsNm" class="f_txt w_full" maxlength="30" />
                                                <form:errors path="ofcpsNm" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emailAdres">이메일주소</label>
                                            </td>
                                            <td>
                                                <form:input path="emailAdres" id="emailAdres" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="emailAdres" />
                                            </td>
                                            <td class="lb">
                                                <label for="areaNo">집전화<br>지역번호</label>
                                            </td>
                                            <td>
                                                <form:input path="areaNo" id="areaNo" class="f_txt w_70" maxlength="4" title="전화번호 첫번째" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <form:input path="homemiddleTelno" id="homemiddleTelno" class="f_txt w_70" maxlength="4" title="전화번호 두번째" />
                                                <span class="f_txt_inner mr5 ml5">-</span>
                                                <form:input path="homeendTelno" id="homeendTelno" class="f_txt w_70" maxlength="4" title="전화번호 세번째" />
                                                <form:errors path="areaNo" />
                                                <form:errors path="homemiddleTelno" />
                                                <form:errors path="homeendTelno" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="offmTelno">사무실<br>전화번호</label>
                                            </td>
                                            <td>
                                                <form:input path="offmTelno" id="offmTelno" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="offmTelno" />
                                            </td>
                                            <td class="lb">
                                                <label for="fxnum">팩스번호</label>
                                            </td>
                                            <td>
                                                <form:input path="fxnum" id="fxnum" class="f_txt w_full" maxlength="15" />
                                                <form:errors path="fxnum" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="homeadres">주소</label>
                                            </td>
                                            <td>
                                                <span class="f_search2 w_150">
                                                    <form:input path="homeadres" id="zip_view" maxlength="100" readonly="readonly"/>
                                                    <form:errors path="homeadres" />
                                                    <input name="zip_view" id="zip_view" type="hidden" value="<c:out value='${userManageVO.zip}'/>" maxlength="8" readonly="readonly"/>
                                                    <form:hidden path="zip" />
                                                    	<button type="button" class="btn" onclick="fn_egov_ZipSearch();">조회</button>
                                                    <form:errors path="zip" />
                                                </span>
                                                <span class="f_txt_inner ml15">(우편번호 검색)</span>
                                            </td>
                                            <td class="lb">
                                                <label for="detailAdres">상세주소</label>
                                            </td>
                                            <td>
                                                <form:input path="detailAdres" id="detailAdres" class="f_txt w_full" maxlength="50" />
                                                <form:errors path="detailAdres" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="lb">
                                                <label for="emplyrSttusCode">사용자상태<br>코드</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="emplyrSttusCode">
                                                    <form:select path="emplyrSttusCode" id="emplyrSttusCode" name="emplyrSttusCode" title="사용자상태코드">
	                                                    <form:option value="" label="선택하세요"/>
	                                                    <form:options items="${emplyrSttusCode_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="emplyrSttusCode" />
                                            </td>
                                            <td class="lb">
                                                <label for="groupId">권한그룹</label>
                                                <span class="req">필수</span>
                                            </td>
                                            <td>
                                                <label class="f_select w_full" for="groupId">
                                                    <form:select path="groupId" id="groupId" name="groupId" title="그룹아이디">
                                                    	<form:option value="" label="선택하세요"/>
                                                    	<form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
                                                    </form:select>
                                                </label>
                                                <form:errors path="groupId" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>

								<!-- 목록/저장버튼  -->
                                <div class="board_view_bot">
                                    <div class="left_col btn3">
                                        <a href="<c:url value='/uss/umt/user/EgovUserDelete.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnDeleteUser('<c:out value='${userManageVO.userTy}'/>:<c:out value='${userManageVO.uniqId}'/>'); return false;"><spring:message code="button.delete" /></a><!-- 삭제 -->
                                        <a href="<c:url value='/uss/umt/user/EgovUserPasswordUpdtView.do'/>" class="btn btn_skyblue_h46 w_100" onclick="fnPasswordMove(); return false;"><spring:message code="button.passwordUpdate" /></a><!-- 비밀번호변경 -->
                                        <a href="#LINK" class="btn btn_skyblue_h46 w_100" onclick="javascript:document.userManageVO.reset();"><spring:message code="button.reset" /></a><!-- 초기화 -->
                                    </div>

                                    <div class="right_col btn1">
                                        <a href="#LINK" class="btn btn_blue_46 w_100" onclick="JavaScript:fnUpdate(); return false;"><spring:message code="button.save" /></a><!-- 저장 -->
                                        <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" class="btn btn_blue_46 w_100" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a><!-- 목록 -->
                                    </div>
                                </div>
                                <!-- // 목록/저장버튼 끝  -->
                                
                                <form:hidden path="password" />
                                
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