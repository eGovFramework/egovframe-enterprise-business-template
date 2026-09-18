package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * EgovNumberUtil 단위 테스트
 */
class EgovNumberUtilTest {

    // ── getNumToStrCnvr ──────────────────────────────────────────────────────

    @Test
    @DisplayName("getNumToStrCnvr: 정수를 문자열로 변환")
    void getNumToStrCnvr_convertsIntToString() {
        assertEquals("20081212", EgovNumberUtil.getNumToStrCnvr(20081212));
    }

    @Test
    @DisplayName("getNumToStrCnvr: 0 변환")
    void getNumToStrCnvr_zero() {
        assertEquals("0", EgovNumberUtil.getNumToStrCnvr(0));
    }

    // ── getNumSearchCheck ────────────────────────────────────────────────────

    @Test
    @DisplayName("getNumSearchCheck: 존재하는 숫자 → true")
    void getNumSearchCheck_found_returnsTrue() {
        assertTrue(EgovNumberUtil.getNumSearchCheck(12345678, 7));
    }

    @Test
    @DisplayName("getNumSearchCheck: 없는 숫자 → false")
    void getNumSearchCheck_notFound_returnsFalse() {
        assertFalse(EgovNumberUtil.getNumSearchCheck(12345678, 9));
    }

    @Test
    @DisplayName("getNumSearchCheck: 자릿수 포함 검색(substring)")
    void getNumSearchCheck_multiDigitSearch() {
        assertTrue(EgovNumberUtil.getNumSearchCheck(12345678, 123));
    }

    // ── getNumberValidCheck ───────────────────────────────────────────────────

    @Test
    @DisplayName("getNumberValidCheck: 숫자 문자열 → true")
    void getNumberValidCheck_numericString_returnsTrue() {
        assertTrue(EgovNumberUtil.getNumberValidCheck("12345"));
    }

    @Test
    @DisplayName("getNumberValidCheck: 문자 포함 → false")
    void getNumberValidCheck_alphaIncluded_returnsFalse() {
        assertFalse(EgovNumberUtil.getNumberValidCheck("123a5"));
    }

    @Test
    @DisplayName("getNumberValidCheck: 공백 포함 → false")
    void getNumberValidCheck_spaceIncluded_returnsFalse() {
        assertFalse(EgovNumberUtil.getNumberValidCheck("123 5"));
    }

    // ── checkRlnoInteger ─────────────────────────────────────────────────────

    @Test
    @DisplayName("checkRlnoInteger: 음수 → -1")
    void checkRlnoInteger_negative_returnsMinusOne() {
        assertEquals(-1, EgovNumberUtil.checkRlnoInteger(-5.0));
    }

    @Test
    @DisplayName("checkRlnoInteger: double 타입은 소수점이 포함되어 실수(1) 반환")
    void checkRlnoInteger_doubleWithZeroFraction_returnsOne() {
        // double 리터럴 123.0은 String.valueOf() 시 "123.0"으로 변환되어 소수점 포함 → 1
        assertEquals(1, EgovNumberUtil.checkRlnoInteger(123.0));
    }

    @Test
    @DisplayName("checkRlnoInteger: 실수(소수점 있음) → 1")
    void checkRlnoInteger_real_returnsOne() {
        assertEquals(1, EgovNumberUtil.checkRlnoInteger(3.14));
    }

    // ── getNumberCnvr ────────────────────────────────────────────────────────

    @Test
    @DisplayName("getNumberCnvr: 123→999로 치환")
    void getNumberCnvr_replacesSubNumber() {
        assertEquals(99945678, EgovNumberUtil.getNumberCnvr(12345678, 123, 999));
    }

    @Test
    @DisplayName("getNumberCnvr: 일치 없음 → 원본 반환")
    void getNumberCnvr_noMatch_returnsOriginal() {
        assertEquals(12345678, EgovNumberUtil.getNumberCnvr(12345678, 999, 111));
    }

    // ── getNumToDateCnvr ──────────────────────────────────────────────────────

    @Test
    @DisplayName("getNumToDateCnvr: 8자리 숫자 → yyyy-MM-dd 형식")
    void getNumToDateCnvr_eightDigits_formatsDate() {
        assertEquals("2008-12-12", EgovNumberUtil.getNumToDateCnvr(20081212));
    }
}
