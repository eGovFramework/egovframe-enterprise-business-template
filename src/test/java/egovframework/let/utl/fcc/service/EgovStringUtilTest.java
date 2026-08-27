package egovframework.let.utl.fcc.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

/**
 * EgovStringUtil 단위 테스트
 */
class EgovStringUtilTest {

    // ── cutString(String, String, int) ──────────────────────────────────────

    @Test
    @DisplayName("cutString: 길이 초과 시 자르고 suffix 붙임")
    void cutString_exceedsLength_appendsSuffix() {
        assertEquals("Hello...", EgovStringUtil.cutString("Hello World", "...", 5));
    }

    @Test
    @DisplayName("cutString: 길이 이하인 경우 원본 반환")
    void cutString_withinLength_returnsOriginal() {
        assertEquals("Hi", EgovStringUtil.cutString("Hi", "...", 5));
    }

    @Test
    @DisplayName("cutString: null 입력 시 null 반환")
    void cutString_null_returnsNull() {
        assertNull(EgovStringUtil.cutString(null, "...", 5));
    }

    // ── cutString(String, int) ───────────────────────────────────────────────

    @Test
    @DisplayName("cutString(no suffix): 길이 초과 시 잘라냄")
    void cutStringNoSuffix_exceedsLength_truncates() {
        assertEquals("Hello", EgovStringUtil.cutString("Hello World", 5));
    }

    @Test
    @DisplayName("cutString(no suffix): 길이 이하인 경우 원본 반환")
    void cutStringNoSuffix_withinLength_returnsOriginal() {
        assertEquals("Hi", EgovStringUtil.cutString("Hi", 5));
    }

    // ── isEmpty ─────────────────────────────────────────────────────────────

    @Test
    @DisplayName("isEmpty: null → true")
    void isEmpty_null_returnsTrue() {
        assertTrue(EgovStringUtil.isEmpty(null));
    }

    @Test
    @DisplayName("isEmpty: 빈 문자열 → true")
    void isEmpty_emptyString_returnsTrue() {
        assertTrue(EgovStringUtil.isEmpty(""));
    }

    @Test
    @DisplayName("isEmpty: 공백 포함 문자열 → false")
    void isEmpty_blankString_returnsFalse() {
        assertFalse(EgovStringUtil.isEmpty(" "));
    }

    @Test
    @DisplayName("isEmpty: 일반 문자열 → false")
    void isEmpty_normalString_returnsFalse() {
        assertFalse(EgovStringUtil.isEmpty("hello"));
    }

    // ── remove ───────────────────────────────────────────────────────────────

    @Test
    @DisplayName("remove: 지정 문자 모두 제거")
    void remove_removesAllOccurrences() {
        assertEquals("qeed", EgovStringUtil.remove("queued", 'u'));
    }

    @Test
    @DisplayName("remove: 없는 문자 제거 시도 → 원본 반환")
    void remove_charNotPresent_returnsOriginal() {
        assertEquals("queued", EgovStringUtil.remove("queued", 'z'));
    }

    @Test
    @DisplayName("remove: null 입력 → null 반환")
    void remove_null_returnsNull() {
        assertNull(EgovStringUtil.remove(null, 'u'));
    }

    // ── removeCommaChar / removeMinusChar ────────────────────────────────────

    @Test
    @DisplayName("removeCommaChar: 콤마 제거")
    void removeCommaChar_removesCommas() {
        assertEquals("asdfgqweqe", EgovStringUtil.removeCommaChar("asdfg,qweqe"));
    }

    @Test
    @DisplayName("removeMinusChar: 마이너스 제거")
    void removeMinusChar_removesMinuses() {
        assertEquals("asdfgqweqe", EgovStringUtil.removeMinusChar("a-sdfg-qweqe"));
    }

    // ── replace ──────────────────────────────────────────────────────────────

    @Test
    @DisplayName("replace: 모든 일치 문자열 치환")
    void replace_replacesAllOccurrences() {
        assertEquals("AXcAXc", EgovStringUtil.replace("AbcAbc", "b", "X"));
    }

    @Test
    @DisplayName("replace: 일치 없음 → 원본 반환")
    void replace_noMatch_returnsOriginal() {
        assertEquals("abc", EgovStringUtil.replace("abc", "z", "X"));
    }

    // ── replaceOnce ──────────────────────────────────────────────────────────

    @Test
    @DisplayName("replaceOnce: 첫 번째 일치만 치환")
    void replaceOnce_replacesFirstOnly() {
        assertEquals("AXcAbc", EgovStringUtil.replaceOnce("AbcAbc", "b", "X"));
    }

    // ── indexOf ──────────────────────────────────────────────────────────────

    @Test
    @DisplayName("indexOf: 정상 검색")
    void indexOf_found_returnsIndex() {
        assertEquals(2, EgovStringUtil.indexOf("aabaabaa", "b"));
    }

    @Test
    @DisplayName("indexOf: null 입력 → -1")
    void indexOf_nullStr_returnsMinusOne() {
        assertEquals(-1, EgovStringUtil.indexOf(null, "b"));
    }

