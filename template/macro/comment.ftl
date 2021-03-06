<#macro comment target type>
  <div class="joe_comment_box">
    <#if type=='post'><h2>评论区</h2></#if>
    <#--  <#if options.comment_internal_plugin_js??>  -->
    <#--  <script src="${options.comment_internal_plugin_js}"></script>  -->
    <#--  <#else>  -->
    <#assign sys_options = '{"blog_logo": "${options.blog_logo!}", "gravatar_source": "${options.gravatar_source!}", "comment_gravatar_default": "${options.comment_gravatar_default!}"}'>
    <#assign configs = '{
      "autoLoad": "${settings.enable_comment_autoload?string}",
      "showUserAgent": "${settings.enable_comment_ua?string}",
      "isAllowUploadAvatar": "${settings.enable_comment_upload_avatar?string}",
      "isGetIpLocation": "${settings.enable_comment_ip_location?string}",
      "isDelete2Recycle": "${settings.enable_comment_delete_to_recycle?string}",
      "imgGithubUser": "${settings.img_github_user!}",
      "imgGithubRepo": "${settings.img_github_repo}",
      "imgGithubApiToken": "${settings.img_github_api_token!}",
      "githubApiHost": "${settings.github_api_host!}",
      "gravatarSource": "${settings.gravatar_source!}",
      "loadingStyle": "${settings.comment_loading_style}",
      "authorPopup": "${settings.comment_author_poptext!}",
      "emailPopup": "${settings.comment_email_poptext!}",
      "aWord": "${settings.comment_aword!}",
      "avatarLoading": "${settings.comment_avatar_loading!}",
      "avatarError": "${settings.comment_avatar_error!}",
      "notComment": "${settings.comment_empty_text!}",
      "blogAuthorNickname": "${settings.comment_blog_author_nickname!}",
      "blogAuthorSite": "${settings.comment_blog_author_site!}",
      "blogAuthorEmail": "${settings.comment_blog_author_email!}",
      "blogAdminUserName": "${settings.comment_blog_admin_user_name!}",
      "assetsAddr": "${BASE_RES_URL}/source/lib/halo-comment"
    }'>
    <halo-comment id='${target.id?c}' type='${type}' configs='${configs}' options='${sys_options}'/>
    <#--  </#if>  -->
  </div>
</#macro>