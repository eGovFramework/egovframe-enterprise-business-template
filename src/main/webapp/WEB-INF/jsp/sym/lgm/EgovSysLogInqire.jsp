<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
 /**
  * @Class Name : EgovSysLogInqire.jsp
  * @Description : 시스템 로그 정보 상세조회 화면
  * @Modification Information
  * @
  * @  수정일      수정자          수정내용
  * @  -------    --------       ---------------------------
  * @ 2009.03.11   이삼섭          최초 생성
  * @ 2011.07.08   이기하          패키지 분리, 경로수정(sym.log -> sym.log.lgm)
  *
  *  @author 공통서비스 개발팀 이삼섭
  *  @since 2009.03.11
  *  @version 1.0
  *  @see
  *
  */
%>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href="<c:url value='/css/egovframework/com/cmm/com.css' />" rel="stylesheet" type="text/css">

<title>시스템 로그 상세보기</title>
</head>
<body>
	<table width="700" cellpadding="8" class="table-search" border="0">
	 <tr>
	  <td width="100%"class="title_left"><h1 class="title_left">
	   <img src="<c:url value='/images/egovframework/com/cmm/icon/tit_icon.gif' />" width="16" height="16" hspace="3" style="vertical-align: middle" alt="제목아이콘이미지">&nbsp;시스템 로그 정보</h1></td>
	 </tr>
	</table>
	<table width="700" border="0" cellpadding="0" cellspacing="1" class="table-register" summary="요청ID, 발생일자, 서비스명, 메소드명, 처리구분, 처리시간, 요청자, 요청자IP를 보는 시스템 로그 상세보기 테이블이다.">
	<CAPTION style="display: none;">시스템 로그 정보</CAPTION>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">요청ID</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.requstId}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">발생일자</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.occrrncDe}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">서비스명</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.srvcNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">메소드명</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.methodNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">처리구분</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.processSeCodeNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">처리시간</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.processTime}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">요청자</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.rqsterNm}"/>
	    </td>
	  </tr>
	 <tr>
	    <th width="20%" height="23" align="center" scope="row">요청자IP</th>
	    <td width="80%" nowrap >&nbsp;&nbsp;
	      <c:out value="${result.rqesterIp}"/>
	    </td>
	  </tr>
	</table>
	<table width="700" border="0" cellspacing="0" cellpadding="0">
	  <tr>
	    <td height="10"></td>
	  </tr>
	</table>
	<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_left.gif'/>" width="8" height="20" alt=""></td>
      <td style="background-image:URL(<c:url value='/images/egovframework/com/cmm/btn/bu2_bg.gif'/>);" class="text_left" nowrap>
      <a href="#noscript" onclick="window.close(); return false;">닫기</a>
      </td>
      <td><img src="<c:url value='/images/egovframework/com/cmm/btn/bu2_right.gif'/>" width="8" height="20" alt="버튼이미지"></td>
	</tr>
	</table>
</body>
</html>
