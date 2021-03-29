<%--
  Class Name : EgovMenuCreat.jsp
  Description : 메뉴생성 화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.10    이용             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 이용
    since    : 2009.03.10
--%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%
  /* Image Path 설정 */
  String imagePath_icon   = "/images/egovframework/sym/mpm/icon/";
  String imagePath_button = "/images/egovframework/sym/mpm/button/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<title>메뉴생성</title>
<style type="text/css">
    h1 {font-size:12px;}
    caption {visibility:hidden; font-size:0; height:0; margin:0; padding:0; line-height:0;}
</style>
<script type="text/javaScript">
<!--
var imgpath = "<c:url value='/'/>images/tree/";
//-->
</script>
<script language="javascript1.2" type="text/javaScript" src="<c:url value='/js/EgovMenuCreat.js'/>"></script>
<script language="javascript1.2" type="text/javaScript">
<!--
/* ********************************************************
 * 조회 함수
 ******************************************************** */
function selectMenuCreatTmp() {
    document.menuCreatManageForm.action = "<c:url value='/sym/mpm/EgovMenuCreatSelect.do'/>";
    document.menuCreatManageForm.submit();
}

/* ********************************************************
 * 멀티입력 처리 함수
 ******************************************************** */
function fInsertMenuCreat() {
    var checkField = document.menuCreatManageForm.checkField;
    var checkMenuNos = "";
    var checkedCount = 0;
    if(checkField) {
        if(checkField.length > 1) {
            for(var i=0; i < checkField.length; i++) {
                if(checkField[i].checked) {
                    checkMenuNos += ((checkedCount==0? "" : ",") + checkField[i].value);
                    checkedCount++;
                }
            }
        } else {
            if(checkField.checked) {
                checkMenuNos = checkField.value;
            }
        }
    }   
    document.menuCreatManageForm.checkedMenuNoForInsert.value=checkMenuNos;
    document.menuCreatManageForm.checkedAuthorForInsert.value=document.menuCreatManageForm.authorCode.value;
    document.menuCreatManageForm.action = "<c:url value='/sym/mnu/mcm/EgovMenuCreatInsert.do'/>";
    document.menuCreatManageForm.submit(); 
}
/* ********************************************************
 * 메뉴사이트맵 생성 화면 호출
 ******************************************************** */
function fMenuCreatSiteMap() {
    id = document.menuCreatManageForm.authorCode.value;
    window.open("<c:url value='/sym/mpm/EgovMenuCreatSiteMapSelect.do'/>?authorCode="+id,'Pop_SiteMap','scrollbars=yes, width=550, height=700');
}
<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
-->
</script>

</head>

<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>    
<!-- 전체 레이어 시작 -->
<div id="wrap">
    
        
            <!-- 현재위치 네비게이션 시작 -->
            <div id="content">
                

                <form name="menuCreatManageForm" action ="/sym/mpm/EgovMenuCreatSiteMapSelect.do" method="post">
                <input type="submit" id="invisible" class="invisible"/>
	                <input name="checkedMenuNoForInsert" type="hidden" >
	                <input name="checkedAuthorForInsert"  type="hidden" >

	                <!-- 검색 필드 박스 시작 -->
	                <div id="search_field">
	                    <div id="search_field_loc"><h2><strong>메뉴생성</strong></h2></div>
	                        <fieldset><legend>조건정보 영역</legend>    
	                        <div class="sf_start">
	                            <ul id="search_first_ul">
	                                <li>
	                                    <label for="authorCode">권한코드 : </label>
	                                    <input id="authorCode" name="authorCode" type="text" size="30"  maxlength="30" title="권한코드" value="${resultVO.authorCode}" readonly="readonly"> 
	                                </li>
	                            </ul>
	                            <ul id="search_second_ul">
	                                <li>
	                                    <div class="buttons" style="float:right;">
	                                        <a href="#LINK" onclick="fInsertMenuCreat(); return false;">메뉴생성</a>
	                                    </div>                              
	                                </li>
	                            </ul>           
	                        </div>          
	                        </fieldset>
	                </div>
	                <!-- //검색 필드 박스 끝 -->
	                <div id="page_info"><div id="page_info_align"></div></div>                    
	
	                <!-- table add start -->
	                <div >
	                    <c:forEach var="result1" items="${list_menulist}" varStatus="status" > 
                            <input type="hidden" name="tmp_menuNmVal" value="${result1.menuNo}|${result1.upperMenuId}|${result1.menuNm}|${result1.progrmFileNm}|${result1.chkYeoBu}|">
                        </c:forEach>
	                    <table summary="메뉴일괄등록" cellpadding="0" cellspacing="0">
	                        <caption>메뉴일괄등록</caption>
						    <tr>
							    <td width='20'>&nbsp;</td>
							    <td>
								    <!-- div class="tree" style="position:absolute; left:24px; top:70px; width:179px; height:25px; z-index:10;" -->
								    <div class="tree" >
								        <script language="javascript" type="text/javaScript">
								            var chk_Object = true;
								            var chk_browse = "";
								            if (eval(document.menuCreatManageForm.authorCode)=="[object]") chk_browse = "IE";
								            if (eval(document.menuCreatManageForm.authorCode)=="[object NodeList]") chk_browse = "Fox";
								            if (eval(document.menuCreatManageForm.authorCode)=="[object Collection]") chk_browse = "safai";
								
								            var Tree = new Array;
								            if(chk_browse=="IE"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object]"){
								               alert("메뉴 목록 데이타가 존재하지 않습니다.");
								               chk_Object = false;
								            }
								            if(chk_browse=="Fox"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object NodeList]"){
								               alert("메뉴 목록 데이타가 존재하지 않습니다.");
								               chk_Object = false;
								            }
								            if(chk_browse=="safai"&&eval(document.menuCreatManageForm.tmp_menuNmVal)!="[object Collection]"){
								                   alert("메뉴 목록 데이타가 존재하지 않습니다.");
								                   chk_Object = false;
								            }
								            if( chk_Object ){
								                for (var j = 0; j < document.menuCreatManageForm.tmp_menuNmVal.length; j++) {
								                    Tree[j] = document.menuCreatManageForm.tmp_menuNmVal[j].value;
								                }
								                createTree(Tree);
								            }else{
								                alert("메뉴가 존재하지 않습니다. 메뉴 등록 후 사용하세요.");
								                window.close();
								            }
								        </script>
								    </div>
						       </td> 
						   </tr>
						</table>
				     </div>
	                 <input type="hidden" name="req_menuNo">
	            </form>

            </div>
            <!-- //content 끝 -->    
        </div>  
        <!-- //container 끝 -->
        <!-- footer 시작 -->
        <div id="footer"><c:import url="/EgovPageLink.do?link=main/inc/EgovIncFooter" /></div>
        <!-- //footer 끝 -->
    
    <!-- //전체 레이어 끝 -->
 </body>
</html>