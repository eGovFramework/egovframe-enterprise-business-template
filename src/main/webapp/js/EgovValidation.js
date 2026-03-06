/**
 * eGovFrame Common Validation JavaScript Library
 * Spring Modules Validation을 대체하는 클라이언트사이드 검증 라이브러리
 */

const EgovValidation = {
    
    // 에러 메시지 설정
    messages: {
        required: '{0}은(는) 필수입력 항목입니다.',
        maxlength: '{0}은(는) {1}자를 초과할 수 없습니다.',
        minlength: '{0}은(는) {1}자 이상이어야 합니다.',
        integer: '{0}은(는) 숫자여야 합니다.',
        email: '{0}은(는) 올바른 이메일 형식이 아닙니다.',
        password1: '패스워드는 8~20자 이내여야 합니다.',
        password2: '패스워드에 특수문자를 사용할 수 없습니다.',
        password3: '연속된 문자나 순차적인 문자 4개 이상 사용할 수 없습니다.',
        password4: '반복문자나 숫자 연속 4개 이상 사용할 수 없습니다.',
        pwdCheckComb3: '영문자, 숫자, 특수문자의 최소 3가지 조합이어야 합니다.',
        pwdCheckComb4: '영대문자, 영소문자, 숫자, 특수문자의 최소 4가지 조합이어야 합니다.',
        pwdCheckSeries: '연속된 3개 이상의 문자나 숫자를 사용할 수 없습니다.',
        pwdCheckRepeat: '반복된 3개 이상의 문자나 숫자를 사용할 수 없습니다.',
        english: '{0}은(는) 영문자만 입력 가능합니다.'
    },
    
    // 기본 validation 규칙들
    rules: {
        // 필수입력 검사
        required: function(value) {
            return value !== null && value !== undefined && 
                   (typeof value === 'string' ? value.trim().length > 0 : true);
        },
        
        // 최대 길이 검사
        maxlength: function(value, max) {
            if (!value) return true;
            return value.length <= parseInt(max);
        },
        
        // 최소 길이 검사
        minlength: function(value, min) {
            if (!value) return true;
            return value.length >= parseInt(min);
        },
        
        // 숫자 검사
        integer: function(value) {
            if (!value) return true;
            return /^\d+$/.test(value);
        },
        
        // 이메일 검사
        email: function(value) {
            if (!value) return true;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(value);
        },
        
        // 영문자만 허용
        english: function(value) {
            if (!value) return true;
            return /^[a-zA-Z]+$/.test(value);
        },
        
        // 패스워드 길이 검사 (8~20자)
        password1: function(value) {
            if (!value) return true;
            return value.length >= 8 && value.length <= 20;
        },
        
        // 패스워드 특수문자 제한
        password2: function(value) {
            if (!value) return true;
            // 특수문자 체크 (ASCII 33-47, 58-64, 91-96, 123-126)
            for (let i = 0; i < value.length; i++) {
                const ch = value.charCodeAt(i);
                if ((ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || 
                    (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126)) {
                    return false;
                }
            }
            return true;
        },
        
        // 연속된 문자/순차적 문자 4개 이상 금지
        password3: function(value) {
            if (!value) return true;
            let cnt = 0, cnt2 = 1, cnt3 = 1;
            let temp = "";
            
            for (let i = 0; i < value.length; i++) {
                const ch = value.charAt(i);
                if (i > 0) {
                    const prevCh = value.charAt(i-1);
                    if (ch.charCodeAt(0) - prevCh.charCodeAt(0) === 1) {
                        cnt2++;
                        if (cnt2 >= 4) return false;
                    } else {
                        cnt2 = 1;
                    }
                    
                    if (ch.charCodeAt(0) - prevCh.charCodeAt(0) === -1) {
                        cnt3++;
                        if (cnt3 >= 4) return false;
                    } else {
                        cnt3 = 1;
                    }
                }
            }
            return true;
        },
        
        // 반복문자/숫자 연속 4개 이상 금지
        password4: function(value) {
            if (!value) return true;
            for (let i = 0; i < value.length - 3; i++) {
                if (value.charAt(i) === value.charAt(i+1) && 
                    value.charAt(i) === value.charAt(i+2) && 
                    value.charAt(i) === value.charAt(i+3)) {
                    return false;
                }
            }
            return true;
        },
        
        // 3가지 조합 (영문자, 숫자, 특수문자)
        pwdCheckComb3: function(value) {
            if (!value) return true;
            let hasAlpha = /[a-zA-Z]/.test(value);
            let hasNum = /\d/.test(value);
            let hasSpecial = /[~!@#$%^&*?]/.test(value);
            
            let count = 0;
            if (hasAlpha) count++;
            if (hasNum) count++;
            if (hasSpecial) count++;
            
            return count >= 3;
        },
        
        // 4가지 조합 (영대문자, 영소문자, 숫자, 특수문자)
        pwdCheckComb4: function(value) {
            if (!value) return true;
            let hasUpper = /[A-Z]/.test(value);
            let hasLower = /[a-z]/.test(value);
            let hasNum = /\d/.test(value);
            let hasSpecial = /[~!@#$%^&*?]/.test(value);
            
            let count = 0;
            if (hasUpper) count++;
            if (hasLower) count++;
            if (hasNum) count++;
            if (hasSpecial) count++;
            
            return count >= 4;
        },
        
        // 연속된 3개 이상의 문자나 숫자 금지
        pwdCheckSeries: function(value) {
            if (!value) return true;
            for (let i = 0; i < value.length - 2; i++) {
                const ch1 = value.charCodeAt(i);
                const ch2 = value.charCodeAt(i+1);
                const ch3 = value.charCodeAt(i+2);
                
                if ((ch2 - ch1 === 1 && ch3 - ch2 === 1) || 
                    (ch1 - ch2 === 1 && ch2 - ch3 === 1)) {
                    return false;
                }
            }
            return true;
        },
        
        // 반복된 3개 이상의 문자나 숫자 금지
        pwdCheckRepeat: function(value) {
            if (!value) return true;
            for (let i = 0; i < value.length - 2; i++) {
                if (value.charAt(i) === value.charAt(i+1) && 
                    value.charAt(i) === value.charAt(i+2)) {
                    return false;
                }
            }
            return true;
        }
    },
    
    // 폼 검증 함수
    validateForm: function(formElement, validationRules) {
        const errors = [];
        let firstErrorField = null;
        
        for (const fieldName in validationRules) {
            const field = formElement.elements[fieldName];
            if (!field) continue;
            
            const fieldRules = validationRules[fieldName];
            const fieldValue = this.getFieldValue(field);
            const fieldLabel = fieldRules.label || fieldName;
            
            // 각 규칙별로 검증
            for (const ruleName in fieldRules.rules) {
                if (ruleName === 'label') continue;
                
                const ruleValue = fieldRules.rules[ruleName];
                const ruleFunction = this.rules[ruleName];
                
                if (ruleFunction) {
                    let isValid = false;
                    
                    if (ruleValue === true) {
                        // 매개변수가 없는 규칙
                        isValid = ruleFunction(fieldValue);
                    } else {
                        // 매개변수가 있는 규칙
                        isValid = ruleFunction(fieldValue, ruleValue);
                    }
                    
                    if (!isValid) {
                        const errorMsg = this.formatMessage(this.messages[ruleName], fieldLabel, ruleValue);
                        errors.push(errorMsg);
                        
                        if (!firstErrorField) {
                            firstErrorField = field;
                        }
                        break; // 첫 번째 에러만 표시
                    }
                }
            }
        }
        
        if (errors.length > 0) {
            alert(errors.join('\n'));
            if (firstErrorField) {
                firstErrorField.focus();
            }
            return false;
        }
        
        return true;
    },
    
    // 필드 값 가져오기
    getFieldValue: function(field) {
        if (!field) return '';
        
        if (field.type === 'checkbox' || field.type === 'radio') {
            if (field.length) {
                // 배열인 경우
                for (let i = 0; i < field.length; i++) {
                    if (field[i].checked) {
                        return field[i].value;
                    }
                }
                return '';
            } else {
                return field.checked ? field.value : '';
            }
        } else if (field.type === 'select-one') {
            return field.selectedIndex >= 0 ? field.options[field.selectedIndex].value : '';
        } else if (field.type === 'select-multiple') {
            const values = [];
            for (let i = 0; i < field.options.length; i++) {
                if (field.options[i].selected) {
                    values.push(field.options[i].value);
                }
            }
            return values.join(',');
        } else {
            return field.value || '';
        }
    },
    
    // 메시지 포맷팅
    formatMessage: function(template, ...args) {
        return template.replace(/{(\d+)}/g, function(match, index) {
            return args[index] !== undefined ? args[index] : match;
        });
    },
    
    // 문자열 trim 유틸리티
    trim: function(str) {
        return str ? str.replace(/^\s+|\s+$/g, '') : '';
    }
};

// 전역 함수로 노출 (기존 코드 호환성을 위해)
window.EgovValidation = EgovValidation;

// 기존 Spring Modules validation 함수들을 대체하는 래퍼 함수들

// 게시판 관리 
function validateBoardMaster(form) {
    const rules = {
        bbsNm: {
            label: '게시판명',
            rules: {
                required: true,
                maxlength: 120
            }
        },
        bbsIntrcn: {
            label: '게시판소개',
            rules: {
                required: true,
                maxlength: 2000
            }
        },
        bbsTyCode: {
            label: '게시판유형',
            rules: {
                required: true
            }
        },
		bbsAttrbCode: {
			label: '게시판속성',
			rules: {
				required: true
			}
		},
        replyPosblAt: {
            label: '답글가능여부',
            rules: {
                required: true
            }
        },
        fileAtchPosblAt: {
            label: '파일첨부가능여부',
            rules: {
                required: true
            }
        },
		posblAtchFileNumber: {
			label: '첨부가능파일 숫자',
			rules: {
				required: true
			}
		},
        tmplatNm: {
            label: '템플릿정보',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 게시판
function validateBoard(form) {
    const rules = {
        nttSj: {
            label: '제목',
            rules: {
                required: true,
                maxlength: 1200
            }
        },
		nttCn: {
            label: '글내용',
            rules: {
                required: true
            }
        },
		ntceBgnde: {
		    label: '게시기간 시작일',
		    rules: {
		        required: true
		    }
		},
		ntceEndde: {
		    label: '게시기간 종료일',
		    rules: {
		        required: true
		    }
		},
		ntcrNm: {
			label: 'ntcrNm',
		    rules: {
		        required: true
		    }
		},
		password: {
			label: 'password',
		    rules: {
		        required: true
		    }
		}
    };
    return EgovValidation.validateForm(form, rules);
}

// 템플릿 관리
function validateTemplateInf(form) {
    const rules = {
        tmplatNm: {
            label: '템플릿명',
            rules: {
                required: true,
                maxlength: 120
            }
        },
        tmplatCours: {
            label: '템플릿경로',
            rules: {
                required: true,
                maxlength: 2000
            }
        },
        tmplatSeCode: {
            label: '템플릿구분코드',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 게시판 사용 정보
function validateBoardUseInf(form) {
    const rules = {
        bbsNm: {
            label: '게시판명',
            rules: {
                required: true
            }
        },
        trgetNm: {
            label: '대상명',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 사용자 부재
function validateUserAbsnce(form) {
    const rules = {
        // userAbsnce form에 대한 validation 규칙이 XML에 정의되지 않았으므로 기본 규칙만 설정
        // 실제 사용 시 필요한 필드들을 추가해야 함
    };
    return EgovValidation.validateForm(form, rules);
}

// 메인 이미지
function validateMainImage(form) {
    const rules = {
        // mainImage form에 대한 validation 규칙이 XML에 정의되지 않았으므로 기본 규칙만 설정
        // 실제 사용 시 필요한 필드들을 추가해야 함
    };
    return EgovValidation.validateForm(form, rules);
}

// 사용자 관리
function validateUserManageVO(form) {
    const rules = {
        emplyrId: {
            label: '사용자아이디',
            rules: {
                required: true,
                maxlength: 20
            }
        },
        emplyrNm: {
            label: '사용자이름',
            rules: {
                required: true,
                maxlength: 50
            }
        },
        passwordHint: {
            label: '비밀번호힌트',
            rules: {
                required: true
            }
        },
        passwordCnsr: {
            label: '비밀번호정답',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        areaNo: {
            label: '집지역번호',
            rules: {
                maxlength: 4
            }
        },
        homemiddleTelno: {
            label: '집중간전화번호',
            rules: {
                maxlength: 4
            }
        },
        homeendTelno: {
            label: '집마지막전화번호',
            rules: {
                maxlength: 4
            }
        },
        offmTelno: {
            label: '사무실전화번호',
            rules: {
                maxlength: 15
            }
        },
        fxnum: {
            label: '팩스번호',
            rules: {
                maxlength: 15
            }
        },
        moblphonNo: {
            label: '핸드폰번호',
            rules: {
                maxlength: 15
            }
        },
        emailAdres: {
            label: '이메일주소',
            rules: {
                email: true
            }
        },
        homeadres: {
            label: '주소',
            rules: {
                maxlength: 100
            }
        },
        orgnztId: {
            label: '조직코드',
            rules: {
                required: true
            }
        },
        emplyrSttusCode: {
            label: '사용자상태코드',
            rules: {
                required: true
            }
        },
        groupId: {
            label: '그룹아이디',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 비밀번호 변경
function validatePasswordChgVO(form) {
    const rules = {
        // passwordChgVO form에 대한 validation 규칙이 XML에 정의되지 않았으므로 기본 규칙만 설정
        // 실제 사용 시 필요한 필드들을 추가해야 함
    };
    return EgovValidation.validateForm(form, rules);
}

// 메뉴 관리
function validateMenuManageVO(form) {
    const rules = {
        menuNo: {
            label: '메뉴번호',
            rules: {
                required: true,
                integer: true
            }
        },
        menuOrdr: {
            label: '메뉴순서',
            rules: {
                required: true,
                integer: true
            }
        },
        menuNm: {
            label: '메뉴명',
            rules: {
                required: true,
                maxlength: 50
            }
        },
        upperMenuId: {
            label: '메뉴상위번호',
            rules: {
                required: true,
                integer: true
            }
        },
        progrmFileNm: {
            label: '프로그램파일명',
            rules: {
                required: true,
                maxlength: 50
            }
        },
        menuDc: {
            label: '메뉴설명',
            rules: {
                maxlength: 100
            }
        },
        relateImagePath: {
            label: '관련이미지경로',
            rules: {
                maxlength: 100
            }
        },
        relateImageNm: {
            label: '관련이미지명',
            rules: {
                maxlength: 50
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 로그인 정책 관리
function validateLoginPolicy(form) {
    const rules = {
        ipInfo: {
            label: 'IP정보',
            rules: {
                required: true,
                maxlength: 23
            }
        },
        lmttAt: {
            label: 'IP제한여부',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 롤 관리
function validateRoleManageVO(form) {
    const rules = {
        roleNm: {
            label: '롤명',
            rules: {
                required: true
            }
        },
        rolePtn: {
            label: '롤패턴',
            rules: {
                required: true
            }
        },
        roleSort: {
            label: '롤Sort',
            rules: {
                required: true,
                integer: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 권한 관리
function validateAuthorManage(form) {
    const rules = {
        authorCode: {
            label: '권한코드',
            rules: {
                required: true
            }
        },
        authorNm: {
            label: '권한명',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 그룹 관리
function validateGroupManage(form) {
    const rules = {
        groupNm: {
            label: '그룹명',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 공통 코드
function validateCmmnCode(form) {
    const rules = {
        codeId: {
            label: '코드ID',
            rules: {
                required: true,
                maxlength: 6
            }
        },
        codeIdNm: {
            label: '코드ID명',
            rules: {
                required: true,
                maxlength: 60
            }
        },
        codeIdDc: {
            label: '코드ID설명',
            rules: {
                required: true,
                maxlength: 200
            }
        },
        clCode: {
            label: '분류코드',
            rules: {
                required: true,
                maxlength: 3
            }
        },
        useAt: {
            label: '사용여부',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 공통 코드 상세
function validateCmmnDetailCode(form) {
    const rules = {
        codeId: {
            label: '코드ID',
            rules: {
                required: true,
                maxlength: 6
            }
        },
        code: {
            label: '코드',
            rules: {
                required: true,
                maxlength: 15
            }
        },
        codeNm: {
            label: '코드명',
            rules: {
                required: true,
                maxlength: 60
            }
        },
        codeDc: {
            label: '코드설명',
            rules: {
                required: true,
                maxlength: 200
            }
        },
        useAt: {
            label: '사용여부',
            rules: {
                required: true
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 공통 코드 분류
function validateCmmnClCode(form) {
    const rules = {
		clCode: {
			label: '분류코드',
			rules: {
				required: true,
				maxlength: 3
			}
		},
		clCodeNm: {
			lebel: '분류코드명',
			rules: {
				required: true,
				maxlength: 60
			}
		},
		clCodeDc: {
			lebel: '분류코드설명',
			rules: {
				required: true,
				maxlength: 200
			}
		},
		useAt: {
			lebel: '사용여부',
			rules: {
				required: true
			}
		}
    };
    return EgovValidation.validateForm(form, rules);
}

// 우편번호 관리
function validateZip(form) {
    const rules = {
        zip: {
            label: '우편번호',
            rules: {
                required: true,
                maxlength: 6
            }
        },
        ctprvnNm: {
            label: '시도명',
            rules: {
                required: true,
                maxlength: 20
            }
        },
        signguNm: {
            label: '시군구명',
            rules: {
                required: true,
                maxlength: 20
            }
        },
        emdNm: {
            label: '읍면동명',
            rules: {
                required: true,
                maxlength: 30
            }
        },
        liBuldNm: {
            label: '리건물명',
            rules: {
                maxlength: 60
            }
        },
        lnbrDongHo: {
            label: '번지동호',
            rules: {
                maxlength: 20
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}

// 프로그램 관리
function validateProgrmManageVO(form) {
    const rules = {
        progrmFileNm: {
            label: '프로그램파일명',
            rules: {
                required: true,
                maxlength: 50
            }
        },
        progrmStrePath: {
            label: '프로그램저장경로',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        progrmKoreanNm: {
            label: '프로그램한글명',
            rules: {
                required: true,
                maxlength: 50
            }
        },
        URL: {
            label: 'URL',
            rules: {
                required: true,
                maxlength: 100
            }
        },
        progrmDc: {
            label: '프로그램설명',
            rules: {
                maxlength: 100
            }
        }
    };
    return EgovValidation.validateForm(form, rules);
}
