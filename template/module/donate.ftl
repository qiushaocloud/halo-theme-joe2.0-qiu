<div class="joe_donate">
  <i class="joe-font joe-icon-shang"></i>
  <#if settings.qrcode_zfb!='' || settings.qrcode_wx!=''>
    <ol class="joe_donate_list${(settings.qrcode_zfb?? && settings.qrcode_wx??)?string(' two','')}">
      <#if settings.qrcode_zfb??><li><img src="${settings.qrcode_zfb!}" alt="qrcode alipay"/></li></#if>
      <#if settings.qrcode_wx??><li><img src="${settings.qrcode_wx!}" alt="qrcode weixin"/></li></#if>
    </ol>
  </#if>
</div>
