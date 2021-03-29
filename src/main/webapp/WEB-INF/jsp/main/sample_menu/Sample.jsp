<%--
  Class Name : Sample.jsp 
  Description : 샘플화면 - 관리용화면샘플(sample)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>표준프레임워크 경량환경 내부업무템플릿</title>
<link href="css/common.css" rel="stylesheet" type="text/css" >
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
							<li>샘플</li>
							<li>&gt;</li>
							<li><strong>샘플화면</strong></li>
						</ul>
					</div>
				</div>
				<!-- 검색 필드 박스 시작 -->
				<div id="search_field">
					<div id="search_field_loc"><h2><strong>샘플화면(기능별 생성)</strong></h2></div>
					<form action="form_action.jsp" method="post">
					  	<fieldset><legend>조건정보 영역</legend>	  
					  	<div class="sf_start">
					  		<ul id="search_first_ul">
					  			<li>
								    <label for="search_select">상태정보</label>
									<select name="search_select" id="search_select">
									    <option value="0" selected="selected">승인</option>
									    <option value="1">비승인</option>
									</select>						
					  			</li>
					  			<li>
					  			<label>가입일자</label>
								<input type="text" name="st_date" /><img src="images/calendar.gif" width="19" height="19" alt="" />
					  			~ <input type="text" name="en_date" /><img src="images/calendar.gif" width="19" height="19" alt="" />
					  			</li>		
					  		</ul>
					  		<ul id="search_second_ul">
					  			<li><label for="username">사용자명</label></li>
					  			<li><input type="text" name="username" id="username" /></li>
					  			<li>
									<div class="buttons" style="float:right;">
										<a href="#"><img src="<c:url value='/images/img_search.gif' />" alt="search" />조회 </a>
									    <a href="#">등록 </a>
									    <a href="#">삭제</a>
									</div>	  				  			
					  			</li>
					  		</ul>			
						</div>			
						</fieldset>
					</form>
				</div>
				<!-- //검색 필드 박스 끝 -->
				<div id="page_info"><div id="page_info_align"></div></div>					
				<!-- table add start -->
				<div class="default_tablestyle">
					<table summary="사용자목록관리" cellpadding="0" cellspacing="0">
					<caption>사용자목록관리</caption>
					<colgroup>
    					<col width="38" >
    					<col width="130" >  
    					<col width="50" >
    					<col width="50" >
    					<col width="%" >
    					<col width="%" >
					</colgroup>
					<thead>
					<tr>
						<th scope="col" class="f_field">선택</th>
						<th scope="col">아이디</th>
						<th scope="col">상태</th>
						<th scope="col">회원명</th>
						<th scope="col">권한그룹</th>
						<th scope="col">등록일</th>
					</tr>
					</thead>
					<tbody>		  			
					<!-- loop 시작 -->								
					<tr>
						<td><strong>1</strong></td>
						<td><a href="#">admin_test01_0707</a></td>
						<td>승인</td>
						<td>홍길동</td>
						<td>관리자</td>
						<td>2011-07-01</td>
					</tr>
					<tr>
						<td><strong>2</strong></td>
						<td><a href="#">admin_test01_0707</a></td>
						<td>승인</td>
						<td>홍길동</td>
						<td>관리자</td>
						<td>2011-07-01</td>
					</tr>
					<tr>
						<td><strong>3</strong></td>
						<td><a href="#">admin_test01_0707</a></td>
						<td>승인</td>
						<td>홍길동</td>
						<td>관리자</td>
						<td>2011-07-01</td>
					</tr>
					<tr>
						<td><strong>4</strong></td>
						<td><a href="#">admin_test01_0707</a></td>
						<td>승인</td>
						<td>홍길동</td>
						<td>관리자</td>
						<td>2011-07-01</td>
					</tr>
					<tr>
						<td><strong>5</strong></td>
						<td><a href="#">admin_test01_0707</a></td>
						<td>승인</td>
						<td>홍길동</td>
						<td>관리자</td>
						<td>2011-07-01</td>
					</tr>													
					</tbody>
					</table> 
				</div>
				<!-- 페이지 네비게이션 시작 -->
				<div id="paging_div">
					<ul class="paging_align">
						<li class="first"><img src="<c:url value='/'/>images/btn/btn_prev.gif" alt="prev" /></li>
						<li><a href="#">1</a></li>
						<li>2</li>
						<li>3</li>
						<li>4</li>
						<li>5</li>
						<li class="first"><img src="<c:url value='/'/>images/btn/btn_next.gif" alt="next" /></li>
					</ul>
				</div>							
			</div>
			<!-- //페이지 네비게이션 끝 -->	
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