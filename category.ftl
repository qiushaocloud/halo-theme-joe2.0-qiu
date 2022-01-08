<!DOCTYPE html>
<html lang="zh-CN">
  <#import "template/common/header.ftl" as headInfo>
  <@headInfo.head title="${category.name!}" type="category"/>
  <#import "template/macro/tail.ftl" as tailInfo>
  <body>
    <div id="Joe" class="category-slug-${category.slug!} category-pathname">
      <#include "template/common/navbar.ftl">
      <div class="joe_container joe_main_container page-category">
        <div class="joe_main">
          <div class="joe_archive">
            <div class="joe_archive__title">
              <div class="joe_archive__title-title">
                <i class="joe-font joe-icon-feather joe_archive__title-icon"></i>以下是
                <span class="muted ellipsis">${category.name!}</span>
                <span>相关的文章</span>
              </div>
            </div>
            <#if posts.content?size gt 0>
              <#include "template/macro/post_item.ftl">
              <ul class="joe_archive__list joe_list animated fadeIn">
                <#list posts.content as post>
                  <@post_item post=post index=post_index type="category"/>
                </#list>
              </ul>
            <#else>
              <#include "template/macro/empty.ftl">
              <@empty type="category" text="未找到相关文章..."/>
            </#if>
          </div>
          <@paginationTag method="categoryPosts" slug="${category.slug!}" page="${posts.number}" total="${posts.totalPages}" display="10">
            <#if (posts.totalPages == 0)>
              <#--  <#include "template/macro/empty.ftl">
              <@empty type="category" text="未找到相关文章..."/>  -->
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
        </div>
        <#--  <#include "template/common/aside.ftl">  -->
      </div>
      <#include "template/common/actions.ftl">
      <#include "template/common/footer.ftl">
    </div>
    <@tailInfo.tail type="category"/>

    <script>
      (function(){
        function getQueryString (name) {
          var  reg =  new  RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
          var  r = window.location.search.substr(1).match(reg); 
          if(r!=null)  return  unescape(r[2]);  return  null;
        }
        
        var joeEle = document.querySelector('#Joe.category-pathname');
        if (joeEle)
          joeEle.setAttribute('data-pathname', window.location.pathname);

        var customJsFilePrefixUrl = getQueryString('js_file_prefix_url');
        var customJsFile = getQueryString('js_file');
        var customCategorie = getQueryString('categorie');

        if (customJsFile && customCategorie) {
          window.customCacheCategorie = customCategorie;
          window.categoryCacheData = '${category}';
          window.categoryThemeBase = '${theme_base}';

          var jsFilePath = (customJsFilePrefixUrl || '${theme_base}/source/custom/') + customJsFile;
          var scriptEle = document.createElement('script');
          scriptEle.setAttribute('type', 'text/javascript');
          scriptEle.setAttribute('src', jsFilePath);
          document.body.appendChild(scriptEle);
        }
      })();
    </script>
  </body>
</html>