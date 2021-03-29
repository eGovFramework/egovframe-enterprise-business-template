<%--
  Class Name : EgovUserAbsnceRegist.jsp
  Description : EgovUserAbsnceRegist 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.07.01   lee.m.j            최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 lee.m.j
    since    : 2009.07.01
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="validator" uri="http://www.springmodules.org/tags/commons-validator" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>사용자부재 등록</title>
<script type="text/javascript" src="<c:url value='/js/EgovMultiFile.js'/>"></script>
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="userAbsnce" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript" language="javascript">

function fncSelectUserAbsnceList() {
    var varFrom = document.getElementById("userAbsnce");
    varFrom.action = "<c:url value='/uss/ion/uas/selectUserAbsnceList.do'/>";
    varFrom.submit();       
}

function fncUserAbsnceInsert() {

    var varFrom = document.getElementById("userAbsnce");
    varFrom.action = "<c:url value='/uss/ion/uas/addUserAbsnce.do'/>";

    if(confirm("저장 하시겠습니까?")){
        varFrom.submit();
    }
}

function fncUserAbsnceDelete() {
    var varFrom = document.getElementById("userAbsnce");
    varFrom.action = "<c:url value='/uss/ion/uas/removeUserAbsnce.do'/>";
    if(confirm("삭제 하시겠습니까?")){
        varFrom.submit();
    }
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
                            <li><strong>사용자부재 등록</strong></li>
                        </ul>
                    </div>
                </div>
                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>사용자부재 등록</strong></h2></div>
                </div>
                <form:form commandName="userAbsnce" action="${pageContext.request.contextPath}/uss/ion/uas/addUserAbsnce.do" method="post"> 

                    <div class="modify_user" >
                        <table>
                              <tr> 
							    <th class="required_text" width="20%" scope="row" nowrap="nowrap">사용자ID
                                <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                                 -->
							    </th>
							    <td nowrap="nowrap"><input name="userId" id="userId" title="사용자ID" type="text" value="<c:out value='${userAbsnce.userId}'/>" size="30" class="readOnlyClass" readonly></td>
							  </tr>
							  <tr>
							    <th class="required_text" width="20%" scope="row" nowrap="nowrap">사용자명
                                <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                                 -->
                                </th>
							    <td nowrap="nowrap"><input name="userNm" id="userNm" title="사용자명" type="text" value="<c:out value='${userAbsnce.userNm}'/>" size="30" class="readOnlyClass" readonly></td>
							  </tr>
							  <tr>
							    <th class="required_text" width="20%" scope="row" nowrap="nowrap">부재여부
                                <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                                 -->
                                </th>
							    <td nowrap="nowrap">
							      <select name="userAbsnceAt" id="userAbsnceAt" title="부재여부">
							          <option value="Y" <c:if test="${userAbsnce.userAbsnceAt == 'Y'}">selected</c:if> >Y</option>
							          <option value="N" <c:if test="${userAbsnce.userAbsnceAt == 'N'}">selected</c:if> >N</option>
							      </select>
							   </td> 
							  </tr>
							  <tr>
							    <th class="required_text" width="20%" scope="row" nowrap="nowrap">등록일시
                                <!-- <img src="/images/egovframework/cmm/uss/umt/icon/required.gif" width="15" height="15" alt="" />
                                 -->
                                </th>
							    <td nowrap="nowrap"><input name="lastUpdusrPnttm" id="lastUpdusrPnttm" title="등록일시" type="text" maxLength="50" size="20" class="readOnlyClass" readonly></td>
                            </tr>
                        </table>
                    </div>

                    <!-- 버튼 시작(상세지정 style로 div에 지정) -->
                    <div class="buttons" style="padding-top:10px;padding-bottom:10px;">
                        <!-- 목록/저장버튼  -->
                        <table border="0" cellspacing="0" cellpadding="0" align="center">
                        <tr> 
                          <td>
                            <a href="#LINK" onclick="JavaScript:fncUserAbsnceInsert(); return false;"><spring:message code="button.save" /></a> 
                          </td>
                          <td width="10"></td>
                          <td>
                            <a href="<c:url value='/uss/ion/uas/selectUserAbsnceList.do'/>?pageIndex=<c:out value='${userAbsnceVO.pageIndex}'/>&amp;searchKeyword=<c:out value="${userAbsnceVO.searchKeyword}"/>&amp;searchCondition=1&amp;selAbsnceAt=<c:out value="${userAbsnceVO.selAbsnceAt}"/>" onclick="fncSelectUserAbsnceList(); return false;"><spring:message code="button.list" /></a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

					<!-- 검색조건 유지 -->
					    <input type="hidden" name="searchCondition" value="<c:out value='${userAbsnceVO.searchCondition}'/>">
					    <input type="hidden" name="searchKeyword" value="<c:out value='${userAbsnceVO.searchKeyword}'/>">
					    <input type="hidden" name="pageIndex" value="<c:out value='${userAbsnceVO.pageIndex}'/>">
					    <input type="hidden" name="selAbsnceAt" value="<c:out value='${userAbsnceVO.selAbsnceAt}'/>">
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

