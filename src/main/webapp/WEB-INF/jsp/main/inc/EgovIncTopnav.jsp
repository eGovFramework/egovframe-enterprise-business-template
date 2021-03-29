<%--
  Class Name : EgovIncTopnav.jsp
  Description : 상단메뉴화면(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!-- topmenu start -->
<script type="text/javascript">
<!--
    function getLastLink(baseMenuNo){
    	var tNode = new Array;
        for (var i = 0; i < document.menuListForm.tmp_menuNm.length; i++) {
            tNode[i] = document.menuListForm.tmp_menuNm[i].value;
            var nValue = tNode[i].split("|");
            //선택된 메뉴(baseMenuNo)의 하위 메뉴중 첫번재 메뉴의 링크정보를 리턴한다.
            if (nValue[1]==baseMenuNo) {
                if(nValue[5]!="dir" && nValue[5]!="" && nValue[5]!="/"){
                    //링크정보가 있으면 링크정보를 리턴한다.
                    return nValue[5];
                }else{
                    //링크정보가 없으면 하위 메뉴중 첫번째 메뉴의 링크정보를 리턴한다.
                    return getLastLink(nValue[0]);
                }
            }
        }
    }
    function goMenuPage(baseMenuNo){
    	document.getElementById("baseMenuNo").value=baseMenuNo;
    	//document.getElementById("link").value=getLastLink(baseMenuNo);
        //document.menuListForm.chkURL.value=url;
        document.menuListForm.action = "<c:url value='/'/>"+getLastLink(baseMenuNo).substring(1);
        document.menuListForm.submit();
    }
    function actionLogout()
    {
        document.selectOne.action = "<c:url value='/uat/uia/actionLogout.do'/>";
        document.selectOne.submit();
        //document.location.href = "<c:url value='/j_spring_security_logout'/>";
    }
//-->
</script>
<ul>
	<c:forEach var="result" items="${list_headmenu}" varStatus="status">
        <li><a href="#LINK" onclick="javascript:goMenuPage('<c:out value="${result.menuNo}"/>')"><c:out value="${result.menuNm}"/></a></li>  
    </c:forEach>
    <c:if test="${fn:length(list_headmenu) == 0 }">
        <li>등록된 메뉴가 없습니다.</li>
    </c:if>
</ul>
<!-- //topmenu end -->
<!-- menu list -->
    <form name="menuListForm" action="" method="post">
        <input type="hidden" id="baseMenuNo" name="baseMenuNo" value="<%=session.getAttribute("baseMenuNo")%>" />
        <input type="hidden" id="link" name="link" value="" />
        <div style="width:0px; height:0px;">
        <c:forEach var="result" items="${list_menulist}" varStatus="status" > 
            <input type="hidden" name="tmp_menuNm" value="${result.menuNo}|${result.upperMenuId}|${result.menuNm}|${result.relateImagePath}|${result.relateImageNm}|${result.chkURL}|" />
        </c:forEach>
        </div>
    </form>
