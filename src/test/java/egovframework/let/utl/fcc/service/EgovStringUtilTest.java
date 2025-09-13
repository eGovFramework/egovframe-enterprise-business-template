package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.CsvSource;
import org.junit.jupiter.params.provider.NullAndEmptySource;
import org.junit.jupiter.params.provider.ValueSource;

/**
 * EgovStringUtil 클래스에 대한 종합적인 단위 테스트
 * 다양한 엣지 케이스와 경계값 테스트를 포함합니다.
 * 
 * @author eGovFramework Test Team
 * @since 2024.09
 */
@DisplayName("EgovStringUtil 테스트")
class EgovStringUtilTest {

    // ========== cutString 메서드 테스트 ==========
    
    @Test
    @DisplayName("cutString: 정상 케이스 - 길이 초과 시 잘라내기와 추가 문자열 붙이기")
    void should_cutAndAppendString_when_lengthExceeded() {
        // Given
        String source = "안녕하세요반갑습니다";
        String output = "...";
        int slength = 5;
        
        // When
        String result = EgovStringUtil.cutString(source, output, slength);
        
        // Then
        assertEquals("안녕하세요...", result);
    }
    
    @Test
    @DisplayName("cutString: 길이 이하인 경우 원본 반환")
    void should_returnOriginal_when_lengthNotExceeded() {
        // Given
        String source = "짧은글";
        String output = "...";
        int slength = 10;
        
        // When
        String result = EgovStringUtil.cutString(source, output, slength);
        
        // Then
        assertEquals("짧은글", result);
    }
    
    @Test
    @DisplayName("cutString: null 처리")
    void should_handleNull_when_cutString() {
        // When
        String result = EgovStringUtil.cutString(null, "...", 5);
        
        // Then
        assertNull(result);
    }
    
    @Test
    @DisplayName("cutString: 빈 문자열 처리")
    void should_handleEmpty_when_cutString() {
        // When
        String result = EgovStringUtil.cutString("", "...", 5);
        
        // Then
        assertEquals("", result);
    }
    
    @ParameterizedTest
    @CsvSource({
        "'한글테스트문자열', 0, ''",
        "'영문테스트', 3, '영문테'", 
        "'MixedText한글', 8, 'MixedTex'",
        "'특수문자!@#$%^&*()', 5, '특수문자!'"
    })
    @DisplayName("cutString: 다양한 길이와 문자 타입 테스트")
    void should_cutCorrectly_when_variousInputs(String source, int length, String expected) {
        // When
        String result = EgovStringUtil.cutString(source, length);
        
        // Then
        assertEquals(expected, result);
    }
    
    // ========== isEmpty 메서드 테스트 ==========
    
    @Test
    @DisplayName("isEmpty: null 문자열 검증")
    void should_returnTrue_when_stringIsNull() {
        // When & Then
        assertTrue(EgovStringUtil.isEmpty(null));
    }
    
    @Test
    @DisplayName("isEmpty: 빈 문자열 검증") 
    void should_returnTrue_when_stringIsEmpty() {
        // When & Then
        assertTrue(EgovStringUtil.isEmpty(""));
    }
    
    @ParameterizedTest
    @ValueSource(strings = {" ", "  ", "\t", "\n", "a", "text", "한글", "!@#"})
    @DisplayName("isEmpty: 공백이나 내용이 있는 문자열은 false")
    void should_returnFalse_when_stringHasContent(String input) {
        // When & Then
        assertFalse(EgovStringUtil.isEmpty(input));
    }
    
    // ========== remove 메서드 테스트 ==========
    
    @Test
    @DisplayName("remove: 문자 제거 정상 케이스")
    void should_removeTargetChar_when_charExists() {
        // Given
        String source = "queued";
        char removeChar = 'u';
        
        // When
        String result = EgovStringUtil.remove(source, removeChar);
        
        // Then
        assertEquals("qeed", result);
    }
    
