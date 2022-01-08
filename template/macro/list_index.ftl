<#macro list_index>
  <#include "post_item.ftl">
  <ul class="joe_list">
    <#assign lazy_img=settings.lazyload_sthumbnail!LAZY_IMG>
    <#assign exclude_categorie_slugs=settings.exclude_categorie_slugs!''>

    <#list posts.content as post>
      <#assign first_categorie=post.categories[0]!>
      <#if first_categorie??>
        <#assign first_categorie_slug=first_categorie.slug!''>

        <#if (first_categorie_slug != '' && exclude_categorie_slugs != '' && (exclude_categorie_slugs == first_categorie_slug || exclude_categorie_slugs?index_of(','+first_categorie_slug) != -1 || exclude_categorie_slugs?index_of(first_categorie_slug+',') != -1)) == false >
          <@post_item post=post index=post_index type="index" />
        </#if>
      <#else>
        <@post_item post=post index=post_index type="index" />
      </#if>
    </#list>
  </ul>
</#macro>