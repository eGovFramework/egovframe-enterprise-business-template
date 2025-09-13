package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

/**
 * EgovDateUtil 클래스에 대한 종합적인 단위 테스트
 * 날짜 처리의 다양한 엣지 케이스와 경계값 테스트를 포함합니다.
 * 
 * @author eGovFramework Test Team
 * @since 2024.09
 */
@DisplayName("EgovDateUtil 테스트")
class EgovDateUtilTest {

    // ========== addYearMonthDay 메서드 테스트 ==========
    
    @Test
    @DisplayName("addYearMonthDay: 일 단위 증가 테스트")
    void should_addDaysCorrectly_when_validDateGiven() {
        // Given
        String inputDate = "19810828";
        int year = 0, month = 0, day = 19;
        
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals("19810916", result);
    }
    
    @Test
    @DisplayName("addYearMonthDay: 일 단위 감소 테스트")
    void should_subtractDaysCorrectly_when_negativeDayGiven() {
        // Given
        String inputDate = "20060228";
        int year = 0, month = 0, day = -10;
        
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals("20060218", result);
    }
    
    @Test
    @DisplayName("addYearMonthDay: 월 단위 감소로 인한 월말일 조정 테스트")
    void should_adjustEndOfMonth_when_monthSubtracted() {
        // Given
        String inputDate = "20050331"; // 3월 31일
        int year = 0, month = -1, day = 0; // 1달 빼기
        
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals("20050228", result); // 2월 28일로 조정
    }
    
    @ParameterizedTest
    @CsvSource({
        "'20060228', 0, 0, 10, '20060310'",   // 일반적인 날짜 증가
        "'20060228', 0, 0, 32, '20060401'",   // 월 경계를 넘는 날짜 증가
        "'20041231', 1, 0, 0, '20051231'",    // 년도 증가
        "'20040229', 1, 0, 0, '20050228'",    // 윤년에서 평년으로 (2월 29일 → 2월 28일)
        "'20000228', 0, 0, 1, '20000229'"     // 윤년의 2월 29일 테스트
    })
    @DisplayName("addYearMonthDay: 다양한 날짜 계산 테스트")
    void should_calculateCorrectly_when_variousDateOperations(
            String inputDate, int year, int month, int day, String expected) {
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals(expected, result);
    }
    
    @Test
    @DisplayName("addYearMonthDay: 하이픈이 포함된 날짜 형식 처리")
    void should_handleHyphenatedDateFormat_when_validFormat() {
        // Given
        String inputDate = "2006-02-28";
        int year = 0, month = 0, day = 10;
        
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals("20060310", result);
    }
    
    // ========== 경계값 및 예외 상황 테스트 ==========
    
    @Test
    @DisplayName("addYearMonthDay: null 입력 처리")
    void should_handleNull_when_nullInput() {
        // When & Then
        assertThrows(Exception.class, () -> {
            EgovDateUtil.addYearMonthDay(null, 0, 0, 1);
        });
    }
    
    @Test
    @DisplayName("addYearMonthDay: 명확하게 잘못된 형식")
    void should_throwException_when_clearlyInvalidFormat() {
        // When & Then
        assertThrows(IllegalArgumentException.class, () -> {
            EgovDateUtil.addYearMonthDay("invalid", 0, 0, 1);
        });
        
        assertThrows(IllegalArgumentException.class, () -> {
            EgovDateUtil.addYearMonthDay("2024", 0, 0, 1);
        });
    }
    
    @Test
    @DisplayName("addYearMonthDay: 잘못된 월/일 값 처리")
    void should_handleInvalidDateValues_when_wrongMonthDay() {
        // When & Then - 실제 동작 확인 (예외 발생 여부는 구현에 따라 다름)
        assertDoesNotThrow(() -> {
            EgovDateUtil.addYearMonthDay("20241301", 0, 0, 1); // 13월
        });
        
        assertDoesNotThrow(() -> {
            EgovDateUtil.addYearMonthDay("2024-13-01", 0, 0, 1); // 하이픈 포함 13월
        });
    }
    
    @Test
    @DisplayName("addYearMonthDay: 극한값 테스트 - 큰 수 더하기")
    void should_handleLargeNumbers_when_extremeValues() {
        // Given
        String inputDate = "20240101";
        
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, 100, 0, 0); // 100년 후
        
