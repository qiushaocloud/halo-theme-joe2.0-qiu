var live2d_settings = {
    modelAPI: '//live2d.fghrsh.net/api/',
    tipsMessage: 'takagi-tips.json',
    hitokotoAPI: 'lwl12.com',
    modelId: 1,
    modelTexturesId: 1,
    showToolMenu: true,
    canCloseLive2d: true,
    canSwitchModel: true,
    canSwitchTextures: true,
    canSwitchHitokoto: true,
    canTakeScreenshot: true,
    canTurnToHomePage: true,
    canTurnToAboutPage: true,
    modelStorage: true,
    modelRandMode: 'switch',
    modelTexturesRandMode: 'rand',
    showHitokoto: true,
    showF12Status: true,
    showF12Message: false,
    showF12OpenMsg: true,
    showCopyMessage: true,
    showWelcomeMessage: true,
    takagiSize: '280x250',
    takagiTipsSize: '250x70',
    takagiFontSize: '12px',
    takagiToolFont: '14px',
    takagiToolLine: '20px',
    takagiToolTop: '0px',
    takagiMinWidth: '768px',
    takagiEdgeSide: 'left:0',
    takagiDraggable: 'disable',
    takagiDraggableRevert: true,
    l2dVersion: '1.0.0',
    l2dVerDate: '2020.07.01',
    homePageUrl: 'auto',
    aboutPageUrl: 'https://lixingyong.com/s/halo-live2d',
    screenshotCaptureName: 'live2d.png'
}

String.prototype.render = function(context) {
    var tokenReg = /(\\)?\{([^\{\}\\]+)(\\)?\}/g;

    return this.replace(tokenReg, function (word, slash1, token, slash2) {
        if (slash1 || slash2) { return word.replace('\\', ''); }
        
        var variables = token.replace(/\s/g, '').split('.');
        var currentObject = context;
        var i, length, variable;
        
        for (i = 0, length = variables.length; i < length; ++i) {
            variable = variables[i];
            currentObject = currentObject[variable];
            if (currentObject === undefined || currentObject === null) return '';
        }
        return currentObject;
    });
};

var re = /x/;
function empty(obj) {return typeof obj=="undefined"||obj==null||obj==""?true:false}
function getRandText(text) {return Array.isArray(text) ? text[Math.floor(Math.random() * text.length + 1)-1] : text}

function showMessage(text, timeout, flag) {
    if(flag || sessionStorage.getItem('takagi-text') === '' || sessionStorage.getItem('takagi-text') === null){
        if(Array.isArray(text)) text = text[Math.floor(Math.random() * text.length + 1)-1];
        if (live2d_settings.showF12Message) console.log('[Message]', text.replace(/<[^<>]+>/g,''));
        
        if(flag) sessionStorage.setItem('takagi-text', text);
        
        $('.takagi-tips').stop();
        $('.takagi-tips').html(text).fadeTo(200, 1);
        if (timeout === undefined) timeout = 5000;
        hideMessage(timeout);
    }
}

function hideMessage(timeout) {
    $('.takagi-tips').stop().css('opacity',1);
    if (timeout === undefined) timeout = 5000;
    window.setTimeout(function() {sessionStorage.removeItem('takagi-text')}, timeout);
    $('.takagi-tips').delay(timeout).fadeTo(200, 0);
}