    @Test
    @DisplayName("remove: 제거 대상 문자가 없는 경우")
    void should_returnOriginal_when_charNotExists() {
        // Given
        String source = "queued";
        char removeChar = 'z';
        
        // When
        String result = EgovStringUtil.remove(source, removeChar);
        
        // Then
        assertEquals("queued", result);
    }
    
    @ParameterizedTest
    @NullAndEmptySource
    @DisplayName("remove: null 또는 빈 문자열 처리")
    void should_handleNullOrEmpty_when_remove(String source) {
        // When
        String result = EgovStringUtil.remove(source, 'a');
        
        // Then
        assertEquals(source, result); // null은 null, ""는 "" 반환
    }
    
    @ParameterizedTest
    @CsvSource({
        "'aabbcc', 'a', 'bbcc'",
        "'한글테스트', '스', '한글테트'",
        "'!!!???', '!', '???'",
        "'123-456-789', '-', '123456789'"
    })
    @DisplayName("remove: 다양한 문자 제거 테스트")
    void should_removeAllOccurrences_when_multipleCharsExist(String source, char removeChar, String expected) {
        // When
        String result = EgovStringUtil.remove(source, removeChar);
        
        // Then
        assertEquals(expected, result);
    }
    
    // ========== 경계값 및 성능 테스트 ==========
    
    @Test
    @DisplayName("cutString: 경계값 테스트 - 길이 0")
    void should_handleZeroLength_when_cutString() {
        // Given
        String source = "테스트";
        
        // When
        String result = EgovStringUtil.cutString(source, 0);
        
        // Then
        assertEquals("", result);
    }
    
    @Test
    @DisplayName("cutString: 경계값 테스트 - 음수 길이")
    void should_handleNegativeLength_when_cutString() {
        // Given
        String source = "테스트";
        
        // When & Then
        assertThrows(StringIndexOutOfBoundsException.class, () -> {
            EgovStringUtil.cutString(source, -1);
        });
    }
    
    @Test
    @DisplayName("대용량 문자열 처리 테스트")
    void should_handleLargeString_when_processing() {
        // Given
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < 10000; i++) {
            sb.append("테스트");
        }
        String largeString = sb.toString();
        
        // When
        String cutResult = EgovStringUtil.cutString(largeString, 100);
        boolean emptyResult = EgovStringUtil.isEmpty(largeString);
        String removeResult = EgovStringUtil.remove(largeString, '스');
        
        // Then
        assertEquals(100, cutResult.length());
        assertFalse(emptyResult);
        assertFalse(removeResult.contains("스"));
    }
    
    // ========== 특수 케이스 테스트 ==========
    
    @Test
    @DisplayName("유니코드 문자 처리 테스트")
    void should_handleUnicodeCharacters_when_processing() {
        // Given
        String unicodeStr = "👍🎉🚀한글English123!@#";
        
        // When
        String cutResult = EgovStringUtil.cutString(unicodeStr, 10);
        boolean emptyResult = EgovStringUtil.isEmpty(unicodeStr);
        String removeResult = EgovStringUtil.remove(unicodeStr, '🎉');
        
        // Then
        assertEquals(10, cutResult.length());
        assertFalse(emptyResult);
        assertFalse(removeResult.contains("🎉"));
    }
    
    @Test
    @DisplayName("공백 문자 처리 테스트")
    void should_handleWhitespaceCharacters_when_processing() {
        // Given
        String whitespaceStr = " \t\n\r ";
        
        // When
        boolean emptyResult = EgovStringUtil.isEmpty(whitespaceStr);
        String removeSpaceResult = EgovStringUtil.remove(whitespaceStr, ' ');
        String removeTabResult = EgovStringUtil.remove(whitespaceStr, '\t');
        
        // Then
        assertFalse(emptyResult); // 공백도 내용이므로 false
        assertEquals("\t\n\r", removeSpaceResult);
        assertEquals(" \n\r ", removeTabResult);
    }
}