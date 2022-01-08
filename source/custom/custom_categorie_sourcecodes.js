(function(){
  if (!window.categoryCacheData)
    return;

  function _getCategoryItem (key) {
    var keyTmp = key+'=';
    var indexTmp1 = window.categoryCacheData.indexOf(key+'=');
    if (indexTmp1 === -1)
      return undefined;

    var strTmp1 = window.categoryCacheData.substr(indexTmp1+keyTmp.length);
    var indexTmp2 = strTmp1.search(/, .*=/g);
    if (indexTmp2 === -1)
      return undefined;

    var strTmp2 = strTmp1.substr(strTmp1, indexTmp2);
    return strTmp2;
  }

  var joeEle = document.getElementById('Joe');
  if (joeEle) {
    var styleEle = document.createElement('style');
    styleEle.innerHTML = `
      @media (min-width: 1200px) {
        .joe_list__item {
          width: 49%;
          padding: 15px 0;
          float: left;
          margin: 10px 0;
          background-color: rgb(58 57 57 / 32%);
        }

        .joe_list__item:nth-child(2n) {
          float: right;
        }
      }
    `;
    joeEle.appendChild(styleEle);
  }

  var joeTitleEle = document.querySelector('#Joe .joe_archive__title');
  if (joeTitleEle) {
    joeTitleEle.className += (' custom-categorie ' + window.customCacheCategorie);
    joeTitleEle.style.borderBottom = 'none';

    joeTitleEle.innerHTML =
      '<span class="qiushaocloud-name">' + _getCategoryItem('name') + '</span>'
      + '<span class="qiushaocloud-slug">' + _getCategoryItem('slug') + '</span>'
      + '<span class="qiushaocloud-description">' + _getCategoryItem('description') + '</span>'
      // + '<img class="qiushaocloud-thumbnail" src="' + _getCategoryItem('thumbnail') + '" />'
    ;

    var extraEle = document.createElement('div');
    extraEle.innerHTML = `<ul class="joe_detail__friends" style="margin: 7px;" >
      <li class="joe_detail__friends-item">
        <a class="contain" href="https://github.com/qiushaocloud" target="_blank" style="background:linear-gradient(to right, #a8edea 0%, #fed6e3 100%)" rel="noopener noreferrer">
          <span class="title">博主 Github</span>
          <div class="content">
            <div class="desc" title="博主的 Github 源码分享">博主的 Github 源码分享</div>
            <img width="40" height="40" class="avatar lazyloaded" data-src="${window.categoryThemeBase}/source/custom/img/github.png" src="${window.categoryThemeBase}/source/custom/img/github.png" alt="博主 Github">
          </div>
        </a>
      </li>
      <li class="joe_detail__friends-item">
        <a class="contain" href="https://gitee.com/qiushaocloud" target="_blank" style="background:linear-gradient(to top, #09203f 0%, #537895 100%)" rel="noopener noreferrer">
          <span class="title">博主 Gitee</span>
          <div class="content">
            <div class="desc" title="博主的 Gitee 源码分享">博主的 Gitee 源码分享</div>
            <img width="40" height="40" class="avatar lazyloaded" data-src="${window.categoryThemeBase}/source/custom/img/gitee.png" src="${window.categoryThemeBase}/source/custom/img/gitee.png" alt="博主 Gitee">
          </div>
        </a>
      </li>
      <li class="joe_detail__friends-item">
        <a class="contain" href="https://www.qiushaocloud.top/gitlab/qiushaocloud" target="_blank" style="background:linear-gradient(to right, #fa709a 0%, #fee140 100%)" rel="noopener noreferrer">
          <span class="title">博主自建 Gitlab</span>
          <div class="content">
            <div class="desc" title="博主自建的 Gitlab ，希望能帮助到您">博主自建的 Gitlab ，希望能帮助到您</div>
            <img width="40" height="40" class="avatar lazyloaded" data-src="${window.categoryThemeBase}/source/custom/img/gitlab.png" src="${window.categoryThemeBase}/source/custom/img/gitlab.png" alt="博主自建 Gitlab">
          </div>
        </a>
      </li>
      <li class="joe_detail__friends-item">
        <a class="contain" href="https://hub.docker.com/u/qiushaocloud" target="_blank" style="background:linear-gradient(to right, #a8caba 0%, #5d4157 100%)" rel="noopener noreferrer">
          <span class="title">博主 DockerHub</span>
          <div class="content">
            <div class="desc" title="博主 DockerHub 镜像仓库">博主 DockerHub 镜像仓库</div>
            <img width="40" height="40" class="avatar lazyloaded" data-src="${window.categoryThemeBase}/source/custom/img/docker.png" src="${window.categoryThemeBase}/source/custom/img/docker.png" alt="博主 DockerHub">
          </div>
        </a>
      </li>
    </ul>`;

    extraEle.className = 'custom-extra-box';
    extraEle.style.borderBottom = '1px solid var(--classC)';
    joeTitleEle.parentNode.insertBefore(extraEle, joeTitleEle.nextSibling);
  }
})();