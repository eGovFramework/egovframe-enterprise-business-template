package egovframework.let.sym.mnu.mcm.service;

import org.apache.commons.lang3.builder.ToStringBuilder;
 
/** 
 * 메뉴생성 생성을 위한 모델 클래스를 정의한다.
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *   2011.08.31  JJY            경량환경 템플릿 커스터마이징버전 생성 
 *
 * </pre>
 */
public class MenuCreat{
    /** 메뉴번호 */
    private   int      menuNo;
    /** 맵생성ID */
    private   String   mapCreatId;
    /** 권한코드 */
    private   String   authorCode;
   
	public int getMenuNo() {
		return menuNo;
	}
	public void setMenuNo(int menuNo) {
		this.menuNo = menuNo;
	}
	public String getMapCreatId() {
		return mapCreatId;
	}
	public void setMapCreatId(String mapCreatId) {
		this.mapCreatId = mapCreatId;
	}
	public String getAuthorCode() {
		return authorCode;
	}
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}
	
	/**
     * toString 메소드를 대치한다.
     */
    public String toString() {
    	return ToStringBuilder.reflectionToString(this);
    }
}