<%--
  Class Name : EgovConectStats.jsp
  Description : 접근로그 통계화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2009.03.23    박지욱             최초 생성
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 공통서비스 개발팀 박지욱
    since    : 2009.03.23 
--%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >
<title>접속통계 조회</title>
<script type="text/javascript" src="<c:url value='/js/EgovCalPopup.js' />"></script>
<script type="text/javaScript" language="javascript">
/* ********************************************************
 * 기간구분 변경
 ******************************************************** */
function fnChangePdKind(){
    var v_pdKind = document.getElementById("PD");
    document.listForm.pdKind.value = v_pdKind.options[v_pdKind.selectedIndex].value;
}
/* ********************************************************
 * 통계구분 변경
 ******************************************************** */
function fnChangeStsKind(){
    var v_statsKind = document.getElementById("STKIND");
    document.listForm.statsKind.value = v_statsKind.options[v_statsKind.selectedIndex].value;
}

/* ********************************************************
 * 개인별 검색어 변경
 ******************************************************** */
function fnChangePerson(){
    document.listForm.detailStatsKind.value = document.listForm.person.value;
}
/*********************************************************
 * 조회 처리 
 *********************************************************/
function fnSearch(){
    var fromDate = document.listForm.fromDate.value;
    var toDate = document.listForm.toDate.value;
    var pdKind = document.listForm.pdKind.value;
    var statsKind = document.listForm.statsKind.value;
    var detailStatsKind = document.listForm.detailStatsKind.value;

    if (fromDate == "") {
        alert("기간 시작일자를 입력하세요");
        return;
    } else if (toDate == "") {
        alert("기간 종료일자를 입력하세요");
        return;
    } else if (pdKind == "") {
        alert("기간 구분을 선택하세요");
        return;
    } else if (statsKind == "") {
        alert("통계 구분을 선택하세요");
        return;
    } 

    document.listForm.action = "<c:url value='/sts/cst/selectConectStats.do'/>";
    document.listForm.submit();
}
/* ********************************************************
 * 초기화
 ******************************************************** */
function fnInitAll(){

    // 시작일자, 종료일자
    if (document.listForm.fromDate.value == "" && document.listForm.toDate.value == "") {
        var now = new Date();
        var year= now.getFullYear();
        var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
        var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
        var toDay = year + mon + day;
        document.listForm.fromDate.value = toDay;
        document.listForm.toDate.value = toDay;
        toDay = year + "-" + mon + "-" + day;
        document.listForm.fDate.value = toDay;
        document.listForm.tDate.value = toDay;
    } else if (document.listForm.fromDate.value != "" && document.listForm.toDate.value != "") {
        var fromDate = document.listForm.fromDate.value;
        var toDate = document.listForm.toDate.value;
        document.listForm.fDate.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
        document.listForm.tDate.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
    }
    // 기간구분
    var pdKind = document.listForm.pdKind.value;
    var v_pdKind = document.getElementById("PD");
    for(var i = 0; i < v_pdKind.options.length; i++) {
        if (pdKind == v_pdKind.options[i].value) {
            v_pdKind.selectedIndex = i;
        }
    }
    if(pdKind=="") {document.listForm.pdKind.value= v_pdKind.options[v_pdKind.selectedIndex].value; } 
    // 통계구분
    var statsKind = document.listForm.statsKind.value;
    var v_statsKind = document.getElementById("STKIND");
    for(var j = 0; j < v_statsKind.options.length; j++) {
        if (statsKind == v_statsKind.options[j].value) {
            v_statsKind.selectedIndex = j;
            fnChangeStsKind();
        }
    }
    if(statsKind=="") {document.listForm.statsKind.value= v_statsKind.options[v_statsKind.selectedIndex].value; } 
}