        // Then
        assertEquals("21240101", result);
    }
    
    @Test  
    @DisplayName("addYearMonthDay: 극한값 테스트 - 큰 수 빼기")
    void should_handleLargeNegativeNumbers_when_extremeValues() {
        // Given
        String inputDate = "20240101";
        
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, -10, 0, 0); // 10년 전
        
        // Then
        assertEquals("20140101", result);
    }
    
    // ========== 윤년 처리 테스트 ==========
    
    @ParameterizedTest
    @CsvSource({
        "'20000229', 0, 0, 365, '20010228'", // 윤년에서 평년으로 1년 후
        "'20000229', 4, 0, 0, '20040229'",   // 윤년에서 윤년으로 4년 후
        "'20040229', 1, 0, 0, '20050228'",   // 윤년에서 평년으로 1년 후
        "'19960229', 4, 0, 0, '20000229'"    // 윤년에서 윤년으로 4년 후
    })
    @DisplayName("addYearMonthDay: 윤년 경계 처리 테스트")
    void should_handleLeapYearBoundary_when_leapYearDates(
            String inputDate, int year, int month, int day, String expected) {
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals(expected, result);
    }
    
    // ========== 월별 경계값 테스트 ==========
    
    @ParameterizedTest
    @CsvSource({
        "'20240131', 0, 1, 0, '20240229'",   // 1월 31일 → 2월 (윤년)
        "'20230131', 0, 1, 0, '20230228'",   // 1월 31일 → 2월 (평년)  
        "'20240131', 0, 3, 0, '20240430'",   // 1월 31일 → 4월 (30일까지만)
        "'20240530', 0, 1, 0, '20240630'",   // 5월 30일 → 6월
        "'20240531', 0, 1, 0, '20240630'"    // 5월 31일 → 6월 (30일로 조정)
    })
    @DisplayName("addYearMonthDay: 월말일 경계 처리 테스트")
    void should_handleMonthEndBoundary_when_monthEndDates(
            String inputDate, int year, int month, int day, String expected) {
        // When
        String result = EgovDateUtil.addYearMonthDay(inputDate, year, month, day);
        
        // Then
        assertEquals(expected, result);
    }
    
    // ========== 연속 계산 테스트 ==========
    
    @Test
    @DisplayName("addYearMonthDay: 연속 날짜 계산 테스트")
    void should_handleConsecutiveCalculations_when_multipleCalls() {
        // Given
        String startDate = "20240101";
        
        // When - 여러 번 연속 계산
        String step1 = EgovDateUtil.addYearMonthDay(startDate, 0, 1, 0);   // +1개월
        String step2 = EgovDateUtil.addYearMonthDay(step1, 0, 0, 15);      // +15일
        String step3 = EgovDateUtil.addYearMonthDay(step2, 1, 0, 0);       // +1년
        
        // Then
        assertEquals("20240201", step1);
        assertEquals("20240216", step2);
        assertEquals("20250216", step3);
    }
    
    // ========== 성능 테스트 ==========
    
    @Test
    @DisplayName("addYearMonthDay: 대량 날짜 계산 성능 테스트")
    void should_performWell_when_manyCalculations() {
        // Given
        String baseDate = "20240101";
        long startTime = System.currentTimeMillis();
        
        // When - 1000번 계산
        for (int i = 0; i < 1000; i++) {
            EgovDateUtil.addYearMonthDay(baseDate, 0, 0, i);
        }
        
        // Then
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;
        
        // 1000번 계산이 5초 이내에 완료되어야 함
        assertTrue(duration < 5000, "날짜 계산 성능이 기대치를 초과했습니다: " + duration + "ms");
    }
    
    // ========== 데이터 일관성 테스트 ==========
    
    @Test
    @DisplayName("addYearMonthDay: 역계산 일관성 테스트")
    void should_maintainConsistency_when_reverseCalculation() {
        // Given
        String originalDate = "20240315";
        
        // When - 앞으로 갔다가 뒤로 가기
        String forward = EgovDateUtil.addYearMonthDay(originalDate, 1, 2, 10);
        String backward = EgovDateUtil.addYearMonthDay(forward, -1, -2, -10);
        
        // Then
        assertEquals(originalDate, backward);
    }
}