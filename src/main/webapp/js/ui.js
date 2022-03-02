$(function() {

    // init
    $('.popup').length && popup.init();


    // Form

        // Checkbox
        $('.f_chk').on('keyup', function(e) {
            e.preventDefault();
            if (window.event.keyCode == 13) {
                $(this).toggleClass('on');
                if ( $(this).find('input').prop('checked') ) {
                    $(this).find('input').prop('checked', false);
                } else {
                    $(this).find('input').prop('checked', true);
                }
            }
        });
        $('.f_chk input').on('click', function(e) {
            e.preventDefault();
            $(this).parent().toggleClass('on');
        });

        var chkOnly = {
            init: function() {
                this.$tartet = $('.f_chk_only');
                this.addEvent();
            },
            addEvent: function() {
                this.$tartet.on('click', function() {
                    if ($(this).hasClass('on')) {
                        $(this).removeClass('on');
                        $(this).find('input').prop('checked', false);
                    } else {
                        $(this).addClass('on');
                        $(this).find('input').prop('checked', true);
                    }
                });
            }
        }
        $('.f_chk_only').length && chkOnly.init();

        var chkAll = {
            init: function() {
                this.$tartet = $('.chkAll');
                this.addEvent();
            },
            addEvent: function() {
                this.$tartet.on('click', function() {
                    var idx = $(this).parents('tr').find('th').index($(this).parent('th'));

                    if ($(this).hasClass('on')) {
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only').addClass('on');
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only input').prop('checked', true);
                    } else {
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only').removeClass('on');
                        $(this).parents('table').find('tbody tr').find('td:eq('+idx+') .f_chk_only input').prop('checked', false);
                    }
                });
            },
        }
        $('.chkAll').length && chkAll.init();

        // Radio
        $('.f_rdo').on('keyup', function(e) {
            e.preventDefault();
            if (window.event.keyCode == 13) {
                if ($(this).parents('.rdoSet') < 1) {
                    $(this).toggleClass('on');
                    if ( $(this).find('input').prop('checked') ) {
                        $(this).find('input').prop('checked', false);
                    } else {
                        $(this).find('input').prop('checked', true);
                    }
                } else {
                    $(this).parents('.rdoSet').find('.f_rdo').removeClass('on');
                    $(this).parents('.rdoSet').find('.f_rdo').prop('checked', false);
                    $(this).addClass('on');
                    $(this).find('input').prop('checked', true);
                }
            }
        });
        $('.f_rdo input').on('click', function(e) {
            e.preventDefault();
            if ($(this).parents('.rdoSet') < 1) {
                $(this).parent().toggleClass('on');
            } else {
                $(this).parents('.rdoSet').find('.f_rdo').removeClass('on');
                $(this).parent().addClass('on');
            }
        });

    

    // All menu
    var allMenu = {
        init: function() {
            this.$tartet = $('.all_menu');
            this.$btn = $('.util_menu .allmenu');
            
            this.addEvent();
        },
        addEvent: function() {
            var _this = this.$tartet;
            this.$btn.on('click', function(e) {
                e.preventDefault();
                if (_this.is(':visible')) {
                    _this.fadeOut(100);
                    $(this).removeClass('on');
                } else {
                    _this.fadeIn(100);
                    $(this).addClass('on');
                }
            });
        }
    }
    $('.all_menu').length && allMenu.init();



    // 
    var tempIntro = {
        init: function() {
            this.$tartet = $('.POP_TEMPLATE_INTRO');
            this.$btn = $('.header .go');
            this.addEvent();
        },
        addEvent: function(e) {
            var _this = this.$tartet;
            this.$btn.on('click', function(e) {
                e.preventDefault();
                _this.show();
            });
        }
    }
    tempIntro.init();


    $('.tree-ui').length && tree.init();
    
});


// Popup
var popup = {
    init: function() {
        this.$tartet = $('.popup');
        this.$popClose = this.$tartet.find('.pop_header .close');
        this.addEvent();
    },
    open: function(obj) {
        $('.' + obj).show();
        $('body').css('overflow', 'hidden');
    },
    addEvent: function() {
        this.$popClose.on('click', function() {
            $(this).parents('.popup').hide();
            $('body').css('overflow', 'visible');
        });
    }
}



// 메뉴생성
var tree = {
    init: function() {
        this.$tartet = $('.tree-ui');
        this.$allChk = this.$tartet.find('.all-chk');
        this.$combo = this.$tartet.find('.list .f_chk_only');
        this.addEvent();
    },
    addEvent: function() {
        this.$allChk.on('click', function() {
            if ($(this).find('input').prop('checked')) {
                $(this).parents('.tree-ui').find('.list .f_chk_only').addClass('on');
                $(this).parents('.tree-ui').find('.list .f_chk_only input').prop('checked', true);
            } else {
                $(this).parents('.tree-ui').find('.list .f_chk_only').removeClass('on');
                $(this).parents('.tree-ui').find('.list .f_chk_only input').prop('checked', false);
            }
        });
        this.$combo.on('click', function() {

        });
    }
}
