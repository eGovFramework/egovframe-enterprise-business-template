<%--
  Class Name : EgovCcmZipModify.jsp
  Description : EgovCcmZipModify 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.04.01   이중호              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이중호
    since    : 2009.04.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<c:url var="ImgUrl" value="/images"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>우편번호 수정</title>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="zip" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">
<!--
/* ********************************************************
 * 목록 으로 가기
 ******************************************************** */
function fn_egov_list_Zip(){
    location.href = "<c:url value='/sym/ccm/zip/EgovCcmZipList.do'/>";
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_modify_Zip(form){
    if(confirm("<spring:message code='common.save.msg'/>")){
        if(!validateZip(form)){             
            return;
        }else{
            form.submit();
        }
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
                            <li>내부시스템관리</li>
                            <li>&gt;</li>
                            <li>코드관리</li>
                            <li>&gt;</li>
                            <li><strong>우편번호관리</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>우편번호 수정</strong></h2></div>
                </div>
				<form:form commandName="zip" name="zip" method="post">
				
					<input name="cmd" type="hidden" value="Modify">
					<input name="zip" type="hidden" value="${zip.zip}">
					<form:hidden path="sn"/>
					<form:hidden path="ctprvnNm"/>
					<form:hidden path="signguNm"/>
					<form:hidden path="emdNm"/>
                    <div class="modify_user" >
                        <table summary="리건물명과 번지동호를 수정하는 우편번호 수정 테이블이다.">
						  <tr>
						    <th width="20%" height="23" class="required_text" scope="row" nowrap >우편번호<img src="${ImgUrl}/required.gif" alt="필수"  width="15" height="15"></th>          
						    <td width="80%" nowrap colspan="3">
						        <c:out value='${fn:substring(zip.zip, 0,3)}'/>-<c:out value='${fn:substring(zip.zip, 3,6)}'/>
						    </td>
						  </tr> 
						  <tr> 
						    <th width="20%" height="23" class="required_text" scope="row" nowrap >시도명<img src="${ImgUrl}/required.gif" alt="필수"  width="15" height="15"></th>
						    <td width="80%" nowrap="nowrap">
						        <c:out value='${zip.ctprvnNm}'/>
						    </td>    
						  </tr>
						  <tr>
						    <th width="20%" height="23" class="required_text" scope="row" nowrap >시군구명<img src="${ImgUrl}/required.gif" alt="필수"  width="15" height="15"></th>          
						    <td width="80%" nowrap="nowrap">
						        <c:out value='${zip.signguNm}'/>
						    </td>    
						  </tr> 
						  <tr>
						    <th width="20%" height="23" class="required_text" scope="row" nowrap >읍면동명<img src="${ImgUrl}/required.gif" alt="필수"  width="15" height="15"></th>          
						    <td width="80%" nowrap="nowrap">
						        <c:out value='${zip.emdNm}'/>    
						    </td>    
						  </tr> 
						  <tr>
						    <th width="20%" height="23" nowrap scope="row" ><label for="liBuldNm">리건물명</label></th>          
						    <td width="80%" nowrap="nowrap">
						        <input name="liBuldNm" type="text" size="60" value="<c:out value='${zip.liBuldNm}'/>"  maxlength="60" id="liBuldNm" >
						    </td>    
						  </tr> 
						  <tr>
						    <th width="20%" height="23" scope="row" nowrap ><label for="lnbrDongHo">번지동호</label></th>          
						    <td width="80%" nowrap="nowrap">
						        <input name="lnbrDongHo" type="text" size="20" value="<c:out value='${zip.lnbrDongHo}'/>"  maxlength="20" id="lnbrDongHo">
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
                            <a href="#noscript" onclick="fn_egov_list_Zip(); return false;">목록</a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="#noscript" onclick="fn_egov_modify_Zip(document.zip); return false;"><spring:message code="button.save" /></a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

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

