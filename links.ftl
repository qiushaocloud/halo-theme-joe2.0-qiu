<!DOCTYPE html>
<html lang="zh-CN">
  <#assign title=settings.links_title!'友情链接'>
  <#import "template/common/header.ftl" as headInfo>
  <@headInfo.head title="${title}" type="links"/>
  <#import "template/macro/tail.ftl" as tailInfo>
  <body>
    <div id="Joe">
      <#include "template/common/navbar.ftl">
      <div class="joe_container joe_main_container page-links${(settings.aside_position=='left')?then(' revert','')}">
        <div class="joe_main">
          <div class="joe_detail">
            <h1 class="joe_detail__title txt-shadow qiushaocloud-text-shadow">${title}</h1>
            <#include "template/macro/links_item.ftl">
            <#assign logo_default=(settings.links_logo_default?? && settings.links_logo_default!='')?then(settings.links_logo_default, BASE_RES_URL+'/source/img/icon_qiye.png')>
            <#assign colors=["linear-gradient(-90deg, #29bdd9 0%, #276ace 100%)", "linear-gradient(to right, #ff9569 0%, #e92758 100%)", "linear-gradient(to right, #a1c4fd 0%, #c2e9fb 100%)", "linear-gradient(to right, #f6d365 0%, #fda085 100%)", "linear-gradient(to right, #30cfd0 0%, #330867 100%)", "linear-gradient(to right, #fa709a 0%, #fee140 100%)", "linear-gradient(to right, #a8edea 0%, #fed6e3 100%)", "linear-gradient(to right, #fddb92 0%, #d1fdff 100%)", "linear-gradient(to right, #ebc0fd 0%, #d9ded8 100%)",  "linear-gradient(to right, #e4afcb 0%, #b8cbb8 0%, #b8cbb8 0%, #e2c58b 30%, #c2ce9c 64%, #7edbdc 100%)", "linear-gradient(to right, #ebbba7 0%, #cfc7f8 100%)", "linear-gradient(to right, #eea2a2 0%, #bbc1bf 19%, #57c6e1 42%, #b49fda 79%, #7ac5d8 100%)", "linear-gradient(to top, #09203f 0%, #537895 100%)", "linear-gradient(to right, #a8caba 0%, #5d4157 100%)", "linear-gradient(-60deg, #16a085 0%, #f4d03f 100%)", "linear-gradient(to right, #3b41c5 0%, #a981bb 49%, #ffc8a9 100%)", "linear-gradient(to right, #0fd850 0%, #f9f047 100%)"]>
            <#assign omits=settings.links_omit?trim!''>
            <article class="joe_detail__article animated fadeIn">
              <h5>友链列表<#if omits == ''><@linkTag method="count"><span class="totals">${count!0} 条</span></@linkTag></#if></h5>
              <#if settings.links_type?ends_with('group')>
                <@linkTag method="${(settings.links_type == 'group')?then('listTeams', 'listTeamsByRandom')}">
                    <#assign flag = 0>
                    <#list teams as team>
                      <#if omits?index_of(team.team) == -1>
                        <div class="links-group first-priority" data-first-priority="${team.links[0].priority!}">
                          <h1>${team.team!}</h1>
                          <@links_item links=team.links />
                        </div>
                      <#else>
                        <#assign flag++>
                      </#if>
                    </#list>

                    <script>
                      /** 重新排序 links-group, 根据第 1 个 link 的 priority */
                      (function(){
                        var linksGroupEles = document.querySelectorAll('#Joe .joe_detail__article .links-group.first-priority');
                        var groupsIndexArr = [];
                        for (let i=0, len=linksGroupEles.length; i<len; i++) {
                          var ele = linksGroupEles[i];
                          var priority = ele.getAttribute('data-first-priority');
                          groupsIndexArr.push({index: i, ele: ele, priority: Number(priority)});
                        }
                        groupsIndexArr.sort(function(item1, item2){
                          return item1.priority - item2.priority;
                        });
                        for (let i=0, len=groupsIndexArr.length; i<len; i++) {
                          var ele = groupsIndexArr[i].ele;
                          var eleParentNode = ele.parentNode;
                          eleParentNode.removeChild(ele);
                          eleParentNode.appendChild(ele);
                        }
                      })();
                    </script>
                  <#if teams?size == 0 || flag == teams?size>
                    <div class="joe_nodata">${settings.links_empty_text!}</div>
                  </#if>
                </@linkTag>
              <#else>
                <@linkTag method="${(settings.links_type == 'list')?then('list', 'listByRandom')}">
                  <#assign nextRandom = .now?string["HHmmssSSS"]?number>
                  <@links_item links=links />
                </@linkTag>
              </#if>
            </article>
            <article class="joe_detail__article animated fadeIn">
              <h5>申请格式</h5>
              <div class="link-requirement">
                <p>
                  <joe-message type="info" content='<em style="font-style:normal;font-weight:bold;">< 博客名称 + 博客地址 + 博客Logo + 博客简介 ></em><br />(大家到留言栏目里留言哦)'></joe-message>
                </p>
                <#assign logo_url = blog_url + '/logo'>
                <blockquote class="joe_link__demo">博客名称：${blog_title!}<br>博客地址：<a href="${blog_url!}">${blog_url!}</a><br>博客Logo：<a href="${logo_url!!}">${logo_url!}</a><br>博客简介：${meta_description!'这是一个非常牛逼的博客'}</blockquote>
              </div>
            </article>
          </div>
          <#--  目前友链页无法评论  -->
          <#--  <div class="joe_comment">
            <@global.comment target=links type="links" />
          </div>  -->
        </div>
        <#if settings.enable_links_aside!false>
          <#include "template/common/aside.ftl">
        </#if>
      </div>
      <#include "template/common/actions.ftl">
      <#include "template/common/footer.ftl">
    </div>
    <@tailInfo.tail type="links"/> 
  </body>
</html>