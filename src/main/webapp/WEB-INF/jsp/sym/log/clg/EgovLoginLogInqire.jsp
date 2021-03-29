<%--
  Class Name : EgovLoginLogInqire.jsp
  Description : 로그인 로그 정보 상세조회 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.11  이삼섭              최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀  이삼섭
    since    : 2009.03.11  
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>로그인 로그 상세</title>
</head>

<body style=";margin-left:10px;;margin-top:10px;">
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
    <!-- header 시작 -->
    <!-- //header 끝 --> 
    <!-- container 시작 -->
        <!-- 좌측메뉴 시작 -->
        <!-- //좌측메뉴 끝 -->
                <!-- 검색 필드 박스 시작 -->
                <h2><strong>로그인 로그 정보</strong></h2>
                <form name="Form" method="post" action="#LINK" >
                <input type="submit" id="invisible" class="invisible"/>
                    <div class="popop_detail" >
                        <table width="50%">
					     <tr> 
					        <th width="20%" height="23" align="center">로그ID</th>
					        <td width="80%" nowrap >&nbsp;&nbsp;
					          <c:out value="${result.logId}"/>
					        </td>
					      </tr>
					     <tr> 
					        <th width="20%" height="23" align="center">발생일자</th>
					        <td width="80%" nowrap >&nbsp;&nbsp;
					          <c:out value="${result.creatDt}"/>
					        </td>
					      </tr>
					     <tr> 
					        <th width="20%" height="23" align="center">로그유형</th>
					        <td width="80%" nowrap >&nbsp;&nbsp;
					          <c:out value="${result.loginMthd}"/>
					        </td>
					      </tr>
					     <tr> 
					        <th width="20%" height="23" align="center">요청자</th>
					        <td width="80%" nowrap >&nbsp;&nbsp;
					          <c:out value="${result.loginNm}"/>
					        </td>
					      </tr>
					     <tr> 
					        <th width="20%" height="23" align="center">요청자IP</th>
					        <td width="80%" nowrap >&nbsp;&nbsp;
					          <c:out value="${result.loginIp}"/>
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
                            <a href="#LINK" onclick="javascript:window.close(); return false;">닫기</a> 
                          </td>
                        </tr>
                        </table>
                    </div>
                    <!-- 버튼 끝 -->                           

                    <!-- 검색조건 유지 -->
                    <!-- 검색조건 유지 -->
                </form>

            <!-- //content 끝 -->    
    <!-- //container 끝 -->
    <!-- footer 시작 -->
    <!-- //footer 끝 -->
<!-- //전체 레이어 끝 -->
</body>
</html>