    @Test
    @DisplayName("indexOf: null 검색어 → -1")
    void indexOf_nullSearchStr_returnsMinusOne() {
        assertEquals(-1, EgovStringUtil.indexOf("aabaabaa", null));
    }

    // ── lowerCase / upperCase ────────────────────────────────────────────────

    @Test
    @DisplayName("lowerCase: 대문자 → 소문자 변환")
    void lowerCase_convertToLower() {
        assertEquals("abc", EgovStringUtil.lowerCase("aBc"));
    }

    @Test
    @DisplayName("lowerCase: null → null")
    void lowerCase_null_returnsNull() {
        assertNull(EgovStringUtil.lowerCase(null));
    }

    @Test
    @DisplayName("upperCase: 소문자 → 대문자 변환")
    void upperCase_convertToUpper() {
        assertEquals("ABC", EgovStringUtil.upperCase("aBc"));
    }

    @Test
    @DisplayName("upperCase: null → null")
    void upperCase_null_returnsNull() {
        assertNull(EgovStringUtil.upperCase(null));
    }

    // ── stripStart / stripEnd / strip ───────────────────────────────────────

    @Test
    @DisplayName("stripStart: 앞쪽 공백 제거 (null stripChars)")
    void stripStart_leadingWhitespace_stripped() {
        assertEquals("abc  ", EgovStringUtil.stripStart("  abc  ", null));
    }

    @Test
    @DisplayName("stripStart: 지정 문자 앞에서 제거")
    void stripStart_specifiedChars_stripped() {
        assertEquals("abc  ", EgovStringUtil.stripStart("yxabc  ", "xyz"));
    }

    @Test
    @DisplayName("stripEnd: 뒤쪽 공백 제거 (null stripChars)")
    void stripEnd_trailingWhitespace_stripped() {
        assertEquals("  abc", EgovStringUtil.stripEnd("  abc  ", null));
    }

    @Test
    @DisplayName("stripEnd: 지정 문자 뒤에서 제거")
    void stripEnd_specifiedChars_stripped() {
        assertEquals("  abc", EgovStringUtil.stripEnd("  abcyx", "xyz"));
    }

    @Test
    @DisplayName("strip: 앞뒤 공백 제거")
    void strip_bothSidesWhitespace_stripped() {
        assertEquals("abc", EgovStringUtil.strip(" abc ", null));
    }

    // ── decode ───────────────────────────────────────────────────────────────

    @Test
    @DisplayName("decode(4-arg): 두 값 같을 때 returnStr 반환")
    void decode4Arg_equal_returnsReturnStr() {
        assertEquals("foo", EgovStringUtil.decode("하이", "하이", "foo", "bar"));
    }

    @Test
    @DisplayName("decode(4-arg): 두 값 다를 때 defaultStr 반환")
    void decode4Arg_notEqual_returnsDefaultStr() {
        assertEquals("bar", EgovStringUtil.decode("하이", "하이  ", "foo", "bar"));
    }

    @Test
    @DisplayName("decode(4-arg): 둘 다 null일 때 returnStr 반환")
    void decode4Arg_bothNull_returnsReturnStr() {
        assertEquals("foo", EgovStringUtil.decode(null, null, "foo", "bar"));
    }

    @Test
    @DisplayName("decode(3-arg): 같을 때 returnStr 반환")
    void decode3Arg_equal_returnsReturnStr() {
        assertEquals("foo", EgovStringUtil.decode("하이", "하이", "foo"));
    }

    @Test
    @DisplayName("decode(3-arg): 다를 때 sourceStr 반환")
    void decode3Arg_notEqual_returnsSourceStr() {
        assertEquals("하이", EgovStringUtil.decode("하이", "바이", "foo"));
    }

    // ── addMinusChar ─────────────────────────────────────────────────────────

    @Test
    @DisplayName("addMinusChar: 8자리 날짜에 - 삽입")
    void addMinusChar_8digits_formatsDate() {
        assertEquals("2010-09-01", EgovStringUtil.addMinusChar("20100901"));
    }

    @Test
    @DisplayName("addMinusChar: 8자리 아닌 경우 빈 문자열 반환")
    void addMinusChar_notEightDigits_returnsEmpty() {
        assertEquals("", EgovStringUtil.addMinusChar("2010090"));
    }

    // ── removeWhitespace ─────────────────────────────────────────────────────

    @Test
    @DisplayName("removeWhitespace: 공백 문자 모두 제거")
    void removeWhitespace_removesAll() {
        assertEquals("abc", EgovStringUtil.removeWhitespace("   ab  c  "));
    }

    @Test
    @DisplayName("removeWhitespace: null → null")
    void removeWhitespace_null_returnsNull() {
        assertNull(EgovStringUtil.removeWhitespace(null));
    }

    // ── nullConvert / isNullToString ──────────────────────────────────────────

    @Test
    @DisplayName("isNullToString: null → 빈 문자열")
    void isNullToString_null_returnsEmpty() {
        assertEquals("", EgovStringUtil.isNullToString(null));
    }

    @Test
    @DisplayName("isNullToString: 객체 → toString().trim()")
    void isNullToString_object_returnsTrimmedString() {
        assertEquals("hello", EgovStringUtil.isNullToString("  hello  "));
    }
}
