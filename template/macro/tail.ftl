<#macro tail type>
  <#-- ===== 引入脚本 start ===== -->
  <#if (type == 'index' && settings.enable_index_list_effect == true) || ( type == 'journals' && settings.enable_journal_effect == true) || ( type == 'photos' && settings.enable_photos_effect == true)>
    <script src="${BASE_RES_URL!}/source/lib/wowjs/wow.min.js"></script>
  </#if>
  <script src="${BASE_RES_URL!}/source/lib/lazysizes/lazysizes.min.js"></script>
  <script src="${BASE_RES_URL!}/source/lib/qmsg/qmsg.js"></script>
  <#if settings.show_newreply == true || type == 'sheet'>
    <script src="${BASE_RES_URL}/source/lib/j-marked/marked.min.js"></script>
  </#if>
  <script src="${BASE_RES_URL}/source/js/min/joe.utils.min.js?v=${theme.version!}"></script>
  <#if type == 'index' && settings.enable_banner == true>
    <script src="${BASE_RES_URL!}/source/lib/swiper/swiper.min.js"></script>
  </#if>
  <#if type == 'post' || type == 'journals' || type == 'sheet'>
    <script src="${BASE_RES_URL!}/source/lib/prism/prism.min.js"></script>
  </#if>
  <#if type == 'post' && settings.enable_toc == true>
    <script src="${BASE_RES_URL!}/source/lib/tocbot/tocbot.min.js"></script>
  </#if>
  <#if settings.enable_clean_mode != true && ( type == 'post' || type == 'journals' || type == 'sheet')>
    <script src="${BASE_RES_URL!}/source/lib/vue@2.6.10/vue.min.js"></script>
    <#--  <script src="${BASE_RES_URL!}/source/lib/halo-comment/halo-comment.min.js?v=${theme.version!}"></script>  -->
    <script src="${theme_base!}/source/lib/halo-comment/halo-comment.min.js?v=${theme.version!}"></script>
    <#--  <script src="https://gcore.jsdelivr.net/gh/qiushaocloud/halo-comment-joe2.0-qiu@master/dist/halo-comment.min.js?v=${theme.version!}"></script>  -->
  </#if>
  <script src="${BASE_RES_URL!}/source/lib/fancybox/jquery.fancybox.min.js"></script>
  <#if settings.enable_aside == true && settings.enable_music_player == true && settings.music_id?? && settings.music_id?trim!= ''>
    <link rel="stylesheet" href="${BASE_RES_URL}/source/lib/APlayer/APlayer.min.css"> 
    <script src="${BASE_RES_URL}/source/lib/APlayer/APlayer.min.js"></script>
    <script src="${BASE_RES_URL}/source/lib/meting/meting.min.js"></script>
  </#if>
  <script src="${BASE_RES_URL!}/source/lib/smooth-scroll/smooth-scroll.min.js"></script>
  <script src="${BASE_RES_URL}/source/js/min/joe.custom.min.js?v=${theme.version!}"></script>
  <#if type == 'post' || type == 'journals' || type == 'sheet'>
    <script src="${BASE_RES_URL}/source/lib/clipboard/clipboard.min.js"></script>
  </#if>
  <#assign enable_mathjax = (metas?? && metas.enable_mathjax?? && metas.enable_mathjax?trim!='')?then(metas.enable_mathjax?trim,settings.enable_mermaid?then('true','false'))>
  <#if enable_mathjax == 'true' && (type == 'post' || type == 'journals' || type == 'sheet')>
    <link rel="stylesheet" href="${BASE_RES_URL}/source/lib/katex@0.13.18/katex.min.css">
    <script src="${BASE_RES_URL}/source/lib/katex@0.13.18/katex.min.js"></script>
    <script src="${BASE_RES_URL}/source/lib/katex@0.13.18/contrib/auto-render.min.js"></script>
  </#if>
  <#assign enable_mermaid = (metas?? && metas.enable_mermaid?? && metas.enable_mermaid?trim!='')?then(metas.enable_mermaid?trim,settings.enable_mermaid?then('true','false'))>
  <#if enable_mermaid == 'true' && (type == 'post' || type == 'journals' || type == 'sheet')>
    <script src="${BASE_RES_URL}/source/lib/mermaid@8.4.4/mermaid.min.js"></script>
  </#if>
  <#if settings.favicon?? && settings.favicon?trim!=''>
    <script src="${BASE_RES_URL}/source/lib/favico/favico.min.js"></script>
  </#if>
  <#if type == 'post'>
    <script src="${BASE_RES_URL}/source/lib/jquery-qrcode/jquery.qrcode.min.js"></script>
  </#if>
  <#--  相册  -->
  <#if type == 'photos'>
    <script src="${BASE_RES_URL}/source/lib/justifiedGallery/justifiedGallery.min.js"></script>
    <#--  <script src="https://unpkg.com/masonry-layout@4/dist/masonry.min.js"></script>  -->
    <#--  <script src="https://unpkg.com/imagesloaded@4/imagesloaded.min.js"></script>  -->
  </#if>

  <#-- ===== 引入页面级js start ===== -->
  <#--  <script src="${BASE_RES_URL}/source/js/min/joe.common.min.js?v=${theme.version!}"></script>  -->
  <script src="${theme_base!}/source/js/min/joe.common.min.js?v=${theme.version!}"></script>

  <#if type == 'index'>
    <script src="${BASE_RES_URL}/source/js/min/joe.index.min.js?v=${theme.version!}"></script>
  </#if>
  <#if type == 'archives'>
    <script src="${BASE_RES_URL}/source/js/min/joe.archives.min.js?v=${theme.version!}"></script>
  </#if>
  <#if type == 'post'>
    <script src="${BASE_RES_URL}/source/js/min/joe.post.min.js?v=${theme.version!}"></script>
  </#if>
  <#if type == 'journals'>
    <script src="${BASE_RES_URL}/source/js/min/joe.journals.min.js?v=${theme.version!}"></script>
  </#if>
  <#if type == 'photos'>
    <script src="${BASE_RES_URL}/source/js/min/joe.photos.min.js?v=${theme.version!}"></script>
  </#if>
  <#if type == 'sheet'>
    <script src="${BASE_RES_URL}/source/lib/draggabilly/draggabilly.min.js"></script>
    <#--  <script src="${BASE_RES_URL}/source/js/min/joe.leaving.min.js?v=${theme.version!}"></script>  -->
    <script src="${theme_base}/source/js/min/joe.leaving.min.js?v=${theme.version!}"></script>
  </#if>
  <#--  <#if settings.enable_pjax!false>
    <script src="${BASE_RES_URL}/source/lib/jquery-pjax/jquery.pjax.min.js"></script>
    <script src="${BASE_RES_URL}/source/js/min/pjax.min.js?v=${theme.version!}"></script>
  </#if>   -->
  <#-- ===== 引入页面级js end ===== -->

  <#-- ===== 引入脚本 start ===== -->
  <#if settings.enable_global_music_player!false>
    <#--  <!-- 音乐播放器 -->
    <div id="global-aplayer"></div>
  </#if>
  <#if settings.enable_live2d>
    <!-- live2d -->
    <#include "../../plugins/live2d/ftl/live2d.ftl">
    <@live2d />
  </#if>
  <#-- ===== 引入脚本 end ===== -->

  <#if settings.custom_external_js_body??>
    <!-- 自定义外部js -->
    <script src="${settings.custom_external_js_body!}"></script>
  </#if>
  <#if settings.custom_js_body??>
    <!-- 自定义js -->
    <script type="text/javascript">${settings.custom_js_body!}</script>
  </#if>
</#macro>