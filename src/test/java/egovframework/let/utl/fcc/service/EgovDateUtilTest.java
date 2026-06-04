package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * EgovDateUtil 단위 테스트
 *
 * @author 이백행
 * @since 2025-06-05
 */
@DisplayName("EgovDateUtil 단위 테스트")
class EgovDateUtilTest {

    // ===================== addYearMonthDay =====================

    @Test
    @DisplayName("addYearMonthDay - 일 증가: 19810828 + 19일 = 19810916")
    void addYearMonthDay_addDays_basic() {
        assertEquals("19810916", EgovDateUtil.addYearMonthDay("19810828", 0, 0, 19));
    }

    @Test
    @DisplayName("addYearMonthDay - 일 감소: 20060228 - 10일 = 20060218")
    void addYearMonthDay_subtractDays() {
        assertEquals("20060218", EgovDateUtil.addYearMonthDay("20060228", 0, 0, -10));
    }

    @Test
    @DisplayName("addYearMonthDay - 월말 초과: 20060228 + 10일 = 20060310")
    void addYearMonthDay_crossMonthBoundary() {
        assertEquals("20060310", EgovDateUtil.addYearMonthDay("20060228", 0, 0, 10));
    }

    @Test
    @DisplayName("addYearMonthDay - 월 감소: 20050331 - 1개월 = 20050228 (2월 말일 처리)")
    void addYearMonthDay_subtractMonth_endOfMonth() {
        assertEquals("20050228", EgovDateUtil.addYearMonthDay("20050331", 0, -1, 0));
    }

    @Test
    @DisplayName("addYearMonthDay - 연도 증가(윤년→평년): 20040229 + 2년 = 20060228")
    void addYearMonthDay_leapYearToNonLeap() {
        assertEquals("20060228", EgovDateUtil.addYearMonthDay("20040229", 2, 0, 0));
    }

    @Test
    @DisplayName("addYearMonthDay - yyyy-MM-dd 형식 입력 허용")
    void addYearMonthDay_hyphenFormat() {
        assertEquals("20060310", EgovDateUtil.addYearMonthDay("2006-02-28", 0, 0, 10));
    }

    @Test
    @DisplayName("addYearMonthDay - null 입력 시 IllegalArgumentException")
    void addYearMonthDay_nullInput_throwsException() {
        assertThrows(IllegalArgumentException.class, () -> EgovDateUtil.addYearMonthDay(null, 0, 0, 1));
    }

    @Test
    @DisplayName("addYearMonthDay - 잘못된 형식 입력 시 IllegalArgumentException")
    void addYearMonthDay_invalidFormat_throwsException() {
        assertThrows(IllegalArgumentException.class, () -> EgovDateUtil.addYearMonthDay("200602", 0, 0, 1));
    }

    // ===================== addYear =====================

    @Test
    @DisplayName("addYear - 62년 증가: 20000201 + 62 = 20620201")
    void addYear_increase() {
        assertEquals("20620201", EgovDateUtil.addYear("20000201", 62));
    }

    @Test
    @DisplayName("addYear - 62년 감소: 20620201 - 62 = 20000201")
    void addYear_decrease() {
        assertEquals("20000201", EgovDateUtil.addYear("20620201", -62));
    }

    // ===================== addMonth =====================

    @Test
    @DisplayName("addMonth - 12개월 증가: 20010201 + 12개월 = 20020201")
    void addMonth_increase12() {
        assertEquals("20020201", EgovDateUtil.addMonth("20010201", 12));
    }

    @Test
    @DisplayName("addMonth - 1개월 증가(월말): 20060131 + 1개월 = 20060228")
    void addMonth_endOfMonthClip() {
        assertEquals("20060228", EgovDateUtil.addMonth("20060131", 1));
    }

    // ===================== addDay =====================

    @Test
    @DisplayName("addDay - 62일 증가: 19991201 + 62 = 20000201")
    void addDay_crossYear() {
        assertEquals("20000201", EgovDateUtil.addDay("19991201", 62));
    }

    @Test
    @DisplayName("addDay - 62일 감소: 20000201 - 62 = 19991201")
    void addDay_subtractCrossYear() {
        assertEquals("19991201", EgovDateUtil.addDay("20000201", -62));
    }

    // ===================== getDaysDiff =====================

    @Test
    @DisplayName("getDaysDiff - 양수 차이: 20060228 → 20060310 = 10일")
    void getDaysDiff_positive() {
        assertEquals(10, EgovDateUtil.getDaysDiff("20060228", "20060310"));
    }

    @Test
    @DisplayName("getDaysDiff - 1년 차이: 20060101 → 20070101 = 365일")
    void getDaysDiff_oneYear() {
        assertEquals(365, EgovDateUtil.getDaysDiff("20060101", "20070101"));
    }

    @Test
    @DisplayName("getDaysDiff - 음수 차이: 19990228 → 19990131 = -28일")
    void getDaysDiff_negative() {
        assertEquals(-28, EgovDateUtil.getDaysDiff("19990228", "19990131"));
    }

