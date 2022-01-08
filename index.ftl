<!DOCTYPE html>
<html lang="zh-CN">
  <#import "template/common/header.ftl" as headInfo>
  <@headInfo.head title="首页" type="index"/>
  <#import "template/macro/tail.ftl" as tailInfo>
  <body>
    <div id="Joe">
      <#include "template/common/navbar.ftl">
      <div class="joe_container joe_main_container page-index${(settings.aside_position=='left')?then(' revert','')}">
        <div class="joe_main">
          <div class="joe_index">
            <#if settings.enable_banner!true>
              <#import "template/macro/banner.ftl" as h_banner>
              <@h_banner.banner />
            </#if>
            <#if settings.enable_hot_category!true>
              <#import "template/macro/hot_category.ftl" as hp>
              <@hp.hot_category />
            </#if>
            <#import "template/macro/article.ftl" as h_article>
            <@h_article.article posts=posts />
          </div>
          <#if settings.enable_index_list_ajax==false>
            <@paginationTag method="index" page="${posts.number}" total="${posts.totalPages}" display="3">
              <#if (posts.totalPages == 0)>
                <#include "template/macro/empty.ftl">
                <@empty type="index" text="${settings.home_empty_text!'暂无文章数据'}" isAsync="true"/>
              <#elseif (posts.totalPages == 1)>
              <#else>
                <ul class="joe_pagination">
                  <#if pagination.hasPrev>
                    <li class="prev">
                      <a href="${pagination.prevPageFullPath!}">
                        <i class="joe-font joe-icon-prev"></i>
                      </a>
                    </li>
                  </#if>
                  <#list pagination.rainbowPages as number>
                    <#if number.isCurrent>
                      <li class="active">
                        <a href="${number.fullPath!}">${number.page!}</a>
                      </li>
                    <#else>
                      <li>
                        <a href="${number.fullPath!}">${number.page!}</a>
                      </li>
                    </#if>
                  </#list>
                  <#if pagination.hasNext && (pagination.rainbowPages?size gt 0)>
                    <li class="next">
                      <a href="${pagination.nextPageFullPath!}">
                        <i class="joe-font joe-icon-next"></i>
                      </a>
                    </li>
                  </#if>
                </ul>
              </#if>    
            </@paginationTag>
          <#else>
            <div class="joe_load" loading="true">加载中...</div>
          </#if>
        </div>
        <#include "template/common/aside.ftl">
      </div>
      <#include "template/common/actions.ftl">
      <#include "template/common/footer.ftl">
    </div>
    <@tailInfo.tail type="index"/> 
  </body>
</html>