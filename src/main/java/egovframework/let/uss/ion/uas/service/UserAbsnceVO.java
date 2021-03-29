package egovframework.let.uss.ion.uas.service;

import java.util.List;
/**
 * 사용자부재에 대한 Vo 클래스를 정의한다.
 * 사용자부재의 목록 항목을 관리한다.
 * @author 공통서비스개발팀 lee.m.j
 * @since 2009.08.03
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.08.03  lee.m.j        최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
public class UserAbsnceVO extends UserAbsnce {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;	
	/**
	 * 사용자부재 목록
	 */
	List<UserAbsnceVO> userAbsnceList;
	/**
	 * 삭제대상 목록
	 */
	String[] delYn;
	/**
	 * 부재여부 조회조건
	 */	
	String selAbsnceAt;
	
	/**
	 * @return the userAbsnceList
	 */
	public List<UserAbsnceVO> getUserAbsnceList() {
		return userAbsnceList;
	}
	/**
	 * @param userAbsnceList the userAbsnceList to set
	 */
	public void setUserAbsnceList(List<UserAbsnceVO> userAbsnceList) {
		this.userAbsnceList = userAbsnceList;
	}
	/**
	 * @return the delYn
	 */
	public String[] getDelYn() {
		return delYn;
	}
	/**
	 * @param delYn the delYn to set
	 */
	public void setDelYn(String[] delYn) {
		this.delYn = delYn;
	}
	/**
	 * @return the selAbsnceAt
	 */
	public String getSelAbsnceAt() {
		return selAbsnceAt;
	}
	/**
	 * @param selAbsnceAt the selAbsnceAt to set
	 */
	public void setSelAbsnceAt(String selAbsnceAt) {
		this.selAbsnceAt = selAbsnceAt;
	}
	

	
	
}
