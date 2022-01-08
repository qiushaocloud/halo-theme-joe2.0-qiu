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

  var joeTitleEle = document.querySelector('#Joe .joe_archive__title');
  if (joeTitleEle) {
    joeTitleEle.className += (' custom-categorie ' + window.customCacheCategorie);

    joeTitleEle.innerHTML =
      '<span class="qiushaocloud-name">' + _getCategoryItem('name') + '</span>'
      + '<span class="qiushaocloud-slug">' + _getCategoryItem('slug') + '</span>'
      + '<span class="qiushaocloud-description">' + _getCategoryItem('description') + '</span>'
      // + '<img class="qiushaocloud-thumbnail" src="' + _getCategoryItem('thumbnail') + '" />'
    ;
  }
})();