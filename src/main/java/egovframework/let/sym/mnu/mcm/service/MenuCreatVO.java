package egovframework.let.sym.mnu.mcm.service;

import org.apache.commons.lang3.builder.ToStringBuilder;

import lombok.Getter;
import lombok.Setter;

/**
 * 메뉴생성 처리를 위한 VO 클래스르를 정의한다
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
@Getter
@Setter
public class MenuCreatVO {

   /** 메뉴번호 */
   private int menuNo;
   /** 맵생성ID */
   private String mapCreatId;
   /** 권한코드 */
   private String authorCode;

   /** 권한정보설정 */
   /** 권한명 */
   private String authorNm;
   /** 권한설명 */
   private String authorDc;
   /** 권한생성일자 */
   private String authorCreatDe;

   /** 기타VO변수 */
   /** 생성자ID **/
   private String creatPersonId;

   /**
    * toString 메소드를 대치한다.
    */
   public String toString() {
      return ToStringBuilder.reflectionToString(this);
   }
}
