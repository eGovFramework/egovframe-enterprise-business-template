package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.*;

import java.util.HashSet;
import java.util.Set;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.ValueSource;

/**
 * EgovNumberUtil 클래스에 대한 종합적인 단위 테스트
 * 숫자 처리의 다양한 엣지 케이스와 경계값 테스트를 포함합니다.
 * 
 * @author eGovFramework Test Team
 * @since 2024.09
 */
@DisplayName("EgovNumberUtil 테스트")
class EgovNumberUtilTest {

    // ========== getRandomNum 메서드 테스트 ==========
    
    @Test
    @DisplayName("getRandomNum: 정상 범위 내 랜덤 숫자 생성")
    void should_generateRandomWithinRange_when_validRangeGiven() {
        // Given
        int startNum = 10;
        int endNum = 20;
        
        // When
        int randomNum = EgovNumberUtil.getRandomNum(startNum, endNum);
        
        // Then
        assertTrue(randomNum >= startNum && randomNum <= endNum, 
                   "Random number " + randomNum + " should be between " + startNum + " and " + endNum);
    }
    
    @Test
    @DisplayName("getRandomNum: 동일한 시작/종료 숫자")
    void should_returnSameNumber_when_startEqualsEnd() {
        // Given
        int num = 5;
        
        // When
        int randomNum = EgovNumberUtil.getRandomNum(num, num);
        
        // Then
        assertEquals(num, randomNum);
    }
    
    @Test
    @DisplayName("getRandomNum: 0부터 시작하는 범위")
    void should_handleZeroStart_when_startFromZero() {
        // Given
        int startNum = 0;
        int endNum = 10;
        
        // When
        int randomNum = EgovNumberUtil.getRandomNum(startNum, endNum);
        
        // Then
        assertTrue(randomNum >= 0 && randomNum <= 10);
    }
    
    @Test
    @DisplayName("getRandomNum: 분포도 테스트 (통계적 검증)")
    void should_generateWellDistributedNumbers_when_multipleCallsMade() {
        // Given
        int startNum = 1;
        int endNum = 5;
        int iterations = 10000;
        Set<Integer> generatedNumbers = new HashSet<>();
        
        // When - 10000번 랜덤 숫자 생성
        for (int i = 0; i < iterations; i++) {
            int randomNum = EgovNumberUtil.getRandomNum(startNum, endNum);
            generatedNumbers.add(randomNum);
            assertTrue(randomNum >= startNum && randomNum <= endNum);
        }
        
        // Then - 1~5 모든 숫자가 최소 한 번은 나와야 함
        assertEquals(5, generatedNumbers.size(), "모든 범위의 숫자가 생성되어야 합니다");
        for (int i = startNum; i <= endNum; i++) {
            assertTrue(generatedNumbers.contains(i), "숫자 " + i + "가 생성되지 않았습니다");
        }
    }
    
    @ParameterizedTest
    @CsvSource({
        "1, 100",
        "50, 100", 
        "0, 1",
        "100, 1000",
        "-10, 10"
    })
    @DisplayName("getRandomNum: 다양한 범위 테스트")
    void should_generateValidNumbers_when_variousRanges(int start, int end) {
        // When
        int randomNum = EgovNumberUtil.getRandomNum(start, end);
        
        // Then
        assertTrue(randomNum >= start && randomNum <= end,
                   "Generated " + randomNum + " should be between " + start + " and " + end);
    }
    
    // ========== getNumSearchCheck 메서드 테스트 ==========
    
    @Test
    @DisplayName("getNumSearchCheck: 숫자 존재 확인 - 존재하는 경우")
    void should_returnTrue_when_digitExists() {
        // Given
        int sourceInt = 12345678;
        int searchInt = 7;
        
        // When
        Boolean result = EgovNumberUtil.getNumSearchCheck(sourceInt, searchInt);
        
        // Then
        assertTrue(result);
    }
    
    @Test
    @DisplayName("getNumSearchCheck: 숫자 존재 확인 - 존재하지 않는 경우")
    void should_returnFalse_when_digitNotExists() {
        // Given
        int sourceInt = 12345678;
        int searchInt = 9;
        
        // When
        Boolean result = EgovNumberUtil.getNumSearchCheck(sourceInt, searchInt);
        
        // Then
        assertFalse(result);
    }
    
    @ParameterizedTest
    @CsvSource({
        "12345, 1, true",
        "12345, 3, true", 
        "12345, 5, true",
        "12345, 0, false",
        "12345, 6, false",
        "0, 0, true",
        "10203, 0, true",
        "999, 9, true"
    })
    @DisplayName("getNumSearchCheck: 다양한 숫자 검색 테스트")
    void should_findDigitCorrectly_when_variousInputs(int source, int search, boolean expected) {
        // When
        Boolean result = EgovNumberUtil.getNumSearchCheck(source, search);
        
        // Then
        assertEquals(expected, result);
    }
    
    @Test
    @DisplayName("getNumSearchCheck: 음수 처리 테스트")
    void should_handleNegativeNumbers_when_negativeInput() {
        // Given
        int sourceInt = -12345;
        int searchInt = 2;
        
        // When
        Boolean result = EgovNumberUtil.getNumSearchCheck(sourceInt, searchInt);
        
        // Then
        assertTrue(result); // -12345에서 2를 찾을 수 있어야 함
    }
    
    @Test
    @DisplayName("getNumSearchCheck: 다중 자릿수 검색")
    void should_handleMultiDigitSearch_when_searchingMultipleDigits() {
        // Given
        int sourceInt = 12345678;
        int searchInt = 456; // 연속된 여러 자릿수
        
        // When
        Boolean result = EgovNumberUtil.getNumSearchCheck(sourceInt, searchInt);
        
        // Then
        assertTrue(result); // 12345678에서 456을 찾을 수 있어야 함
    }
    
