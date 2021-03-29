<%--
  Class Name : EgovIncHeader.jsp
  Description : 화면상단 Header (include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="skipNav" class="invisible">
    <dl>
        <dt>콘텐츠 바로가기</dt>
        <dd><a href="#content">컨텐츠 바로가기</a></dd>
        <dd><a href="#topnavi">메인메뉴 바로가기</a></dd>
        <dd><a href="#leftmenu">좌메뉴 바로가기</a></dd>
    </dl>
</div>
<!-- 행정안전부 로고 및 타이틀 시작 -->
<div id="logoarea">
	<h1><a href="<c:url value='/'/>uat/uia/actionMain.do"><img src="<c:url value='/'/>images/header/logo.jpg" alt="템플릿 샘플 내부업무 사이트" /></a></h1>
</div>
<div id="project_title"><span class="maintitle">표준프레임워크 </span><strong>샘플 내부업무 사이트</strong>
<a href="<c:url value='/EgovPageLink.do?link=main/sample_menu/Intro'/>" target="_blank"><img width="20" height="20" src="<c:url value='/images/question.jpg'/>" alt="메뉴구성 설명" title="메뉴구성 설명"></a>
</div>
<!-- //행정안전부 로고 및 타이틀 끝 -->
