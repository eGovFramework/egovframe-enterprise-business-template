package egovframework.com.cmm;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

/**
 * EgovWebUtil 단위 테스트.
 *
 * 외부 의존성 없는 stateless util이라 순수 JUnit 5로 검증.
 */
class EgovWebUtilTest {

    @Test
    @DisplayName("clearXSSMinimum은 <, > 문자를 HTML 엔티티로 치환한다")
    void clearXSSMinimum_replacesAngleBrackets() {
        String input = "<script>alert('xss')</script>";

        String cleaned = EgovWebUtil.clearXSSMinimum(input);

        assertFalse(cleaned.contains("<"), "결과에 '<'가 남아있음: " + cleaned);
        assertFalse(cleaned.contains(">"), "결과에 '>'가 남아있음: " + cleaned);
        assertTrue(cleaned.contains("&lt;"));
        assertTrue(cleaned.contains("&gt;"));
    }

    @Test
    @DisplayName("clearXSSMinimum은 null/빈 입력에 대해 빈 문자열을 반환한다")
    void clearXSSMinimum_returnsEmptyForBlankInput() {
        assertEquals("", EgovWebUtil.clearXSSMinimum(null));
        assertEquals("", EgovWebUtil.clearXSSMinimum(""));
        assertEquals("", EgovWebUtil.clearXSSMinimum("   "));
    }

    @Test
    @DisplayName("clearXSSMinimum은 & 문자를 &amp;로 치환한다")
    void clearXSSMinimum_escapesAmpersand() {
        String input = "a & b";

        String cleaned = EgovWebUtil.clearXSSMinimum(input);

        assertTrue(cleaned.contains("&amp;"), "결과에 &amp;가 없음: " + cleaned);
    }

    @Test
    @DisplayName("removeCRLF는 \\r과 \\n을 모두 제거한다")
    void removeCRLF_stripsControlCharacters() {
        String input = "first\r\nsecond\rthird\nfourth";

        String cleaned = EgovWebUtil.removeCRLF(input);

        assertFalse(cleaned.contains("\r"));
        assertFalse(cleaned.contains("\n"));
        assertEquals("firstsecondthirdfourth", cleaned);
    }

    @Test
    @DisplayName("isIPAddress는 점 4개로 구분된 1~3자리 숫자 패턴을 true로 반환한다")
    void isIPAddress_acceptsDottedQuad() {
        assertTrue(EgovWebUtil.isIPAddress("127.0.0.1"));
        assertTrue(EgovWebUtil.isIPAddress("10.0.0.255"));
    }

    @Test
    @DisplayName("isIPAddress는 점-숫자 형식이 아닌 입력을 false로 반환한다")
    void isIPAddress_rejectsNonDottedQuad() {
        assertFalse(EgovWebUtil.isIPAddress("not-an-ip"));
        assertFalse(EgovWebUtil.isIPAddress("127.0.0"));
        assertFalse(EgovWebUtil.isIPAddress(""));
    }

    @Test
    @DisplayName("filePathBlackList는 .. 토큰을 제거해 경로 순회를 차단한다")
    void filePathBlackList_blocksPathTraversal() {
        String input = "../../etc/passwd";

        String cleaned = EgovWebUtil.filePathBlackList(input);

        assertFalse(cleaned.contains(".."), "결과에 ..가 남아있음: " + cleaned);
    }

    @Test
    @DisplayName("filePathBlackList는 null/빈 입력에 대해 빈 문자열을 반환한다")
    void filePathBlackList_returnsEmptyForBlankInput() {
        assertEquals("", EgovWebUtil.filePathBlackList(null));
        assertEquals("", EgovWebUtil.filePathBlackList(""));
        assertEquals("", EgovWebUtil.filePathBlackList("   "));
    }
}
