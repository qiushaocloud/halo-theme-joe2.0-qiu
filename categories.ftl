<!DOCTYPE html>
<html lang="zh-CN">
  <#import "template/common/header.ftl" as headInfo>
  <@headInfo.head title="文章分类" type="categorys"/>
  <#import "template/macro/tail.ftl" as tailInfo>
  <body>
    <div id="Joe">
      <#include "template/common/navbar.ftl">
      <div class="joe_container joe_main_container page-categories${(settings.aside_position=='left')?then(' revert','')}">
        <div class="joe_main">
          <div class="joe_index">
            <div class="joe_index__title">
              <ul class="joe_index__title-title pl-15">
                <li class="item active">${settings.categories_title!}<@categoryTag method="count"><span class="totals">${count!0}</span></@categoryTag></li>
              </ul>
            </div>
            <div class="joe_index__hot categories">
              <@categoryTag method="list">
                <#if categories?size gt 0>
                  <#assign random_img_ok=settings.enable_random_img_api==true && settings.random_img_api!=''>
                  <ul class="joe_index__hot-list animated fadeIn">
                    <#list categories?sort_by(settings.categories_sort)?reverse as category>
                      <li class="item category-slug-${category.slug!}">
                        <a class="link" href="${category.fullPath!}" title="${category.name!}">
                          <figure class="inner">
                            <#if settings.enable_categories_post_num!true><span class="post-nums">${category.postCount!}篇</span></#if>
                            <#assign thumbnail=(category.thumbnail?? && category.thumbnail!='')?then(category.thumbnail,(random_img_ok==true)?then(settings.random_img_api + ((settings.random_img_api?index_of('?')!=-1)?then('&','?')) + '_r=' + category.id,'https://picsum.photos/id/2${category_index}/175/90')) >
                            <img width="100%" height="120" class="image lazyload" data-src="${thumbnail}" src="${LAZY_IMG}" onerror="this.src='${settings.fallback_thumbnail!}'" alt="${category.name!}">
                            <figcaption class="title">${category.name!}</figcaption>
                          </figure>
                        </a>
                      </li>
                    </#list>
                  </ul>
                <#else>
                  <#include "template/macro/empty.ftl">
                  <@empty type="categories" text="未找到相关文章..."/>
                </#if>
              </@categoryTag>
            </div>
          </div>
        </div>
        <#if settings.enable_categories_aside!true>
          <#include "template/common/aside.ftl">
        </#if>
      </div>
      <#include "template/common/actions.ftl">
      <#include "template/common/footer.ftl">
    </div>
    <@tailInfo.tail type="categories"/> 
  </body>
</html>