function initModel(takagiPath, options) {
    if(typeof(options) == 'object') {
        for(var key in options) {
            if(!!$.trim(options[key])) {
                live2d_settings[key] = options[key];
            }
        }
    }
    /* console welcome message */
    if(live2d_settings.showF12OpenMsg)
        eval(function(p,a,c,k,e,r){e=function(c){return(c<a?'':e(parseInt(c/a)))+((c=c%a)>35?String.fromCharCode(c+29):c.toString(36))};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('8.d(" ");8.d("\\U,.\\y\\5.\\1\\1\\1\\1/\\1,\\u\\2 \\H\\n\\1\\1\\1\\1\\1\\b \', !-\\r\\j-i\\1/\\1/\\g\\n\\1\\1\\1 \\1 \\a\\4\\f\'\\1\\1\\1 L/\\a\\4\\5\\2\\n\\1\\1 \\1 /\\1 \\a,\\1 /|\\1 ,\\1 ,\\1\\1\\1 \',\\n\\1\\1\\1\\q \\1/ /-\\j/\\1\\h\\E \\9 \\5!\\1 i\\n\\1\\1\\1 \\3 \\6 7\\q\\4\\c\\1 \\3\'\\s-\\c\\2!\\t|\\1 |\\n\\1\\1\\1\\1 !,/7 \'0\'\\1\\1 \\X\\w| \\1 |\\1\\1\\1\\n\\1\\1\\1\\1 |.\\x\\"\\1\\l\\1\\1 ,,,, / |./ \\1 |\\n\\1\\1\\1\\1 \\3\'| i\\z.\\2,,A\\l,.\\B / \\1.i \\1|\\n\\1\\1\\1\\1\\1 \\3\'| | / C\\D/\\3\'\\5,\\1\\9.\\1|\\n\\1\\1\\1\\1\\1\\1 | |/i \\m|/\\1 i\\1,.\\6 |\\F\\1|\\n\\1\\1\\1\\1\\1\\1.|/ /\\1\\h\\G \\1 \\6!\\1\\1\\b\\1|\\n\\1\\1\\1 \\1 \\1 k\\5>\\2\\9 \\1 o,.\\6\\2 \\1 /\\2!\\n\\1\\1\\1\\1\\1\\1 !\'\\m//\\4\\I\\g\', \\b \\4\'7\'\\J\'\\n\\1\\1\\1\\1\\1\\1 \\3\'\\K|M,p,\\O\\3|\\P\\n\\1\\1\\1\\1\\1 \\1\\1\\1\\c-,/\\1|p./\\n\\1\\1\\1\\1\\1 \\1\\1\\1\'\\f\'\\1\\1!o,.:\\Q \\R\\S\\T v"+e.V+" / W "+e.N);8.d(" ");',60,60,'|u3000|uff64|uff9a|uff40|u30fd|uff8d||console|uff8a|uff0f|uff3c|uff84|log|live2d_settings|uff70|u00b4|uff49||u2010||u3000_|u3008||_|___|uff72|u2500|uff67|u30cf|u30fc||u30bd|u4ece|u30d8|uff1e|__|u30a4|k_|uff17_|u3000L_|u3000i|uff1a|u3009|uff34|uff70r|u30fdL__||___i|l2dVerDate|u30f3|u30ce|nLive2D|u770b|u677f|u5a18|u304f__|l2dVersion|Takagi|u00b40i'.split('|'),0,{}));
    
    /* 判断 JQuery */
    if (typeof($.ajax) != 'function') typeof(jQuery.ajax) == 'function' ? window.$ = jQuery : console.log('[Error] JQuery is not defined.');
    
    /* 加载看板娘样式 */
    live2d_settings.takagiSize = live2d_settings.takagiSize.split('x');
    live2d_settings.takagiTipsSize = live2d_settings.takagiTipsSize.split('x');
    live2d_settings.takagiEdgeSide = live2d_settings.takagiEdgeSide.split(':');
    
    $("#live2d").attr("width",live2d_settings.takagiSize[0]);
    $("#live2d").attr("height",live2d_settings.takagiSize[1]);
    $(".takagi-tips").width(live2d_settings.takagiTipsSize[0]);
    $(".takagi-tips").height(live2d_settings.takagiTipsSize[1]);
    $(".takagi-tips").css("top",live2d_settings.takagiToolTop);
    $(".takagi-tips").css("font-size",live2d_settings.takagiFontSize);
    $(".takagi-tool").css("font-size",live2d_settings.takagiToolFont);
    $(".takagi-tool span").css("line-height",live2d_settings.takagiToolLine);
    
    if (live2d_settings.takagiEdgeSide[0] == 'left') $(".takagi").css("left",live2d_settings.takagiEdgeSide[1]+'px');
    else if (live2d_settings.takagiEdgeSide[0] == 'right') $(".takagi").css("right",live2d_settings.takagiEdgeSide[1]+'px');
    
    window.takagiResize = function() { $(window).width() <= Number(live2d_settings.takagiMinWidth.replace('px','')) ? $(".takagi").hide() : $(".takagi").show(); };
    if (live2d_settings.takagiMinWidth != 'disable') { takagiResize(); $(window).resize(function() {takagiResize()}); }
    
    try {
        if (live2d_settings.takagiDraggable == 'axis-x') $(".takagi").draggable({ axis: "x", revert: live2d_settings.takagiDraggableRevert });
        else if (live2d_settings.takagiDraggable == 'unlimited') $(".takagi").draggable({ revert: live2d_settings.takagiDraggableRevert });
        else $(".takagi").css("transition", 'all .3s ease-in-out');
    } catch(err) { console.log('[Error] JQuery UI is not defined.') }
    
    live2d_settings.homePageUrl == 'auto' ? window.location.protocol+'//'+window.location.hostname+'/' : live2d_settings.homePageUrl;
    if (window.location.protocol == 'file:' && live2d_settings.modelAPI.substr(0,2) == '//') live2d_settings.modelAPI = 'http:'+live2d_settings.modelAPI;
    
    $('.takagi-tool .fui-home').click(function (){
        //window.location = 'https://www.fghrsh.net/';
        window.location = live2d_settings.homePageUrl;
    });
    
    $('.takagi-tool .fui-info-circle').click(function (){
        //window.open('https://imjad.cn/archives/lab/add-dynamic-poster-girl-with-live2d-to-your-blog-02');
        window.open(live2d_settings.aboutPageUrl);
    });
    
    if (typeof(takagiPath) == "object") loadTipsMessage(takagiPath); else {
        $.ajax({
            cache: true,
            url: takagiPath == '' ? live2d_settings.tipsMessage : (takagiPath.substr(takagiPath.length-16)=='takagi-tips.json'?takagiPath:takagiPath+'takagi-tips.json'),
            dataType: "json",
            success: function (result){ loadTipsMessage(result); }
        });
    }
    
    if (!live2d_settings.showToolMenu) $('.takagi-tool').hide();
    if (!live2d_settings.canCloseLive2d) $('.takagi-tool .fui-cross').hide();
    if (!live2d_settings.canSwitchModel) $('.takagi-tool .fui-eye').hide();
    if (!live2d_settings.canSwitchTextures) $('.takagi-tool .fui-user').hide();
    if (!live2d_settings.canSwitchHitokoto) $('.takagi-tool .fui-chat').hide();
    if (!live2d_settings.canTakeScreenshot) $('.takagi-tool .fui-photo').hide();
    if (!live2d_settings.canTurnToHomePage) $('.takagi-tool .fui-home').hide();
    if (!live2d_settings.canTurnToAboutPage) $('.takagi-tool .fui-info-circle').hide();

    if (takagiPath === undefined) takagiPath = '';
    var modelId = localStorage.getItem('modelId');
    var modelTexturesId = localStorage.getItem('modelTexturesId');
    
    if (!live2d_settings.modelStorage || modelId == null) {
        var modelId = live2d_settings.modelId;
        var modelTexturesId = live2d_settings.modelTexturesId;
    } loadModel(modelId, modelTexturesId);
}

function loadModel(modelId, modelTexturesId=0) {
    if (live2d_settings.modelStorage) {
        localStorage.setItem('modelId', modelId);
        localStorage.setItem('modelTexturesId', modelTexturesId);
    } else {
        sessionStorage.setItem('modelId', modelId);
        sessionStorage.setItem('modelTexturesId', modelTexturesId);
    } loadlive2d('live2d', live2d_settings.modelAPI+'get/?id='+modelId+'-'+modelTexturesId, (live2d_settings.showF12Status ? console.log('[Status]','live2d','模型',modelId+'-'+modelTexturesId,'加载完成'):null));
}

function loadTipsMessage(result) {
    window.takagi_tips = result;
    
    $.each(result.mouseover, function (index, tips){
        $(document).on("mouseover", tips.selector, function (){
            var text = getRandText(tips.text);
            text = text.render({text: $(this).data("text") || $(this).text()});
            showMessage(text, 3000);
        });
    });
    $.each(result.click, function (index, tips){
        $(document).on("click", tips.selector, function (){
            var text = getRandText(tips.text);
            text = text.render({text: $(this).data("text") || $(this).text()});
            showMessage(text, 3000, true);
        });
    });
    $.each(result.seasons, function (index, tips){
        var now = new Date();
        var after = tips.date.split('-')[0];
        var before = tips.date.split('-')[1] || after;
        
        if((after.split('/')[0] <= now.getMonth()+1 && now.getMonth()+1 <= before.split('/')[0]) && 
           (after.split('/')[1] <= now.getDate() && now.getDate() <= before.split('/')[1])){
            var text = getRandText(tips.text);
            text = text.render({year: now.getFullYear()});
            showMessage(text, 6000, true);
        }
    });
    
    if (live2d_settings.showF12OpenMsg) {
        re.toString = function() {
            showMessage(getRandText(result.takagi.console_open_msg), 5000, true);
            return '';
        };
    }
    
    if (live2d_settings.showCopyMessage) {
        $(document).on('copy', function() {
            showMessage(getRandText(result.takagi.copy_message), 5000, true);
        });
    }
    
    $('.takagi-tool .fui-photo').click(function(){
        showMessage(getRandText(result.takagi.screenshot_message), 5000, true);
        window.Live2D.captureName = live2d_settings.screenshotCaptureName;
        window.Live2D.captureFrame = true;
    });
    
    $('.takagi-tool .fui-cross').click(function(){
        sessionStorage.setItem('takagi-dsiplay', 'none');
        showMessage(getRandText(result.takagi.hidden_message), 1300, true);
        window.setTimeout(function() {$('.takagi').hide();}, 1300);
    });
    
    window.showWelcomeMessage = function(result) {
        var text;
        if (window.location.href == live2d_settings.homePageUrl) {
            var now = (new Date()).getHours();
            if (now > 23 || now <= 5) text = getRandText(result.takagi.hour_tips.t23-5);
            else if (now > 5 && now <= 7) text = getRandText(result.takagi.hour_tips.t5-7);
            else if (now > 7 && now <= 11) text = getRandText(result.takagi.hour_tips.t7-11);
            else if (now > 11 && now <= 14) text = getRandText(result.takagi.hour_tips.t11-14);
            else if (now > 14 && now <= 17) text = getRandText(result.takagi.hour_tips.t14-17);
            else if (now > 17 && now <= 19) text = getRandText(result.takagi.hour_tips.t17-19);
            else if (now > 19 && now <= 21) text = getRandText(result.takagi.hour_tips.t19-21);
            else if (now > 21 && now <= 23) text = getRandText(result.takagi.hour_tips.t21-23);
            else text = getRandText(result.takagi.hour_tips.default);
        } else {
            var referrer_message = result.takagi.referrer_message;
            if (document.referrer !== '') {
                var referrer = document.createElement('a');
                referrer.href = document.referrer;
                var domain = referrer.hostname.split('.')[1];
                if (window.location.hostname == referrer.hostname)
                    text = referrer_message.localhost[0] + document.title.split(referrer_message.localhost[2])[0] + referrer_message.localhost[1];
                else if (domain == 'baidu')
                    text = referrer_message.baidu[0] + referrer.search.split('&wd=')[1].split('&')[0] + referrer_message.baidu[1];
                else if (domain == 'so')
                    text = referrer_message.so[0] + referrer.search.split('&q=')[1].split('&')[0] + referrer_message.so[1];
                else if (domain == 'google')
                    text = referrer_message.google[0] + document.title.split(referrer_message.google[2])[0] + referrer_message.google[1];
                else {
                    $.each(result.takagi.referrer_hostname, function(i,val) {if (i==referrer.hostname) referrer.hostname = getRandText(val)});
                    text = referrer_message.default[0] + referrer.hostname + referrer_message.default[1];
                }
            } else text = referrer_message.none[0] + document.title.split(referrer_message.none[2])[0] + referrer_message.none[1];
        }
        showMessage(text, 6000);
    }; if (live2d_settings.showWelcomeMessage) showWelcomeMessage(result);
    
    var takagi_tips = result.takagi;
    
    function loadOtherModel() {
        var modelId = modelStorageGetItem('modelId');
        var modelRandMode = live2d_settings.modelRandMode;
        
        $.ajax({
            cache: modelRandMode == 'switch' ? true : false,
            url: live2d_settings.modelAPI+modelRandMode+'/?id='+modelId,
            dataType: "json",
            success: function(result) {
                loadModel(result.model['id']);
                var message = result.model['message'];
                $.each(takagi_tips.model_message, function(i,val) {if (i==result.model['id']) message = getRandText(val)});
                showMessage(message, 3000, true);
            }
        });
    }
    
    function loadRandTextures() {
        var modelId = modelStorageGetItem('modelId');
        var modelTexturesId = modelStorageGetItem('modelTexturesId');
        var modelTexturesRandMode = live2d_settings.modelTexturesRandMode;
        
        $.ajax({
            cache: modelTexturesRandMode == 'switch' ? true : false,
            url: live2d_settings.modelAPI+modelTexturesRandMode+'_textures/?id='+modelId+'-'+modelTexturesId,
            dataType: "json",
            success: function(result) {
                if (result.textures['id'] == 1 && (modelTexturesId == 1 || modelTexturesId == 0))
                    showMessage(takagi_tips.load_rand_textures[0], 3000, true);
                else showMessage(takagi_tips.load_rand_textures[1], 3000, true);
                loadModel(modelId, result.textures['id']);
            }
        });
    }
    
    function modelStorageGetItem(key) { return live2d_settings.modelStorage ? localStorage.getItem(key) : sessionStorage.getItem(key); }
    
    /* 检测用户活动状态，并在空闲时显示一言 */
    if (live2d_settings.showHitokoto) {
        window.getActed = false; window.hitokotoTimer = 0; window.hitokotoInterval = false;
        $(document).mousemove(function(e){getActed = true;}).keydown(function(){getActed = true;});
        setInterval(function(){ if (!getActed) ifActed(); else elseActed(); }, 1000);
    }
    
    function ifActed() {
        if (!hitokotoInterval) {
            hitokotoInterval = true;
            hitokotoTimer = window.setInterval(showHitokotoActed, 10000);
        }
    }
    
    function elseActed() {
        getActed = hitokotoInterval = false;
        window.clearInterval(hitokotoTimer);
    }
    
    function showHitokotoActed() {
        if ($(document)[0].visibilityState == 'visible') showHitokoto();
    }
    
    function showHitokoto() {
    	switch(live2d_settings.hitokotoAPI) {
    	    case 'lwl12.com':
    	        $.getJSON('https://api.lwl12.com/hitokoto/v1?encode=realjson',function(result){
        	        if (!empty(result.source)) {
                        var text = takagi_tips.hitokoto_api_message['lwl12.com'][0];
                        if (!empty(result.author)) text += takagi_tips.hitokoto_api_message['lwl12.com'][1];
                        text = text.render({source: result.source, creator: result.author});
                        window.setTimeout(function() {showMessage(text+takagi_tips.hitokoto_api_message['lwl12.com'][2], 3000, true);}, 5000);
                    } showMessage(result.text, 5000, true);
                });break;
    	    case 'fghrsh.net':
    	        $.getJSON('https://api.fghrsh.net/hitokoto/rand/?encode=jsc&uid=3335',function(result){
            	    if (!empty(result.source)) {
                        var text = takagi_tips.hitokoto_api_message['fghrsh.net'][0];
                        text = text.render({source: result.source, date: result.date});
                        window.setTimeout(function() {showMessage(text, 3000, true);}, 5000);
                        showMessage(result.hitokoto, 5000, true);
            	    }
                });break;
            case 'jinrishici.com':
                $.ajax({
                    url: 'https://v2.jinrishici.com/one.json',
                    xhrFields: {withCredentials: true},
                    success: function (result, status) {
                        if (!empty(result.data.origin.title)) {
                            var text = takagi_tips.hitokoto_api_message['jinrishici.com'][0];
                            text = text.render({title: result.data.origin.title, dynasty: result.data.origin.dynasty, author:result.data.origin.author});
                            window.setTimeout(function() {showMessage(text, 3000, true);}, 5000);
                        } showMessage(result.data.content, 5000, true);
                    }
                });break;
    	    default:
    	        $.getJSON('https://v1.hitokoto.cn',function(result){
            	    if (!empty(result.from)) {
                        var text = takagi_tips.hitokoto_api_message['hitokoto.cn'][0];
                        text = text.render({source: result.from, creator: result.creator});
                        window.setTimeout(function() {showMessage(text, 3000, true);}, 5000);
            	    }
                    showMessage(result.hitokoto, 5000, true);
                });
    	}
    }
    
    $('.takagi-tool .fui-eye').click(function (){loadOtherModel()});
    $('.takagi-tool .fui-user').click(function (){loadRandTextures()});
    // $('.takagi-tool .fui-chat').click(function (){showHitokoto()});
}
