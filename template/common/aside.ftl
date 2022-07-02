<#if settings.enable_aside>
  <aside class="joe_aside${(settings.aside_position=='left')?then(' pos_left','')}">
    <#if settings.show_blogger!true>
      <#include "../module/blogger.ftl">
    </#if>
    <#if settings.enable_notice && settings.site_notice??>
      <section class="joe_aside__item notice">
        <div class="joe_aside__item-title">
          <#--  <i class="joe-font joe-icon-speaker"></i>  -->
          <#include "../module/speaker.ftl">
          <span class="text">公告信息</span>
        </div>
        <div class="joe_aside__item-contain">
          <div class="notice_content">${settings.site_notice!}</div>
        </div>
      </section>
    </#if>
    <#if settings.enable_qrcode && settings.qrcode_url?? && settings.qrcode_url!=''>
      <section class="joe_aside__item qrcode">
        <div class="joe_aside__item-title">
          <i class="joe-font joe-icon-qrcode"></i>
          <span class="text">${settings.qrcode_title!'我的二维码'}</span>
        </div>
        <div class="joe_aside__item-contain">
          <img class="qrcode_img lazyload" src="${LAZY_IMG}" data-src="${settings.qrcode_url!}" alt="二维码"/>
          <#if settings.qrcode_description??>
            <p class="qrcode_description">${settings.qrcode_description!}</p>
          </#if>
        </div>
      </section>
    </#if>
    <#if settings.enable_music_player && settings.music_id?? && settings.music_id!=''>
      <section class="joe_aside__item timelife">
        <div class="joe_aside__item-title">
          <i class="joe-font joe-icon-yinfu"></i>
          <span class="text">我的歌单</span>
        </div>
        <div id="aplayer" class="aplayer" data-id="${settings.music_id}" list-max-height="20px" data-server="netease" data-type="playlist" data-fixed="false" data-listfolded="true" data-order="random"  data-mode="#f3f3f7"></div>
      </section>
    </#if>
    <#if settings.enable_newest_post!true>
      <#import "../macro/latest.ftl" as np>
      <@np.newest/>
    </#if>
    <#if settings.enable_lifetime!true>
      <section class="joe_aside__item timelife">
        <div class="joe_aside__item-title">
          <i class="joe-font joe-icon-shalou"></i>
          <span class="text">人生倒计时</span>
        </div>
        <div class="joe_aside__item-contain"></div>
      </section>
    </#if>
    <#if settings.enable_clean_mode!=true && settings.show_newreply==true>
      <section class="joe_aside__item newreply">
        <div class="joe_aside__item-title">
          <i class="joe-font joe-icon-message"></i>
          <span class="text">最新回复</span>
        </div>
        <@commentTag method="latest" top='${settings.newreply_page_size!5}'>
          <#if comments.content?size gt 0>
            <ul class="joe_aside__item-contain">
              <#list comments.content as comment>
                <li class="item">
                  <div class="user">
                    <div class="info">
                      <img
                        id='asideCommentReplyAvatar-${comment.id}'
                        class="avatar lazyload"
                        src="${settings.lazyload_avatar}"
                        data-src="${options.gravatar_source!}/${comment.gravatarMd5!}?s=256&d=${options.comment_gravatar_default!"mm"}"
                        alt="用户头像"
                        onerror="this.src='${settings.comment_avatar_error}'"
                      />
                      <div class="author">${comment.author!}</div>
                      <span class="date">${comment.createTime?string("yyyy-MM-dd")}</span>
                    </div>
                  </div>
                  <div class="reply">
                    <a id='asideCommentReplyContent-${comment.id}' class="link aside-reply-content" href="${comment.post.fullPath}">${comment.content!}</a>
                    <script>
                        (function(){
                          var asideCommentReplyContentEle = document.getElementById('asideCommentReplyContent-${comment.id}');
                          var asideCommentReplyAvatarEle = document.getElementById('asideCommentReplyAvatar-${comment.id}');
                          if (!asideCommentReplyContentEle)
                            return;

                          var commentContent = asideCommentReplyContentEle.innerText;
						              var contentArr = commentContent.split('<i style="display: none;" class="qiushaocloud_comment_extra_json">');
                          var commentAvatar = '';
                          if (contentArr && contentArr.length >= 2) {
                            commentContent = contentArr[0];
                            var extraJsonStr = contentArr[1];
                            if (extraJsonStr) {
                              try{
                                var extraData = JSON.parse(window.decodeURIComponent(extraJsonStr.substring(0, extraJsonStr.lastIndexOf('</i>'))));
                                commentAvatar = extraData.avatar;
                              }catch(err){
                                console.error('JSON.parse catch err:', err, contentArr);
                              }
                            }
                          }
                          asideCommentReplyContentEle.innerHTML = commentContent;
                          if (commentAvatar && asideCommentReplyAvatarEle) {
                            asideCommentReplyAvatarEle.src = commentAvatar;
                          }
                        })();
                      </script>
                  </div>
                </li>
              </#list>
            </ul>
          <#else>
            <#include "../macro/empty.ftl">
            <@empty type="aside" showImg="false"/>
          </#if>
        </@commentTag>
      </section>
    </#if>
    <#if settings.enable_tag_cloud!true>
      <section class="joe_aside__item tags-cloud">
        <div class="joe_aside__item-title">
          <i class="joe-font joe-icon-tag"></i>
          <span class="text">标签云</span>
        </div>
        <div class="joe_aside__item-contain">
          <@tagTag method="list">
            <#if tags?size gt 0>
              <div class="tags-cloud-list"${(settings.tag_cloud_type=='3d')?then(' style="display:none;"','')}>
                <#list tags as tag>
                  <#if tag_index lt settings.tag_cloud_max?default(18)?number>
                    <a data-url="${tag.fullPath!}" data-label="${tag.name!}" href="${tag.fullPath!}" title="${tag.name!}">${tag.name!}</a>
                  </#if>
                </#list>
              </div>
              <#if settings.tag_cloud_type=='3d'>
                <div id="tags-3d">
                  <div class="empty">加载中…</div>
                </div>
              </#if>
            <#else>
              <div class="empty">暂无标签</div>
            </#if>   
            <#if tags?size gt settings.tag_cloud_max?default(18)?number>
              <a class="tags_more" href="${blog_url!}/tags">更多<i class="joe-font joe-icon-more-right"></i></a>
            </#if>
          </@tagTag>
        </div>
      </section>
    </#if>
    <#if settings.enable_clean_mode!=true && settings.enable_aside_ads==true>
      <#include "../ads/ads_aside.ftl">
    </#if>
  </aside>
</#if>