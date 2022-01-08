<!DOCTYPE html>
<html lang="zh-CN">
  <#import "template/common/header.ftl" as headInfo>
  <@headInfo.head title="${sheet.title}" type="sheet" id=sheet.id />
  <#import "template/macro/tail.ftl" as tailInfo>
  <body>
    <div id="Joe">
      <#include "template/common/navbar.ftl">
      <div class="about_container joe_container joe_main_container page-sheet${(settings.aside_position=='left')?then(' revert','')}">
        <div class="joe_main">
          <div class="joe_detail">
            <#include "template/macro/post_status.ftl">
            <@post_status status=sheet.status />
            <h1 class="joe_detail__title txt-shadow qiushaocloud-text-shadow" data-sheetid="${sheet.id}">${sheet.title}</h1>
            <#assign enable_page_meta = (metas?? && metas.enable_page_meta?? && metas.enable_page_meta?trim!='')?then(metas.enable_page_meta?trim,'true')>

            <#assign img_align = (metas?? && metas.img_align?? && metas.img_align?trim!='')?then(metas.img_align?trim,settings.post_img_align!'center')>
            <article class="joe_detail__article animated fadeIn ${img_align+'-img'}${(settings.enable_code_line_number==true && settings.enable_code_newline!=true)?then(' line-numbers','')}${settings.enable_single_code_select?then(' single_code_select','')}">
              ${sheet.formatContent!}
            </article>

            <#assign enable_comment = (metas?? && metas.enable_comment?? && metas.enable_comment?trim!='')?then(metas.enable_comment?trim,'true')>
          </div>
        </div>
        <#assign enable_aside = (metas?? && metas.enable_aside?? && metas.enable_aside?trim!='')?then(metas.enable_aside?trim,'true')>
        <#if settings.enable_sheet_aside == true && enable_aside == 'true'>
          <#include "template/common/aside.ftl">
        </#if>
      </div>
      <#include "template/common/actions.ftl">
      <#include "template/common/footer.ftl">
    </div>
    <@tailInfo.tail type="sheet"/>
  </body>
</html>