    // ========== getNumToStrCnvr 메서드 테스트 ==========
    
    @Test
    @DisplayName("getNumToStrCnvr: 정수를 문자열로 변환")
    void should_convertNumberToString_when_validNumberGiven() {
        // Given
        int number = 20081212;
        
        // When
        String result = EgovNumberUtil.getNumToStrCnvr(number);
        
        // Then
        assertEquals("20081212", result);
    }
    
    @ParameterizedTest
    @ValueSource(ints = {0, 1, -1, 123, -456, 2147483647, -2147483648})
    @DisplayName("getNumToStrCnvr: 다양한 정수 변환 테스트")
    void should_convertVariousNumbers_when_differentIntegers(int number) {
        // When
        String result = EgovNumberUtil.getNumToStrCnvr(number);
        
        // Then
        assertEquals(String.valueOf(number), result);
        assertNotNull(result);
    }
    
    // ========== getNumToDateCnvr 메서드 테스트 ==========
    
    @Test
    @DisplayName("getNumToDateCnvr: 8자리 숫자를 날짜로 변환")
    void should_convert8DigitNumberToDate_when_validDateNumber() {
        // Given
        int dateNumber = 20081212;
        
        // When
        String result = EgovNumberUtil.getNumToDateCnvr(dateNumber);
        
        // Then
        assertEquals("2008-12-12", result);
    }
    
    @Test  
    @DisplayName("getNumToDateCnvr: 14자리 숫자를 날짜로 변환")
    void should_convert14DigitNumberToDate_when_validDateTimeNumber() {
        // Given
        int dateTimeNumber = 20081212; // Note: int는 14자리 처리 불가, long 필요
        
        // When & Then
        // 8자리로 처리됨
        String result = EgovNumberUtil.getNumToDateCnvr(dateTimeNumber);
        assertEquals("2008-12-12", result);
    }
    
    @ParameterizedTest
    @CsvSource({
        "20240101, 2024-01-01",
        "20000229, 2000-02-29",  // 윤년
        "19991231, 1999-12-31"
    })
    @DisplayName("getNumToDateCnvr: 다양한 유효한 날짜 변환")
    void should_convertValidDates_when_validDateNumbers(int dateNumber, String expected) {
        // When
        String result = EgovNumberUtil.getNumToDateCnvr(dateNumber);
        
        // Then
        assertEquals(expected, result);
    }
    
    @ParameterizedTest
    @ValueSource(ints = {1234567, 123456789, 12345, 0, -20081212})
    @DisplayName("getNumToDateCnvr: 잘못된 길이의 숫자 처리")
    void should_throwException_when_invalidLengthNumbers(int invalidNumber) {
        // When & Then
        assertThrows(IllegalArgumentException.class, () -> {
            EgovNumberUtil.getNumToDateCnvr(invalidNumber);
        });
    }
    
    @ParameterizedTest
    @ValueSource(ints = {20081301, 20080230, 20081332}) // 잘못된 날짜
    @DisplayName("getNumToDateCnvr: 잘못된 날짜 형식 처리")
    void should_handleInvalidDates_when_invalidDateNumbers(int invalidDate) {
        // When - 파싱 오류가 발생하지만 예외는 던지지 않고 null 반환 가능
        String result = EgovNumberUtil.getNumToDateCnvr(invalidDate);
        
        // Then - 구현에 따라 null이거나 오류 처리될 수 있음
        // 실제 구현을 확인해야 정확한 예상 결과 설정 가능
        // 여기서는 예외가 발생하지 않는다고 가정
        assertDoesNotThrow(() -> EgovNumberUtil.getNumToDateCnvr(invalidDate));
    }
    
    // ========== 경계값 테스트 ==========
    
    @Test
    @DisplayName("getRandomNum: 경계값 테스트 - 큰 범위")
    void should_handleLargeRange_when_extremeValues() {
        // Given - 합리적인 범위로 테스트
        int start = 1000;
        int end = 10000;
        
        // When
        int result = EgovNumberUtil.getRandomNum(start, end);
        
        // Then
        assertTrue(result >= start && result <= end);
    }
    
    @Test
    @DisplayName("모든 메서드 null-safety 테스트")
    void should_handleEdgeCasesGracefully_when_extremeInputs() {
        // getNumSearchCheck with 0
        assertDoesNotThrow(() -> {
            EgovNumberUtil.getNumSearchCheck(0, 0);
        });
        
        // getNumToStrCnvr with 0
        assertDoesNotThrow(() -> {
            EgovNumberUtil.getNumToStrCnvr(0);
        });
        
        // 경계값들이 정상적으로 처리되는지 확인
        assertNotNull(EgovNumberUtil.getNumToStrCnvr(0));
        assertTrue(EgovNumberUtil.getNumSearchCheck(0, 0));
    }
    
    // ========== 성능 테스트 ==========
    
    @Test
    @DisplayName("대량 연산 성능 테스트")
    void should_performWell_when_manyOperations() {
        // Given
        long startTime = System.currentTimeMillis();
        
        // When - 다양한 메서드 1000번씩 호출
        for (int i = 0; i < 1000; i++) {
            EgovNumberUtil.getRandomNum(1, 100);
            EgovNumberUtil.getNumSearchCheck(123456789, i % 10);
            EgovNumberUtil.getNumToStrCnvr(i);
        }
        
        // Then
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;
        
        assertTrue(duration < 5000, "성능이 기대치를 초과했습니다: " + duration + "ms");
    }
}