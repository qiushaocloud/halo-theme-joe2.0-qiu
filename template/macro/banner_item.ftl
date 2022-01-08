<#macro banner_item post index=0 max=10>
  <#if (index + 1) lte max>
    <div class="swiper-slide">
      <#import "post_thumbnail.ftl" as tbn>
      <@tbn.post_thumbnail post=post />
      <#assign cur_img = tbn.thumbnail>
      <#assign cur_title = post.title?trim!>
      <#assign cur_link = post.fullPath!>
      <a class="item" href="${cur_link}" target="_blank" rel="noopener noreferrer nofollow">
        <img width="100%" height="100%" class="thumbnail lazyload" data-src="${cur_img!}" src="${settings.banner_lazyload_img}" alt="${cur_title!'banner'}">
        <#if settings.enable_banner_title==true && cur_title!=''>
          <div class="title">${cur_title}</div>
        </#if>
        <i class="joe-font joe-icon-zhifeiji"></i>
      </a>
    </div>
  </#if>
</#macro>