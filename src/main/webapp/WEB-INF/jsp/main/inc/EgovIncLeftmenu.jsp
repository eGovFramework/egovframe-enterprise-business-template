<%--
  Class Name : EgovIncLeftmenu.jsp
  Description : 좌메뉴화면(include)
  Modification Information

      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성

    author   : 실행환경개발팀 JJY
    since    : 2011.08.31
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import ="egovframework.com.cmm.LoginVO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<c:url value="/js/EgovMainMenu.js"/>"></script>
<script type="text/javascript">
<!--
/* ********************************************************
 * 상세내역조회 함수
 ******************************************************** */
function fn_MovePage(nodeNum) {
    var nodeValues = treeNodes[nodeNum].split("|");
    //parent.main_right.location.href = nodeValues[5];
    document.menuListForm.action = "${pageContext.request.contextPath}"+nodeValues[5];
    //alert(document.menuListForm.action);
    document.menuListForm.submit();
}
//-->
</script>
<!-- 메뉴 시작 -->
<div id="LoginStatus">
	  <fieldset><legend>조건정보 영역</legend>
	  	<%
        LoginVO loginVO = (LoginVO)session.getAttribute("LoginVO");
        if(loginVO == null){
        %>
        <ul>
	  		<li>로그인정보 없음</li>
	  		<li><a href="<c:url value='/uat/uia/egovLoginUsr.do'/>"><img src="<c:url value='/images/leftmenu/login.jpg' />" alt="로그인" /></a></li>
	  		<li>로그인후 사용하십시오</li>
	  	</ul>
	  	<%
        }else{
	  	%>
            <c:set var="loginName" value="<%= loginVO.getName()%>"/>
            <ul>
	  	    <li><a href="#LINK" onclick="alert('개인정보 확인 등의 링크 제공'); return false;">
            <c:out value="${loginName}"/> 님</a></li>
            <li><a href="<c:url value='/uat/uia/actionLogout.do'/>">
            <img src="<c:url value='/images/leftmenu/logout.jpg' />" alt="로그아웃" /></a></li>
            <li>최근접속:2011-10-12 13:24</li>
            </ul>
	  	<%
	  	}
        %>
	  </fieldset>
</div>
<div id="nav">
	<div class="top"></div>
    <div class="nav_style">
     <script type="text/javascript">
     <!--
         var Tree = new Array;
         if(document.menuListForm.tmp_menuNm != null){
             for (var j = 0; j < document.menuListForm.tmp_menuNm.length; j++) {
                 Tree[j] = document.menuListForm.tmp_menuNm[j].value;
             }
         }
         createTree(Tree, true, document.getElementById("baseMenuNo").value);
     //-->
     </script>
    </div>
	<div class="bottom"></div>
</div>

<!-- //메뉴 끝 -->