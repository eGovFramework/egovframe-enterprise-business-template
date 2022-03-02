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
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="<c:url value='/'/>css/base.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/layout.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/component.css">
	<link rel="stylesheet" href="<c:url value='/'/>css/page.css">
	<script src="<c:url value='/'/>js/jquery-1.11.2.min.js"></script>
	<script src="<c:url value='/'/>js/ui.js"></script>
	<script src="<c:url value='/'/>js/jquery.js"></script>
	<script src="<c:url value='/'/>js/jqueryui.js"></script>
	<link rel="stylesheet" href="<c:url value='/'/>css/jqueryui.css">

<title>내부업무 사이트 > 내부서비스관리 > 접속통계관리</title>
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
        document.listForm.searchBgnDe.value = toDay;
        document.listForm.searchEndDe.value = toDay;
    } else if (document.listForm.fromDate.value != "" && document.listForm.toDate.value != "") {
        var fromDate = document.listForm.fromDate.value;
        var toDate = document.listForm.toDate.value;
        document.listForm.searchBgnDe.value = fromDate.substring(0, 4) + "-" + fromDate.substring(4, 6) + "-" + fromDate.substring(6, 8);
        document.listForm.searchEndDe.value = toDate.substring(0, 4) + "-" + toDate.substring(4, 6) + "-" + toDate.substring(6, 8);
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

function fn_egov_init_date(){
	
	$("#searchBgnDe").datepicker(
	        {dateFormat:'yy-mm-dd'
	         , showOn: 'button'
	         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
	         , buttonImageOnly: true
	         
	         , showMonthAfterYear: true
	         , showOtherMonths: true
		     , selectOtherMonths: true
		     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
				
	         , changeMonth: true // 월선택 select box 표시 (기본은 false)
	         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
	         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});


	$("#searchEndDe").datepicker( 
        {dateFormat:'yy-mm-dd'
         , showOn: 'button'
         , buttonImage: '<c:url value='/images/ico_calendar.png'/>'
         , buttonImageOnly: true
         
         , showMonthAfterYear: true
         , showOtherMonths: true
	     , selectOtherMonths: true
	     , monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월']
			
         , changeMonth: true // 월선택 select box 표시 (기본은 false)
         , changeYear: true  // 년선택 selectbox 표시 (기본은 false)
         , showButtonPanel: true // 하단 today, done  버튼기능 추가 표시 (기본은 false)
	});
}

</script>
</head>

<style type="text/css">
.ui-datepicker-trigger {
	margin-left: 10px;
	vertical-align: middle;
}
</style>

<body onload="fnInitAll(); fn_egov_init_date();">
<noscript class="noScriptTitle">자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>

    <!-- Skip navigation -->
    <a href="#contents" class="skip_navi">본문 바로가기</a>

    <div class="wrap">
		<!-- Header -->
		<c:import url="/sym/mms/EgovHeader.do" />
		<!--// Header -->

        <div class="container">
            <div class="sub_layout">
                <div class="sub_in">
                    <div class="layout">
						<!-- Left menu -->
						<c:import url="/sym/mms/EgovMenuLeft.do" />
						<!--// Left menu -->
        
                        <div class="content_wrap">
                            <div id="contents" class="content">
                                 <!-- Location -->
                                <div class="location">
                                    <ul>
                                        <li><a class="home" href="">Home</a></li>
                                        <li><a href="">내부서비스관리</a></li>
                                        <li><a href="">사용현황관리</a></li>
                                        <li>접속통계관리</li>
                                    </ul>
                                </div>
                                <!--// Location -->

								<form name="listForm" action="<c:url value='/sts/selectConectStats.do'/>" method="post">
								
			                    <input type="hidden" name="pdKind" value='<c:out value="${statsInfo.pdKind}"/>'/>
			                    <input type="hidden" name="statsKind" value='<c:out value="${statsInfo.statsKind}"/>'/>
			                    <input type="hidden" name="detailStatsKind" value=""/>

                                <h1 class="tit_1">내부서비스관리</h1>

                                <h2 class="tit_2">접속통계관리</h2>
                                
                                <!-- 검색조건 -->
                                <div class="condition2">
                                	
                                	<input type="hidden" name="cal_url" value="<c:url value='/sym/cmm/EgovNormalCalPopup.do'/>" />
				                    <input type="hidden" name="fromDate" value="${statsInfo.fromDate}" size="10"/>
				                    <input type="hidden" name="toDate" value="${statsInfo.toDate}" size="10"/>
                                	
                                	<input type="text" name="searchBgnDe" id="searchBgnDe" class="f_date" maxlength="10" value="${searchVO.searchBgnDe}" title="시작일자입력" />&nbsp ~ &nbsp
                                    <input type="text" name="searchEndDe" id="searchEndDe" class="f_date" maxlength="10" value="${searchVO.searchEndDe}" title="종료일자입력" >
                                    
                                    <label class="f_select ml20" for="PD">
                                        <select id="PD" name="PD" class="select" onchange="fnChangePdKind();" title="기간구분 선택">
                                            <option value="Y" selected="">연도별</option>
                                            <option value="M">월별</option>
                                            <option value="D">일별</option>
                                          </select>
                                    </label>
                                    <label class="f_select" for="STKIND">
                                        <select id="STKIND" name="STKIND" class="select" onchange="fnChangeStsKind();" title="통계구분">
                                            <option value="SERVICE" selected="">서비스별</option>
                                          </select>
                                    </label>

                                    <a href="#LINK" class="item btn btn_blue_46 w_100 ml10" onclick="fnSearch(); return false;"><spring:message code='button.inquire' /></a><!-- 조회 -->
                                </div>
                                <!--// 검색조건 -->

                                <!-- 게시판 -->
                                <!-- 서비스별 결과 -->
                                <c:if test='${statsInfo.statsKind == "SERVICE" }'>
	                                <div class="board_list">
	                                    <table summary="기간, 기간구분, 통계구분을 입력하여 MOPAS 접속통계를 조회한다.">
	                                    	<caption>서비스별 접속 통계</caption>
	                                        <colgroup>
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                            <col style="width: ;">
	                                        </colgroup>
	                                        <thead>
	                                            <tr>
	                                                <th scope="col">일자</th>
	                                                <th scope="col">메소드명</th>
	                                                <th scope="col">생성(로그인)</th>
	                                                <th scope="col">수정(미사용)</th>
	                                                <th scope="col">조회(미사용)</th>
	                                                <th scope="col">출력(미사용)</th>
	                                                <th scope="col">삭제(미사용)</th>
	                                                <th scope="col">에러(미사용)</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        	
	                                        	<c:if test="${fn:length(conectStats) == 0 }">
	                                        		<tr>
	                                        			<td colspan="8"> 조회된 접속 통계가 없습니다.</td>
	                                        		</tr>
	                                        	</c:if>
	                                        	
	                                        	<c:forEach items="${conectStats}" var="resultInfo" varStatus="status">
	                                        		<tr>
	                                        			<td>${resultInfo.statsDate}</td>
	                                        			<td>${resultInfo.conectMethod}</td>
	                                        			<td>${resultInfo.creatCo}</td>
	                                        			<td>${resultInfo.updtCo}</td>
	                                        			<td>${resultInfo.inqireCo}</td>
	                                        			<td>${resultInfo.deleteCo}</td>
	                                        			<td>${resultInfo.outptCo}</td>
	                                        			<td>${resultInfo.errorCo}</td>
	                                        		</tr>
	                                        	</c:forEach>
	                                        </tbody>
	                                    </table>
	                                </div>
                                </c:if>
                                
                                <!-- 개인별 결과 -->
                                <c:if test='${statsInfo.statsKind == "PRSONAL" }'>
	                                <div class="board_list">
	                                	<!-- 막대그래프 시작 -->
	                                	<span><b>1. 그래프 (단위, 횟수)</b></span>
	                                    <table summary="">
	                                    	<c:forEach items="${conectStats}" var="resultInfo" varStatus="status">
		                                        <thead>
		                                            <tr>
		                                                <th scope="col">${resultInfo.statsDate}</th>
		                                            </tr>
		                                        </thead>
		                                        <tbody>
	                                        		<tr>
	                                        			<td>
	                                        				<img src="<c:url value='/images_old/left_bg.gif'/>" width="<c:out value='${resultInfo.statsCo * statsInfo.maxUnit}'/>" height="10" align="left" alt=""/>&nbsp;(${resultInfo.statsCo}&nbsp;회)
	                                        			</td>
	                                        		</tr>
		                                        </tbody>
		                                    </c:forEach>
	                                    </table>
	                                    <!-- 막대그래프 끝 -->
	                                    
	                                    <!-- 테이블표 시작 -->
	                                    <span><b>2. 텍스트 (단위, 횟수)</b></span>
	                                    <table summary="">
	                                    	<c:forEach items="${conectStats}" var="resultInfo" varStatus="status">
                                        		<tr>
                                        			<td>${resultInfo.statsDate}</td>
                                        			<td>${resultInfo.statsCo}&nbsp;회</td>
                                        		</tr>
		                                    </c:forEach>
	                                    </table>
	                                    <!-- 테이블표  끝 -->
	                                </div>
                                </c:if>
                                <!--// 게시판 -->
                                
                                </form>
                                
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

		<!-- Footer -->
		<c:import url="/sym/mms/EgovFooter.do" />
		<!--// Footer -->
    </div>
</body>
</html>