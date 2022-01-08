<!DOCTYPE html>
<html lang="zh-CN">
  <#import "template/common/header.ftl" as headInfo>
  <@headInfo.head title="所有标签" type="tags"/>
  <#import "template/macro/tail.ftl" as tailInfo>
  <body>
    <div id="Joe">
      <#include "template/common/navbar.ftl">
      <div class="joe_container joe_main_container page-tags${(settings.aside_position=='left')?then(' revert','')}">
        <div class="joe_main">
          <div class="joe_index">
            <div class="joe_index__title">
              <ul class="joe_index__title-title pl-15">
                <li class="item active">${settings.tags_title!}<@tagTag method="count"><span class="totals">${count!0}</span></@tagTag></li>
              </ul>
            </div>
            <div class="joe_index__hot">
              <#assign random_img_ok=settings.enable_random_img_api==true && settings.random_img_api?trim!=''>
              <ul class="joe_index__hot-list animated fadeIn" style="padding-bottom: 10px;">
                <@tagTag method="list">
                  <#list tags?sort_by(settings.tags_sort)?reverse as tag>
                    <li class="item">
                      <a class="link" href="${tag.fullPath!}" title="${tag.name!}">
                        <figure class="inner">
                          <#if settings.enable_tags_post_num!true><span class="post-nums">${tag.postCount!}篇</span></#if>
                          <#assign thumbnail=(tag.thumbnail?? && tag.thumbnail!='')?then(tag.thumbnail,(random_img_ok==true)?then(settings.random_img_api + ((settings.random_img_api?index_of('?')!=-1)?then('&','?')) + '_r=' + tag.id,'https://picsum.photos/id/1${tag_index}/175/90')) >
                          <img width="100%" height="120" class="image lazyload" data-src="${thumbnail}" src="${LAZY_IMG}" onerror="this.src='${settings.fallback_thumbnail!}'" alt="${tag.name!}">
                          <figcaption class="title">${tag.name!}</figcaption>
                        </figure>
                      </a>
                    </li>
                  </#list>
                </@tagTag>
              </ul>
            </div>
          </div>
        </div>
        <#if settings.enable_tags_aside!true>
          <#include "template/common/aside.ftl">
        </#if>
      </div>
      <#include "template/common/actions.ftl">
      <#include "template/common/footer.ftl">
    </div>
    <@tailInfo.tail type="tags"/> 
  </body>
</html>