<%--
  Class Name : EgovUserInsert.jsp
  Description : 사용자등록View JSP
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

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>사용자 등록</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userManageVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javascript" src="<c:url value='/js/EgovZipPopup.js' />" ></script>
<script type="text/javaScript" language="javascript" defer="defer">
<!--
function fnIdCheck(){
    var retVal;
    var url = "<c:url value='/uss/umt/cmm/EgovIdDplctCnfirmView.do'/>";
    var varParam = new Object();
    varParam.checkId = document.userManageVO.emplyrId.value;
    var openParam = "dialogWidth:303px;dialogHeight:250px;scroll:no;status:no;center:yes;resizable:yes;";
    retVal = window.showModalDialog(url, varParam, openParam);
    if(retVal) {
        document.userManageVO.emplyrId.value = retVal;
        document.userManageVO.id_view.value = retVal;
    }
}
function showModalDialogCallback(retVal) {
    if(retVal) {
        document.userManageVO.emplyrId.value = retVal;
        document.userManageVO.id_view.value = retVal;
    }
}
function fnListPage(){
    document.userManageVO.action = "<c:url value='/uss/umt/user/EgovUserManage.do'/>"; 
    document.userManageVO.submit();
}
function fnInsert(){
    if(validateUserManageVO(document.userManageVO)){
        if(document.userManageVO.password.value != document.userManageVO.password2.value){
            alert("<spring:message code="fail.user.passwordUpdate2" />");
            return;
        }
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

/*
if (typeof(opener.fn_egov_dn_info_setting) == 'undefined') {
    alert('메인 화면이 변경되거나 없습니다');
    this.close();
} else {
    opener.fn_egov_dn_info_setting(dn);
    this.close();
}
*/

//-->
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
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li><strong>사용자관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>업무사용자 등록</strong></h2></div>
                </div>
		        <form:form commandName="userManageVO" action="${pageContext.request.contextPath}/uss/umt/user/EgovUserInsert.do" name="userManageVO" method="post" >
		            <!-- 우편번호검색 -->
		            <input type="hidden" name="zip_url" value="<c:url value='/sym/cmm/EgovCcmZipSearchPopup.do'/>" />

                    <div class="modify_user" > 
				        <table>
				            <tr> 
				                <th width="20%" height="23" class="required_text">사용자아이디
				                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
				                </th>
				                <td width="30%" >
				                    <input type="text" size="20" maxlength="20" disabled="disabled" id="id_view" name="id_view" >
				                    <form:input path="emplyrId" id="emplyrId" title="사용자아이디" size="20" maxlength="20" cssStyle="display:none" />
				                    <a href="#LINK" onclick="fnIdCheck();">
				                        <img src="/images/img_search.gif" alt=""/>(중복아이디 검색)
				                    </a>
				                    <form:errors path="emplyrId" cssClass="error"/>                    
				                </td>
                                <th width="20%" height="23" class="required_text">핸드폰번호&nbsp;&nbsp;</th>
                                <td width="30%" >
                                    <form:input path="moblphonNo" id="moblphonNo" title="핸드폰번호" cssClass="txaIpt" size="20" maxlength="15" />
                                    <form:errors path="moblphonNo" cssClass="error" />
                                </td>
				            </tr>

				            <tr> 
				                <th width="20%" height="23" class="required_text"  >비밀번호
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
				                <td width="30%" >
				                    <form:password path="password" id="password" title="비밀번호" size="20" maxlength="20" />
				                    <form:errors path="password" cssClass="error" />
				                </td>
				                <th width="20%" height="23" class="required_text"  >비밀번호확인
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
				                <td width="30%" >
				                    <input name="password2" id="password2" title="비밀번호확인" type="password" size="20" maxlength="20" />
				                </td>
				            </tr>

				            <tr> 
				                <th width="20%" height="23" class="required_text"  >비밀번호힌트
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
				                <td width="30%" >
				                    <form:select path="passwordHint" id="passwordHint" title="비밀번호힌트">
				                        <form:option value="" label="--선택하세요--"/>
				                        <form:options items="${passwordHint_result}" itemValue="code" itemLabel="codeNm"/>
				                    </form:select>
				                    <form:errors path="passwordHint" cssClass="error"/>
				                </td>
				                <th width="20%" height="23" class="required_text" >비밀번호정답
                                <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
				                <td width="30%" >
				                    <form:input path="passwordCnsr" id="passwordCnsr" title="비밀번호정답" cssClass="txaIpt" size="50" maxlength="100" />
				                    <form:errors path="passwordCnsr" cssClass="error"/>
				                </td>
				            </tr>

				            <tr> 
                                <th width="20%" height="23" class="required_text">이름
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
                                <td width="30%" >
                                    <input name="emplyrNm" id="emplyrNm" title="사용자이름" type="text" size="20" value="" maxlength="60" />
                                    <form:errors path="emplyrNm" cssClass="error" />
                                </td>
				                <th width="20%" height="23" class="required_text">소속기관</th>
				                <td width="30%" >
				                    <form:select path="insttCode" id="insttCode" title="소속기관">
				                        <form:option value="" label="--선택하세요--"/>
				                        <form:options items="${insttCode_result}" itemValue="code" itemLabel="codeNm"/>
				                    </form:select>
				                    <form:errors path="insttCode" cssClass="error"/>
				                </td>
				            </tr>

				            <tr> 
                                <th width="20%" height="23" class="required_text">조직코드
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
                                <td width="30%" >
                                    <form:select path="orgnztId" id="orgnztId" title="부서">
                                        <form:option value="" label="--선택하세요--"/>
                                        <form:options items="${orgnztId_result}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>
                                    <form:errors path="orgnztId" cssClass="error"/>
                                </td>
				                <th width="20%" height="23" class="required_text"  >직위명</th>
				                <td width="30%" >
				                    <form:input path="ofcpsNm" id="ofcpsNm" title="직위명" cssClass="txaIpt" size="20" maxlength="30" />
				                    <form:errors path="ofcpsNm" cssClass="error" />
				                </td>
 				            </tr>

				            <tr>
                                <th width="20%" height="23" class="required_text">이메일주소</th>
                                <td width="30%">
                                    <form:input path="emailAdres" id="emailAdres" title="이메일주소" cssClass="txaIpt" size="20" maxlength="50" />
                                    <form:errors path="emailAdres" cssClass="error" />
                                </td>
                                <th width="20%" height="23" class="required_text">집전화지역번호
                                </th>
                                <td width="30%" >
                                    <form:input path="areaNo" id="areaNo" title="areaNo" cssClass="txaIpt" size="5" maxlength="5" />
                                    - <form:input path="homemiddleTelno" title="homemiddleTelno" id="homemiddleTelno" cssClass="txaIpt" size="5" maxlength="5" />
                                    - <form:input path="homeendTelno" title="homeendTelno" id="homeendTelno" cssClass="txaIpt" size="5" maxlength="5" />
                                    <form:errors path="areaNo" cssClass="error" />
                                    <form:errors path="homemiddleTelno" cssClass="error" />
                                    <form:errors path="homeendTelno" cssClass="error" />
                                </td>
				            </tr>

				            <tr> 
				                <th width="20%" height="23" class="required_text">사무실전화번호</th>
				                <td width="30%" >
				                    <form:input path="offmTelno" id="offmTelno" title="사무실전화번호" cssClass="txaIpt" size="20" maxlength="15" />
				                    <form:errors path="offmTelno" cssClass="error" />
				                </td>
				                <th width="20%" height="23" class="required_text">팩스번호</th>
				                <td width="30%" >
				                    <form:input path="fxnum" id="fxnum" cssClass="txaIpt" title="팩스번호" size="20" maxlength="15" />
				                    <form:errors path="fxnum" cssClass="error" />
				                </td>
				            </tr>

				            <tr>
				                <th width="20%" height="23" class="required_text">주소</th>
				                <td width="30%" >
				                    <form:input path="homeadres" id="homeadres" title="주소" cssClass="txaIpt" size="40" maxlength="100" readonly="true" />
				                    <form:errors path="homeadres" cssClass="error" />
                                    <form:hidden path="zip" />
                                        <a href="#LINK" onclick="javascript:fn_egov_ZipSearch(document.userManageVO, document.userManageVO.zip, document.userManageVO.zip_view, document.userManageVO.homeadres);">
                                            <img src="<c:url value='/images/btn/icon_zip_search.gif'/>" alt=""/>(우편번호 검색)
                                        </a>
                                    <form:errors path="zip" cssClass="error" />
                                    <input name="zip_view" id="zip_view" type="hidden" title="우편번호" size="20" value="<c:out value='${userManageVO.zip}'/>"  maxlength="8" readonly="readonly" />
				                </td>
				                <th width="20%" height="23" class="required_text"  >상세주소</th>
				                <td width="30%" >
				                    <form:input path="detailAdres" id="detailAdres" title="상세주소" cssClass="txaIpt" size="40" maxlength="50" />
				                    <form:errors path="detailAdres" cssClass="error" />
				                </td>
				            </tr>

				            <tr> 
                                <th width="20%" height="23" class="required_text">사용자상태코드
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
                                <td width="30%" >
                                    <form:select path="emplyrSttusCode" id="emplyrSttusCode" title="사용자상태코드">
                                        <form:option value="" label="--선택하세요--"/>
                                        <form:options items="${emplyrSttusCode_result}" itemValue="code" itemLabel="codeNm"/>
                                    </form:select>
                                    <form:errors path="emplyrSttusCode" cssClass="error"/>
                                </td>
				                <th width="20%" height="23" class="required_text">그룹아이디
                                    <img src="<c:url value='/'/>images/required.gif" width="15" height="15" alt="필수" />
                                </th>
				                <td width="30%" >
				                    <form:select path="groupId" id="groupId" title="그룹아이디">
				                        <form:option value="" label="--선택하세요--"/>
				                        <form:options items="${groupId_result}" itemValue="code" itemLabel="codeNm"/>
				                    </form:select>
				                    <form:errors path="groupId" cssClass="error"/>
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
                            <a href="#LINK" onclick="JavaScript:fnInsert(); return fallse;"><spring:message code="button.save" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="<c:url value='/uss/umt/user/EgovUserManage.do'/>" onclick="fnListPage(); return false;"><spring:message code="button.list" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#LINK" onclick="javascript:document.userManageVO.reset();"><spring:message code="button.reset" /></a>
                          </td>      
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

			        <!-- 검색조건 유지 -->
			        <input type="hidden" name="searchCondition" value="<c:out value='${userSearchVO.searchCondition}'/>"/>
			        <input type="hidden" name="searchKeyword" value="<c:out value='${userSearchVO.searchKeyword}'/>"/>
			        <input type="hidden" name="sbscrbSttus" value="<c:out value='${userSearchVO.sbscrbSttus}'/>"/>
			        <input type="hidden" name="pageIndex" value="<c:out value='${userSearchVO.pageIndex}'/><c:if test="${userSearchVO.pageIndex eq null}">1</c:if>"/>
			        
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