    @Test
    @DisplayName("getDaysDiff - 동일 날짜 = 0")
    void getDaysDiff_sameDate() {
        assertEquals(0, EgovDateUtil.getDaysDiff("20060801", "20060801"));
    }

    // ===================== checkDate(String) =====================

    @Test
    @DisplayName("checkDate - 유효한 날짜: 20060228 = true")
    void checkDate_valid_yyyyMMdd() {
        assertTrue(EgovDateUtil.checkDate("20060228"));
    }

    @Test
    @DisplayName("checkDate - 유효한 날짜: 2006-02-28 = true")
    void checkDate_valid_hyphen() {
        assertTrue(EgovDateUtil.checkDate("2006-02-28"));
    }

    @Test
    @DisplayName("checkDate - 존재하지 않는 월: 2000-13-31 = false")
    void checkDate_invalidMonth() {
        assertFalse(EgovDateUtil.checkDate("2000-13-31"));
    }

    @Test
    @DisplayName("checkDate - 존재하지 않는 날: 2006-11-31 = false")
    void checkDate_invalidDay() {
        assertFalse(EgovDateUtil.checkDate("2006-11-31"));
    }

    @Test
    @DisplayName("checkDate - 월 자리수 부족(yyyy-M-dd 형식): 2006-2-28 = false")
    void checkDate_invalidFormat_shortMonth() {
        assertThrows(IllegalArgumentException.class, () -> EgovDateUtil.checkDate("2006-2-28"));
    }

    // ===================== checkDate(String, String, String) =====================

    @Test
    @DisplayName("checkDate(year,month,day) - 유효한 날짜")
    void checkDate_threeArgs_valid() {
        assertTrue(EgovDateUtil.checkDate("2006", "02", "28"));
    }

    @Test
    @DisplayName("checkDate(year,month,day) - 윤년 2월 29일 유효")
    void checkDate_threeArgs_leapDay() {
        assertTrue(EgovDateUtil.checkDate("2004", "02", "29"));
    }

    @Test
    @DisplayName("checkDate(year,month,day) - 평년 2월 29일 무효")
    void checkDate_threeArgs_nonLeapDay() {
        assertFalse(EgovDateUtil.checkDate("2006", "02", "29"));
    }

    // ===================== isLeapYear =====================

    @Test
    @DisplayName("isLeapYear - 4의 배수이고 100의 배수 아님(2004): 윤년이므로 false")
    void isLeapYear_typicalLeapYear() {
        assertFalse(EgovDateUtil.isLeapYear(2004));
    }

    @Test
    @DisplayName("isLeapYear - 평년(2005): true")
    void isLeapYear_nonLeapYear() {
        assertTrue(EgovDateUtil.isLeapYear(2005));
    }

    @Test
    @DisplayName("isLeapYear - 100의 배수이나 400의 배수 아님(1900): 평년이므로 true")
    void isLeapYear_century_nonLeap() {
        assertTrue(EgovDateUtil.isLeapYear(1900));
    }

    @Test
    @DisplayName("isLeapYear - 400의 배수(2000): 윤년이므로 false")
    void isLeapYear_400multiple() {
        assertFalse(EgovDateUtil.isLeapYear(2000));
    }

    // ===================== formatDate =====================

    @Test
    @DisplayName("formatDate - 8자리 날짜를 점 구분자로 변환")
    void formatDate_dot_separator() {
        assertEquals("2003.04.05", EgovDateUtil.formatDate("20030405", "."));
    }

    @Test
    @DisplayName("formatDate - 8자리 날짜를 슬래시 구분자로 변환")
    void formatDate_slash_separator() {
        assertEquals("2004/01/01", EgovDateUtil.formatDate("20040101", "/"));
    }

    @Test
    @DisplayName("formatDate - 연도 0000이면 빈 문자열 반환")
    void formatDate_zeroYear() {
        assertEquals("", EgovDateUtil.formatDate("00000101", "."));
    }

    @Test
    @DisplayName("formatDate - 6자리(yyyyMM) 입력 시 IllegalArgumentException (validChkDate가 8/10자리만 허용)")
    void formatDate_sixDigits_throwsException() {
        assertThrows(IllegalArgumentException.class, () -> EgovDateUtil.formatDate("200304", "."));
    }

    // ===================== validChkDate =====================

    @Test
    @DisplayName("validChkDate - 하이픈 제거 후 8자리 반환")
    void validChkDate_stripHyphen() {
        assertEquals("20060228", EgovDateUtil.validChkDate("2006-02-28"));
    }

    @Test
    @DisplayName("validChkDate - 8자리 입력 그대로 반환")
    void validChkDate_eightDigits() {
        assertEquals("20060228", EgovDateUtil.validChkDate("20060228"));
    }

    @Test
    @DisplayName("validChkDate - null 입력 시 IllegalArgumentException")
    void validChkDate_null_throwsException() {
        assertThrows(IllegalArgumentException.class, () -> EgovDateUtil.validChkDate(null));
    }

}