function getNextWeek(v,t){ 
    var str=new Array(); 
    var b=v.split("-");
    var c=new Date(b[0],b[1]-1,b[2]); 
    var d=c.valueOf()+1000*60*60*24*t;
    var e=new Date(d); 
    
    str[str.length]=e.getYear(); 
    str[str.length]=e.getMonth()+1; 
    str[str.length]=e.getDate(); 
    return str.join(""); 
}
</script>
</head>
<body onload="javascript:fnInitAll();">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>
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
                            <li>내부서비스관리</li>
                            <li>&gt;</li>
                            <li>사용현황관리</li>
                            <li>&gt;</li>
                            <li><strong>접속통계관리</strong></li>
                        </ul>
                    </div>
                </div>
                <form name="listForm" action="<c:url value='/sts/selectConectStats.do'/>" method="post">
                <input type="submit" id="invisible" class="invisible"/>
                    <input type="hidden" name="pdKind" value='<c:out value="${statsInfo.pdKind}"/>'/>
                    <input type="hidden" name="statsKind" value='<c:out value="${statsInfo.statsKind}"/>'/>
                    <input type="hidden" name="detailStatsKind" value=""/>

                <!-- 검색 필드 박스 시작 -->
                <div id="search_field">
                    <div id="search_field_loc"><h2><strong>접속 통계 관리</strong></h2></div>
                        <fieldset><legend>조건정보 영역</legend>    
                        <div class="sf_start">
                            <ul id="search_first_ul">
                                <li>
                                    <label for="fDate">기간 : </label>
				                    <input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
				                    <input type="hidden" name="fromDate" value="${statsInfo.fromDate}" size="10"/>
				                    <input type="hidden" name="toDate" value="${statsInfo.toDate}" size="10"/>
				                    <input type="text" name="fDate" value="" size="10"  title="시작일자(새창)" id="fDate"/>
				                    <a href="#noscript" onclick="fn_egov_NormalCalendar(document.listForm, document.listForm.fromDate, document.listForm.fDate,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>'); return false;" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/calendar.gif' />" alt="달력(새창)"></a>
				                    &nbsp;~&nbsp;<input type="text" name="tDate" value="" size="10"  title="종료일자(새창)" id="tDate" />
				                    <a href="#noscript" onclick="fn_egov_NormalCalendar(document.listForm, document.listForm.toDate, document.listForm.tDate,'','<c:url value='/sym/cmm/EgovselectNormalCalendar.do'/>'); return false;" style="selector-dummy:expression(this.hideFocus=false);"><img src="<c:url value='/images/calendar.gif' />" alt="달력(새창)"></a>
                                </li>
                                <li>
                                    <label for="PD">기간구분 : </label>
					                  <select id="PD" name="PD" class="select" onChange="javascript:fnChangePdKind();"  title="기간구분">
					                    <option value='Y' selected>연도별</option>
					                    <option value='M'>월별</option>
					                    <option value='D'>일별</option>
					                  </select>
                                </li>
                                <li>
                                    <label for="STKIND">통계구분 : </label>
					                  <select id="STKIND" name="STKIND" class="select" onChange="javascript:fnChangeStsKind();"  title="통계구분">
					                    <option value='SERVICE' selected>서비스별</option>
					                    <!-- option value='PRSONAL'>개인별</option-->
					                  </select>
					                  <!-- 접속통계정보만 확인하므로 개인별 검색조건은 주석
					                  <input name="person" type="text" size="15" value="" onChange="fnChangePerson();"  title="" id="person">
					                  -->
                                </li>       
                            </ul>
                            <ul id="search_second_ul">
                                <li>
                                    <div class="buttons" style="float:right;">
                                        <a href="#LINK" onclick="fnSearch(); return false;"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
                                        <!-- a href="#LINK" onclick="fnInitAll(); return false;">초기화</a-->
                                    </div>                              
                                </li>
                            </ul>           
                        </div>          
                        </fieldset>
                </div>
                <!-- //검색 필드 박스 끝 -->

                <div id="page_info"><div id="page_info_align"></div></div>                    
                <!-- table add start -->
                
			        <!-- 서비스별 결과 -->
			        <c:if test='${statsInfo.statsKind == "SERVICE" }'>
			        <div class="default_tablestyle">
	                    <table summary="기간, 기간구분, 통계구분을 입력하여 MOPAS 접속통계를 조회한다." cellpadding="0" cellspacing="0">
	                    <caption>서비스별 접속 통계</caption>
	                    <colgroup>
	                    <col width="10%" >
	                    <col width="30%" >  
	                    <col width="10%" >
	                    <col width="10%" >
	                    <col width="10%" >
	                    <col width="10%" >
	                    <col width="10%" >
	                    <col width="10%" >
	                    </colgroup>
	                    <thead>
	                    <tr>
	                        <th scope="col" class="f_field" nowrap="nowrap">일자</th>
	                        <th scope="col" nowrap="nowrap">메소드명</th>
	                        <th scope="col" nowrap="nowrap">생성(로그인)</th>
	                        <th scope="col" nowrap="nowrap">수정(미사용)</th>
	                        <th scope="col" nowrap="nowrap">조회(미사용)</th>
	                        <th scope="col" nowrap="nowrap">삭제(미사용)</th>
	                        <th scope="col" nowrap="nowrap">출력(미사용)</th>
	                        <th scope="col" nowrap="nowrap">에러(미사용)</th>
	                    </tr>
	                    </thead>
	                    <tbody>
    	                    <c:forEach items="${conectStats}" var="resultInfo" varStatus="status">
    	                      <tr>
    			                  <td nowrap="nowrap">${resultInfo.statsDate}</td>
    			                  <td nowrap="nowrap">&nbsp;${resultInfo.conectMethod}</td>
    			                  <td nowrap="nowrap">${resultInfo.creatCo}</td>
    			                  <td nowrap="nowrap">${resultInfo.updtCo}</td>
    			                  <td nowrap="nowrap">${resultInfo.inqireCo}</td>
    			                  <td nowrap="nowrap">${resultInfo.deleteCo}</td>
    			                  <td nowrap="nowrap">${resultInfo.outptCo}</td>
    			                  <td nowrap="nowrap">${resultInfo.errorCo}</td>
    	                      </tr>
    	                     </c:forEach>
                             <c:if test="${fn:length(conectStats) == 0 }">
                                <tr>
                                    <td colspan="8"> 조회된 접속 통계가 없습니다.</td>
                                </tr>
                            </c:if>
	                    </tbody>
	                    </table>
	                    </div>
			        </c:if>
			        
			        <!-- 개인별 결과 -->
			        <c:if test='${statsInfo.statsKind == "PRSONAL" }'>
                        <div class="">
                        <!-- 막대그래프 시작 -->
                        <span><b>1. 그래프 (단위, 횟수)</b></span>
                            <table width="660" cellpadding="8"  border="0">
                            <c:forEach items="${conectStats}" var="resultInfo" varStatus="status">
                            <tr>
                                <td width="80px">${resultInfo.statsDate}</td>
                                <td>
                                   <img src="<c:url value='/images/left_bg.gif'/>" 
                                       width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}'/>" 
                                       height="10" align="left" alt=""/>&nbsp;(${resultInfo.statsCo}&nbsp;회)
		                        </td>
		                    </tr>
                            </c:forEach>
		                    </table>
		                <!-- 막대그래프 끝 -->
		                        
                        <!-- 테이블표 시작 -->
                        <br/>
                        <span><b>2. 텍스트 (단위, 횟수)</b></span>
                          <table width="660" cellpadding="8" class="table-search" border="0">
	                        <c:forEach items="${conectStats}" var="resultInfo" varStatus="status">
	                        <!-- loop 시작 -->                                
	                          <tr>
	                              <td width="80px">${resultInfo.statsDate}</td>
	                              <td align="left">${resultInfo.statsCo}&nbsp;회</td>
	                          </tr>
	                         </c:forEach>
	                      </table>
                         <!-- 테이블표  끝 -->
                         
                         </div>
                    </c:if>
            </form>
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